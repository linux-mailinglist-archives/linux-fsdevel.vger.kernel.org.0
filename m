Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E66135CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiJaMTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJaMTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:19:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22BFF58E;
        Mon, 31 Oct 2022 05:19:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74D4D1F94D;
        Mon, 31 Oct 2022 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667218770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0NmLcuK0RtLWfxsYewoTZqt5GInuYF2VLW7qII+j/0=;
        b=Z6xIAltqg5yCEsY1t1qCKAaQsFCmib9lDkTeek5bj3g67xwB6fw6AADs0QV/DZPQTpeu3G
        SN9TbkfmvPkhHyjahr2DVj9+BN66G5ZyYtRZDdBkDsEomZikZrgtFr1jHEk0tYpWhBup0N
        E/jOWXllREehCR0gaYXUOetqs1cGKWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667218770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0NmLcuK0RtLWfxsYewoTZqt5GInuYF2VLW7qII+j/0=;
        b=5O7W2TMvqcDLcpbfQsY5xVaG7C8PA0rGGfr8r9XtZDhNtXfReYUVgeqrLoVqEAI6XHqHby
        JJR+Iy/X589dSIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 126D613451;
        Mon, 31 Oct 2022 12:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /2qUA1K9X2M9NwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 12:19:30 +0000
Date:   Mon, 31 Oct 2022 13:19:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221031121912.GY5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026074145.2be5ca09@gandalf.local.home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:41:45AM -0400, Steven Rostedt wrote:
> On Wed, 26 Oct 2022 07:36:45 +0000
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:
> > On 24.10.22 19:11, David Sterba wrote:
> > > On Mon, Oct 24, 2022 at 11:25:04AM -0400, Chris Mason wrote:  
> > >> On 10/24/22 10:44 AM, Christoph Hellwig wrote:  
> > >>> On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:  
> > >>>> David, what's your plan to progress with this series?  
> > >>>
> > >>> FYI, I object to merging any of my code into btrfs without a proper
> > >>> copyright notice, and I also need to find some time to remove my
> > >>> previous significant changes given that the btrfs maintainer
> > >>> refuses to take the proper and legally required copyright notice.
> > >>>
> > >>> So don't waste any of your time on this.  
> > >>
> > >> Christoph's request is well within the norms for the kernel, given that 
> > >> he's making substantial changes to these files.  I talked this over with 
> > >> GregKH, who pointed me at:
> > >>
> > >> https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects
> > >>
> > >> Even if we'd taken up some of the other policies suggested by this doc, 
> > >> I'd still defer to preferences of developers who have made significant 
> > >> changes.  
> > > 
> > > I've asked for recommendations or best practice similar to the SPDX
> > > process. Something that TAB can acknowledge and that is perhaps also
> > > consulted with lawyers. And understood within the linux project,
> > > not just that some dudes have an argument because it's all clear as mud
> > > and people are used to do things differently.
> > > 
> > > The link from linux foundation blog is nice but unless this is codified
> > > into the process it's just somebody's blog post. Also there's a paragraph
> > > about "Why not list every copyright holder?" that covers several points
> > > why I don't want to do that.
> > > 
> > > But, if TAB says so I will do, perhaps spending hours of unproductive
> > > time looking up the whole history of contributors and adding year, name,
> > > company whatever to files.
> 
> There's no requirement to list every copyright holder, as most developers do
> not require it for acceptance. The issue I see here is that there's someone
> that does require it for you to accept their code.

That this time it is a hard requirement is a first occurrence for me
acting as maintainer. In past years we had new code and I asked if the
notice needs to be there and asked for resend without it. The reason is
that we have git and complete change history, but that is apparently not
sufficient for everybody.

> The policy is simple. If someone requires a copyright notice for their
> code, you simply add it, or do not take their code. You can be specific
> about what that code is that is copyrighted. Perhaps just around the code in
> question or a description at the top.

Let's say it's OK for substantial amount of code. What if somebody
moves existing code that he did not write to a new file and adds a
copyright notice? We got stuck there, both sides have different answer.
I see it at minimum as unfair to the original code authors if not
completely wrong because it could appear as "stealing" ownership.

> Looking over the thread, I'm still confused at what the issue is. Is it
> that if you add one copyright notice you must do it for everyone else? Is
> everyone else asking for it? If not, just add the one and be done with it.

My motivation is to be fair to all contributors and stick to the project
standards (ideally defined in process). Adding a copyright notice after
several years of not taking them would rightfully raise questions from
past and current contributors what would deserve to be mentioned as
copyright holders.

This leaves me with 'all or nothing', where 'all' means to add the
notices where applicable and we can continue perhaps with more
contributions in the future. But that'll cost time and inventing how to
do it so everybody is satisfied with the result.

You may have missed the start of the discussions, https://lore.kernel.org/all/20220909101521.GS32411@twin.jikos.cz/ ,
Bradley Kuhn's reply https://lore.kernel.org/all/YyfNMcUM+OHn5qi8@ebb.org/ ,
the documented position on the notices https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Copyright_notices_in_files.2C_SPDX .
