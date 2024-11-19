Return-Path: <linux-fsdevel+bounces-35210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE849D2820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6735CB27D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593ED1CDA35;
	Tue, 19 Nov 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSxI+7Mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A772AE74;
	Tue, 19 Nov 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026110; cv=none; b=LvsduHVWhJWpDCLPlv7RgAyBzK8EmXbXGsZBw98d5V2+LEAXRdPyn/0NLWaYTseyX/2q9h8EESFyXFKcAeQPi+coaJlerv95iswOt6OXTGS7hrxRPYD+OLTOQ91jqV9Jj0UiRsO3Cg76nRY/bHsRE3mMIcNhPJ6XVxxItC2TyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026110; c=relaxed/simple;
	bh=CnlQO+MPs9b+dxGUIAEng6ROnP7aZxTEAiJRbL6Kay4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9G5zeeKLvviQWvGp6BOZvVLIL0aXLWT6h0/Lk89qIVEEGuHKV6KDc8Bxx4vIiFO6vdIfS877fwGISPl2qVYAQ2Plh2CQVX3uu2gWpgfXS3G3bYWJKg+7YsTs28hePq5Yk4s3hB4P6VAXLle8hZKCfQQd824JGAwYHKzNPnJCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSxI+7Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F56C4CECF;
	Tue, 19 Nov 2024 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732026110;
	bh=CnlQO+MPs9b+dxGUIAEng6ROnP7aZxTEAiJRbL6Kay4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PSxI+7MjokKkdOCGZErDhh0Iz9oBeFMiwSpjVZqIW49zW2Ec7uFRDuTdgBacNGo7q
	 c0tK2UB1zY+2f+SAlPFxPo6B4blKwITaq03hLG6DD5tsFh/1sfMC4sR925JZZZZfB+
	 IEF0yrMc9aOGJzAKFdU01L5mrjWvd+dYCUMoTTOjnH+bR5a3xRs5UgKdOQoYFtAzWT
	 ksQwM/gfZWz2OMYLuIBoHUMj7AxQxqNsQkjXhKdZbABsjoAD9x80gt2UnRfKB8zCHA
	 F5obNgydJSxmu2z2wzI4YAkKLaCEc5bYtRXPiTL+Ho/pFZ9ySrcIkU7jfNcMJNrEc4
	 OZNkD00c7R+2g==
Message-ID: <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
From: Jeff Layton <jlayton@kernel.org>
To: Song Liu <songliubraving@meta.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team
 <kernel-team@meta.com>,  "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,  "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>,  "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>, 
 "amir73il@gmail.com" <amir73il@gmail.com>, "repnop@google.com"
 <repnop@google.com>, Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net"
 <mic@digikod.net>,  "gnoack@google.com" <gnoack@google.com>
Date: Tue, 19 Nov 2024 09:21:47 -0500
In-Reply-To: <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
	 <20241112082600.298035-3-song@kernel.org>
	 <20241113-sensation-morgen-852f49484fd8@brauner>
	 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
	 <20241115111914.qhrwe4mek6quthko@quack3>
	 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-15 at 17:35 +0000, Song Liu wrote:
> Hi Jan,=20
>=20
> > On Nov 15, 2024, at 3:19=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
>=20
> [...]
>=20
> > > AFAICT, we need to modify how lsm blob are managed with=20
> > > CONFIG_BPF_SYSCALL=3Dy && CONFIG_BPF_LSM=3Dn case. The solution, even
> > > if it gets accepted, doesn't really save any memory. Instead of=20
> > > growing struct inode by 8 bytes, the solution will allocate 8
> > > more bytes to inode->i_security. So the total memory consumption
> > > is the same, but the memory is more fragmented.
> >=20
> > I guess you've found a better solution for this based on James' suggest=
ion.
> >=20
> > > Therefore, I think we should really step back and consider adding
> > > the i_bpf_storage to struct inode. While this does increase the
> > > size of struct inode by 8 bytes, it may end up with less overall
> > > memory consumption for the system. This is why.=20
> > >=20
> > > When the user cannot use inode local storage, the alternative is=20
> > > to use hash maps (use inode pointer as key). AFAICT, all hash maps=
=20
> > > comes with non-trivial overhead, in memory consumption, in access=20
> > > latency, and in extra code to manage the memory. OTOH, inode local=
=20
> > > storage doesn't have these issue, and is usually much more efficient:=
=20
> > > - memory is only allocated for inodes with actual data,=20
> > > - O(1) latency,=20
> > > - per inode data is freed automatically when the inode is evicted.=
=20
> > > Please refer to [1] where Amir mentioned all the work needed to=20
> > > properly manage a hash map, and I explained why we don't need to=20
> > > worry about these with inode local storage.
> >=20
> > Well, but here you are speaking of a situation where bpf inode storage
> > space gets actually used for most inodes. Then I agree i_bpf_storage is=
 the
> > most economic solution. But I'd also expect that for vast majority of
> > systems the bpf inode storage isn't used at all and if it does get used=
, it
> > is used only for a small fraction of inodes. So we are weighting 8 byte=
s
> > per inode for all those users that don't need it against more significa=
nt
> > memory savings for users that actually do need per inode bpf storage. A
> > factor in this is that a lot of people are running some distribution ke=
rnel
> > which generally enables most config options that are at least somewhat
> > useful. So hiding the cost behind CONFIG_FOO doesn't really help such
> > people.
>=20
> Agreed that an extra pointer will be used if there is no actual users
> of it. However, in longer term, "most users do not use bpf inode
> storage" may not be true. As kernel engineers, we may not always notice=
=20
> when user space is using some BPF features. For example, systemd has
> a BPF LSM program "restrict_filesystems" [1]. It is enabled if the=20
> user have lsm=3Dbpf in kernel args. I personally noticed it as a=20
> surprise when we enabled lsm=3Dbpf.=20
>=20
> > I'm personally not *so* hung up about a pointer in struct inode but I c=
an
> > see why Christian is and I agree adding a pointer there isn't a win for
> > everybody.
>=20
> I can also understand Christian's motivation. However, I am a bit
> frustrated because similar approach (adding a pointer to the struct)=20
> worked fine for other popular data structures: task_struct, sock,=20
> cgroup.=20
>=20

There are (usually) a lot more inodes on a host than all of those other
structs combined. Worse, struct inode is often embedded in other
structs, and adding fields can cause alignment problems there.


> > Longer term, I think it may be beneficial to come up with a way to atta=
ch
> > private info to the inode in a way that doesn't cost us one pointer per
> > funcionality that may possibly attach info to the inode. We already hav=
e
> > i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always a to=
ugh
> > call where the space overhead for everybody is worth the runtime &
> > complexity overhead for users using the functionality...
>=20
> It does seem to be the right long term solution, and I am willing to=20
> work on it. However, I would really appreciate some positive feedback
> on the idea, so that I have better confidence my weeks of work has a=20
> better chance to worth it.=20
>=20
> Thanks,
> Song
>=20
> [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_fs=
/restrict-fs.bpf.c

fsnotify is somewhat similar to file locking in that few inodes on the
machine actually utilize these fields.

For file locking, we allocate and populate the inode->i_flctx field on
an as-needed basis. The kernel then hangs on to that struct until the
inode is freed. We could do something similar here. We have this now:

#ifdef CONFIG_FSNOTIFY
        __u32                   i_fsnotify_mask; /* all events this inode c=
ares about */
        /* 32-bit hole reserved for expanding i_fsnotify_mask */
        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
#endif

What if you were to turn these fields into a pointer to a new struct:

	struct fsnotify_inode_context {
		struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
		struct bpf_local_storage __rcu		*i_bpf_storage;
		__u32                   		i_fsnotify_mask; /* all events this inode cares=
 about */
	};

Then whenever you have to populate any of these fields, you just
allocate one of these structs and set the inode up to point to it.
They're tiny too, so don't bother freeing it until the inode is
deallocated.

It'd mean rejiggering a fair bit of fsnotify code, but it would give
the fsnotify code an easier way to expand per-inode info in the future.
It would also slightly shrink struct inode too.
--=20
Jeff Layton <jlayton@kernel.org>

