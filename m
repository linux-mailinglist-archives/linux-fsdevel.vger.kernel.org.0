Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620A855290F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 03:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiFUBjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 21:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiFUBjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:39:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0B1EAE1;
        Mon, 20 Jun 2022 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VgDEwV/6vW56MaSqzt3dabSrMNxD2Tms7iNkvTe/k0w=; b=kknt8010MtZAiXmjBdKnm4XC5s
        2sg6OEblMwSwuSUL5PZHhp8+Gjssglo7tw/EpHILRTBXLnn4+3gzt48NYDFF2NccQdA5PedTeS+Vw
        C34Dcr8/3/Eh5elUEh4EhUyiU302b63jzBeQkNthIkzoZh55GDPS+VZcESNhd4Bb5GD+2jrCffrz6
        oHt9gRJ3T4jF4uQLzvk16mSVt4Jt5z1HZmoMC63371qupKw2Hr4eV57xJc77sN18A21maCgt40smI
        8DRD7AhFyRsLs9HXRri0yj6zZzyt3pVt1gEDtDTE0pQmbx6ntB/m9C7EyufsmlRvZZA9w/8LPXliS
        nNj8NQLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3Srl-005i6P-Fg; Tue, 21 Jun 2022 01:39:41 +0000
Date:   Tue, 21 Jun 2022 02:39:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Message-ID: <YrEhXYBeQz8kNuGo@casper.infradead.org>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:28:40AM +0530, Ritesh Harjani wrote:
> @@ -1636,14 +1636,12 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>  		sb->s_checksum = jbd2_superblock_csum(journal, sb);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_write_sync;
> -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	submit_bh(REQ_OP_WRITE, write_flags, bh);
>  	wait_on_buffer(bh);
>  	if (buffer_write_io_error(bh)) {
>  		clear_buffer_write_io_error(bh);
>  		set_buffer_uptodate(bh);
>  		ret = -EIO;
> -	}
> -	if (ret) {
>  		printk(KERN_ERR "JBD2: Error %d detected when updating "
>  		       "journal superblock for %s.\n", ret,
>  		       journal->j_devname);

Maybe rephrase the error message?  And join it together to match the
current preferred style.

		printk(KERN_ERR "JBD2: I/O error when updating journal superblock for %s.\n",
				journal->j_devname);
