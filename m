Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125BC79F06A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjIMRcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIMRcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:32:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A49E;
        Wed, 13 Sep 2023 10:32:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80F0B218E3;
        Wed, 13 Sep 2023 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694626346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzZLURoFZ/bpIZJUCzmIphDrAkLvI9seeWq/0zEo2bI=;
        b=xjaBlRu0i7JGAQSWhgqD4kHKuscodhvfI1HD977oDlPe+IMg6OT6BVxnlGKXexfD8AsBj7
        lkJGu2xYrR4qHdcByCRDDCsK+nEajUVergaN/Tax3IHwoycFjbb5LrMyjgTaxMGOQdWoSN
        em4Ce69hNUR4AXOCxJL4Knt9QXZNjWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694626346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzZLURoFZ/bpIZJUCzmIphDrAkLvI9seeWq/0zEo2bI=;
        b=pfprUm/6bc9LKPfH5a1QbTguciRPZSv1Z+inuEYEbITATEmZm5+iVzb/19NpdSy6DrsSBz
        YjQS1vgkBVfXeXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26DAC13440;
        Wed, 13 Sep 2023 17:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wyqmCCryAWWKPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 17:32:26 +0000
Date:   Wed, 13 Sep 2023 19:32:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Message-ID: <20230913173224.GX20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
 <6da9b6b1-5028-c0e2-f11e-377fabf1432d@igalia.com>
 <4914eb22-6b51-a816-1d5b-a2ceb8bcbf06@oracle.com>
 <e89b4997-5247-556e-9aee-121b4e19938e@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89b4997-5247-556e-9aee-121b4e19938e@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:15:13AM -0300, Guilherme G. Piccoli wrote:
> On 12/09/2023 21:39, Anand Jain wrote:
> > [..] 
> >> Now, sorry for the silly question, but where is misc-next?! I'm looking
> >> here: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/
> >>
> >> I based my work in the branch "for-next", but I can't find misc-next.
> >> Also, I couldn't find "btrfs: pseudo device-scan for single-device
> >> filesystems" in the tree...probably some silly confusion from my side,
> >> any advice is appreciated!
> > 
> > 
> > David maintains the upcoming mainline merges in the branch "misc-next" here:
> > 
> >     https://github.com/kdave/btrfs-devel.git
> > 
> > Thanks.
> > 
> 
> Thanks a lot Anand!
> 
> Checking now, I could also find it in the documentation - my bad, apologies

It's documented at https://btrfs.readthedocs.io/en/latest/Source-repositories.html
but it can be always improved. If the page contents was incomplete from
you POV please let me know or open an issue at
github.com/kdave/btrfs-progs .
