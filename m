Return-Path: <linux-fsdevel+bounces-6188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46303814A3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CA1C24CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A33033A;
	Fri, 15 Dec 2023 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAL0aMf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550430323;
	Fri, 15 Dec 2023 14:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D07C433C7;
	Fri, 15 Dec 2023 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702649742;
	bh=W1XtoLwVjVlAviGOn0QyQ+64RcpOZK/R2alKEsb4h7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAL0aMf+dpQBTHJO41cESnUUu9P9iGGA8GxN8xIXum9wB1sVU5XfcohZtHgOX34EH
	 raV5AE/oofgN2lvhuOTdfg+6YeKwl//5lh5xvg53NZYT3/kMeUlf/Bd+O7w+2duQNR
	 W0EtsQlndP6C2ie4+6xuVA6F1xI5HXpJK5eB2vsjXmwXibuXos7YHGy5DJPjNvXP2L
	 9nYOBIfgwVnOFRAe0NurqbC13QiZ+XhUVQQxs/ewoaIi/oW3jcfbx3kL4PLdKTYN/G
	 7FoBPrmgYlUU8L95AU3br4trKGSy25AjVCFsxP+lmp7LHN7SM0IjpvEdDJ3NYDaStO
	 Xn8LAr0wwkjSQ==
Date: Fri, 15 Dec 2023 15:15:33 +0100
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
Message-ID: <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>

On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Weiß wrote:
> On 15.12.23 13:31, Christian Brauner wrote:
> > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
> >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> >> namespace in cooperation of an attached cgroup device program. We
> >> just need to implement the security_inode_mknod() hook for this.
> >> In the hook, we check if the current task is guarded by a device
> >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> >> helper. If so, we strip out SB_I_NODEV from the super block.
> >>
> >> Access decisions to those device nodes are then guarded by existing
> >> device cgroups mechanism.
> >>
> >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> >> ---
> > 
> > I think you misunderstood me... My point was that I believe you don't
> > need an additional LSM at all and no additional LSM hook. But I might be
> > wrong. Only a POC would show.
> 
> Yeah sorry, I got your point now.

I think I might have had a misconception about how this works.
A bpf LSM program can't easily alter a kernel object such as struct
super_block I've been told.

> 
> > 
> > Just write a bpf lsm program that strips SB_I_NODEV in the existing
> > security_sb_set_mnt_opts() call which is guranteed to be called when a
> > new superblock is created.
> 
> This does not work since SB_I_NODEV is a required_iflag in
> mount_too_revealing(). This I have already tested when writing the
> simple LSM here. So maybe we need to drop SB_I_NODEV from required_flags
> there, too. Would that be safe?

Right. I think we might be able to add a new SB_I_MANAGED_DEVICES flag.
__UNTESTED, UNCOMPILED_

diff --git a/fs/namespace.c b/fs/namespace.c
index fbf0e596fcd3..e87cc0320091 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4887,7 +4887,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,

 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
-       const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
        struct mnt_namespace *ns = current->nsproxy->mnt_ns;
        unsigned long s_iflags;

@@ -4899,9 +4898,13 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
        if (!(s_iflags & SB_I_USERNS_VISIBLE))
                return false;

-       if ((s_iflags & required_iflags) != required_iflags) {
-               WARN_ONCE(1, "Expected s_iflags to contain 0x%lx\n",
-                         required_iflags);
+       if (!(s_iflags & SB_I_NOEXEC)) {
+               WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC\n");
+               return true;
+       }
+
+       if (!(s_iflags & (SB_I_NODEV | SB_I_MANAGED_DEVICES))) {
+               WARN_ONCE(1, "Expected s_iflags to contain device access mask\n");
                return true;
        }

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..6ca0fe922478 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE            0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE        0x00000020
 #define SB_I_UNTRUSTED_MOUNTER         0x00000040
+#define SB_I_MANAGED_DEVICES           0x00000080

 #define SB_I_SKIP_SYNC 0x00000100      /* Skip superblock at global sync */
 #define SB_I_PERSB_BDI 0x00000200      /* has a per-sb bdi */

> 
> > 
> > Store your device access rules in a bpf map or in the sb->s_security
> > blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).
> > 
> > Then make that bpf lsm program kick in everytime a
> > security_inode_mknod() and security_file_open() is called and do device
> > access management in there. Actually, you might need to add one hook
> > when the actual device that's about to be opened is know. 
> > This should be where today the device access hooks are called.
> > 
> > And then you should already be done with this. The only thing that you
> > need is the capable check patch.
> > 
> > You don't need that cgroup_bpf_current_enabled() per se. Device
> > management could now be done per superblock, and not per task. IOW, you
> > allowlist a bunch of devices that can be created and opened. Any task
> > that passes basic permission checks and that passes the bpf lsm program
> > may create device nodes.
> > 
> > That's a way more natural device management model than making this a per
> > cgroup thing. Though that could be implemented as well with this.
> > 
> > I would try to write a bpf lsm program that does device access
> > management with your capable() sysctl patch applied and see how far I
> > get.
> > 
> > I don't have the time otherwise I'd do it.
> I'll give it a try but no promises how fast this will go.

No worries. We're entering the holiday season anyway.

