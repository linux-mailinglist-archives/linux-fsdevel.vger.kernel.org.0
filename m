Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537E7A79F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjITLEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjITLEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:04:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC7B4;
        Wed, 20 Sep 2023 04:04:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1F4721EAD;
        Wed, 20 Sep 2023 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695207869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLPW7WlL8cJf75Le/6G/I8YoVTbk/0STcBuGlCRkC+4=;
        b=GfDE6/EE1ZVgR60BAbcPEW/UiSIFoWSC8rORjuPzKIWWkql046UH0SIdYRUW+oucuw3kmK
        NBcf1uYWDw296IO9BUTg6R+YseK0pFbKbadTDI7o2aJLCNfikhw0AzIMRu77KL5EKPHlnd
        2LkPhFoSDpeiRkqry6RdwNmWX4pYnyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695207869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLPW7WlL8cJf75Le/6G/I8YoVTbk/0STcBuGlCRkC+4=;
        b=UdPscxwfhuHvyiPGUh2gewyU49pCvr7ZOt/hmgOk4aZ29Ak70x9gYRgrFEcvAXhJEVPQZ0
        lFK9DMB1U+rI7PAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92052132C7;
        Wed, 20 Sep 2023 11:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6kqbI73RCmWRLAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 11:04:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DF4CA077D; Wed, 20 Sep 2023 13:04:29 +0200 (CEST)
Date:   Wed, 20 Sep 2023 13:04:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
Message-ID: <20230920110429.f4wkfuls73pd55pv@quack3>
References: <20230411124037.1629654-1-amir73il@gmail.com>
 <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3>
 <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-09-23 11:26:38, Amir Goldstein wrote:
> On Mon, Apr 17, 2023 at 7:27 PM Jan Kara <jack@suse.cz> wrote:
> > > > > My motivation is to close functional gaps between fanotify and inotify.
> > > > >
> > > > > One of the largest gaps right now is that FAN_REPORT_FID is limited
> > > > > to a subset of local filesystems.
> > > > >
> > > > > The idea is to report fid's that are "good enough" and that there
> > > > > is no need to require that fid's can be used by open_by_handle_at()
> > > > > because that is a non-requirement for most use cases, unpriv listener
> > > > > in particular.
> > > >
> > > > OK. I'd note that if you report only inode number, you are prone to the
> > > > problem that some inode gets freed (file deleted) and then reallocated (new
> > > > file created) and the resulting identifier is the same. It can be
> > > > problematic for a listener to detect these cases and deal with them.
> > > > Inotify does not have this problem at least for some cases because 'wd'
> > > > uniquely identifies the marked inode. For other cases (like watching dirs)
> > > > inotify has similar sort of problems. I'm muttering over this because in
> > > > theory filesystems not having i_generation counter on disk could approach
> > > > the problem in a similar way as FAT and then we could just use
> > > > FILEID_INO64_GEN for the file handle.
> > >
> > > Yes, of course we could.
> > > The problem with that is that user space needs to be able to query the fid
> > > regardless of fanotify.
> > >
> > > The fanotify equivalent of wd is the answer to that query.
> > >
> > > If any fs would export i_generation via statx, then FILEID_INO64_GEN
> > > would have been my choice.
> >
> > One problem with making up i_generation (like FAT does it) is that when
> > inode gets reclaimed and then refetched from the disk FILEID_INO64_GEN will
> > change because it's going to have different i_generation. For NFS this is
> > annoying but I suppose it mostly does not happen since client's accesses
> > tend to keep the inode in memory. For fanotify it could be more likely to
> > happen if watching say the whole filesystem and I suppose the watching
> > application will get confused by this. So I'm not convinced faking
> > i_generation is a good thing to do. But still I want to brainstorm a bit
> > about it :)
> >
> > > But if we are going to change some other API for that, I would not change
> > > statx(), I would change name_to_handle_at(...., AT_HANDLE_FID)
> > >
> > > This AT_ flag would relax this check in name_to_handle_at():
> > >
> > >         /*
> > >          * We need to make sure whether the file system
> > >          * support decoding of the file handle
> > >          */
> > >         if (!path->dentry->d_sb->s_export_op ||
> > >             !path->dentry->d_sb->s_export_op->fh_to_dentry)
> > >                 return -EOPNOTSUPP;
> > >
> > > And allow the call to proceed to the default export_encode_fh() implementation.
> > > Alas, the default implementation encodes FILEID_INO32_GEN.
> > >
> > > I think we can get away with a default implementation for FILEID_INO64_GEN
> > > as long as the former (INO32) is used for fs with export ops without ->encode_fh
> > > (e.g. ext*) and the latter (INO64) is used for fs with no export ops.
> >
> > These default calls seem a bit too subtle to me. I'd rather add explicit
> > handlers to filesystems that really want FILEID_INO32_GEN encoding and then
> > have a fallback function for filesystems not having s_export_op at all.
> >
> > But otherwise the proposal to make name_to_handle_at() work even for
> > filesystems not exportable through NFS makes sense to me. But I guess we
> > need some buy-in from VFS maintainers for this.
> >
> 
> Hi Jan,
> 
> I seem to have dropped the ball on this after implementing AT_HANDLE_FID.
> It was step one in a larger plan.

No problem, I forgot about this as well :)

> Christian, Jeff,
> 
> Do you have an objection to this plan:
> 1. Convert all "legacy" FILEID_INO32_GEN fs with non-empty
>     s_export_op and no explicit ->encode_fh() to use an explicit
>     generic_encode_ino32_gen_fh()
> 2. Relax requirement of non-empty s_export_op for AT_HANDLE_FID
>     to support encoding a (non-NFS) file id on all fs
> 3. For fs with empty s_export_op, allow fallback of AT_HANDLE_FID
>     in exportfs_encode_inode_fh() to encode FILEID_INO64_GEN
> 
> 
> > > > Also I have noticed your workaround with using st_dev for fsid. As I've
> > > > checked, there are actually very few filesystems that don't set fsid these
> > > > days. So maybe we could just get away with still refusing to report on
> > > > filesystems without fsid and possibly fixup filesystems which don't set
> > > > fsid yet and are used enough so that users complain?
> > >
> > > I started going down this path to close the gap with inotify.
> > > inotify is capable of watching all fs including pseudo fs, so I would
> > > like to have this feature parity.
> >
> > Well, but with pseudo filesystems (similarly as with FUSE) the notification
> > was always unreliable. As in: some cases worked but others did not. I'm not
> > sure that is something we should try to replicate :)
> >
> > So still I'd be interested to know which filesystems we are exactly
> > interested to support and whether we are not better off to explicitly add
> > fsid support to them like we did for tmpfs.
> >
> 
> Since this email, kernfs derivative fs gained fsid as well.
> Quoting your audit of remaining fs from another thread:
> 
> > ...As far as I remember
> > fanotify should be now able to handle anything that provides f_fsid in its
> > statfs(2) call. And as I'm checking filesystems not setting fsid currently are:
> >
> > afs, coda, nfs - networking filesystems where inotify and fanotify have
> >   dubious value anyway
> 
> Be that as it may, there may be users that use inotify on network fs
> and it even makes a lot of sense in controlled environments with
> single NFS client per NFS export (e.g. home dirs), so I think we will
> need to support those fs as well.

Fair enough.

> Maybe the wise thing to do is to opt-in to monitor those fs after all?
> Maybe with explicit opt-in to watch a single fs, fanotify group will
> limit itself to marks on a specific sb and then a null fsid won't matter?
 
We have virtual filesystems with all sorts of missing or weird notification
functionality and we don't flag that in any way. So making a special flag
for network filesystems seems a bit arbitrary. I'd just make them provide
fsid and be done with it.

> > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstore,
> > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionality is
> >   quite limited. But some special cases could be useful. Adding fsid support
> >   is the same amount of trouble as for kernfs - a few LOC. In fact, we
> >   could perhaps add a fstype flag to indicate that this is a filesystem
> >   without persistent identification and so uuid should be autogenerated on
> >   mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
> >   This way we could handle all these filesystems with trivial amount of
> >   effort.
> >
> 
> Christian,
> 
> I recall that you may have had reservations on initializing s_uuid
> and f_fsid in vfs code?
> Does an opt-in fstype flag address your concerns?
> Will you be ok with doing the tmpfs/kernfs trick for every fs
> that opted-in with fstype flag in generic vfs code?
> 
> > freevxfs - the only real filesystem without f_fsid. Trivial to handle one
> >   way or the other.
> >
> 
> Last but not least, btrfs subvolumes.
> They do have an fsid, but it is different from the sb fsid,
> so we disallow (even inode) fanotify marks.
>
> I am not sure how to solve this one,
> but if we choose to implement the opt-in fanotify flag for
> "watch single fs", we can make this problem go away, along
> with the problem of network fs fsid and other odd fs that we
> do not want to have to deal with.
> 
> On top of everything, it is a fast solution and it doesn't
> involve vfs and changing any fs at all.

Yeah, right, forgot about this one. Thanks for reminding me. But this is
mostly a kernel internal implementation issue and doesn't seem to be a
principial problem so I'd prefer not to complicate the uAPI for this. We
could for example mandate a special super_operation for fetching fsid for a
dentry for filesystems which don't have uniform fsids over the whole
filesystem (i.e., btrfs) and call this when generating event for such
filesystems. Or am I missing some other complication?
 
> > > If we can get away with fallback to s_dev as fsid in vfs_statfs()
> > > I have no problem with that, but just to point out - functionally
> > > it is equivalent to do this fallback in userspace library as the
> > > fanotify_get_fid() LTP helper does.
> >
> > Yes, userspace can workaround this but I was more thinking about avoiding
> > adding these workarounds into fanotify in kernel *and* to userspace.
> >
> > > > > I chose a rather generic name for the flag to opt-in for "good enough"
> > > > > fid's.  At first, I was going to make those fid's self describing the
> > > > > fact that they are not NFS file handles, but in the name of simplicity
> > > > > to the API, I decided that this is not needed.
> > > >
> > > > I'd like to discuss a bit about the meaning of the flag. On the first look
> > > > it is a bit strange to have a flag that says "give me a fh, if you don't
> > > > have it, give me ino". It would seem cleaner to have "give me fh" kind of
> > > > interface (FAN_REPORT_FID) and "give me ino" kind of interface (new
> > > > FAN_REPORT_* flag). I suspect you've chosen the more complex meaning
> > > > because you want to allow a usecase where watches of filesystems which
> > > > don't support filehandles are mixed with watches of filesystems which do
> > > > support filehandles in one notification group and getting filehandles is
> > > > actually prefered over getting just inode numbers? Do you see real benefit
> > > > in getting file handles when userspace has to implement fallback for
> > > > getting just inode numbers anyway?
> > > >
> > >
> > > Yes, there is a benefit, because a real fhandle has no-reuse guarantee.
> > >
> > > Even if we implement the kernel fallback to FILEID_INO64_GEN, it does
> > > not serve as a statement from the filesystem that i_generation is useful
> > > and in fact, i_generation will often be zero in simple fs and ino will be
> > > reusable.
> > >
> > > Also, I wanted to have a design where a given fs/object always returns
> > > the same FID regardless of the init flags.
> > >
> > > Your question implies that if
> > > "userspace has to implement fallback for getting just inode numbers",
> > > then it doesn't matter if we report fhandle or inode, but it is not accurate.
> > >
> > > The fanotify_get_fid() LTP helper always gets a consistent FID for a
> > > given fs/object. You do not need to feed it the fanotify init flags to
> > > provide a consistent answer.
> > >
> > > For all the reasons above, I think that a "give me ino'' flag is not useful.
> > > IMO, the flag just needs better marketing.
> > > This is a "I do not need/intend to open_by_handle flag".
> > > Suggestions for a better name are welcome.
> >
> > I see, yes, these reasons make sense.
> >
> > > For all I care, we do not need to add an opt-in flag at all.
> > > We could simply start to support fs that were not supported before.
> > > This sort of API change is very common and acceptable.
> > >
> > > There is no risk if the user tries to call open_by_handle_at() with the
> > > fanotify encoded FID, because in this case the fs is guaranteed to
> > > return ESTALE, because fs does not support file handles.
> > >
> > > This is especially true, if we can get away with seamless change
> > > of behavior for vfs_statfs(), because that seamless change would
> > > cause FAN_REPORT_FID to start working on fs like fuse that
> > > support file handles and have zero fsid.
> >
> > Yeah. Actually I like the idea of a seamless change to start reporting fsid
> > and also to start reporting "fake" handles. In the past we've already
> > enabled tmpfs like this...
> >
> 
> I am now leaning towards a combination of:
> 1. Seamless change of behavior for vfs_statfs() and
>     name_to_handle_at(..., AT_HANDLE_FID) for the simple cases
>     using an opt-in fstype flag

Ack.

> AND
> 2. Simple interim fallback for other fs with an opt-in fanotify flag (*)

I'm not sold on the special flag yet (see above) ;).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
