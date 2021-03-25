Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B99349A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhCYTn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhCYTnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD9D0619C9;
        Thu, 25 Mar 2021 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616701404;
        bh=1r+GeFGCMbDDIXeRYKJ4Hm8F51/bPaP4XF8mxybzx2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGP1DZMB24r/DF69LXH/qos9xWt+IB2JQD2/pxxusRzuFj7yp8XP9X6ZX11xq7UI3
         SqgDqD5EeTOq9jkARGuGO2Y0JjS2eKLD1lvQ4i83zw0FkGZLqPEa3b/DEr7vJrFQWM
         rHRuNJnaf0MP6CSUnAClzOox/qpLeEiVup7Sm+LLExLdFtmcCn/BLnD9OtQ7Oo6VBs
         d7Fde1+FRBsdZGBPah8hBCy9p2ot8rPBJtccyc2DJhao2COhMdQJ//x2+YRTz5xxdN
         EXnfAdx8UBx9lXiF0DKxfcGOPjRXFd0HRnsj3Zr8bwt/TO151jqIYDrDv/W5Pcm7br
         j61kk91T6iVTA==
Date:   Thu, 25 Mar 2021 12:43:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        drosen@google.com, yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v4 2/5] fs: Check if utf8 encoding is loaded before
 calling utf8_unload()
Message-ID: <YFzn2rbN6P0LvdA+@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-3-shreeya.patel@collabora.com>
 <YFziza/VMyzEs4s1@sol.localdomain>
 <878s6bt4gx.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s6bt4gx.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:31:42PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Thu, Mar 25, 2021 at 05:38:08AM +0530, Shreeya Patel wrote:
> >> utf8_unload is being called if CONFIG_UNICODE is enabled.
> >> The ifdef block doesn't check if utf8 encoding has been loaded
> >> or not before calling the utf8_unload() function.
> >> This is not the expected behavior since it would sometimes lead
> >> to unloading utf8 even before loading it.
> >> Hence, add a condition which will check if sb->encoding is NOT NULL
> >> before calling the utf8_unload().
> >> 
> >> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> >> ---
> >>  fs/ext4/super.c | 6 ++++--
> >>  fs/f2fs/super.c | 9 ++++++---
> >>  2 files changed, 10 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> >> index ad34a37278cd..e438d14f9a87 100644
> >> --- a/fs/ext4/super.c
> >> +++ b/fs/ext4/super.c
> >> @@ -1259,7 +1259,8 @@ static void ext4_put_super(struct super_block *sb)
> >>  	fs_put_dax(sbi->s_daxdev);
> >>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
> >>  #ifdef CONFIG_UNICODE
> >> -	utf8_unload(sb->s_encoding);
> >> +	if (sb->s_encoding)
> >> +		utf8_unload(sb->s_encoding);
> >>  #endif
> >>  	kfree(sbi);
> >>  }
> >
> >
> > What's the benefit of this change?  utf8_unload is a no-op when passed a NULL
> > pointer; why not keep it that way?
> 
> For the record, it no longer is a no-op after patch 5 of this series.
> Honestly, I prefer making it explicitly at the caller that we are not
> entering the function, like the patch does, instead of returning from it
> immediately.  Makes it more readable, IMO.
> 

I don't think making all the callers do the NULL check is more readable.  It's
conventional for free-like functions to accept NULL pointers.  See for example
every other function in the code snippet above -- fs_put_dax(),
fscrypt_free_dummy_policy(), and kfree().

This seems more like an issue with patch 5; it shouldn't be dropping the NULL
check from unicode_unload().

- Eric
