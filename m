Return-Path: <linux-fsdevel+bounces-3764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D27F7BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD0C2821FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E439FF8;
	Fri, 24 Nov 2023 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWCVMqtk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522139FEA;
	Fri, 24 Nov 2023 18:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B38CC433C9;
	Fri, 24 Nov 2023 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700849338;
	bh=+Onur62i+JRm8hJ4GcCqwMgzvptXqa0TFT19YK6FOgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWCVMqtkqXftVtN9joPIEwEYC8AlmmadpDBhBJUmc8X7rNJZn991L6GelQikqJ1Bf
	 kXMtzeeU24PZHElIOMKyDaboNLUZyGOZtnenAQ27mbDzRpH143SFNLwrXAYn5XMKeA
	 +oOrZcutqPo6LgBt5FfHLgbzSUvh5XEGvCskX8OO0aylLp5TpWZcehCp5uzT6VHmDZ
	 msQnrOmjV2CBRJJi0Jy6jgU2tIapJTh8Dc3mV9j4oUh2Tin/Vd8es4SPVs8z/vLt6B
	 cwyXpKCJYMZv9ylKef5vNxZH2HRbwVRNmhl2iiK+3PK7w//WngOggTC6V8Vph0ZBcq
	 zESHmGtnQd0gw==
Date: Fri, 24 Nov 2023 19:08:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de
Subject: Re: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for
 non-initial user namespace
Message-ID: <20231124-tropfen-kautschukbaum-bee7c7dec096@brauner>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
 <20231124-filzen-bohrinsel-7ff9c7f44fe1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124-filzen-bohrinsel-7ff9c7f44fe1@brauner>

On Fri, Nov 24, 2023 at 05:47:32PM +0100, Christian Brauner wrote:
> > - Integrate this as LSM (Christian, Paul)
> 
> Huh, my rant made you write an LSM. I'm not sure if that's a good or bad
> thing...
> 
> So I dislike this less than the initial version that just worked around

Hm, I wonder if we're being to timid or too complex in how we want to
solve this problem.

The device cgroup management logic is hacked into multiple layers and is
frankly pretty appalling.

What I think device access management wants to look like is that you can
implement a policy in an LSM - be it bpf or regular selinux - and have
this guarded by the main hooks:

security_file_open()
security_inode_mknod()

So, look at:

vfs_get_tree()
-> security_sb_set_mnt_opts()
   -> bpf_sb_set_mnt_opts()

A bpf LSM program should be able to strip SB_I_NODEV from sb->s_iflags
today via bpf_sb_set_mnt_opts() without any kernel changes at all.

I assume that a bpf LSM can also keep state in sb->s_security just like
selinux et al? If so then a device access management program or whatever
can be stored in sb->s_security.

That device access management program would then be run on each call to:

security_file_open()
-> bpf_file_open()

and

security_inode_mknod()
-> bpf_sb_set_mnt_opts()

and take access decisions.

This obviously makes device access management something that's tied
completely to a filesystem. So, you could have the same device node on
two tmpfs filesystems both mounted in the same userns.

The first tmpfs has SB_I_NODEV and doesn't allow you to open that
device. The second tmpfs has a bpf LSM program attached to it that has
stripped SB_I_NODEV and manages device access and allows callers to open
that device.

I guess it's even possible to restrict this on a caller basis by marking
them with a "container id" when the container is started. That can be
done with that task storage thing also via a bpf LSM hook. And then
you can further restrict device access to only those tasks that have a
specific container id in some range or some token or something.

I might just be fantasizing abilities into bpf that it doesn't have so
anyone with the knowledge please speak up.

If this is feasible then the only thing we need to figure out is what to
do with the legacy cgroup access management and specifically the
capable(CAP_SYS_ADMIN) check that's more of a hack than anything else.

So, we could introduce a sysctl that makes it possible to turn this
check into ns_capable(sb->s_userns, CAP_SYS_ADMIN). Because due to
SB_I_NODEV it is inherently safe to do that. It's just that a lot of
container runtimes need to have time to adapt to a world where you may
be able to create a device but not be able to then open it. This isn't
rocket science but it will take time.

But in the end this will mean we get away with minimal kernel changes
and using a lot of existing infrastructure.

Thoughts?

