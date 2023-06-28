Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104FA740E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjF1KRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 06:17:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjF1KLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:11:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBD02187F;
        Wed, 28 Jun 2023 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687947093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nJNJSNTTNh2JCFGe0rsIE8YNFrRfLqpVv3jDwxu/kQ=;
        b=1M/VOkpAPbO9GRW6aHPKoN3cQlCAucE1vQ7N7CBT+vzkvelbXTliGhw0pGtTk5XgTVFtzE
        DR92gC/+BzEehG2JF804j5Zcsa51j/LkoeeZPc0cKbixg2PfHYBSxUA8cCamEaB1kZugGL
        AR/25cIrPsciid74+7d94XYaz298Suo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687947093;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nJNJSNTTNh2JCFGe0rsIE8YNFrRfLqpVv3jDwxu/kQ=;
        b=34b3usdD4lsSdoP5NYlxBteRGnPdiN8z8oI8KSKtFpNgapNeNrcHSEicyd96tDtCLAVQwT
        mStHpGJjHh522VCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E1CD138EF;
        Wed, 28 Jun 2023 10:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d3IME1UHnGTlEQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 10:11:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C47F6A0707; Wed, 28 Jun 2023 12:11:32 +0200 (CEST)
Date:   Wed, 28 Jun 2023 12:11:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <20230628101132.kvchg544mczxv2pm@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 09:33:43, Amir Goldstein wrote:
> On Tue, Jun 27, 2023 at 11:50 PM Ahelenia Ziemiańska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > The current behaviour caused an asymmetry where some write APIs
> > (write, sendfile) would notify the written-to/read-from objects,
> > but splice wouldn't.
> >
> > This affected userspace which uses inotify, most notably coreutils
> > tail -f, to monitor pipes.
> > If the pipe buffer had been filled by a splice-family function:
> >   * tail wouldn't know and thus wouldn't service the pipe, and
> >   * all writes to the pipe would block because it's full,
> > thus service was denied.
> > (For the particular case of tail -f this could be worked around
> >  with ---disable-inotify.)
> >
> 
> Is my understanding of the tail code wrong?
> My understanding was that tail_forever_inotify() is not called for
> pipes, or is it being called when tailing a mixed collection of pipes
> and regular files? If there are subtleties like those you need to
> mention them , otherwise people will not be able to reproduce the
> problem that you are describing.

Well, on my openSUSE 15.4 at least, tail -f does use inotify on FIFOs and
indeed when data is spliced to the FIFO, tail doesn't notice.

> I need to warn you about something regarding this patch -
> often there are colliding interests among different kernel users -
> fsnotify use cases quite often collide with the interest of users tracking
> performance regressions and IN_ACCESS/IN_MODIFY on anonymous pipes
> specifically have been the source of several performance regression reports
> in the past and have driven optimizations like:
> 
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> when there is no watcher")
> e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> 
> The moral of this story is: even if your patches are accepted by fsnotify
> reviewers, once they are staged for merging they will be subject to
> performance regression tests and I can tell you with certainty that
> performance regression will not be tolerated for the tail -f use case.
> I will push your v4 patches to a branch in my github, to let the kernel
> test bots run the performance regressions on it whenever they get to it.
> 
> Moreover, if coreutils will change tail -f to start setting inotify watches
> on anonymous pipes (my understanding is that currently does not?),
> then any tail -f on anonymous pipe can cripple the "no marks on sb"
> performance optimization for all anonymous pipes and that would be
> a *very* unfortunate outcome.

Do you mean the "s_fsnotify_connectors" check? Yeah, a fsnotify watch on
any pipe inode is going to somewhat slow down the fsnotify calls for any
pipe. OTOH I don't expect inotify watches on pipe inodes to be common and
it is not like the overhead is huge. Also nobody really prevents you from
placing watch on pipe inode now with similar consequences, this patch only
makes it actually working with splice. So I'm not worried about the
performance impact. At least until somebody comes with a realistic
complaint ;-).

> I think we need to add a rule to fanotify_events_supported() to ban
> sb/mount marks on SB_KERNMOUNT and backport this
> fix to LTS kernels (I will look into it) and then we can fine tune
> the s_fsnotify_connectors optimization in fsnotify_parent() for
> the SB_KERNMOUNT special case.

Yeah, probably makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
