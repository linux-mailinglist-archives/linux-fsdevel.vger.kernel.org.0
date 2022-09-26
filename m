Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3345EACC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIZQlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIZQkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:40:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0B146610
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 08:27:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B93421B5F;
        Mon, 26 Sep 2022 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664206056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=St3Rveq1F6hH7wkXZJ7IZVPaF1fjB2VcqWhzVZfT/JI=;
        b=ZPj36r6/cssaWoJ6LIsBsuSHs/qlFO8MXA8fo3MnevdYhZTHsvUjmkf0F3VEEIiP5kaTE5
        vAQk440cOL3D5XKbU+IsPUTuwu9rLIvv3R6w/+f7PSV5LIzqsFPDj8VOuQ6BU7jvZk3d7M
        Fem6Lfr2Lp00ZKGM8KDQcsFmlkKpowQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664206056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=St3Rveq1F6hH7wkXZJ7IZVPaF1fjB2VcqWhzVZfT/JI=;
        b=jcPMoe+gVnhSwU89LqT+4oV4hBwGcOyvb7y/8YT/7WTSVQ9IuTxrLvYTnmLGMfkIYCTf1Q
        f60k3Kwi0hw6RiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4710413486;
        Mon, 26 Sep 2022 15:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7vdTEejEMWOBJAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 15:27:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2191A0685; Mon, 26 Sep 2022 17:27:35 +0200 (CEST)
Date:   Mon, 26 Sep 2022 17:27:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Fufu Fang <fangfufu2003@gmail.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220926152735.fgvx37rppdfhuokz@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 16:03:41, Amir Goldstein wrote:
> On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 20-09-22 21:19:25, Amir Goldstein wrote:
> > > For the next steps of POC, I could do:
> > > - Report FAN_ACCESS_PERM range info to implement random read
> > >   patterns (e.g. unzip -l)
> > > - Introduce FAN_MODIFY_PERM, so file content could be downloaded
> > >   before modifying a read-write HSM cache
> > > - Demo conversion of a read-write FUSE HSM implementation
> > >   (e.g. https://github.com/volga629/davfs2)
> > > - Demo HSM with filesystem mark [*] and a hardcoded test filter
> > >
> > > [*] Note that unlike the case with recursive inotify, this POC HSM
> > > implementation is not racy, because of the lookup permission events.
> > > A filesystem mark is still needed to avoid pinning all the unpopulated
> > > cache tree leaf entries to inode cache, so that this HSM could work on
> > > a very large scale tree, the same as my original use case for implementing
> > > filesystem mark.
> >
> > Sounds good! Just with your concern about pinning - can't you use evictable
> > marks added on lookup for files / dirs you want to track? Maybe it isn't
> > great design for other reasons but it would save you some event
> > filtering...
> >
> 
> With the current POC, there is no trigger to re-establish the evicted mark,
> because the parent is already populated and has no mark.

So my original thinking was that you'd place FAN_LOOKUP_PERM mark on top of
the directory tree and then you'd add evictable marks to all the subdirs
that are looked up from the FAN_LOOKUP_PERM event handler. That way I'd
imagine you can place evictable marks on all directories that are used in a
race-free manner.

> A hook on instantiate of inode in inode cache could fill that gap.
> It could still be useful to filter FAN_INSTANTIATE_PERM events in the
> kernel but it is not a must because instantiate is more rare than (say) lookup
> and then the fast lookup path (RCU walk) on populated trees suffers almost
> no overhead when the filesystem is watched.
> 
> Please think about this and let me know if you think that this is a direction
> worth pursuing, now, or as a later optimization.

I think an event on instantiate seems to be depending too much on kernel
internals instead of obvious filesystem operations. Also it might be a bit
challenging during startup when you don't know what is cached and what not
so you cannot rely on instantiate events for placing marks. So I'd leave
this for future optimization.

> > > If what you are looking for is an explanation why fanotify HSM would be better
> > > than a FUSE HSM implementation then there are several reasons.
> > > Performance is at the top of the list. There is this famous USENIX paper [3]
> > > about FUSE passthrough performance.
> > > It is a bit outdated, but many parts are still relevant - you can ask
> > > the Android
> > > developers why they decided to work on FUSE-BFP...
> > >
> > > [3] https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf
> > >
> > > For me, performance is one of the main concerns, but not the only one,
> > > so I am not entirely convinced that a full FUSE-BFP implementation would
> > > solve all my problems.
> > >
> > > When scaling to many millions of passthrough inodes, resource usage start
> > > becoming a limitation of a FUSE passthrough implementation and memory
> > > reclaim of native fs works a lot better than memory reclaim over FUSE over
> > > another native fs.
> > >
> > > When the workload works on the native filesystem, it is also possible to
> > > use native fs features (e.g. XFS ioctls).
> >
> > OK, understood. Out of curiosity you've mentioned you'd looked into
> > implementing HSM in overlayfs. What are the issues there? I assume
> > performance is very close to native one so that is likely not an issue and
> > resource usage you mention above likely is not that bad either. So I guess
> > it is that you don't want to invent hooks for userspace for moving (parts
> > of) files between offline storage and the local cache?
> 
> In a nutshell, when realizing that overlayfs needs userspace hooks
> to cater HSM, it becomes quite useless to use a stacked fs design.
> 
> Performance is not a problem with overlayfs, but like with FUSE,
> all the inodes/dentries in the system double, memory reclaim
> of layered fs becomes an awkward dance, which messes with the
> special logic of xfs shrinkers, and on top of all this, overlayfs does
> not proxy all the XFS ioctls either.
> 
> The fsnotify hooks are a much better design when realizing that
> the likely() case is to do nothing and incur least overhead and
> the unlikely() case of user hook is rare.

OK, understood. Thanks!

> > The remaining concern I have is that we should demonstrate the solution is
> > able to scale to millions of inodes (and likely more) because AFAIU that
> > are the sizes current HSM solutions are interested in. I guess this is kind
> > of covered in your last step of POCs though.
> >
> 
> Well, in $WORK we have performance test setups for those workloads,
> so part of my plan is to convert the in-house FUSE HSM
> to fanotify and make sure that all those tests do not regress.
> But that is not code, nor tests that I can release, I can only report back
> that the POC works and show the building blocks that I used on
> some open source code base.

Even this is useful I think.

> I plan to do the open source small scale POC first to show the
> building blocks so you could imagine the end results and
> then take the building blocks for a test drive in the real world.
> 
> I've put my eye on davfs2 [1] as the code base for read-write HSM
> POC, but maybe I will find an S3 FUSE fs that could work too
> I am open to other suggestions.
> 
> [1] https://github.com/volga629/davfs2
> 
> When DeepSpace Storage releases their product to github,
> I will be happy to work with them on a POC with their code
> base and I bet they could arrange a large scale test setup.
> (hint hint).

:-)

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
