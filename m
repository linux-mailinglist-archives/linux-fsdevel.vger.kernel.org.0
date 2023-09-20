Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB47A83D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbjITNsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjITNsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:48:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A754DE;
        Wed, 20 Sep 2023 06:48:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75AD221CAA;
        Wed, 20 Sep 2023 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695217710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG2hkP47QelhfijYjSl97U2+RYa0g9PVy/TKx2M2yf0=;
        b=CvbZeEoTjRLcV8lB7ky4jc/8h3R2xU1Zkt2GAFmQSF0qcrRljlzBPwhio2YVYca1doQAcW
        t4a2fU3p+NOe68aXFxQzvC3QGkcWyIhPXVq39kRP3HO4VeItReJppP3VK0/E9L37nH8gvJ
        JKnLfYJSrPrAUeeE3uSPMO5FE3/eo1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695217710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG2hkP47QelhfijYjSl97U2+RYa0g9PVy/TKx2M2yf0=;
        b=I0lVFltHmaQKVVXUPhSOfpGM0vRAFjuP9j0WISQnP14JU0DOj2RFpO4kziMjhvj+xp2PNL
        ctQ/8EnKRHEcsACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66AD81333E;
        Wed, 20 Sep 2023 13:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pVoLGS74CmXGCwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 13:48:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EB376A077D; Wed, 20 Sep 2023 15:48:29 +0200 (CEST)
Date:   Wed, 20 Sep 2023 15:48:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
Message-ID: <20230920134829.n74smxum27herhl6@quack3>
References: <20230411124037.1629654-1-amir73il@gmail.com>
 <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3>
 <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3>
 <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-09-23 15:41:06, Amir Goldstein wrote:
> On Wed, Sep 20, 2023 at 2:04 PM Jan Kara <jack@suse.cz> wrote:
> > On Wed 20-09-23 11:26:38, Amir Goldstein wrote:
> > > Be that as it may, there may be users that use inotify on network fs
> > > and it even makes a lot of sense in controlled environments with
> > > single NFS client per NFS export (e.g. home dirs), so I think we will
> > > need to support those fs as well.
> >
> > Fair enough.
> >
> > > Maybe the wise thing to do is to opt-in to monitor those fs after all?
> > > Maybe with explicit opt-in to watch a single fs, fanotify group will
> > > limit itself to marks on a specific sb and then a null fsid won't matter?
> >
> > We have virtual filesystems with all sorts of missing or weird notification
> > functionality and we don't flag that in any way. So making a special flag
> > for network filesystems seems a bit arbitrary. I'd just make them provide
> > fsid and be done with it.
> >
> 
> OK. I will try.
> 
> However, in reply to Jeff's comment:
> 
> > Caution here. Most of these filesystems don't have protocol support for
> > anything like inotify (the known exception being SMB). You can monitor
> > such a network filesystem, but you won't get events for things that
> > happen on remote hosts.
> 
> Regardless of the fsid question, when we discussed remote notifications
> support for FUSE/SMB, we raised the point that which notifications the
> user gets (local or remote) are ambiguous and one suggestion was to
> be explicit about requesting LOCAL or REMOTE notifications (or both).
> 
> Among the filesystems that currently support fanotify, except for the
> most recent kernfs family, I think all of them are "purely local".
> For the purpose of this discussion I consider debugfs and such to have
> REMOTE notifications, which are not triggered from user vfs syscalls.

Well, now you are speaking of FAN_REPORT_FID mode. There I agree we
currently support only filesystems with a sane behavior. But there are
definitely existing users of fanotify in "standard" file-descriptor mode
for filesystems such as sysfs, proc, etc. So the new flag would have to
change behavior only to FAN_REPORT_FID groups and that's why I think it's a
bit odd.

> The one exception is smb, but only with config CIFS_NFSD_EXPORT
> and that one depends on BROKEN.
> 
> If we did want to require an explicit FAN_LOCAL_NOTIF flag to allow
> setting marks on fs which may have changes not via local syscalls,
> it may be a good idea to flag those fs and disallow them without explicit
> opt-in, before we add fanotify support to fs with missing notifications?
> Perhaps before the official release of 6.6?

Yeah, overall I agree it would be nice to differentiate filesystems where
we aren't going to generate all the events. But as I write above, there are
already existing users for non-FID mode so we cannot have that flag in the
general setting.

> > > > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstore,
> > > > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionality is
> > > >   quite limited. But some special cases could be useful. Adding fsid support
> > > >   is the same amount of trouble as for kernfs - a few LOC. In fact, we
> > > >   could perhaps add a fstype flag to indicate that this is a filesystem
> > > >   without persistent identification and so uuid should be autogenerated on
> > > >   mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
> > > >   This way we could handle all these filesystems with trivial amount of
> > > >   effort.
> > > >
> > >
> > > Christian,
> > >
> > > I recall that you may have had reservations on initializing s_uuid
> > > and f_fsid in vfs code?
> > > Does an opt-in fstype flag address your concerns?
> > > Will you be ok with doing the tmpfs/kernfs trick for every fs
> > > that opted-in with fstype flag in generic vfs code?
> > >
> > > > freevxfs - the only real filesystem without f_fsid. Trivial to handle one
> > > >   way or the other.
> > > >
> > >
> > > Last but not least, btrfs subvolumes.
> > > They do have an fsid, but it is different from the sb fsid,
> > > so we disallow (even inode) fanotify marks.
> > >
> > > I am not sure how to solve this one,
> > > but if we choose to implement the opt-in fanotify flag for
> > > "watch single fs", we can make this problem go away, along
> > > with the problem of network fs fsid and other odd fs that we
> > > do not want to have to deal with.
> > >
> > > On top of everything, it is a fast solution and it doesn't
> > > involve vfs and changing any fs at all.
> >
> > Yeah, right, forgot about this one. Thanks for reminding me. But this is
> > mostly a kernel internal implementation issue and doesn't seem to be a
> > principial problem so I'd prefer not to complicate the uAPI for this. We
> > could for example mandate a special super_operation for fetching fsid for a
> > dentry for filesystems which don't have uniform fsids over the whole
> > filesystem (i.e., btrfs) and call this when generating event for such
> > filesystems. Or am I missing some other complication?
> >
> 
> The problem is the other way around :)
> btrfs_statfs() takes a dentry and returns the fsid of the subvolume.
> That is the fsid that users will get when querying the path to be marked.

Yup.

> If users had a flag to statfs() to request the "btrfs root volume fsid",
> then fanotify could also report the root fsid and everyone will be happy
> because the btrfs file handle already contains the subvolume root
> object id (FILEID_BTRFS_WITH_PARENT_ROOT), but that is not
> what users get for statfs() and that is not what fanotify documentation
> says about how to query fsid.
> 
> We could report the subvolume fsid for marked inode/mount
> that is not a problem - we just cache the subvol fsid in inode/mount
> connector, but that fsid will be inconsistent with the fsid in the sb
> connector, so the same object (in subvolume) can get events
> with different fsid (e.g. if one event is in mask of sb and another
> event is in mask of inode).

Yes. I'm sorry I didn't describe all the details. My idea was to report
even on a dentry with the fsid statfs(2) would return on it. We don't want
to call dentry_statfs() on each event (it's costly and we don't always have
the dentry available) but we can have a special callback into the
filesystem to get us just the fsid (which is very cheap) and call *that* on
the inode on which the event happens to get fsid for the event. So yes, the
sb mark would be returning events with different fsids for btrfs. Or we
could compare the obtained fsid with the one in the root volume and ignore
the event if they mismatch (that would be more like the different subvolume
=> different filesystem point of view and would require some more work on
fanotify side to remember fsid in the sb mark and not in the sb connector).

> As Jeff said, nfsd also have issues with exporting btrfs subvolumes,
> because of these oddities and I have no desire to solve those issues.
> 
> I think we could relax the EXDEV case for unpriv fanotify, because
> inode marks should not have this problem?

Yes, inode marks definitely don't have the problem so enabling them is a
no-brainer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
