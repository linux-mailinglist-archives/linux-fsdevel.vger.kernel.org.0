Return-Path: <linux-fsdevel+bounces-1241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6327D8264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A97D281FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F592D7BF;
	Thu, 26 Oct 2023 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSYCcZk+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDobBLbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A72D7B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 12:17:38 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB1B9;
	Thu, 26 Oct 2023 05:17:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4150521AB5;
	Thu, 26 Oct 2023 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698322655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NR2l8V1cvlS3VC1AbzLrfqK8FhV3SgS3by08l7Z+82o=;
	b=sSYCcZk+yDDgpOpA8yS+lH8BnKu8YNkFvdOYvTk1jgpiWEECkofxHK3vCxDvYkR16U/AEg
	cPb14shKD5da1ZZ7V1woxchBwhccKpwvXdQoebCI4Dzn5FwhhyNbUb7mJBj8DSkjm/fY/e
	VVXkEEi47QKTrg1aOdI0yBa0RC6T6hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698322655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NR2l8V1cvlS3VC1AbzLrfqK8FhV3SgS3by08l7Z+82o=;
	b=MDobBLbQnFMRjkinkoFjI6+BnCS5r61YLM8aSWSXMfDlB+94EnimpkUwUJrPOdvsS8nMHQ
	5qatfUHS9lKjh3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 302DE1358F;
	Thu, 26 Oct 2023 12:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mpC9C99YOmWtDgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 12:17:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9446AA05BC; Thu, 26 Oct 2023 14:17:34 +0200 (CEST)
Date: Thu, 26 Oct 2023 14:17:34 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231026121734.o4k7djftwdnectq4@quack3>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <CAOQ4uxg2uFz8bR37bwR_OwnDkq5C7NG+hoqu=7gwSC5Zjd4Ccg@mail.gmail.com>
 <CAOQ4uxjJFyXUOP_46O9erdCEmwctBc8BVJU_jTzyX4d+m0gFyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjJFyXUOP_46O9erdCEmwctBc8BVJU_jTzyX4d+m0gFyg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 25-10-23 21:02:45, Amir Goldstein wrote:
> On Wed, Oct 25, 2023 at 8:17 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 4:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Jan,
> > >
> > > This patch set implements your suggestion [1] for handling fanotify
> > > events for filesystems with non-uniform f_fsid.
> > >
> > > With these changes, events report the fsid as it would be reported
> > > by statfs(2) on the same objet, i.e. the sub-volume's fsid for an inode
> > > in sub-volume.
> > >
> > > This creates a small challenge to watching program, which needs to map
> > > from fsid in event to a stored mount_fd to use with open_by_handle_at(2).
> > > Luckily, for btrfs, fsid[0] is uniform and fsid[1] is per sub-volume.
> > >
> > > I have adapted fsnotifywatch tool [2] to be able to watch btrfs sb.
> > > The adapted tool detects the special case of btrfs (a bit hacky) and
> > > indexes the mount_fd to be used for open_by_handle_at(2) by fsid[0].
> > >
> > > Note that this hackacry is not needed when the tool is watching a
> > > single filesystem (no need for mount_fd lookup table), because btrfs
> > > correctly decodes file handles from any sub-volume with mount_fd from
> > > any other sub-volume.
> >
> > Jan,
> >
> > Now that I've implemented the userspace part of btrfs sb watch,
> > I realize that if userspace has to be aware of the fsid oddity of btrfs
> > anyway, maybe reporting the accurate fsid of the object in event is
> > not that important at all.
> >
> > Facts:
> > 1. file_handle is unique across all sub-volumes and can be resolved
> >     from any fd on any sub-volume
> > 2. fsid[0] can be compared to match an event to a btrfs sb, where any
> >     fd can be used to resolve file_handle
> > 3. userspace needs to be aware of this fsid[0] fact if it watches more
> >     than a single sb and userspace needs not care about the value of
> >     fsid in event at all when watching a single sb
> > 4. even though fanotify never allowed setting sb mark on a path inside
> >     btrfs sub-volume, it always reported events on inodes in sub-volumes
> >     to btrfs sb watch - those events always carried the "wrong" fsid (i.e.
> >     the btrfs root volume fsid)
> > 5. we already agreed that setting up inode marks on inodes inside
> >     sub-volume should be a no brainer
> >
> > If we allow reporting either sub-vol fsid or root-vol fsid (exactly as
> > we do for inodes in sub-vol in current upstream),
> 
> Another way to put it is that fsid in event describes the object
> that was used to setup the mark not the target object.
> 
> If an event is received via an inode/sb/mount mark, the fsid
> would always describe the fsid of the inode that was used to setup
> the mark and that is always the fsid that userspace would query
> statfs(2) at the time of calling the fanotify_mark(2) call.
> 
> Maybe it is non trivial to document, but for a library that returns
> an opaque "watch descriptor", the "watch descriptor" can always
> be deduced from the event.
> 
> Does this make sense?

Yes, it makes sense if we always reported event with fsid of the object
used for placing the mark. For filesystems with homogeneous fsid there's no
difference, for btrfs it looks like the least surprising choice and works
well for inode marks as well. The only catch is in the internal fsnotify
implementation AFAICT - if we have multiple marks for the same btrfs
superblock, each mark on different subvolume, then we should be reporting
one event with different fsids for different marks. So we need to cache the
fsid in the mark and not in the connector. But that should be easy to do.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

