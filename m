Return-Path: <linux-fsdevel+bounces-1635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93E7DCCC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C5BB20FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858101DA3F;
	Tue, 31 Oct 2023 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EryOX9Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA219BAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7417CC433C8;
	Tue, 31 Oct 2023 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698754487;
	bh=vX+0QLP82CXz0Olz5YIyT7NGlWqlICp11NlH2e8uzIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EryOX9Fo7jfCX+o03f1JbdHs/duqVdXq+GD5CeI36Mxv82Ri04fPrmOLs+bGPPVAv
	 oLwfKLZ0DwbUkLyJvKVjiSYwZ9yJdUcQfM9jPZVEb2uCbV7EBGVaMYrOMzbDDKGCqk
	 phiQ6nyhEzqH6x6gN6EbQdHb01iAMSYgLkNs+FBoWPJ1jXsmNr/hlp31zZJr7UeRLQ
	 zBEcwE81i+ldfUTNE0XX/a9JYtCvEcZnbzKuwBqjLWbHz/OxTta3wzBJt+NiK6CcKz
	 i+BKOqDeWgy08+NeHb4mUxBhtSgiMFjTd+lTbaMqtoPqPhqRsPosKhyDfVhZ+uJpss
	 F+zecNRCGmdpg==
Date: Tue, 31 Oct 2023 13:14:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZT+uxSEh+nTZ2DEY@infradead.org>

> > A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo becomes

So that part confuses me and I'd like to understand this a bit more.

So everytime you create a subvolume what you're doing today is that you
give it an anonymous device number stored in ->anon_dev which presumably
is also stored on disk?

Say I have a btrfs filesystem with 2 subvolumes on /dev/sda:

/mnt/subvol1
/mnt/subvol2

What happens in the kernel right now I've mentiond in the mount api
conversion patch for btrfs I sent out in June at [1] because I tweaked
that behavior. Say I mount both subvolumes:

mount /dev/sda -o subvol=subvol1 /vol1 # sb1@vfsmount1
mount /dev/sda -o subvol=subvol2 /vol2 # sb1@vfsmount2

It creates a superblock for /dev/sda. It then creates two vfsmounts: one
for subvol1 and one for subvol2. So you end up with two subvolumes on
the same superblock.

So if you mount a subvolume today then you already get separate
vfsmounts. To put it another way. If you start 10,000 containers each
using a separate btrfs subvolume then you get 10,000 vfsmounts.

So I don't yet understand the scaling argument if each subvolume has a
vfsmount anyway because afaict that's already the case.

Or is it that you want a separate superblock per subvolume? Because only
if you allocate a new superblock you'll get clean device number
handling, no? Or am I misunderstanding this?

mount /dev/sda -o subvol=subvol1 /vol1 # sget_fc() -> sb1@vfsmount1
mount /dev/sda -o subvol=subvol2 /vol2 # sget_fc() -> sb2@vfsmount2

and mounting the same subvolume again somewhere else gives you the same
superblock but on a different vfsmount:

mount /dev/sda -o subvol=subvol1 /vol1 # sget_fc() -> sb1@vfsmount3

Is that the proposal?

[1]: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org

