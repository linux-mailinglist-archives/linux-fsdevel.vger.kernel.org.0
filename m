Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823154E58E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbiFPPCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFPPCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:02:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F13DA5A;
        Thu, 16 Jun 2022 08:02:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D04FA21D3C;
        Thu, 16 Jun 2022 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655391721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LG13+PzXyKkJJ354mhg9xbVpFu1cjtccEn2WqANniac=;
        b=mbh8tz7rXmsWOg5e2UVivIlGK7FzI5U7F3c56jFPvl6mXdCGlc9iLdZtow9p9dRUmJ1KWr
        m9y7qQ4aM9HJCLzPqk1BAjTCqynFZzLZUeUP0QUOkcWwlNQNMG7AHAtiGbmlbuRqQuTsYw
        l2AIB/zgWvmncuK5HsM5Q3HBVdXzQK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655391721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LG13+PzXyKkJJ354mhg9xbVpFu1cjtccEn2WqANniac=;
        b=/APgIUcaHjm7RI2mc8s+qU5gLnvZ/D0ZLdsUEFQN5wluO7t9WWzjyrkRxlomCfEGWu29YP
        4X/Ufg+xwF6F9PCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73BD41344E;
        Thu, 16 Jun 2022 15:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8Y4G+lFq2IcOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Jun 2022 15:02:01 +0000
Date:   Thu, 16 Jun 2022 16:57:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] KASAN: use-after-free Read in
 copy_page_from_iter_atomic (2)
Message-ID: <20220616145727.GB20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
References: <0000000000003ce9d105e0db53c8@google.com>
 <00000000000085068105e112a117@google.com>
 <20220613193912.GI20633@twin.jikos.cz>
 <20220614071757.GA1207@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614071757.GA1207@lst.de>
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

On Tue, Jun 14, 2022 at 09:17:57AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 13, 2022 at 09:39:12PM +0200, David Sterba wrote:
> > On Fri, Jun 10, 2022 at 12:10:19AM -0700, syzbot wrote:
> > > syzbot has bisected this issue to:
> > > 
> > > commit 4cd4aed63125ccd4efc35162627827491c2a7be7
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Fri May 27 08:43:20 2022 +0000
> > > 
> > >     btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure
> > 
> > Josef also reported a crash and found a bug in the patch, now added as
> > fixup that'll be in for-next:
> 
> The patch looks correct to me.  Two things to note here:
> 
>  - I hadn't realized you had queued up the series.

I did a review and as it looked ok I added it to the for-next for
testing coverage, but I don't think I've sent any notice about that.

>  I've actually
>    started to merge some of my bio work with the bio split at
>    submission time work from Qu and after a few iterations I think
>    I would do the repair code a bit differently based on that.
>    Can you just drop the series for now?

Yeah, we consistently hit 2 crashes, one of them has a fix but the other
not, so I removed the topic branch from for-next. I'll wait for the
reworked version you mention.
