Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33351784EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfG2G1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 02:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2G1g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:27:36 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1F22070B;
        Mon, 29 Jul 2019 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564381655;
        bh=eEx0tfy6aPFIS7G1N250q6V4oZYc59T12k/6VuKoVPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/PDpCLZZOp8JsopUOk6P8DZ7g88WXGcbHCTZIrlJ9+HsEBtD2PZKtLN5faIawQqp
         ym4H3iLdi1MdrcnRAPmHy+2PffkZK4DULhZ6nmD+2Rq+INEuK9ELmzckGZLUKO5s/2
         ucU5Zl66a0LGwL1OX/O3CbMJ2aJr1w+0U2k8I3L8=
Date:   Sun, 28 Jul 2019 23:27:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
Message-ID: <20190729062735.GA98839@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <9362e4ed-2be8-39f5-b4d9-9c86e37ab993@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9362e4ed-2be8-39f5-b4d9-9c86e37ab993@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/28, Chao Yu wrote:
> On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
> >  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> >  #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL))
> 
> We missed to add F2FS_CASEFOLD_FL here to exclude it in F2FS_REG_FLMASK.

Applied.

> 
> > @@ -1660,7 +1660,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> >  		return -EPERM;
> >  
> >  	oldflags = fi->i_flags;
> > +	if ((iflags ^ oldflags) & F2FS_CASEFOLD_FL) {
> > +		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
> > +			return -EOPNOTSUPP;
> > +
> > +		if (!S_ISDIR(inode->i_mode))
> > +			return -ENOTDIR;
> >  
> > +		if (!f2fs_empty_dir(inode))
> > +			return -ENOTEMPTY;
> > +	}

Modified like this:
@@ -1665,6 +1665,13 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
        if (IS_NOQUOTA(inode))
                return -EPERM;

+       if ((iflags ^ fi->i_flags) & F2FS_CASEFOLD_FL) {
+               if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
+                       return -EOPNOTSUPP;
+               if (!f2fs_empty_dir(inode))
+                       return -ENOTEMPTY;
+       }
+

Note that, directory is checked by above change.

I've uploaded in f2fs.git, so could you check it out and test a bit?

Thanks,

> 
> I applied the patches based on last Jaegeuk's dev branch, it seems we needs to
> adjust above code a bit. Otherwise it looks good to me.
> 
> BTW, it looks the patchset works fine with generic/556 testcase.
> 
> Thanks,
