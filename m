Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01399616B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKBRw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKBRw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:52:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960412DAA2;
        Wed,  2 Nov 2022 10:52:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BE5C1F855;
        Wed,  2 Nov 2022 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667411545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OOSqGkoURhhL4+gF2vwCqYB+UasaAQlh1zzbjnsH8o=;
        b=wO7hUFISvjCPUpYpk+VsVF37M1mDlu6W0GzEuib0d3ku6zE7wO6qMRJknkxrVQOXEYu7ZS
        9iacyul1G46jLeBOod3N9+Y3jkCvjx0xxiYnTcT5JWsKBt5/kRgZhE4VAoTr+J5yCUbn2X
        knZiTFJKHX39331zBMJkY16+yviru3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667411545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OOSqGkoURhhL4+gF2vwCqYB+UasaAQlh1zzbjnsH8o=;
        b=Vl+7TWNP/tw4XLj/8A+yhD1ExsCs3ceCbZdSU3q7ayohjTkWaSv2dgoR+MPr6mE88hzTX7
        mEcrGapO0uaCctBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B80D139D3;
        Wed,  2 Nov 2022 17:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z+uDDlmuYmNXSwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Nov 2022 17:52:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BE93BA0700; Wed,  2 Nov 2022 18:52:24 +0100 (CET)
Date:   Wed, 2 Nov 2022 18:52:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
Message-ID: <20221102175224.iacden3lq4oksmof@quack3>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221101175144.yu3l5qo5gfwfpatt@quack3>
 <877d0eh03t.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d0eh03t.fsf@oracle.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 01-11-22 13:48:54, Stephen Brennan wrote:
> Jan Kara <jack@suse.cz> writes:
> > Hi Stephen!
> >
> > On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
> >> Here is v3 of the patch series. I've taken all of the feedback,
> >> thanks Amir, Christian, Hilf, et al. Differences are noted in each
> >> patch.
> >> 
> >> I caught an obvious and silly dentry reference leak: d_find_any_alias()
> >> returns a reference, which I never called dput() on. With that change, I
> >> no longer see the rpc_pipefs issue, but I do think I need more testing
> >> and thinking through the third patch. Al, I'd love your feedback on that
> >> one especially.
> >> 
> >> Thanks,
> >> Stephen
> >> 
> >> Stephen Brennan (3):
> >>   fsnotify: Use d_find_any_alias to get dentry associated with inode
> >>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
> >>   fsnotify: allow sleepable child flag update
> >
> > Thanks for the patches Stephen and I'm sorry for replying somewhat late.
> 
> Absolutely no worries, these things take time. Thanks for taking a look!
> 
> > The first patch is a nobrainer. The other two patches ... complicate things
> > somewhat more complicated than I'd like. I guess I can live with them if we
> > don't find a better solution but I'd like to discuss a bit more about
> > alternatives.
> 
> Understood!
> 
> > So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
> > __fsnotify_parent() for the dentry which triggered the event and does not
> > have watched parent anymore and never bother with full children walk? I
> > suppose your contention problems will be gone, we'll just pay the price of
> > dget_parent() + fsnotify_inode_watches_children() for each child that
> > falsely triggers instead of for only one. Maybe that's not too bad? After
> > all any event upto this moment triggered this overhead as well...
> 
> This is an interesting idea. It came across my mind but I don't think I
> considered it seriously because I assumed that it was too big a change.
> But I suppose in the process I created an even bigger change :P
> 
> The false positive dget_parent() + fsnotify_inode_watches_children()
> shouldn't be too bad. I could see a situation where there's a lot of
> random accesses within a directory, where the dget_parent() could cause
> some contention over the parent dentry. But to be fair, the performance
> would have been the same or worse while fsnotify was active in that
> case, and the contention would go away as most of the dentries get their
> flags cleared. So I don't think this is a problem.
> 
> > Am I missing something?
> 
> I think there's one thing missed here. I understand you'd like to get
> rid of the extra flag in the connector. But the advantage of the flag is
> avoiding duplicate work by saving a bit of state. Suppose that a mark is
> added to a connector, which causes fsnotify_inode_watches_children() to
> become true. Then, any subsequent call to fsnotify_recalc_mask() must
> call __fsnotify_update_child_dentry_flags(), even though the child
> dentry flags don't need to be updated: they're already set. For (very)
> large directories, this can take a few seconds, which means that we're
> doing a few extra seconds of work each time a new mark is added to or
> removed from a connector in that case. I can't imagine that's a super
> common workload though, and I don't know if my customers do that (my
> guess would be no).

I understand. This basically matters for fsnotify_recalc_mask(). As a side
note I've realized that your changes to fsnotify_recalc_mask() acquiring
inode->i_rwsem for updating dentry flags in patch 2/3 are problematic for
dnotify because that calls fsnotify_recalc_mask() under a spinlock.
Furthermore it is somewhat worrying also for inotify & fanotify because it
nests inode->i_rwsem inside fsnotify_group->lock however I'm not 100% sure
something doesn't force the ordering the other way around (e.g. the removal
of oneshot mark during modify event generation). Did you run tests with
lockdep enabled?

Anyway, if the lock ordering issues can be solved, I suppose we can
optimize fsnotify_recalc_mask() like:

	inode_lock(inode);
	spin_lock(&conn->lock);
	oldmask = inode->i_fsnotify_mask;
	__fsnotify_recalc_mask(conn);
	newmask = inode->i_fsnotify_mask;
	spin_unlock(&conn->lock);
	if (watching children changed(oldmask, newmask))
		__fsnotify_update_child_dentry_flags(...)
	inode_unlock(inode);

And because everything is serialized by inode_lock, we don't have to worry
about inode->i_fsnotify_mask and dentry flags getting out of sync or some
mark addition returning before all children are marked for reporting
events. No need for the connector flag AFAICT.

But the locking issue needs to be resolved first in any case. I need to
think some more...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
