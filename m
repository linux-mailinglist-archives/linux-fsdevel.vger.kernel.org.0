Return-Path: <linux-fsdevel+bounces-77579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAH/JWjOlWnjUwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:36:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA5157167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C163017533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B5334C20;
	Wed, 18 Feb 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="gZevNe5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AA328263
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425382; cv=pass; b=unh8yT4ZJ2R7Dic2HdPIufKZJEVc4VeH1aFOn3R9ZGAGNT+G8hdBXbf71I/QVXBmM5O6O3dyCxtDOuWKb0/kd5+7qbow7Gk8gGVAg/go85u9CFRgGAZAz9xcrPWaAn7C2k9YCf1t02UU5H+IIRZk/TNOiW5Du3tFqsk7/+BI5Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425382; c=relaxed/simple;
	bh=AN9Fbz6S4tGUIyG3kSUUtmYAWopa6y3TmZEg8yAKxQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwhZOe2+b1uU3Nsafr0c5zuTAwuSAZsIWhkxYw23l0Y86nraTe8/2m3iazI2bFTwOpM4uYpvIl6niqf8gFBWDG9XfBqJzKqdvxIemeVCaivAmiSmVaKNy8NxSe+FG4XNiLW+MVuNea4rsiJf/Y8siXey6ekV1x9kTR1UTH9dFlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=gZevNe5A; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso7638546e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 06:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771425378; cv=none;
        d=google.com; s=arc-20240605;
        b=aLrQnJldgRHgxbCdlnB5dWUKevkO7nCmbYER0f9cSbay1xs52i2oQ6hTyeXv+QAOuC
         ah7S/3FImbwm3ahnWCFt2wClv+qmju8q45LdeeUUG7V2ksbjEoQr+cWHbZh7fAY7DC/s
         uzelAAZKrlQuXg1yHBg1IQHIEqoCmkjCgQGT7Jdm5FqzYR6LAMpJFVUa2jZMd8vF3LZs
         PbdmZWtAm8umsZDgAE0H8XJtzg6r5holEaBtN7AVFyXC2yFTU1t5OrVcwKTxBDPeqs3l
         IlU/6bcm9d3ItubSFZAkuO4F6bwxwoJjdQxvYdV5b3yVJBAql/jgyYboyfB23n3kwMS+
         C/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AN9Fbz6S4tGUIyG3kSUUtmYAWopa6y3TmZEg8yAKxQ8=;
        fh=t+3pbWbycPAPlxmh762Zb8zLM32gauojsZ0rQAMMdjA=;
        b=M8nSZWvcorNjH7inRb4hfTjblkY+ciHEQWjnObAZ1RAW4tRWynWtEJHrVakxrQxsHk
         AS3smOY6y5ZOghqJJ6xKi5Ahew7Bfpat+y4qS1UvqU9m4FQ9tS95YZp5earEGFIW+QSy
         C0MQ2JVa04gu71be8b4sFMF/XwLIbMhBCPYwz1SFOeVmWnUtvj/+iLjJ7hEpEHw5q6KN
         ndIm1PpkbnC1nkbK+MkRKxkJ4LhjphWe4HhdjhF1gyAxDvaYsMbjFtInvkgo5YPiPfS2
         ovoabX+9uk7qpDPPSDwvgLA0jP7BNi8ba8CZq0dlA70UQCp043GqWnNcKlNs5WLSjd4T
         wmQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771425378; x=1772030178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AN9Fbz6S4tGUIyG3kSUUtmYAWopa6y3TmZEg8yAKxQ8=;
        b=gZevNe5ATKjQDRlHsan6J+ZI9w3em6sm6xCh3namyWzalihN1y0Zfjk3EM6AaQaVKT
         hxEDXNYEHsUbDhnLBnMuA1OaQT+FyYLTUEI+0yoWX5ncAngV34/3dxKtYOtqO9yJ6al9
         NGdMt43Yg7oD37afRxAoRSEyan3ouyj0rkTzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771425378; x=1772030178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN9Fbz6S4tGUIyG3kSUUtmYAWopa6y3TmZEg8yAKxQ8=;
        b=AfY5ROra89NeRMwHy8jJbGFg7KoIxGBXcEgbbZDQ7Vv5ENactc53q3JPZrP8r0XcR/
         bofMKBvcxmDJtPhPC4QiqNZL6Z2RW31VQAECAQoGPF15CBaBnK/evbr1SQ1uBuub5H4A
         1hDxYN8RF78vVuZWXvr3wluWW0K+dxsYNJBWHSXB4H/oGtny793R99lUEq6fZ01h63t8
         uWNJ6D+toth8gN9YTMbiqbpAxENND5iIldkeDicpWCQfiNwC/VX5hI/SxBZ57Hd9Mm0M
         mOgLUlypMsE8+fxzufsHA6Iub3tsHZl19R9vpOoJHZLb8xrerzq1GdOa73w6+5vBCx2T
         yLrA==
X-Forwarded-Encrypted: i=1; AJvYcCX6rOwt5ulagTkOZFJJx2LYEebTNgdVtd5OfszenI+WdDu9AJVjAd26IsDHVFeZlBkmRfUiVQBrVXrb734F@vger.kernel.org
X-Gm-Message-State: AOJu0YzvojfAkS/YEl/QzIK7TZGQTayk/Dsc8cubs5v1mkM0ZfEyXGGb
	ePKiqdIvyKNe6S/gGaf3r1bYUDLt7VBzXahHSguSJoSYIHjnltDJSHQGaZgdogYoNRRQlBdKXDy
	s0zTLeSs3BEZHOmhBLZOIosQ9qHRmLl5vFT63O/4T3g==
X-Gm-Gg: AZuq6aKNI/SuFAJ3X5d0u/F6E+wqDJnw4PMMBPTqSlGqToA0bJfFElmHHokSg9I6gHa
	trf7NVGDd9UhoGDBfg3M/4aOQfMQXdAlAS8MKS00mFpA3agN0bZpAveLDE87OxoEyW5XZtH6nD2
	QhByf9Mp15r5xM8tqtkyFn15XxYeNe9424fZhueEUhYUrVO0wpzvp2kc6bef9q5+GkQQV6h2nV3
	akTqROtZX/zs3YzjjlumHh+EFfEKYKqldGIbiHFmVSScvDUn22s4YRslWvQzkwZk5eq2RoV1eS2
	lYoJC3QaYzUWE6Il3ntwm8IlgIzvXpMUuUZu4W4=
X-Received: by 2002:a05:6512:3c83:b0:59e:5a5c:f33d with SMTP id
 2adb3069b0e04-59f6d389734mr4743913e87.49.1771425378139; Wed, 18 Feb 2026
 06:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com> <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
In-Reply-To: <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Feb 2026 15:36:05 +0100
X-Gm-Features: AaiRm51g2WbP8Q5kdQcodca9udkn8Bigp8RScFIKxbasAbYIBwguQnVra9sis5o
Message-ID: <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stgraber@stgraber.org, brauner@kernel.org, ksugihara@preferred.jp, 
	utam0k@preferred.jp, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz, 
	amir73il@gmail.com, trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77579-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mihalicyn.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,preferred.jp:url]
X-Rspamd-Queue-Id: 51CA5157167
X-Rspamd-Action: no action

Am Mi., 18. Feb. 2026 um 14:49 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >
> > I would like to propose "VFS idmappings support in NFS" as a topic for discussion at the LSF/MM/BPF Summit.
> >
> > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and cephfs [1] with support/guidance
> > from Christian.
> >
> > This experience with Cephfs & FUSE has shown that VFS idmap semantics, while being very elegant and
> > intuitive for local filesystems, can be quite challenging to combine with network/network-like (e.g. FUSE)
> > FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) as a part of our agreement with
> > ceph folks about the right way to support idmaps.
> >
> > One obstacle here was that cephfs has some features that are not very Linux-wayish, I would say.
> > In particular, system administrator can configure path-based UID/GID restrictions on a *server*-side (Ceph MDS).
> > Basically, you can say "I expect UID 1000 and GID 2000 for all files under /stuff directory".
> > The problem here is that these UID/GIDs are taken from a syscall-caller's creds (not from (struct file *)->f_cred)
> > which makes cephfs FDs not very transferable through unix sockets. [3]
> >
> > These path-based UID/GID restrictions mean that server expects client to send UID/GID with every single request,
> > not only for those OPs where UID/GID needs to be written to the disk (mknod, mkdir, symlink, etc).
> > VFS idmaps API is designed to prevent filesystems developers from making a mistakes when supporting FS_ALLOW_IDMAP.
> > For example, (struct mnt_idmap *) is not passed to every single i_op, but instead to only those where it can be
> > used legitimately. Particularly, readlink/listxattr or rmdir are not expected to use idmapping information anyhow.
> >
> > We've seen very similar challenges with FUSE. Not a long time ago on Linux Containers project forum, there
> > was a discussion about mergerfs (a popular FUSE-based filesystem) & VFS idmaps [5]. And I see that this problem
> > of "caller UID/GID are needed everywhere" still blocks VFS idmaps adoption in some usecases.
> > Antonio Musumeci (mergerfs maintainer) claimed that in many cases filesystems behind mergerfs may not be fully
> > POSIX and basically, when mergerfs does IO on the underlying FSes it needs to do UID/GID switch to caller's UID/GID
> > (taken from FUSE request header).
> >
> > We don't expect NFS to be any simpler :-) I would say that supporting NFS is a final boss. It would be great
> > to have a deep technical discussion with VFS/FSes maintainers and developers about all these challenges and
> > make some conclusions and identify a right direction/approach to these problems. From my side, I'm going
> > to get more familiar with high-level part of NFS (or even make PoC if time permits), identify challenges,
> > summarize everything and prepare some slides to navigate/plan discussion.
> >
> > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com
> > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > [5]
> > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-is-there-a-workaround/25336/11?u=amikhalitsyn
> >
> > Kind regards,
> > Alexander Mikhalitsyn @ futurfusion.io
>

Hi Jeff,

thanks for such a fast reply! ;)

>
> IIUC, people mostly use vfs-layer idmappings because they want to remap
> the uid/gid values of files that get stored on the backing store (disk,
> ceph MDS, or whatever).

yes, precisely.

>
> I've never used idmappings myself much in practice. Could you lay out
> an example of how you would use them with NFS in a real environment so
> I understand the problem better? I'd start by assuming a simple setup
> with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> be fairly straightforward.

For me, from the point of LXC/Incus project, idmapped mounts are used as
a way to "delegate" filesystems (or subtrees) to the containers:
1. We, of course, assume that container enables user namespaces and
user can't mount a filesystem
inside because it has no FS_USERNS_MOUNT flag set (like in case of Cephfs, NFS,
CIFS and many others).
2. At the same time host's system administrator wants to avoid
remapping between container's user ns and
sb->s_user_ns (which is init_user_ns for those filesystems). [
motivation here is that in many
cases you may want to have the same subtree to be shared with other
containers and even host users too and
you want UIDs to be "compatible", i.e UID 1000 in one container and
UID 1000 in another container should
land as UID 1000 on the filesystem's inode ]

For this usecase, when we bind-mount filesystem to container, we apply
VFS idmap equal to container's
user namespace. This makes a behavior I described.

But this is just one use case. I'm pretty sure there are some more
around here :)
I know that folks from Preferred Networks (preferred.jp) are also
interested in VFS idmap support in NFS,
probably they can share some ideas/use cases too.

>
> Mixing in AUTH_GSS and real idmapping will be where things get harder,
> so let's not worry about those cases for now.
> --
> Jeff Layton <jlayton@kernel.org>

Kind regards,
Alex

