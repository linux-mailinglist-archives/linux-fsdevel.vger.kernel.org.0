Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F8617D26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKCM5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCM5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:57:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A6110B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 05:57:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0BFE421F75;
        Thu,  3 Nov 2022 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667480269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpMncsQuvTNh0qVP7yCDVYP3Jk7EYp9sdNoeghL/3Mw=;
        b=Npa4bRhlcSEDUmPmfn3HeaHd1jhewurYhJHvzyaKqTzRbWJeI/XxBQU4NcXvy6YDY0cbeU
        EAbpifl3Zpt1/RCUOBzIJgxzMnlmImb3bqF+sd86fWctALfbYAhmUoH+29eRbhu06Dp36j
        n9msLf2lZkEDmXN9oHdCrucwlasQO3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667480269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpMncsQuvTNh0qVP7yCDVYP3Jk7EYp9sdNoeghL/3Mw=;
        b=3lR2NW/67PL6Ob1hFyx3Q156K/ncupBcLTG15ej+j033LAQEE3u8IWN+GznFambUM8iT/w
        uJZXLKyZDZsvxJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D928813AAF;
        Thu,  3 Nov 2022 12:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q92DNMy6Y2M/TQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Nov 2022 12:57:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39EA5A0700; Thu,  3 Nov 2022 13:57:48 +0100 (CET)
Date:   Thu, 3 Nov 2022 13:57:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221103125748.474y4l3vf2h62mot@quack3>
References: <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3>
 <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
 <20220929100145.wruxmbwapjn6dapy@quack3>
 <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
 <20221012154402.h5al3junehejsv24@quack3>
 <CAOQ4uxjY3eDtqXObbso1KtZTMB7+zYHBRiUANg12hO=T=vqJrw@mail.gmail.com>
 <CAOQ4uxi7Y_W+-+TiveYWixk4vYauSQuNAfFFZyEAVPUehT_Gaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7Y_W+-+TiveYWixk4vYauSQuNAfFFZyEAVPUehT_Gaw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm sorry for the really delayed response. We had an internal conference
and some stuff around that which made me busy.

On Thu 13-10-22 15:16:25, Amir Goldstein wrote:
> On Wed, Oct 12, 2022 at 7:28 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Oct 12, 2022 at 6:44 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi Amir!
> > >
> > > On Fri 07-10-22 16:58:21, Amir Goldstein wrote:
> > > > > > The other use case of automatic inode marks I was thinking about,
> > > > > > which are even more relevant for $SUBJECT is this:
> > > > > > When instantiating a dentry with an inode that has xattr
> > > > > > "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> > > > > > mark could be auto created and attached to a group with a special sb
> > > > > > mark (we can limit a single special mark per sb).
> > > > > > This could be implemented similar to get_acl(), where i_fsnotify_mask
> > > > > > is always initialized with a special value (i.e. FS_UNINITIALIZED)
> > > > > > which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> > > > > >
> > > > > > The details of how such an API would look like are very unclear to me,
> > > > > > so I will try to focus on the recursive auto inode mark idea.
> > > > >
> > > > > Yeah, although initializing fanotify marks based on xattrs does not look
> > > > > completely crazy I can see a lot of open questions there so I think
> > > > > automatic inode mark idea has more chances for success at this point :).
> > > >
> > > > I realized that there is one sort of "persistent mark" who raises
> > > > less questions - one that only has an ignore mask.
> > > >
> > > > ignore masks can have a "static" namespace that is not bound to any
> > > > specific group, but rather a set of groups that join this namespace.
> > > >
> > > > I played with this idea and wrote some patches:
> > > > https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask
> > >
> > > I have glanced over the patches. In general the idea looks OK to me but I
> > > have some concerns:
> > >
> > > 1) Technically, it may be challenging to call into filesystem xattr
> > > handling code on first event generated by the inode - that may generate
> > > some unexpected lock recursion for some filesystems and some events which
> > > trigger the initialization...
> >
> > That may be a correct statement in general, but please note that
> > - Only permission events trigger auto-init of xattr ignore mask
> > - Permission events are called from security hooks
> > - Security hooks may also call getxattr to get the security context
> >
> > Perhaps LSMs always initialize the security context in OPEN and
> > never in ACCESS?
> >
> > One of the earlier versions of the patch initialized xattr ignore mask
> > on LOOKUP permission event, if ANY object was interested in ANY
> > permission event even if no object was interested in LOOKUP
> > to mimic the LSM context initialization,
> > but it was complicated and I wasn't sure if this was necessary.
> >
> 
> Also, permission events can sleep by definition
> so why would getxattr not be safe in the
> context of permission events handling?

Well, I'm not afraid of sleeping. I was more worried about lock ordering
issues. But are right that this probably isn't going to be an issue.

> > > 2) What if you set the xattr while the group is already listening to
> > > events? Currently the change will get ignored, won't it? But I guess this
> > > could be handled by clearing the "cached" flag when the xattr is set.
> > >
> >
> > I have created an API to update the xattr via
> >   fanotify_mark(FAN_MARK_XATTR, ...
> > which updates the cached ignore mask in the connector.
> >
> > I see no reason to support "direct" modifications of this xattr.
> > If such changes are made directly it is fine to ignore them.
> >
> > > 3) What if multiple applications want to use the persistent mark
> > > functionality? I think we need some way to associate a particular
> > > fanotify group with a particular subset of fanotify xattrs so that
> > > coexistence of multiple applications is possible...
> > >
> >
> > Yeh, I thought about this as well.
> > The API in the patches is quite naive because it implements a single
> > global namespace for xattr ignore masks, but mostly I wanted to
> > see if I can get the fast path and auto-init implementation done.
> >
> > I was generally thinking of ioctl() as the API to join an xattr marks
> > namespace and negotiate the on-disk format of persistent marks
> > supported by the application.
> >
> > I would not want to allow multiple fanotify xattrs per inode -
> > that could have the consequence of the inode becoming a junkyard.
> >
> > I'd prefer to have a single xattr (say security.fanotify.mark)
> > and that mark will have
> > - on-disk format version
> > - namespace id
> > - ignore mask
> > - etc
> >
> > If multiple applications want to use persistent marks they need to figure
> > out how to work together without stepping on each other's toes.
> > I don't think it is up to fanotify to coordinate that.

I'm not sure if this really scales. Imagine you have your say backup
application that wants to use persistent marks and then you have your HSM
application wanting to do the same. Or you have some daemon caching
preparsed contents of config/ directory and watching whether it needs to
rescan the dir and rebuild the cache using persistent marks (I'm hearing
requests like these for persistent marks from desktop people for many
years). How exactly are these going to coordinate?

I fully understand your concern about the clutter in inode xattrs but if
we're going to limit the kernel to support only one persistent marks user,
then IMO we also need to provide a userspace counterpart (in the form of
some service or library like persistent change notification journal) that
will handle the coordination. Because otherwise it will become a mess
rather quickly.

> > fanotify_mark() can fail with EEXIST when a group that joined namespace A
> > is trying to update a persistent mark when a persistent mark of namespace B
> > already exists and probably some FAN_MARK_REPLACE flag could be used
> > to force overwrite the existing persistent mark.
> 
> One thing that I feel a bit silly about is something that I only fully
> noticed after writing this WIP wiki entry:
> https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#persistent-inode-marks
> 
> Persistent marks (in xattr) with ignore mask are useful, but only a
> little bit more useful than Evictable marks with ignore mask.
> 
> Persistent marks (in xattr) with a "positive" event mask are the real deal.
> Because with "positive" persistent marks, we will be able to optimize away
> srcu_read_lock() and marks iteration for the majority of fsnotify hooks
> by looking at objects interest masks (including the FS_XATTR_CACHED bit).
> 
> The good thing about the POC patches [1] is that there is no technical
> limitation in this code for using persistent marks with positive event
> masks.  It is a bit more challenging to document the fact that a "normal"
> fs/mount mark is needed in order to "activate" the persistent marks in
> the inodes of this fs/mount, but the changes to the code to support that
> would be minimal.

I agree persistent positive marks are very interesting (in fact I've heard
requests for functionality like this about 15 years ago :)). But if you'd
like to use them e.g. for backup or HSM then you need to somehow make sure
you didn't miss any events before you created the activation mark? That
looks like a bit unpleasant race with possible data (backup) corruption
consequences?

> [1] https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
