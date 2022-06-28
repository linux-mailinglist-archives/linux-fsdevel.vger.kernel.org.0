Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038BE55C616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbiF1L6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbiF1L6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:58:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E56337;
        Tue, 28 Jun 2022 04:58:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E741B21E69;
        Tue, 28 Jun 2022 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656417517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uGu7K4Rqu3ezVw8tmoJpMFQURgPc1ipNiiYFEj1I2A=;
        b=yxFOQEWFLpu/oNZdG0wx7s21jDqiwHhxlL25m7DHpY8fTiAlCVmGs/AovRoPrW+e5lAv4b
        ULaGR7D/E3II/YFDbIXrg1VQZ15wYFSt/o9LqL54P+UIimZUKMQVrpQPC5sRtoInScVibP
        OVtJdVVEA2CoDAK8uxX7gYwcIOI6jTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656417517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uGu7K4Rqu3ezVw8tmoJpMFQURgPc1ipNiiYFEj1I2A=;
        b=Q1AnzTXaVXg/QjyyepPg5mfbFyEBOp+DIpo/N9gLOFTOSL1X9AqbyFiTaOJnQR3bOdsoGU
        a+uGd0tNIU2PQVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B34A4139E9;
        Tue, 28 Jun 2022 11:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fT/XKu3sumIvEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Jun 2022 11:58:37 +0000
Date:   Tue, 28 Jun 2022 13:53:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220628115356.GB20633@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
 <20220627101914.gpoz7f6riezkolad@quack3.lan>
 <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:24:07AM +0800, Qu Wenruo wrote:
> On 2022/6/27 18:19, Jan Kara wrote:
> > On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
> >> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> >>> I'm not sure I get the context 100% right but pages getting randomly dirty
> >>> behind filesystem's back can still happen - most commonly with RDMA and
> >>> similar stuff which calls set_page_dirty() on pages it has got from
> >>> pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> >>> be usable within filesystems to detect such cases and protect the
> >>> filesystem but so far neither me nor John Hubbart has got to implement this
> >>> in the generic writeback infrastructure + some filesystem as a sample case
> >>> others could copy...
> >>
> >> Well, so far the strategy elsewhere seems to be to just ignore pages
> >> only dirtied through get_user_pages.  E.g. iomap skips over pages
> >> reported as holes, and ext4_writepage complains about pages without
> >> buffers and then clears the dirty bit and continues.
> >>
> >> I'm kinda surprised that btrfs wants to treat this so special
> >> especially as more of the btrfs page and sub-page status will be out
> >> of date as well.
> >
> > I agree btrfs probably needs a different solution than what it is currently
> > doing if they want to get things right. I just wanted to make it clear that
> > the code you are ripping out may be a wrong solution but to a real problem.
> 
> IHMO I believe btrfs should also ignore such dirty but not managed by fs
> pages.
> 
> But I still have a small concern here.
> 
> Is it ensured that, after RDMA dirtying the pages, would we finally got
> a proper notification to fs that those pages are marked written?
> 
> If not, I would guess those pages would never got a chance to be written
> back.
> 
> If yes, then I'm totally fine to go the ignoring path.

This would work only for the higher level API where eg. RDMA notifies
the filesystem, but there's still the s390 case that is part of the
hardware architecture. The fixup worker is there as a safety for all
other cases, I'm not fine removing or ignoring it.
