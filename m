Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1536AD89D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCGIAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCGH77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:59:59 -0500
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCDE88DA9
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 23:59:40 -0800 (PST)
Date:   Tue, 7 Mar 2023 02:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678175975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enpvn031AvDvojBwqvGGJyGrKEItvTDvix4RkAWXGQs=;
        b=aBNKx6sI/AcKI6TsEb2ICc1TCjmOcaeSDMRW/nwwb9DMMARJaZajEKLnziJcai6839IuyX
        rQlmoaaaTBzOsgnJ8o+rNtsuCnPLWLrh14/PFQ59WNH9MZphokVvtAT4HvsWUb8rqVhmJi
        Z31iJGYbVgwxgX6ngV0qLxPTm8pzpoE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <ZAbu5Mov0wOuiviw@moria.home.lan>
References: <Y/ZxFwCasnmPLUP6@moria.home.lan>
 <ZAbm2zTX83Cfl2SJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAbm2zTX83Cfl2SJ@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:25:15AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 22, 2023 at 02:46:31PM -0500, Kent Overstreet wrote:
> > I'd like to talk more about where things are at, long term goals, and
> > finally upstreaming this beast.
> 
> We don't have any rules about when we decide to upstream a new filesystem.
> There are at least four filesystems considering inclusion right now;
> bcachefs, SSDFS, composefs and nvfs.  Every new filesystem imposes
> certain costs on other developers (eg those who make sweeping API changes,
> *cough*).  I don't think we've ever articulated a clear set of criteria,
> and maybe we can learn from the recent pain of accepting ntfs3 in the
> upstream kernel.

I've been thinking about what's good for the filesystem.

I've been leery about upstreaming too soon, with unfinished important
features or major design work still to be done. When it's upstream, I'll
have to spend a lot more of my time in a maintainer role, and it's going
to be harder to find time for multi-month projects that require deep
focus; like snapshots, or the allocator rewrite, or backpointers, or
right now erasure coding.

And once it's upstream the pressure is going to be to keep things
stable, to not break things that will affect users. Whereas right now,
I've got a testing community that's smaller, more forgiving of temporary
bugs, and people work with me and give me feedback. That feedback is
important and guides what I work on; it's driven a lot of the
scalability work over the past few years. We've got people running it on
100 TB arrays right now (I want to hear from the first person to test it
on a 1 PB array!) - it took a lot of work to get there.

It's still not _quite_ where I want it to be. Snapshots needs a bit more
work - the deletion path needs more torture testing, and I'm adamant on
not shipping without solid working erasure coding. Right now I'm working
on getting the erasure coding copygc torture test passing; the
fundamentals are there but I've probably got another month of work to to
get it all polished and thoroughly debugged.

But, you gotta ship someday :) and the feedback from users has
increasingly been "yeah, it's been solid and trouble free", so... maybe
it is finally just about time :)
