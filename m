Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91286119075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJTTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 14:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfLJTTP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:19:15 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42E02077B;
        Tue, 10 Dec 2019 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576005555;
        bh=v/zlr/k417wcCWHHCL31Rqwau5okPBjp1POLwjKxDYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzLzsGotMfuCA9yyO2/HDt1XmRzGg33023JGprHtkq/N9sJZBqyk9HAiW9R+lNtbo
         1PiVZLTd3dVYranyQaIjPmw22oV4+WshIGF1KQEkAGGNhxiA3fMh/CcB3TF3aBpFQF
         8HlA6I9QpUq/ALD7kyWxTil4u7/f5YRZKDjgzUro=
Date:   Tue, 10 Dec 2019 11:19:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191210191912.GA99557@gmail.com>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 08:10:01PM +0800, Tiezhu Yang wrote:
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 3da3707..ef7eba8 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -11,21 +11,11 @@
>   * This has not yet undergone a rigorous security audit.
>   */
>  
> +#include <linux/namei.h>
>  #include <linux/scatterlist.h>
>  #include <crypto/skcipher.h>
>  #include "fscrypt_private.h"
>  
> -static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
> -{
> -	if (str->len == 1 && str->name[0] == '.')
> -		return true;
> -
> -	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
> -		return true;
> -
> -	return false;
> -}
> -
>  /**
>   * fname_encrypt() - encrypt a filename
>   *
> @@ -255,7 +245,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
>  	const struct qstr qname = FSTR_TO_QSTR(iname);
>  	struct fscrypt_digested_name digested_name;
>  
> -	if (fscrypt_is_dot_dotdot(&qname)) {
> +	if (is_dot_or_dotdot(qname.name, qname.len)) {

There's no need for the 'qname' variable anymore.  Can you please remove it and
do:

	if (is_dot_or_dotdot(iname->name, iname->len)) {

> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 7fe7b87..aba114a 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>  	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>  }
>  
> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> +{
> +	if (unlikely(name[0] == '.')) {
> +		if (len < 2 || (len == 2 && name[1] == '.'))
> +			return true;
> +	}
> +
> +	return false;
> +}

This doesn't handle the len=0 case.  Did you check that none of the users pass
in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
directory entry on-disk has a zero-length name.  Currently it will return
-EUCLEAN in that case, but with this patch it may think it's the name ".".

So I think there needs to either be a len >= 1 check added, *or* you need to
make an argument for why it's okay to not care about the empty name case.

- Eric
