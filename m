Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026260B600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiJXSpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiJXSpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:45:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA5870AD;
        Mon, 24 Oct 2022 10:27:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E14361FD97;
        Mon, 24 Oct 2022 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666631455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aC6p+GauHhTwiVaGS9r9HmOfPKbxmm1GNcmgMdevwBk=;
        b=Acp94ozKle+jv/2WEFMaqZmogz/OyT93zcoivCwqGrUvGLFim4tFv662GdkvpzzMz3Fo/+
        y8/gfC8mRbmK23qh1CQoiK6fQLjLXLJaS5Ku+R6D/a3OaO6lrk9L7wCzngF7qZCLufG1Vu
        pxIhSqS9xrROK6J6wMEtpUPec8v41r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666631455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aC6p+GauHhTwiVaGS9r9HmOfPKbxmm1GNcmgMdevwBk=;
        b=LySjBzc7NzSfLBIctB/+lARoMwBffdkqkTv4nhaiNiy09hX/2LfE63Kalr0pzuef38Ltkg
        S/uyGtFcDgjme0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9416713A79;
        Mon, 24 Oct 2022 17:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cQkoIx/HVmO4eQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 17:10:55 +0000
Date:   Mon, 24 Oct 2022 19:10:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221024171042.GF5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:25:04AM -0400, Chris Mason wrote:
> On 10/24/22 10:44 AM, Christoph Hellwig wrote:
> > On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:
> >> David, what's your plan to progress with this series?
> > 
> > FYI, I object to merging any of my code into btrfs without a proper
> > copyright notice, and I also need to find some time to remove my
> > previous significant changes given that the btrfs maintainer
> > refuses to take the proper and legally required copyright notice.
> > 
> > So don't waste any of your time on this.
> 
> Christoph's request is well within the norms for the kernel, given that 
> he's making substantial changes to these files.  I talked this over with 
> GregKH, who pointed me at:
> 
> https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects
> 
> Even if we'd taken up some of the other policies suggested by this doc, 
> I'd still defer to preferences of developers who have made significant 
> changes.

I've asked for recommendations or best practice similar to the SPDX
process. Something that TAB can acknowledge and that is perhaps also
consulted with lawyers. And understood within the linux project,
not just that some dudes have an argument because it's all clear as mud
and people are used to do things differently.

The link from linux foundation blog is nice but unless this is codified
into the process it's just somebody's blog post. Also there's a paragraph
about "Why not list every copyright holder?" that covers several points
why I don't want to do that.

But, if TAB says so I will do, perhaps spending hours of unproductive
time looking up the whole history of contributors and adding year, name,
company whatever to files.
