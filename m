Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BB55D269
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbiF1LvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbiF1LvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:51:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823BF18;
        Tue, 28 Jun 2022 04:51:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A95C21E50;
        Tue, 28 Jun 2022 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656417063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6QyzjA0WXJZm5y/Yp1Q51V61GQNDJoRSnCEcOY53uI=;
        b=uSA6oXLmU0vSd+JP+EeaPg+uSLJkXqM6iHhljNQDVGWJHNTxyRPF/TT5ev7vyKToAtM4wW
        HMumprw0FlBLhUV9NblLW8NxladvUcfYmqyYutDmzUMnBlWTLNezac1ic8GIth02CNb/Mc
        HH90sAKnLrZDIit4hVMnjGstYchs6KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656417063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6QyzjA0WXJZm5y/Yp1Q51V61GQNDJoRSnCEcOY53uI=;
        b=cyJkAgYhq2ZEegkyJBNwzKYl8/YzKmz2preVaquVDpxqJXCCe0QTVEZLYdAmrWCkVvA6Jt
        0wJZoMxdFvknRkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27367139E9;
        Tue, 28 Jun 2022 11:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ez52CCfrumKEDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Jun 2022 11:51:03 +0000
Date:   Tue, 28 Jun 2022 13:46:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220628114621.GA20633@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625091143.GA23118@lst.de>
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

On Sat, Jun 25, 2022 at 11:11:43AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> > I'm not sure I get the context 100% right but pages getting randomly dirty
> > behind filesystem's back can still happen - most commonly with RDMA and
> > similar stuff which calls set_page_dirty() on pages it has got from
> > pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> > be usable within filesystems to detect such cases and protect the
> > filesystem but so far neither me nor John Hubbart has got to implement this
> > in the generic writeback infrastructure + some filesystem as a sample case
> > others could copy...
> 
> Well, so far the strategy elsewhere seems to be to just ignore pages
> only dirtied through get_user_pages.  E.g. iomap skips over pages
> reported as holes, and ext4_writepage complains about pages without
> buffers and then clears the dirty bit and continues.
> 
> I'm kinda surprised that btrfs wants to treat this so special
> especially as more of the btrfs page and sub-page status will be out
> of date as well.

I'm not sure it's safe to ignore that in btrfs, that's sounds quite
risky and potentially breaking something. It's not only that page does
not have buffers but that there's page with dirty bit set but without
the associated extents updated. So this needs a COW to get it back to
sync. It's special because it's for COW, can't compare that to ext4.
