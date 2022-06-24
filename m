Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757A559A1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiFXNHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:07:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E349B78;
        Fri, 24 Jun 2022 06:07:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D778821A62;
        Fri, 24 Jun 2022 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656076070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Voz+GKLt+fey+7KtZvgQ9tnhwKMgnmP0Zauu+/ksuk=;
        b=EKjodTSxmRV15tgmzR51LSZdksqcI6psB9BLSSqcxX68qKw0H4GLlshpy24s89YgHUp4vV
        0wTCE3IV4Ar/vGtXbWTNAUowga4dWXn56dOTIoaD/xt8xk6eo4iPir7XZe9hD5GBrjyoF7
        fZqDEo6nDsvtAmtswrPk9xuLRYPf7Yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656076070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Voz+GKLt+fey+7KtZvgQ9tnhwKMgnmP0Zauu+/ksuk=;
        b=l9sXkaIeIrs99XCg4CXmvAyv5eylUjA5Vx6my69KfmXkeaH+ztAQ5LUHW+9N+u7eq6fXUl
        fxMnpg47gLoIptCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C19682C220;
        Fri, 24 Jun 2022 13:07:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4BF3BA062D; Fri, 24 Jun 2022 15:07:50 +0200 (CEST)
Date:   Fri, 24 Jun 2022 15:07:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624125118.GA789@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-06-22 14:51:18, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 08:30:00PM +0800, Qu Wenruo wrote:
> > But from my previous feedback on subpage code, it looks like it's some
> > hardware archs (S390?) that can not do page flags update atomically.
> >
> > I have tested similar thing, with extra ASSERT() to make sure the cow
> > fixup code never get triggered.
> >
> > At least for x86_64 and aarch64 it's OK here.
> >
> > So I hope this time we can get a concrete reason on why we need the
> > extra page Private2 bit in the first place.
> 
> I don't think atomic page flags are a thing here.  I remember Jan
> had chased a bug where we'd get into trouble into this area in
> ext4 due to the way pages are locked down for direct I/O, but I
> don't even remember seeing that on XFS.  Either way the PageOrdered
> check prevents a crash in that case and we really can't expect
> data to properly be written back in that case.

I'm not sure I get the context 100% right but pages getting randomly dirty
behind filesystem's back can still happen - most commonly with RDMA and
similar stuff which calls set_page_dirty() on pages it has got from
pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
be usable within filesystems to detect such cases and protect the
filesystem but so far neither me nor John Hubbart has got to implement this
in the generic writeback infrastructure + some filesystem as a sample case
others could copy...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
