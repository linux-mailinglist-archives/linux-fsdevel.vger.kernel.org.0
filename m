Return-Path: <linux-fsdevel+bounces-31286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F2994345
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BA28EF80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9405538A;
	Tue,  8 Oct 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L29s8qM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A014A82;
	Tue,  8 Oct 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377857; cv=none; b=WcPbE0Eu/IjSBmE/djk1iuk1nfKglkm9yzPlWs9ToLRpshIJr5wD+dnHQU/9JmxKDfJ9jNEvFJM9b8t+5uByHCGdUAJRjpEFDetEjI0Gp6OhEs+see+GpMEXkr7lq7dELDisLcZ5FN9dCfjpDQlPdF00LtTZEmoHQvwxA+YIIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377857; c=relaxed/simple;
	bh=zjSwpKSamL/oaVYFaBilZq7b5Csh6FwSM6IroSnQ7pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Eu/k2+f1pa6n0KdB8bcK39AGTKNpZQpFJelW2lLG5DnxAlmtYeu9dv2Ww5oH7yLYdOowV+ZTdZFYzlBwoeeyVqVlFo/emwRZ1PlYlwMA4OHHAtVOhkHKpRIxCuCMgnsEy6JEgqZaA0g8YsVJXw6xU5mDDzQe/cj7ONtCMjZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L29s8qM3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7ae3e3db294so308048985a.2;
        Tue, 08 Oct 2024 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728377854; x=1728982654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSiZA2g8NuCGsh8+CWZXtusESif7cpDAvfOKhygbhTs=;
        b=L29s8qM37nSQ0BnF7hGJKa/dRBRnmTKbXiPdTRN+8TL5mEgqz2muTuaKxUG2C3AX7E
         3WGK5q1zU5VrATMZMmhbwkz1WZEewAz5WULb84NFO42+BXpXWlV2yn5tJMbXNpe2zTVu
         BReblqtyQ62ZaFC8QBtCcvclWfqbZmz7x/LBsw14YUAZIsMBTslTbcTAaaDL0S/ZnsfW
         dQmR2V0mO/gnLXHzt2MqpTnKOavJhVosmd0VdV/YN54cikLRU0LrNqlA9NE63l+Q2xp7
         WAjT9q/nq2rODi6cvM9Cz9aS5IAt5H8KJ1/3V79Erg0+uac9uxfXrGb/10wCk38eQrAW
         3DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377854; x=1728982654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSiZA2g8NuCGsh8+CWZXtusESif7cpDAvfOKhygbhTs=;
        b=DB8CN/PgPoEhMhBa/p/qcKdTKScU80gENKsH5gKc0BbDAAAjxUWB5dpQAB+RWWlliK
         LFAFbsPShV2cfRxHdUVpqG/QcWt3sMdrGJWv+/t1BWu8pvQQXNkmgg7X0B8u/CHM13C9
         usf6zDs7okAlhuQ1+nxckSuKky2twoMQfTPTUHX/mZgs/ipU4TzfTVy6ExZ5W2He7vCc
         JwbAIb2sSgC5hzjJJGw90q0MlIZUK+vHzSEMEQ6PVpwj90VP5MkWnk1M7S3cfrksPiS+
         uEbaDH4omWiN22LXp6J0kohrtgYCM+2dMU8C6Ujn9E74Fe9YqWpIxYClsWE19hxVyi6J
         /Gkw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mQnObKI3siZi4ptvroCJp/JPS6Z4lva7dD3AVHGw8DExYZZxxNJZkopNQTO6gF04kg005moQAv71ND/Sww==@vger.kernel.org, AJvYcCWJwerMr1LTNeb9HsrztDOlCwIrIMWf1HVWH4dpNozwMfucotXPqXWs9gDYcRdx/tgzzCcY7AeqZWrT@vger.kernel.org, AJvYcCWiQcM/VUC7tU12z18VzfOtJWDIGYdI6dgQHi4TulakGaTRyOBiB7NnBQOIHJqpvYawDDkWn2OvdA3xL51gKZH6B3jQ2LyC@vger.kernel.org, AJvYcCXkYKD39+OvxILbpvPxJLAxUb5DmWAi9wVTHwLUYZ0nOMyk934lavJYQsHrv+ssKMKmkqW12PKkr+DyWlnPjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7wB3vhev0NM6QG8f983NX9aF/npFEQQljIuqQe3VpPB43iEW
	7ckPC9YJdloodLnv2sJUpZCAMOFyswJADdG4Fv0Z8BC0OXHazZkJVzPL8ukt8FZqYqiJBo+g4xd
	tuVVj2ou5GX5c9wNqmoSgtTsuts8=
X-Google-Smtp-Source: AGHT+IGyUy4LRGOpbCvoasZRQSP2dmC4WlY6qXQ/VCE3WYJa800SCIs9IYs3KTeh7/Puyqv+pCrRSAP4UIBx9Xwdwpg=
X-Received: by 2002:a05:620a:400d:b0:7ac:a0a5:9bf4 with SMTP id
 af79cd13be357-7ae6f48604fmr2483131085a.40.1728377854081; Tue, 08 Oct 2024
 01:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
In-Reply-To: <ZwRvshM65rxXTwxd@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 10:57:22 +0200
Message-ID: <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:33=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > >
> > > Fair enough. If we go with the iterator variant I've suggested to Dav=
e in
> > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() a=
nd
> > > Landlocks hook_sb_delete() into a single iteration relatively easily.=
 But
> > > I'd wait with that convertion until this series lands.
> >
> > Honza, I looked at this a bit more, particularly with an eye of "what
> > happens if we just end up making the inode lifetimes subject to the
> > dentry lifetimes" as suggested by Dave elsewhere.
>
> ....
>
> > which makes the fsnotify_inode_delete() happen when the inode is
> > removed from the dentry.
>
> There may be other inode references being held that make
> the inode live longer than the dentry cache. When should the
> fsnotify marks be removed from the inode in that case? Do they need
> to remain until, e.g, writeback completes?
>

fsnotify inode marks remain until explicitly removed or until sb
is unmounted (*), so other inode references are irrelevant to
inode mark removal.

(*) fanotify has "evictable" inode marks, which do not hold inode
reference and go away on inode evict, but those mark evictions
do not generate any event (i.e. there is no FAN_UNMOUNT).

> > Then at umount time, the dentry shrinking will deal with all live
> > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > just the root dentry inodes?
>
> I don't think even that is necessary, because
> shrink_dcache_for_umount() drops the sb->s_root dentry after
> trimming the dentry tree. Hence the dcache drop would cleanup all
> inode references, roots included.
>
> > Wouldn't that make things much cleaner, and remove at least *one* odd
> > use of the nasty s_inodes list?
>
> Yes, it would, but someone who knows exactly when the fsnotify
> marks can be removed needs to chime in here...
>
> > I have this feeling that maybe we can just remove the other users too
> > using similar models. I think the LSM layer use (in landlock) is bogus
> > for exactly the same reason - there's really no reason to keep things
> > around for a random cached inode without a dentry.
>
> Perhaps, but I'm not sure what the landlock code is actually trying
> to do. It seems to be trying to avoid races between syscalls
> releasing inode references and unmount calling security_sb_delete()
> to clean up inode references that it has leaked. This implies that
> it's not a) tracking inodes itself, and b) not cleaning up internal
> state early enough in unmount.
>
> Hence, to me, the lifecycle and reference counting of inode related
> objects in landlock doesn't seem quite right, and the use of the
> security_sb_delete() callout appears to be papering over an internal
> lifecycle issue.
>
> I'd love to get rid of it altogether.
>
> > And I wonder if the quota code (which uses the s_inodes list to enable
> > quotas on already mounted filesystems) could for all the same reasons
> > just walk the dentry tree instead (and remove_dquot_ref similarly
> > could just remove it at dentry_unlink_inode() time)?
>
> I don't think that will work because we have to be able to modify
> quota in evict() processing. This is especially true for unlinked
> inodes being evicted from cache, but also the dquots need to stay
> attached until writeback completes.
>
> Hence I don't think we can remove the quota refs from the inode
> before we call iput_final(), and so I think quotaoff (at least)
> still needs to iterate inodes...
>
> > It really feels like most (all?) of the s_inode list users are
> > basically historical, and shouldn't use that list at all. And there
> > aren't _that_ many of them. I think Dave was right in just saying that
> > this list should go away entirely (or was it somebody else who made
> > that comment?)
>
> Yeah, I said that it should go away entirely.
>
> My view of this whole s_inodes list is that subsystems that are
> taking references to inodes *must* track or manage the references to
> the inodes themselves.
>
> The canonical example is the VFS itself: evict_inodes() doesn't need
> to iterate s_inodes at all. It can walk the inode LRU to purge all
> the unreferenced cached inodes from memory. iput_final() guarantees
> that all unreferenced inodes are either put on the LRU or torn down
> immediately.
>
> Hence I think that it is a poor architectural decision to require
> superblock teardown to clean up inode references random subsystems
> have *leaked* to prevent UAFs.  It forces the sb to track all
> inodes whether the VFS actually needs to track them or not.
>

For fsnotify, I think we can/should maintain a list of marked inodes
inside sb->s_fsnotify_info, we can iterate this private list in
fsnotify_unmount_inodes() to remove the marks.

TBH, I am not sure I understand the suggested change for inode
lifetime. An inode can have a reference from dentry or from some
subsystem (e.g. fsnotify) which is responsible for putting their held
reference before unmount. What is the alternative?

Thanks,
Amir.

