Return-Path: <linux-fsdevel+bounces-3729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E17F79AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2359CB20EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1335F16;
	Fri, 24 Nov 2023 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzEdsyqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905A364AB;
	Fri, 24 Nov 2023 16:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F1C433C8;
	Fri, 24 Nov 2023 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700844460;
	bh=BVlDq5Ewu2rdhljejSY79vNe84v5IwBc/GsApe5yU/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzEdsyqs4qX/8QxQpY1uTGL4HjT8TD9PHyDFKrvVO8V4aMZWkHwQBR3R5xKe60OgY
	 4P/zM6kd9pWUB7TaKewQTegxNBwW64+j4X86xFW+QgfblB2uysr0eQLcZhkZXMmxKF
	 ZFTSkkV2hCRt1Ss+sFvxK4pyYPi/dK0e83c5jUHJlnksdwN1mD0ZZ1F9zFPi5hTTk2
	 ka5MZP1GYaHPzjk1T4E0YsZpsc5J4ZoGa9vlDNWZVXEFiJWLyw0rp7Drsr3vlxwQtA
	 wUhqVlnPDpoUxYfhHAqKqFTgnSv5zNhYEX6QvS3upn0WIwdVAWollBPUFNliLQR13/
	 zz+3aL1xxPz+Q==
Date: Fri, 24 Nov 2023 17:47:32 +0100
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
Message-ID: <20231124-filzen-bohrinsel-7ff9c7f44fe1@brauner>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>

> - Integrate this as LSM (Christian, Paul)

Huh, my rant made you write an LSM. I'm not sure if that's a good or bad
thing...

So I dislike this less than the initial version that just worked around
SB_I_NODEV and this might be able to go somewhere. _But_ I want to see
the rules written down:

(1) current device access management
    I summarized the current places where that's done very very briefly in
    https://lore.kernel.org/all/20230815-feigling-kopfsache-56c2d31275bd@brauner

    * inode_permission()
      -> devcgroup_inode_permission()

    * vfs_mknod()
      -> devcgroup_inode_mknod()

    * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
      -> devcgroup_check_permission()

    * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
      -> devcgroup_check_permission()

    but that's not enough. What we need is a summary of how device node
    creation and device node opening currently interact.

    Because it is subtle. Currently you cannot even create device nodes
    without capable(CAP_SYS_ADMIN) and you can't open any existing ones
    if you lack capable(CAP_SYS_ADMIN).

    Years ago we tried that insane model where we enabled userspace to
    create device nodes but not open them. IOW, the capability check
    for device node creation was lifted but the SB_I_NODEV limitation
    wasn't lifted. That broke the whole world and had to be reverted.

(2) LSM device access management

    I really want to be able to see how you envision the permission
    checking to work in the new model. Specifically:

    * How do device node creation and device node opening interact.
    * The consequences of allowing to remove the SB_I_NODEV restriction.
    * Permission checking for users without and without a bpf guarded
      profile.

If you write this down we'll add it to documentation as well or to the
commit messages. It won't be lost. It doesn't have to be some really
long thing. I just want to better understand what you think this is
going to do and what the code does.

