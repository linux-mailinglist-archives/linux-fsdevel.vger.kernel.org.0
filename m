Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FB72B647
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 06:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFLEBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjFLEBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:01:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC41F3;
        Sun, 11 Jun 2023 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xaenqfQWcrt8tWNB36muhsuAFWAiB1Cw0mrXd/6ozhs=; b=hFyETY+oYsUZtG11PLJnEw7ZYu
        p2JXob13WXM2yyU16oeU+XARj2lFszgYIBN8pVhz6dH2pyByljza22w7Xire2GdD1NSA0FB4stkCn
        0zSOyTDM5/dWagM/lFnfPqsgnB9hpFyYOs7saC5DopED9EsJuev8E2rTRENzQlWN5PotjAc4sf7gW
        OxJM5tSTNFF8c1l255fVz/u6kKkwGGnEcIma+4T56iQJWCw+qyA5isB1Ksctriej6oWoGeRA7sgL2
        HOx+c3HGz6YXQZ/6p72gl9JYAjeg1SHWinRmJkER/2dfzYJeV44mcJLgJcVSe0FWHl5B+ATcE/+m9
        0FInOqMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8YkW-002UPs-1y;
        Mon, 12 Jun 2023 04:01:48 +0000
Date:   Sun, 11 Jun 2023 21:01:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <ZIaYrA3Jz5Q75X1P@infradead.org>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:15:28PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Jan Kara suggested that when one thread is in the middle of freezing a
> filesystem, another thread trying to freeze the same fs but with a
> different freeze_holder should wait until the freezer reaches either end
> state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> 
> Plumb in the extra coded needed to wait for the fs freezer to reach an
> end state and try the freeze again.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/super.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index 36adccecc828..151e0eeff2c2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1647,6 +1647,15 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
>  	return 0;
>  }
>  
> +static void wait_for_partially_frozen(struct super_block *sb)
> +{
> +	up_write(&sb->s_umount);
> +	wait_var_event(&sb->s_writers.frozen,
> +			sb->s_writers.frozen == SB_UNFROZEN ||
> +			sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> +	down_write(&sb->s_umount);

Does sb->s_writers.frozen need WRITE_ONCE/READ_ONCE treatment if we want
to check it outside of s_umount?  Or should we maybe just open code
wait_var_event and only drop the lock after checking the variable?

>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> -		deactivate_locked_super(sb);
> -		return -EBUSY;
> +		if (!try_again) {
> +			deactivate_locked_super(sb);
> +			return -EBUSY;
> +		}
> +
> +		wait_for_partially_frozen(sb);
> +		try_again = false;
> +		goto retry;

Can you throw in a comment on wait we're only waiting for a partial
freeze one here?
