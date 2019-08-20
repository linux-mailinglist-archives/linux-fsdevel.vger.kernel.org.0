Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B079665A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfHTQ26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 12:28:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTQ25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HsG/F7Ogp9T1fgqikVwPMPM6wzzJxLkwajIeWfgFhs0=; b=VNtmQN9j07SQ46nnjhC0A8lTn
        F69eYG3Lfxt+UvCsXGRS5wNwHK1zbLiDIo58EKAFtJg9XTEw2d2Oon69C4+FPws5ixhpBL1keqcn4
        XyV1r7ihK3pxWJJNfvM2Uc40myT96KXuJZqVcVTbWJANBZQclRu+PNLfaj1Zcr4WL08c8VDrvMyWy
        mldKUQ4p76bvlW1yvw00YjEoE5TM6lNrcnrrKjRsfIg4lbpLv15caps8ZKTe5OQSUDCgjPQ9TK0Pa
        PNBULtASBuCu8mIiXPSKSrLAPx5e/xwKenYXimha8Rb/Lm1sdFtz4JHpf70c4HjmmWh4CWe5vWI6/
        OHKASCizg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i070C-0006uR-IM; Tue, 20 Aug 2019 16:28:56 +0000
Date:   Tue, 20 Aug 2019 09:28:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: Re: [PATCH v8 08/20] adfs: Fill in max and min timestamps in sb
Message-ID: <20190820162856.GA21274@bombadil.infradead.org>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
 <20190818165817.32634-9-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818165817.32634-9-deepa.kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 09:58:05AM -0700, Deepa Dinamani wrote:
> Note that the min timestamp is assumed to be
> 01 Jan 1970 00:00:00 (Unix epoch). This is consistent
> with the way we convert timestamps in adfs_adfs2unix_time().

That's not actually correct.  RISC OS timestamps are centiseconds since
1900 stored in 5 bytes.

> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  fs/adfs/adfs.h  | 13 +++++++++++++
>  fs/adfs/inode.c |  8 ++------
>  fs/adfs/super.c |  2 ++
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
> index b7e844d2f321..dca8b23aa43f 100644
> --- a/fs/adfs/adfs.h
> +++ b/fs/adfs/adfs.h
> @@ -3,6 +3,19 @@
>  #include <linux/fs.h>
>  #include <linux/adfs_fs.h>
>  
> +/*
> + * 01 Jan 1970 00:00:00 (Unix epoch) as seconds since
> + * 01 Jan 1900 00:00:00 (RISC OS epoch)
> + */
> +#define RISC_OS_EPOCH_DELTA 2208988800LL
> +
> +/*
> + * Convert 40 bit centi seconds to seconds
> + * since 01 Jan 1900 00:00:00 (RISC OS epoch)
> + * The result is 2248-06-03 06:57:57 GMT
> + */
> +#define ADFS_MAX_TIMESTAMP ((0xFFFFFFFFFFLL / 100) - RISC_OS_EPOCH_DELTA)
> +
>  /* Internal data structures for ADFS */
>  
>  #define ADFS_FREE_FRAG		 0
> diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
> index 124de75413a5..41eca1c451dc 100644
> --- a/fs/adfs/inode.c
> +++ b/fs/adfs/inode.c
> @@ -167,11 +167,7 @@ static void
>  adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
>  {
>  	unsigned int high, low;
> -	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
> -	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
> -	 */
> -	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
> -							2208988800000000000LL;
> +	static const s64 nsec_unix_epoch_diff_risc_os_epoch = RISC_OS_EPOCH_DELTA * NSEC_PER_SEC;
>  	s64 nsec;
>  
>  	if (!adfs_inode_is_stamped(inode))
> @@ -216,7 +212,7 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
>  	if (adfs_inode_is_stamped(inode)) {
>  		/* convert 32-bit seconds to 40-bit centi-seconds */
>  		low  = (secs & 255) * 100;
> -		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
> +		high = (secs / 256) * 100 + (low >> 8) + (RISC_OS_EPOCH_DELTA*100/256);
>  
>  		ADFS_I(inode)->loadaddr = (high >> 24) |
>  				(ADFS_I(inode)->loadaddr & ~0xff);
> diff --git a/fs/adfs/super.c b/fs/adfs/super.c
> index 65b04ebb51c3..f074fe7d7158 100644
> --- a/fs/adfs/super.c
> +++ b/fs/adfs/super.c
> @@ -463,6 +463,8 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
>  	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
>  	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
>  	asb->s_log2sharesize	= dr->log2sharesize;
> +	sb->s_time_min		= 0;
> +	sb->s_time_max		= ADFS_MAX_TIMESTAMP;
>  
>  	asb->s_map = adfs_read_map(sb, dr);
>  	if (IS_ERR(asb->s_map)) {
> -- 
> 2.17.1
> 
