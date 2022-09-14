Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF25B8661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiINKaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiINKaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:30:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB23BC5A
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:30:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BA721F88E;
        Wed, 14 Sep 2022 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663151407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKS1qAlRZDm+nKY5tVyiWUcNixRdMbXVkeB5z/uKXKA=;
        b=iQZgVYTp4d/VLwHyHvmYP4H3m4hvuan4aHM9ONc8fVxSVVBOwQ0tblgAezLpukaNdVn/d0
        wHekYVxxLGQtVQgy7xdjvvfzybldO/FwdkEkcAj18s9sIpJcgo2INSroQIMQBrv2GkhgSb
        dALBAWOt1weM5kplQbCOlmRGf4KWxxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663151407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKS1qAlRZDm+nKY5tVyiWUcNixRdMbXVkeB5z/uKXKA=;
        b=sU3nlZkGUfBrq6IMtLQgmi6vif+tspFD5IgU+ezSD0pIvIehCxeXng3fvNsCLvJXhhhhB3
        nVije1dDVNBa5CCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B1A1134B3;
        Wed, 14 Sep 2022 10:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o8avAi+tIWPDSQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 10:30:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0FC4BA0680; Wed, 14 Sep 2022 12:30:06 +0200 (CEST)
Date:   Wed, 14 Sep 2022 12:30:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220914103006.daa6nkqzehxppdf5@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-09-22 10:27:48, Amir Goldstein wrote:
> On Mon, Sep 12, 2022 at 7:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > I have been in contact with some developers in the past
> > > > who were interested in using fanotify to implement HSM
> > > > (to replace old DMAPI implementation).
> > >
> > > Ah, DMAPI. Shiver. Bad memories of carrying that hacky code in SUSE kernels
> > > ;)
> 
> For the record, DMAPI is still partly supported on some proprietary
> filesystems, but even if a full implementation existed, this old API
> which was used for tape devices mostly is not a good fit for modern
> day cloud storage use cases.

Interesting, I didn't know DMAPI still lives :)

> > > So how serious are these guys about HSM and investing into it?
> >
> > Let's put it this way.
> > They had to find a replacement for DMAPI so that they could stop
> > carrying DMAPI patches, so pretty serious.
> > They had to do it one way or the other.
> >
> 
> As mentioned earlier, this is an open source HSM project [1]
> with a release coming soon that is using FAN_OPEN_PERM
> to migrate data from the slower tier.
> 
> As you can imagine, FAN_OPEN_PERM can only get you as far
> as DMAPI but not beyond and it leaves the problem of setting the
> marks on all punched files on bringup.

Sure I can see that FAN_OPEN_PERM works for basic usage but it certainly
leaves room for improvement :)

<snip nice summary of FUSE options>

> > > So I'd prefer to avoid the major API
> > > extension unless there are serious users out there - perhaps we will even
> > > need to develop the kernel API in cooperation with the userspace part to
> > > verify the result is actually usable and useful.
> 
> Yap. It should be trivial to implement a "mirror" HSM backend.
> For example, the libprojfs [5] projects implements a MirrorProvider
> backend for the Microsoft ProjFS [6] HSM API.

Well, validating that things work using some simple backend is one thing
but we are probably also interested in whether the result is practical to
use - i.e., whether the performance meets the needs, whether the API is not
cumbersome for what HSM solutions need to do, whether the more advanced
features like range-support are useful the way they are implemented etc.
We can verify some of these things with simple mirror HSM backend but I'm
afraid some of the problems may become apparent only once someone actually
uses the result in practice and for that we need a userspace counterpart
that does actually something useful so that people have motivation to use
it :).
 
> > > > Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> > > > should be enough to implement a basic HSM, but it is not
> > > > sufficient for implementing more advanced HSM features.
> > > >
> [...]
> > > My main worry here would be that with FAN_FILESYSTEM marks, there will be
> > > far to many events (especially for the lookup & access cases) to reasonably
> > > process. And since the events will be blocking, the impact on performance
> > > will be large.
> > >
> >
> > Right. That problem needs to be addressed.
> >
> > > I think that a reasonably efficient HSM will have to stay in the kernel
> > > (without generating work for userspace) for the "nothing to do" case. And
> > > only in case something needs to be migrated, event is generated and
> > > userspace gets involved. But it isn't obvious to me how to do this with
> > > fanotify (I could imagine it with say overlayfs which is kind of HSM
> > > solution already ;)).
> > >
> 
> It's true, overlayfs is kind of HSM, but:
> - Without swap out to slower tier
> - Without user control over method of swap in from slower tier
> 
> On another thread regarding FUSE-BPF, Miklos also mentioned
> the option to add those features to overlayfs [7] to make it useful
> as an HSM kernel driver.
> 
> So we have at least three options for an HSM kernel driver (FUSE,
> fanotify, overlayfs), but none of them is still fully equipped to drive
> a modern HSM implementation.
> 
> What is clear is that:
> 1. The fast path must not context switch to userspace
> 2. The slow path needs an API for calling into user to migrate files/dirs
> 
> What is not clear is:
> 1. The method to persistently mark files/dirs for fast/slow path
> 2. The API to call into userspace

Agreed.

> Overlayfs provides a method to mark files for slow path
> ('trusted.overlay.metacopy' xattr), meaning file that has metadata
> but not the data, but overlayfs does not provide the API to perform
> "user controlled migration" of the data.
> 
> Instead of inventing a new API for that, I'd rather extend the
> known fanotify protocol and allow the new FAN_XXX_PRE events
> only on filesystems that have the concept of a file without its content
> (a.k.a. metacopy).
> 
> We could say that filesystems that support fscache can also support
> FAN_XXX_PRE events, and perhaps cachefilesd could make use of
> hooks to implement user modules that populate the fscache objects
> out of band.

One possible approach is that we would make these events explicitely
targetted to HSM and generated directly by the filesystem which wants to
support HSM. So basically when the filesystem finds out it needs the data
filled in, it will call something like:

  fsnotify(inode, FAN_PRE_GIVE_ME_DATA, perhaps_some_details_here)

Something like what we currently do for filesystem error events but in this
case the event will work like a permission event. Userspace can be watching
the filesystem with superblock mark to receive these events. The persistent
marking of files is completely left upto the filesystem in this case - it
has to decide when the FAN_PRE_GIVE_ME_DATA event needs to be generated for
an inode.

> There is the naive approach to interpret a "punched hole" in a file as
> "no content" as DMAPI did, to support FAN_XXX_PRE events on
> standard local filesystem (fscache does that internally).
> That would be an opt-in via fanotify_init() flag and could be useful for
> old DMAPI HSM implementations that are converted to use the new API.

I'd prefer to leave these details upto the filesystem wanting to support
HSM and not clutter fanotify API with details about file layout. 

> Practically, the filesystems that allow FAN_XXX_PRE events
> on punched files would need to advertise this support and maintain
> an inode flag (i.e. I_NODATA) to avoid a performance penalty
> on every file access. If we take that route, though, it might be better
> off to let the HSM daemon set this flag explicitly (e.g. chattr +X)
> when punching holes in files and removing the flag explicitly
> when filling the holes.

Again, in what I propose this would be left upto the filesystem - e.g. it
can have inode flag or xattr or something else to carry the information
that this file is under HSM and call fsnotify() when the file is accessed.
It might be challenging to fulfill your desire to generate the event
outside of any filesystem locks with this design though.

> And there is the most flexible option of attaching a BFP filter to
> a filesystem mark, but I am afraid that this program will be limited
> to using information already in the path/dentry/inode struct.
> At least HSM could use an existing arbitrary inode flag
> (e.g. chattr+i) as "persistent marks".
> 
> So many options! I don't know which to choose :)
> 
> If this plan sounds reasonable, I can start with a POC of
> "user controlled copy up/down" for overlayfs, using fanotify
> as the user notification protocol and see where it goes from there.

Yeah, that might be interesting to see as an example. Another example of
"kind-of-hsm" that we already have in the kernel is autofs. So we can think
whether that could be implemented using the scheme we design as an
excercise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
