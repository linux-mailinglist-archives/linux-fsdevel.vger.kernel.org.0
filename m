Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA77D442
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 06:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfHAEFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 00:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfHAEFW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:05:22 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7AA206A3;
        Thu,  1 Aug 2019 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564632321;
        bh=p93UwHtzJnT9bTmzWi9Xj9kNuVoH+OlrITuCGkgZCU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvE7R67i5/FJqUTpXXMJgmYnrP6zkjLyIIQ94Tw1YOk7s0QqPvmNW/1maP7qQTEm/
         vWMPM77/byfy78m7B/pqD4jpczOqeWOzwnSaKYaX6tsk4zQMH/EQLw/tBAw4Yxb5va
         SVcj+hsNBIIFdLlvxBRGSUG5zSnPzPc9A2Lo+tQo=
Date:   Wed, 31 Jul 2019 21:05:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Rosenberg <drosen@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 3/3] f2fs: Support case-insensitive file name lookups
Message-ID: <20190801040520.GA84433@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <20190731175748.GA48637@archlinux-threadripper>
 <5d6c5da8-ad1e-26e2-0a3d-84949cd4e9aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6c5da8-ad1e-26e2-0a3d-84949cd4e9aa@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/01, Chao Yu wrote:
> Hi Nathan,
> 
> Thanks for the report! :)
> 
> On 2019/8/1 1:57, Nathan Chancellor wrote:
> > Hi all,
> > 
> > <snip>
> > 
> >> diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
> >> index cc82f142f811f..99e79934f5088 100644
> >> --- a/fs/f2fs/hash.c
> >> +++ b/fs/f2fs/hash.c
> >> @@ -14,6 +14,7 @@
> >>  #include <linux/f2fs_fs.h>
> >>  #include <linux/cryptohash.h>
> >>  #include <linux/pagemap.h>
> >> +#include <linux/unicode.h>
> >>  
> >>  #include "f2fs.h"
> >>  
> >> @@ -67,7 +68,7 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
> >>  		*buf++ = pad;
> >>  }
> >>  
> >> -f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
> >> +static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
> >>  				struct fscrypt_name *fname)
> >>  {
> >>  	__u32 hash;
> >> @@ -103,3 +104,35 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
> >>  	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
> >>  	return f2fs_hash;
> >>  }
> >> +
> >> +f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
> >> +		const struct qstr *name_info, struct fscrypt_name *fname)
> >> +{
> >> +#ifdef CONFIG_UNICODE
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
> >> +	const struct unicode_map *um = sbi->s_encoding;
> >> +	int r, dlen;
> >> +	unsigned char *buff;
> >> +	struct qstr *folded;
> >> +
> >> +	if (name_info->len && IS_CASEFOLDED(dir)) {
> >> +		buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
> >> +		if (!buff)
> >> +			return -ENOMEM;
> >> +
> >> +		dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
> >> +		if (dlen < 0) {
> >> +			kvfree(buff);
> >> +			goto opaque_seq;
> >> +		}
> >> +		folded->name = buff;
> >> +		folded->len = dlen;
> >> +		r = __f2fs_dentry_hash(folded, fname);
> >> +
> >> +		kvfree(buff);
> >> +		return r;
> >> +	}
> >> +opaque_seq:
> >> +#endif
> >> +	return __f2fs_dentry_hash(name_info, fname);
> >> +}
> > 
> > Clang now warns:
> > 
> > fs/f2fs/hash.c:128:3: warning: variable 'folded' is uninitialized when used here [-Wuninitialized]
> >                 folded->name = buff;
> >                 ^~~~~~
> > fs/f2fs/hash.c:116:21: note: initialize the variable 'folded' to silence this warning
> >         struct qstr *folded;
> >                            ^
> >                             = NULL
> > 1 warning generated.
> > 
> > I assume that it wants to be initialized with f2fs_kzalloc as well but
> > I am not familiar with this code and what it expects to do.
> > 
> > Please look into this when you get a chance!
> 
> That should be a bug, it needs to define a struct qstr type variable rather than
> a pointer there.
> 
> Jaegeuk, could you fix this in you branch?

Yeah, let me apply this.

--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -113,25 +113,27 @@ f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
        const struct unicode_map *um = sbi->s_encoding;
        int r, dlen;
        unsigned char *buff;
-       struct qstr *folded;
+       struct qstr folded;

-       if (name_info->len && IS_CASEFOLDED(dir)) {
-               buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
-               if (!buff)
-                       return -ENOMEM;
+       if (!name_info->len || !IS_CASEFOLDED(dir))
+               goto opaque_seq;

-               dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
-               if (dlen < 0) {
-                       kvfree(buff);
-                       goto opaque_seq;
-               }
-               folded->name = buff;
-               folded->len = dlen;
-               r = __f2fs_dentry_hash(folded, fname);
+       buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
+       if (!buff)
+               return -ENOMEM;

+       dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
+       if (dlen < 0) {
                kvfree(buff);
-               return r;
+               goto opaque_seq;
        }
+       folded.name = buff;
+       folded.len = dlen;
+       r = __f2fs_dentry_hash(&folded, fname);
+
+       kvfree(buff);
+       return r;
+
 opaque_seq:
 #endif
        return __f2fs_dentry_hash(name_info, fname);

