Return-Path: <linux-fsdevel+bounces-6361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E1816DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6262B28432E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD04E61F;
	Mon, 18 Dec 2023 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USyQ0cig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB4B5DE;
	Mon, 18 Dec 2023 12:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933AFC433C7;
	Mon, 18 Dec 2023 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702902643;
	bh=AA/8yh8b80ZQsaF4+TUE7HQt/5ZSOagkn1HY7nMlrt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USyQ0cigRyoU+7qQTCkP8/cqIxRRjB8ZXVPg70kxRRZImeGrhq0VS6W/7VJeP18bV
	 +9y+z0XXYn0BLZ3MwXql72rE4PylbwEoo+U397TxkRZbkQDdh5hjGrVdrxJvY1u6SC
	 ufaBvvHtHI537nNdedn2VcGMlKQ9ApfN5cV+wieiJRSCxq7kP9QEKOHeX+FLLpl1Ez
	 5hF2saq1XZC9DwArwRF8BxTk/WaAfo3p8cLaqiv+1juAnojmMVVL2AEic8YFjRsEXM
	 xxNdvPNPRTPSA0N45n8M0prwDIG0CYHAueVlNPDDrIhZxmKoutDKuluniYSLCcqN2y
	 WfWbSmNv2E/1Q==
Date: Mon, 18 Dec 2023 13:30:34 +0100
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
Message-ID: <20231218-chipsatz-abfangen-d62626dfb9e2@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
 <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
 <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>

On Sat, Dec 16, 2023 at 09:41:10AM -0800, Alexei Starovoitov wrote:
> On Sat, Dec 16, 2023 at 2:38 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Dec 15, 2023 at 10:08:08AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Dec 15, 2023 at 6:15 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Weiß wrote:
> > > > > On 15.12.23 13:31, Christian Brauner wrote:
> > > > > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
> > > > > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > > > > >> namespace in cooperation of an attached cgroup device program. We
> > > > > >> just need to implement the security_inode_mknod() hook for this.
> > > > > >> In the hook, we check if the current task is guarded by a device
> > > > > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > > > > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > > > > >>
> > > > > >> Access decisions to those device nodes are then guarded by existing
> > > > > >> device cgroups mechanism.
> > > > > >>
> > > > > >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > > > > >> ---
> > > > > >
> > > > > > I think you misunderstood me... My point was that I believe you don't
> > > > > > need an additional LSM at all and no additional LSM hook. But I might be
> > > > > > wrong. Only a POC would show.
> > > > >
> > > > > Yeah sorry, I got your point now.
> > > >
> > > > I think I might have had a misconception about how this works.
> > > > A bpf LSM program can't easily alter a kernel object such as struct
> > > > super_block I've been told.
> > >
> > > Right. bpf cannot change arbitrary kernel objects,
> > > but we can add a kfunc that will change a specific bit in a specific
> > > data structure.
> > > Adding a new lsm hook that does:
> > >     rc = call_int_hook(sb_device_access, 0, sb);
> > >     switch (rc) {
> > >     case 0: do X
> > >     case 1: do Y
> > >
> > > is the same thing, but uglier, since return code will be used
> > > to do this action.
> > > The 'do X' can be one kfunc
> > > and 'do Y' can be another.
> > > If later we find out that 'do X' is not a good idea we can remove
> > > that kfunc.
> >
> > The reason I moved the SB_I_MANAGED_DEVICES here is that I want a single
> > central place where that is done for any possible LSM that wants to
> > implement device management. So we don't have to go chasing where that
> > bit is set for each LSM. I also don't want to have LSMs raise bits in
> > sb->s_iflags directly as that's VFS property.
> 
> a kfunc that sets a bit in sb->s_iflags will be the same central place.

For the BPF LSM. I'm talking the same place for al LSMs.

> It will be somewhere in the fs/ directory and vfs maintainers can do what they
> wish with it, including removal.
> For traditional LSM one would need to do an accurate code review to make
> sure that they don't mess with sb->s_iflags while for bpf_lsm it
> will be done automatically. That kfunc will be that only one central place.

I'm not generally opposed to kfuncs ofc but here it just seems a bit
pointless. What we want is to keep SB_I_{NODEV,MANAGED_DEVICES} confined
to alloc_super(). The only central place it's raised where we control
all locking and logic. So it doesn't even have to appear in any
security_*() hooks.

diff --git a/security/security.c b/security/security.c
index 088a79c35c26..bf440d15615d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1221,6 +1221,33 @@ int security_sb_alloc(struct super_block *sb)
 	return rc;
 }
 
+/*
+ * security_sb_device_access() - Let LSMs handle device access
+ * @sb: filesystem superblock
+ *
+ * Let an LSM take over device access management for this superblock.
+ *
+ * Return: Returns 1 if LSMs handle device access, 0 if none does and -ERRNO on
+ *         failure.
+ */
+int security_sb_device_access(struct super_block *sb)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(sb_device_access);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_device_access, list) {
+		thisrc = hp->hook.sb_device_access(sb);
+		if (thisrc < 0)
+			return thisrc;
+		/* At least one LSM claimed device access management. */
+		if (thisrc == 1)
+			rc = 1;
+	}
+
+	return rc;
+}
+
 /**
  * security_sb_delete() - Release super_block LSM associated objects
  * @sb: filesystem superblock

diff --git a/fs/super.c b/fs/super.c
index 076392396e72..2295c0f76e56 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 {
 	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static const struct super_operations default_op;
-	int i;
+	int err, i;
 
 	if (!s)
 		return NULL;
@@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	}
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
-	if (s->s_user_ns != &init_user_ns)
+
+	err = security_sb_device_access(s);
+	if (err < 0)
+		goto fail;
+
+	if (err)
+		s->s_iflags |= SB_I_MANAGED_DEVICES;
+	else if (s->s_user_ns != &init_user_ns)
 		s->s_iflags |= SB_I_NODEV;
+
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);

