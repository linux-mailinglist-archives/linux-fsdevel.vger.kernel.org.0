Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6151A264
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351385AbiEDOnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiEDOnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:43:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30C40E74
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 07:39:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0153E210E4;
        Wed,  4 May 2022 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651675166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tNstsAKebVMKzSdiC6iyWtEJZNDVsqVBryoTALn8dwc=;
        b=Wxxw/TmzXnimtdsVkjhhAc2Vwo+Q9qSC1AeOhgEOS/Ej/APeWzaFH03/YLpINcZuNFxMuC
        D2dw3xJov1Ccd2pTYtPCpIryZ50Miy54LTRAPqfZNuBdxGB01xTT/6F2fo6sLqDF5kuzFw
        gSFjhr5k3dL8uH5IJvv4LhYW91yZv9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651675166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tNstsAKebVMKzSdiC6iyWtEJZNDVsqVBryoTALn8dwc=;
        b=BQjDEajjrHIxd8ndReDzeoC1P9ZoeQU4qheaiZ0HXLCTL9zJvEA301+DpFWkmRIjMUZ7lA
        XuHSBIhZKAmleSAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E61EB2C142;
        Wed,  4 May 2022 14:39:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8645AA061E; Wed,  4 May 2022 16:39:24 +0200 (CEST)
Date:   Wed, 4 May 2022 16:39:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
References: <20220503174958.ynxbvt7xsj7v72dg@quack3.lan>
 <20220504075421.105494-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504075421.105494-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-05-22 00:54:21, Jchao Sun wrote:
> Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> inode->i_lock") made inode->i_io_list not only protected by
> wb->list_lock but also inode->i_lock, but
> inode_io_list_move_locked() was missed. Add lock there and also
> update comment describing things protected by inode->i_lock.
> 
> Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
> Reviewed-by: Jan Kara <jack@suse.cz>

You have significantly modified the patch since last time (which is good
since 0-day testing has found a problem I have missed). But in such case
please do not add Reviewed-by tags (and also we usually drop already
existing ones in the patch) because the patch needs a new review.

> @@ -317,6 +318,7 @@ locked_inode_to_wb_and_lock_list(struct inode *inode)
>  		/* i_wb may have changed inbetween, can't use inode_to_wb() */
>  		if (likely(wb == inode->i_wb)) {
>  			wb_put(wb);	/* @inode already has ref */
> +			spin_lock(&inode->i_lock);
>  			return wb;
>  		}
>  

Please no. I agree the inode->i_lock and wb->list_lock handling in
fs/fs-writeback.c is ugly and perhaps deserves a cleanup but this isn't
making it easier to understand and it definitely belongs to a separate
patch. Also the problem in __mark_inode_dirty() is deeper than just not
holding inode->i_lock when calling inode_io_list_move_locked(). The problem
is that locked_inode_to_wb_and_lock_list() drops inode->i_lock and at that
moment inode can be moved to new lists, writeback can be started on it,
etc. So all the checks we have performed upto that moment are not valid
anymore. So what we need to do is to move
locked_inode_to_wb_and_lock_list() call up, perhaps just after
"inode->i_state |= flags;". Then lock inode->i_lock again, and then perform
all the checks we need and list moving etc.

> Sry for my insufficient tests and any inconvenience in lauguage, because
> my mother tongue is not english. It's my first commit to linux kernel
> community, some strage for me...

Yeah, no problem. You are doing good :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
