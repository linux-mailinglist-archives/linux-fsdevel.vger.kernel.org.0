Return-Path: <linux-fsdevel+bounces-6311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3E8158AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381F21F2580D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798A15AC0;
	Sat, 16 Dec 2023 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3X/v+6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669F14287;
	Sat, 16 Dec 2023 10:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4152C433C7;
	Sat, 16 Dec 2023 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702723122;
	bh=D4jAbfqZArxfJjDljoJoonG0UlpZxX4g3d5+ilJMaQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3X/v+6K+FRfwo2BlGXpMpfZww0L9/InYuqR/nqaBL9hbh8pIl3a2F7YWwiKCaC9P
	 fxFQeMx+EMwc3U2x/55T1e79WEragUkGFW96TOtEA9y8qA2cDBw0YctFC8onK4LB2G
	 EPOTQ/vDxL1MGIno1ifAhz43qDTy0QqlBjDqxhAG7gG24FpwUtBdOykFjvnX9YYuVp
	 eyc51QN0q2GDGjj5Ke5ZspJveY4lq44a3j8EkvwKCk0dKRFYYU4JCdvGW7DAcgCmaW
	 1zh+P/hwb9vvZ3Nyu0xDX31g3YIlGAr4Z4ZyDFkrPIZS0gBzYtN/UdnDS7qBzYxFdk
	 dPjH+WQGosV2Q==
Date: Sat, 16 Dec 2023 11:38:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
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
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	gyroidos@aisec.fraunhofer.de
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-ID: <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
 <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>

On Fri, Dec 15, 2023 at 10:08:08AM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 15, 2023 at 6:15 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Weiß wrote:
> > > On 15.12.23 13:31, Christian Brauner wrote:
> > > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
> > > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > > >> namespace in cooperation of an attached cgroup device program. We
> > > >> just need to implement the security_inode_mknod() hook for this.
> > > >> In the hook, we check if the current task is guarded by a device
> > > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > > >>
> > > >> Access decisions to those device nodes are then guarded by existing
> > > >> device cgroups mechanism.
> > > >>
> > > >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > > >> ---
> > > >
> > > > I think you misunderstood me... My point was that I believe you don't
> > > > need an additional LSM at all and no additional LSM hook. But I might be
> > > > wrong. Only a POC would show.
> > >
> > > Yeah sorry, I got your point now.
> >
> > I think I might have had a misconception about how this works.
> > A bpf LSM program can't easily alter a kernel object such as struct
> > super_block I've been told.
> 
> Right. bpf cannot change arbitrary kernel objects,
> but we can add a kfunc that will change a specific bit in a specific
> data structure.
> Adding a new lsm hook that does:
>     rc = call_int_hook(sb_device_access, 0, sb);
>     switch (rc) {
>     case 0: do X
>     case 1: do Y
> 
> is the same thing, but uglier, since return code will be used
> to do this action.
> The 'do X' can be one kfunc
> and 'do Y' can be another.
> If later we find out that 'do X' is not a good idea we can remove
> that kfunc.

The reason I moved the SB_I_MANAGED_DEVICES here is that I want a single
central place where that is done for any possible LSM that wants to
implement device management. So we don't have to go chasing where that
bit is set for each LSM. I also don't want to have LSMs raise bits in
sb->s_iflags directly as that's VFS property.

