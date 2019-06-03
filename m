Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610AC339B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCU0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 16:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCU0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:26:32 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551A626E5D;
        Mon,  3 Jun 2019 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559593591;
        bh=v9calqM6PHGdBj4mALXAqgtFc8xx6nsYR8rF3Gxiqq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSYE0C9l3qM676qHbrmOp5NvQJ7w+P/sokWBCGTmaeHzN6QtS0eN38H8ncd3DClcz
         DjJALXzTzp4c2qWSFZWGgUjssI7sur8d70+9u1UUURc9nWf9sh2sWM8WHjjM+HwVYQ
         n/S63kQSg7IiUbcB3uM+zCD9Gf6KamrIGCdJ016w=
Date:   Mon, 3 Jun 2019 13:26:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 3/4] f2fs: Fix accounting for unusable blocks
Message-ID: <20190603202630.GB34729@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-4-drosen@google.com>
 <c99079bd-99e1-e100-08f6-1e8adae5e722@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99079bd-99e1-e100-08f6-1e8adae5e722@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/03, Chao Yu wrote:
> On 2019/5/30 8:49, Daniel Rosenberg wrote:
> > Fixes possible underflows when dealing with unusable blocks.
> > 
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > ---
> >  fs/f2fs/f2fs.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9b3d9977cd1ef..a39cc4ffeb4b1 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1769,8 +1769,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >  
> >  	if (!__allow_reserved_blocks(sbi, inode, true))
> >  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> > -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > -		avail_user_block_count -= sbi->unusable_block_count;
> > +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> > +		if (avail_user_block_count > sbi->unusable_block_count)
> > +			avail_user_block_count = 0;
> 
> avail_user_block_count -= sbi->unusable_block_count;
> 
> > +		else
> > +			avail_user_block_count -= sbi->unusable_block_count;
> 
> avail_user_block_count = 0;
> 

I fixed this.

Thanks,

> Thanks,
> 
> > +	}
> >  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
> >  		diff = sbi->total_valid_block_count - avail_user_block_count;
> >  		if (diff > *count)
> > @@ -1970,7 +1974,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >  					struct inode *inode, bool is_inode)
> >  {
> >  	block_t	valid_block_count;
> > -	unsigned int valid_node_count;
> > +	unsigned int valid_node_count, user_block_count;
> >  	int err;
> >  
> >  	if (is_inode) {
> > @@ -1997,10 +2001,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >  
> >  	if (!__allow_reserved_blocks(sbi, inode, false))
> >  		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> > +	user_block_count = sbi->user_block_count;
> >  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > -		valid_block_count += sbi->unusable_block_count;
> > +		user_block_count -= sbi->unusable_block_count;
> >  
> > -	if (unlikely(valid_block_count > sbi->user_block_count)) {
> > +	if (unlikely(valid_block_count > user_block_count)) {
> >  		spin_unlock(&sbi->stat_lock);
> >  		goto enospc;
> >  	}
> > 
