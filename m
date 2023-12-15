Return-Path: <linux-fsdevel+bounces-6176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1C81481D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEBA1F23A02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2A2C6A1;
	Fri, 15 Dec 2023 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLWeqMrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21832D033;
	Fri, 15 Dec 2023 12:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD1C433C7;
	Fri, 15 Dec 2023 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702643502;
	bh=F2ajDU7FVMvzLFF89TySlMLk6Wm17ybM4bb/3tTycL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLWeqMrINDuf4fclsBa9vwJ3LVwgD8gZwJUzNMZAmMQw0OOq62kwBKytqminKjUPv
	 KHUBcwnCONHfYXZBuIVONjo30VQ7p9m5QUGAdAdzxUlcV7bdkrk55xGQDf65yfJw6Z
	 jcKABEYcIBxT+Ljw10Uu7TYsgEGhak+uvJ2Npicett7hvPGCgmVPn3TG/l5BIs8/mS
	 3qGXDoJQ/AdnwPaa5YYTa3giFDmQIutX5qUAXNlddr6ZvrelenQCJhScNBCfIhB5Go
	 5zJ1pFj3aGRJEejS61H6JkxF+vRaXFpUBwpdBXEge9czkeLn/alaLXqLxcbNuxtVHv
	 W07Vz7GBxR7AQ==
Date: Fri, 15 Dec 2023 13:31:32 +0100
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
	linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-ID: <20231215-golfanlage-beirren-f304f9dafaca@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>

On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> namespace in cooperation of an attached cgroup device program. We
> just need to implement the security_inode_mknod() hook for this.
> In the hook, we check if the current task is guarded by a device
> cgroup using the lately introduced cgroup_bpf_current_enabled()
> helper. If so, we strip out SB_I_NODEV from the super block.
> 
> Access decisions to those device nodes are then guarded by existing
> device cgroups mechanism.
> 
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---

I think you misunderstood me... My point was that I believe you don't
need an additional LSM at all and no additional LSM hook. But I might be
wrong. Only a POC would show.

Just write a bpf lsm program that strips SB_I_NODEV in the existing
security_sb_set_mnt_opts() call which is guranteed to be called when a
new superblock is created.

Store your device access rules in a bpf map or in the sb->s_security
blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).

Then make that bpf lsm program kick in everytime a
security_inode_mknod() and security_file_open() is called and do device
access management in there. Actually, you might need to add one hook
when the actual device that's about to be opened is know. 
This should be where today the device access hooks are called.

And then you should already be done with this. The only thing that you
need is the capable check patch.

You don't need that cgroup_bpf_current_enabled() per se. Device
management could now be done per superblock, and not per task. IOW, you
allowlist a bunch of devices that can be created and opened. Any task
that passes basic permission checks and that passes the bpf lsm program
may create device nodes.

That's a way more natural device management model than making this a per
cgroup thing. Though that could be implemented as well with this.

I would try to write a bpf lsm program that does device access
management with your capable() sysctl patch applied and see how far I
get.

I don't have the time otherwise I'd do it.

