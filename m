Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3861F23F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 12:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiKGL4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGL42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:56:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E919C35;
        Mon,  7 Nov 2022 03:56:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 678461F88D;
        Mon,  7 Nov 2022 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667822185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAFxQVQuSdUEmDiDci+wNMiu2DcH6WEZgRjsPrlLJSw=;
        b=pr0F6EePjJI+cy5LxOWv2WRjIzFjJzyNNwZNeHvB9FBiSaQz+GBPbLAQsbEPBiXUJbObOt
        XkRaswjUiHOhyegqDVfJ4YUiyuHUI4SO/gKc5e5ZqKDP5RxflUE5rlOMZ7nPPhou03RVw/
        jhClf63TLwj2pZoNWT7atRAu7iXW6ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667822185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAFxQVQuSdUEmDiDci+wNMiu2DcH6WEZgRjsPrlLJSw=;
        b=Xc2MiYNjI9Jnrd0K7ucS+ggZqTgBDBWfXnUZ61adq5qkdQT7XjOKuiNWogpvUz4P7CtK/z
        2kRkW8rYTtaPd0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51B2213AC7;
        Mon,  7 Nov 2022 11:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VHI3E2nyaGM+JAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 11:56:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7BE60A0704; Mon,  7 Nov 2022 12:56:24 +0100 (CET)
Date:   Mon, 7 Nov 2022 12:56:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
Message-ID: <20221107115624.j2ilaotaigrqiheu@quack3>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221101175144.yu3l5qo5gfwfpatt@quack3>
 <877d0eh03t.fsf@oracle.com>
 <20221102175224.iacden3lq4oksmof@quack3>
 <87y1sqfg75.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1sqfg75.fsf@oracle.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 04-11-22 16:33:18, Stephen Brennan wrote:
> Jan Kara <jack@suse.cz> writes:
> > On Tue 01-11-22 13:48:54, Stephen Brennan wrote:
> >> Jan Kara <jack@suse.cz> writes:
> >> > Hi Stephen!
> >> >
> >> > On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
> >> >> Here is v3 of the patch series. I've taken all of the feedback,
> >> >> thanks Amir, Christian, Hilf, et al. Differences are noted in each
> >> >> patch.
> >> >> 
> >> >> I caught an obvious and silly dentry reference leak: d_find_any_alias()
> >> >> returns a reference, which I never called dput() on. With that change, I
> >> >> no longer see the rpc_pipefs issue, but I do think I need more testing
> >> >> and thinking through the third patch. Al, I'd love your feedback on that
> >> >> one especially.
> >> >> 
> >> >> Thanks,
> >> >> Stephen
> >> >> 
> >> >> Stephen Brennan (3):
> >> >>   fsnotify: Use d_find_any_alias to get dentry associated with inode
> >> >>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
> >> >>   fsnotify: allow sleepable child flag update
> >> >
> >> > Thanks for the patches Stephen and I'm sorry for replying somewhat late.
> >> 
> >> Absolutely no worries, these things take time. Thanks for taking a look!
> >> 
> >> > The first patch is a nobrainer. The other two patches ... complicate things
> >> > somewhat more complicated than I'd like. I guess I can live with them if we
> >> > don't find a better solution but I'd like to discuss a bit more about
> >> > alternatives.
> >> 
> >> Understood!
> >> 
> >> > So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
> >> > __fsnotify_parent() for the dentry which triggered the event and does not
> >> > have watched parent anymore and never bother with full children walk? I
> >> > suppose your contention problems will be gone, we'll just pay the price of
> >> > dget_parent() + fsnotify_inode_watches_children() for each child that
> >> > falsely triggers instead of for only one. Maybe that's not too bad? After
> >> > all any event upto this moment triggered this overhead as well...
> >> 
> >> This is an interesting idea. It came across my mind but I don't think I
> >> considered it seriously because I assumed that it was too big a change.
> >> But I suppose in the process I created an even bigger change :P
> >> 
> >> The false positive dget_parent() + fsnotify_inode_watches_children()
> >> shouldn't be too bad. I could see a situation where there's a lot of
> >> random accesses within a directory, where the dget_parent() could cause
> >> some contention over the parent dentry. But to be fair, the performance
> >> would have been the same or worse while fsnotify was active in that
> >> case, and the contention would go away as most of the dentries get their
> >> flags cleared. So I don't think this is a problem.
> >> 
> >> > Am I missing something?
> >> 
> >> I think there's one thing missed here. I understand you'd like to get
> >> rid of the extra flag in the connector. But the advantage of the flag is
> >> avoiding duplicate work by saving a bit of state. Suppose that a mark is
> >> added to a connector, which causes fsnotify_inode_watches_children() to
> >> become true. Then, any subsequent call to fsnotify_recalc_mask() must
> >> call __fsnotify_update_child_dentry_flags(), even though the child
> >> dentry flags don't need to be updated: they're already set. For (very)
> >> large directories, this can take a few seconds, which means that we're
> >> doing a few extra seconds of work each time a new mark is added to or
> >> removed from a connector in that case. I can't imagine that's a super
> >> common workload though, and I don't know if my customers do that (my
> >> guess would be no).
> >
> > I understand. This basically matters for fsnotify_recalc_mask(). As a side
> > note I've realized that your changes to fsnotify_recalc_mask() acquiring
> > inode->i_rwsem for updating dentry flags in patch 2/3 are problematic for
> > dnotify because that calls fsnotify_recalc_mask() under a spinlock.
> > Furthermore it is somewhat worrying also for inotify & fanotify because it
> > nests inode->i_rwsem inside fsnotify_group->lock however I'm not 100% sure
> > something doesn't force the ordering the other way around (e.g. the removal
> > of oneshot mark during modify event generation). Did you run tests with
> > lockdep enabled?
> 
> No I didn't. I'll be sure to get the LTP tests running with lockdep
> early next week and try this series out, we'll probably get an error
> like you say.
> 
> I'll also take a look at the dnotify use case and see if there's
> anything to do there. Hopefully there's something we can do to salvage
> it :D

Yeah, dnotify should be solvable. I'm even willing to accept somewhat
unusual methods for dnotify ;). It is ancient and rarely used API these
days so I don't want it to block fixes for newer APIs. From a quick look it
should be enough to move fsnotify_recalc_mask() call in
dnotify_recalc_inode_mask() from under the mark->lock out into callers and
perhaps rename dnotify_recalc_inode_mask() to dnotify_recalc_mark_mask()
to make the name somewhat less confusing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
