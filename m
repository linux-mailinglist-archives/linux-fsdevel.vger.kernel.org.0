Return-Path: <linux-fsdevel+bounces-59831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30825B3E43F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E0481089
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED81338F39;
	Mon,  1 Sep 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgbnUt9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A081A76D4;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732250; cv=none; b=TC3IHokdNuMcBN9+8LXJgugYeogk3BAK7uTBJmZEHXIdEWBBak7CxmDtVnmK7rjlJ21cWoidQA+HYxiAbpQhZIoHHwt85NdhnaDYoTqNjJ+hT7lijTiC+rQw25sAge2GKwezjiSnA2dPpTwLotP29K5ZE8jn4TlKI2ERq1vMWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732250; c=relaxed/simple;
	bh=WxAJb8y6KLvFMgj52QKhGM7dsrNASWlYkcze/8Ta6c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzX55E2soJOVz89JG09GOl1vzxzfs35/Ms32ob55P+3NxahFK4RTfwkpb/O65jMDiV2bHdO8L7pyUbMiY/d0eNDVcEAAxq+S9WmvhLyhJ94aLAsmC+ttxz/qZ3vsWy8zDweLl9QPHnO8QYTgopgrVouIgpcWg+ctIsi2bGkJlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgbnUt9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AAF6C19424;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732249;
	bh=WxAJb8y6KLvFMgj52QKhGM7dsrNASWlYkcze/8Ta6c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lgbnUt9AfooIbdKatQDek+v4zywf7AiBssU5Il4r67ywpXoUzRS5bvNYc13AMY83u
	 axoQUW0E8dxryspWLVSScxpppgNrCxdyb/2ECqDIsOcf8AJxlzN/7IHJzJA2rK7ZC7
	 InllPsekfzXnXiqBol7kDj5IKpKtGpxKyQKoeHDwlTSdYASkR4JcT6WevmJLZr/hTM
	 rMNYJe27922bLFjH8NU/r1tN5t94YfUB7hXCtILfYw3R9N08pbC4lYKu05uP7ip20H
	 fAfCF46em5LDK10CvpkMmMPa5ONQ6tK5kYlpf+rtZF7WEYH2ehY/ERDWW0NHV27JWN
	 lwn8yWdDG63vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F2DCA1002;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Mon, 01 Sep 2025 15:09:51 +0200
Subject: [PATCH v2 2/4] copy_process: pass clone_flags as u64 across
 calltree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nios2-implement-clone3-v2-2-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732247; l=28948;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=njxJQVcDFJwG3DHpXL+bH/qXyZK3UEcNYTT5nHs1jB8=;
 b=eP7meY6J764lrrg6lIYhLk4Tfoy0+oVw7ztOVFuBZ4mmUH4nxITt6B4mzbfTT8/ZP41uw5o3U
 /ZWpQeFA/I0AzOiy/UCcxSlvQSHAZPeMgtjDBX0NlUIxO6VJFV/yls8
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
clone3") the effective bit width of clone_flags on all architectures was
increased from 32-bit to 64-bit, with a new type of u64 for the flags.
However, for most consumers of clone_flags the interface was not
changed from the previous type of unsigned long.

While this works fine as long as none of the new 64-bit flag bits
(CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
undesirable in terms of the principle of least surprise.

Thus, this commit fixes all relevant interfaces of callees to
sys_clone3/copy_process (excluding the architecture-specific
copy_thread) to consistently pass clone_flags as u64, so that
no truncation to 32-bit integers occurs on 32-bit architectures.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 block/blk-ioc.c                | 2 +-
 fs/namespace.c                 | 2 +-
 include/linux/cgroup.h         | 4 ++--
 include/linux/cred.h           | 2 +-
 include/linux/iocontext.h      | 6 +++---
 include/linux/ipc_namespace.h  | 4 ++--
 include/linux/lsm_hook_defs.h  | 2 +-
 include/linux/mnt_namespace.h  | 2 +-
 include/linux/nsproxy.h        | 2 +-
 include/linux/pid_namespace.h  | 4 ++--
 include/linux/rseq.h           | 4 ++--
 include/linux/sched/task.h     | 2 +-
 include/linux/security.h       | 4 ++--
 include/linux/sem.h            | 4 ++--
 include/linux/time_namespace.h | 4 ++--
 include/linux/uprobes.h        | 4 ++--
 include/linux/user_events.h    | 4 ++--
 include/linux/utsname.h        | 4 ++--
 include/net/net_namespace.h    | 4 ++--
 include/trace/events/task.h    | 6 +++---
 ipc/namespace.c                | 2 +-
 ipc/sem.c                      | 2 +-
 kernel/cgroup/namespace.c      | 2 +-
 kernel/cred.c                  | 2 +-
 kernel/events/uprobes.c        | 2 +-
 kernel/fork.c                  | 8 ++++----
 kernel/nsproxy.c               | 4 ++--
 kernel/pid_namespace.c         | 2 +-
 kernel/sched/core.c            | 4 ++--
 kernel/sched/fair.c            | 2 +-
 kernel/sched/sched.h           | 4 ++--
 kernel/time/namespace.c        | 2 +-
 kernel/utsname.c               | 2 +-
 net/core/net_namespace.c       | 2 +-
 security/apparmor/lsm.c        | 2 +-
 security/security.c            | 2 +-
 security/selinux/hooks.c       | 2 +-
 security/tomoyo/tomoyo.c       | 2 +-
 38 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9fda3906e5f5..d15918d7fabb 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -286,7 +286,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 }
 EXPORT_SYMBOL_GPL(set_task_ioprio);
 
-int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
+int __copy_io(u64 clone_flags, struct task_struct *tsk)
 {
 	struct io_context *ioc = current->io_context;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 4b352a44cb80..0cd875b38552 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4202,7 +4202,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 }
 
 __latent_entropy
-struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
+struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 		struct user_namespace *user_ns, struct fs_struct *new_fs)
 {
 	struct mnt_namespace *new_ns;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ae73dbb19165..15ed7a8f0abb 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -801,7 +801,7 @@ extern struct cgroup_namespace init_cgroup_ns;
 
 void free_cgroup_ns(struct cgroup_namespace *ns);
 
-struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
+struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 					struct user_namespace *user_ns,
 					struct cgroup_namespace *old_ns);
 
@@ -823,7 +823,7 @@ static inline void put_cgroup_ns(struct cgroup_namespace *ns)
 
 static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
 static inline struct cgroup_namespace *
-copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
+copy_cgroup_ns(u64 flags, struct user_namespace *user_ns,
 	       struct cgroup_namespace *old_ns)
 {
 	return old_ns;
diff --git a/include/linux/cred.h b/include/linux/cred.h
index a102a10f833f..89ae50ad2ace 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -148,7 +148,7 @@ struct cred {
 
 extern void __put_cred(struct cred *);
 extern void exit_creds(struct task_struct *);
-extern int copy_creds(struct task_struct *, unsigned long);
+extern int copy_creds(struct task_struct *, u64);
 extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 14f7eaf1b443..079d8773790c 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -118,8 +118,8 @@ struct task_struct;
 #ifdef CONFIG_BLOCK
 void put_io_context(struct io_context *ioc);
 void exit_io_context(struct task_struct *task);
-int __copy_io(unsigned long clone_flags, struct task_struct *tsk);
-static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
+int __copy_io(u64 clone_flags, struct task_struct *tsk);
+static inline int copy_io(u64 clone_flags, struct task_struct *tsk)
 {
 	if (!current->io_context)
 		return 0;
@@ -129,7 +129,7 @@ static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
 struct io_context;
 static inline void put_io_context(struct io_context *ioc) { }
 static inline void exit_io_context(struct task_struct *task) { }
-static inline int copy_io(unsigned long clone_flags, struct task_struct *tsk)
+static inline int copy_io(u64 clone_flags, struct task_struct *tsk)
 {
 	return 0;
 }
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e8240cf2611a..4b399893e2b3 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -129,7 +129,7 @@ static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
 #endif
 
 #if defined(CONFIG_IPC_NS)
-extern struct ipc_namespace *copy_ipcs(unsigned long flags,
+extern struct ipc_namespace *copy_ipcs(u64 flags,
 	struct user_namespace *user_ns, struct ipc_namespace *ns);
 
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
@@ -151,7 +151,7 @@ static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns
 
 extern void put_ipc_ns(struct ipc_namespace *ns);
 #else
-static inline struct ipc_namespace *copy_ipcs(unsigned long flags,
+static inline struct ipc_namespace *copy_ipcs(u64 flags,
 	struct user_namespace *user_ns, struct ipc_namespace *ns)
 {
 	if (flags & CLONE_NEWIPC)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fd11fffdd3c3..adbe234a6f6c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -211,7 +211,7 @@ LSM_HOOK(int, 0, file_open, struct file *file)
 LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
-	 unsigned long clone_flags)
+	 u64 clone_flags)
 LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
 LSM_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
 LSM_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 70b366b64816..ff290c87b2e7 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -11,7 +11,7 @@ struct fs_struct;
 struct user_namespace;
 struct ns_common;
 
-extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
+extern struct mnt_namespace *copy_mnt_ns(u64, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
 extern void put_mnt_ns(struct mnt_namespace *ns);
 DEFINE_FREE(put_mnt_ns, struct mnt_namespace *, if (!IS_ERR_OR_NULL(_T)) put_mnt_ns(_T))
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index dab6a1734a22..82533e899ff4 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -103,7 +103,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
  *
  */
 
-int copy_namespaces(unsigned long flags, struct task_struct *tsk);
+int copy_namespaces(u64 flags, struct task_struct *tsk);
 void exit_task_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a5811199..0620a3e08e83 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -78,7 +78,7 @@ static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
 }
 #endif
 
-extern struct pid_namespace *copy_pid_ns(unsigned long flags,
+extern struct pid_namespace *copy_pid_ns(u64 flags,
 	struct user_namespace *user_ns, struct pid_namespace *ns);
 extern void zap_pid_ns_processes(struct pid_namespace *pid_ns);
 extern int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd);
@@ -97,7 +97,7 @@ static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
 	return 0;
 }
 
-static inline struct pid_namespace *copy_pid_ns(unsigned long flags,
+static inline struct pid_namespace *copy_pid_ns(u64 flags,
 	struct user_namespace *user_ns, struct pid_namespace *ns)
 {
 	if (flags & CLONE_NEWPID)
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3eb5598..a96fd345aa38 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -65,7 +65,7 @@ static inline void rseq_migrate(struct task_struct *t)
  * If parent process has a registered restartable sequences area, the
  * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
 {
 	if (clone_flags & CLONE_VM) {
 		t->rseq = NULL;
@@ -107,7 +107,7 @@ static inline void rseq_preempt(struct task_struct *t)
 static inline void rseq_migrate(struct task_struct *t)
 {
 }
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
 {
 }
 static inline void rseq_execve(struct task_struct *t)
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ea41795a352b..34d6a0e108c3 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -63,7 +63,7 @@ extern int lockdep_tasklist_lock_is_held(void);
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
-extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
+extern int sched_fork(u64 clone_flags, struct task_struct *p);
 extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
diff --git a/include/linux/security.h b/include/linux/security.h
index 521bcb5b9717..9a1d4a6c8673 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -489,7 +489,7 @@ int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
 int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
-int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
+int security_task_alloc(struct task_struct *task, u64 clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
@@ -1215,7 +1215,7 @@ static inline int security_file_truncate(struct file *file)
 }
 
 static inline int security_task_alloc(struct task_struct *task,
-				      unsigned long clone_flags)
+				      u64 clone_flags)
 {
 	return 0;
 }
diff --git a/include/linux/sem.h b/include/linux/sem.h
index c4deefe42aeb..275269ce2ec8 100644
--- a/include/linux/sem.h
+++ b/include/linux/sem.h
@@ -9,12 +9,12 @@ struct task_struct;
 
 #ifdef CONFIG_SYSVIPC
 
-extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
+extern int copy_semundo(u64 clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
 
 #else
 
-static inline int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+static inline int copy_semundo(u64 clone_flags, struct task_struct *tsk)
 {
 	return 0;
 }
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb2c52f4fc94..b6e36525e0be 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -43,7 +43,7 @@ static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 	return ns;
 }
 
-struct time_namespace *copy_time_ns(unsigned long flags,
+struct time_namespace *copy_time_ns(u64 flags,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct time_namespace *ns);
@@ -129,7 +129,7 @@ static inline void put_time_ns(struct time_namespace *ns)
 }
 
 static inline
-struct time_namespace *copy_time_ns(unsigned long flags,
+struct time_namespace *copy_time_ns(u64 flags,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns)
 {
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 516217c39094..915303a82d84 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -205,7 +205,7 @@ extern void uprobe_start_dup_mmap(void);
 extern void uprobe_end_dup_mmap(void);
 extern void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm);
 extern void uprobe_free_utask(struct task_struct *t);
-extern void uprobe_copy_process(struct task_struct *t, unsigned long flags);
+extern void uprobe_copy_process(struct task_struct *t, u64 flags);
 extern int uprobe_post_sstep_notifier(struct pt_regs *regs);
 extern int uprobe_pre_sstep_notifier(struct pt_regs *regs);
 extern void uprobe_notify_resume(struct pt_regs *regs);
@@ -281,7 +281,7 @@ static inline bool uprobe_deny_signal(void)
 static inline void uprobe_free_utask(struct task_struct *t)
 {
 }
-static inline void uprobe_copy_process(struct task_struct *t, unsigned long flags)
+static inline void uprobe_copy_process(struct task_struct *t, u64 flags)
 {
 }
 static inline void uprobe_clear_state(struct mm_struct *mm)
diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 8afa8c3a0973..57d1ff006090 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -33,7 +33,7 @@ extern void user_event_mm_dup(struct task_struct *t,
 extern void user_event_mm_remove(struct task_struct *t);
 
 static inline void user_events_fork(struct task_struct *t,
-				    unsigned long clone_flags)
+				    u64 clone_flags)
 {
 	struct user_event_mm *old_mm;
 
@@ -68,7 +68,7 @@ static inline void user_events_exit(struct task_struct *t)
 }
 #else
 static inline void user_events_fork(struct task_struct *t,
-				    unsigned long clone_flags)
+				    u64 clone_flags)
 {
 }
 
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index bf7613ba412b..ba34ec0e2f95 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -35,7 +35,7 @@ static inline void get_uts_ns(struct uts_namespace *ns)
 	refcount_inc(&ns->ns.count);
 }
 
-extern struct uts_namespace *copy_utsname(unsigned long flags,
+extern struct uts_namespace *copy_utsname(u64 flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns);
 extern void free_uts_ns(struct uts_namespace *ns);
 
@@ -55,7 +55,7 @@ static inline void put_uts_ns(struct uts_namespace *ns)
 {
 }
 
-static inline struct uts_namespace *copy_utsname(unsigned long flags,
+static inline struct uts_namespace *copy_utsname(u64 flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns)
 {
 	if (flags & CLONE_NEWUTS)
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..0e008cfe159d 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -204,7 +204,7 @@ struct net {
 extern struct net init_net;
 
 #ifdef CONFIG_NET_NS
-struct net *copy_net_ns(unsigned long flags, struct user_namespace *user_ns,
+struct net *copy_net_ns(u64 flags, struct user_namespace *user_ns,
 			struct net *old_net);
 
 void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid);
@@ -218,7 +218,7 @@ extern struct task_struct *cleanup_net_task;
 #else /* CONFIG_NET_NS */
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
-static inline struct net *copy_net_ns(unsigned long flags,
+static inline struct net *copy_net_ns(u64 flags,
 	struct user_namespace *user_ns, struct net *old_net)
 {
 	if (flags & CLONE_NEWNET)
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index af535b053033..4f0759634306 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -8,14 +8,14 @@
 
 TRACE_EVENT(task_newtask,
 
-	TP_PROTO(struct task_struct *task, unsigned long clone_flags),
+	TP_PROTO(struct task_struct *task, u64 clone_flags),
 
 	TP_ARGS(task, clone_flags),
 
 	TP_STRUCT__entry(
 		__field(	pid_t,	pid)
 		__array(	char,	comm, TASK_COMM_LEN)
-		__field( unsigned long, clone_flags)
+		__field(	u64,    clone_flags)
 		__field(	short,	oom_score_adj)
 	),
 
@@ -26,7 +26,7 @@ TRACE_EVENT(task_newtask,
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d comm=%s clone_flags=%lx oom_score_adj=%hd",
+	TP_printk("pid=%d comm=%s clone_flags=%llx oom_score_adj=%hd",
 		__entry->pid, __entry->comm,
 		__entry->clone_flags, __entry->oom_score_adj)
 );
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 4df91ceeeafe..a712ec27209c 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -106,7 +106,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	return ERR_PTR(err);
 }
 
-struct ipc_namespace *copy_ipcs(unsigned long flags,
+struct ipc_namespace *copy_ipcs(u64 flags,
 	struct user_namespace *user_ns, struct ipc_namespace *ns)
 {
 	if (!(flags & CLONE_NEWIPC))
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..0f06e4bd4673 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2303,7 +2303,7 @@ SYSCALL_DEFINE3(semop, int, semid, struct sembuf __user *, tsops,
  * parent and child tasks.
  */
 
-int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+int copy_semundo(u64 clone_flags, struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	int error;
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 144a464e45c6..dedadb525880 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -47,7 +47,7 @@ void free_cgroup_ns(struct cgroup_namespace *ns)
 }
 EXPORT_SYMBOL(free_cgroup_ns);
 
-struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
+struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 					struct user_namespace *user_ns,
 					struct cgroup_namespace *old_ns)
 {
diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..dbf6b687dc5c 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -287,7 +287,7 @@ struct cred *prepare_exec_creds(void)
  * The new process gets the current process's subjective credentials as its
  * objective and subjective credentials
  */
-int copy_creds(struct task_struct *p, unsigned long clone_flags)
+int copy_creds(struct task_struct *p, u64 clone_flags)
 {
 	struct cred *new;
 	int ret;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 31a12b60055f..aa479d24ccaf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2160,7 +2160,7 @@ static void dup_xol_work(struct callback_head *work)
 /*
  * Called in context of a new clone/fork from copy_process.
  */
-void uprobe_copy_process(struct task_struct *t, unsigned long flags)
+void uprobe_copy_process(struct task_struct *t, u64 flags)
 {
 	struct uprobe_task *utask = current->utask;
 	struct mm_struct *mm = current->mm;
diff --git a/kernel/fork.c b/kernel/fork.c
index 82f5d52fecf1..0e9b2dd6c365 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1510,7 +1510,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return NULL;
 }
 
-static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm;
 
@@ -1548,7 +1548,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk)
 {
 	struct fs_struct *fs = current->fs;
 	if (clone_flags & CLONE_FS) {
@@ -1569,7 +1569,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+static int copy_files(u64 clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
@@ -1648,7 +1648,7 @@ static void posix_cpu_timers_init_group(struct signal_struct *sig)
 	posix_cputimers_group_init(pct, cpu_limit);
 }
 
-static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_signal(u64 clone_flags, struct task_struct *tsk)
 {
 	struct signal_struct *sig;
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 5f31fdff8a38..8af3b9ec3aa8 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -64,7 +64,7 @@ static inline struct nsproxy *create_nsproxy(void)
  * Return the newly created nsproxy.  Do not attach this to the task,
  * leave it to the caller to do proper locking and attach it to task.
  */
-static struct nsproxy *create_new_namespaces(unsigned long flags,
+static struct nsproxy *create_new_namespaces(u64 flags,
 	struct task_struct *tsk, struct user_namespace *user_ns,
 	struct fs_struct *new_fs)
 {
@@ -144,7 +144,7 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
  * called from clone.  This now handles copy for nsproxy and all
  * namespaces therein.
  */
-int copy_namespaces(unsigned long flags, struct task_struct *tsk)
+int copy_namespaces(u64 flags, struct task_struct *tsk)
 {
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..06bc7c7f78e0 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -171,7 +171,7 @@ static void destroy_pid_namespace_work(struct work_struct *work)
 	} while (ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count));
 }
 
-struct pid_namespace *copy_pid_ns(unsigned long flags,
+struct pid_namespace *copy_pid_ns(u64 flags,
 	struct user_namespace *user_ns, struct pid_namespace *old_ns)
 {
 	if (!(flags & CLONE_NEWPID))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..6fa85d30d965 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4472,7 +4472,7 @@ int wake_up_state(struct task_struct *p, unsigned int state)
  * __sched_fork() is basic setup which is also used by sched_init() to
  * initialize the boot CPU's idle task.
  */
-static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
+static void __sched_fork(u64 clone_flags, struct task_struct *p)
 {
 	p->on_rq			= 0;
 
@@ -4707,7 +4707,7 @@ late_initcall(sched_core_sysctl_init);
 /*
  * fork()/clone()-time setup:
  */
-int sched_fork(unsigned long clone_flags, struct task_struct *p)
+int sched_fork(u64 clone_flags, struct task_struct *p)
 {
 	__sched_fork(clone_flags, p);
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e256793b9a08..06bcba61ca75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3542,7 +3542,7 @@ static void task_numa_work(struct callback_head *work)
 	}
 }
 
-void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+void init_numa_balancing(u64 clone_flags, struct task_struct *p)
 {
 	int mm_users = 0;
 	struct mm_struct *mm = p->mm;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..f9adfc912ddc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1935,12 +1935,12 @@ extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
-extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
+extern void init_numa_balancing(u64 clone_flags, struct task_struct *p);
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
 static inline void
-init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+init_numa_balancing(u64 clone_flags, struct task_struct *p)
 {
 }
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 667452768ed3..888872bcc5bb 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -130,7 +130,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
  *
  * Return: timens_for_children namespace or ERR_PTR.
  */
-struct time_namespace *copy_time_ns(unsigned long flags,
+struct time_namespace *copy_time_ns(u64 flags,
 	struct user_namespace *user_ns, struct time_namespace *old_ns)
 {
 	if (!(flags & CLONE_NEWTIME))
diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..00d8d7922f86 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -86,7 +86,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
  * utsname of this process won't be seen by parent, and vice
  * versa.
  */
-struct uts_namespace *copy_utsname(unsigned long flags,
+struct uts_namespace *copy_utsname(u64 flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns)
 {
 	struct uts_namespace *new_ns;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1b6f3826dd0e..8ec9d83475bf 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -539,7 +539,7 @@ void net_drop_ns(void *p)
 		net_passive_dec(net);
 }
 
-struct net *copy_net_ns(unsigned long flags,
+struct net *copy_net_ns(u64 flags,
 			struct user_namespace *user_ns, struct net *old_net)
 {
 	struct ucounts *ucounts;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8e1cc229b41b..ba39cfe0cd08 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -112,7 +112,7 @@ static void apparmor_task_free(struct task_struct *task)
 }
 
 static int apparmor_task_alloc(struct task_struct *task,
-			       unsigned long clone_flags)
+			       u64 clone_flags)
 {
 	struct aa_task_ctx *new = task_ctx(task);
 
diff --git a/security/security.c b/security/security.c
index ca126b02d2fe..d5fea03a741a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3224,7 +3224,7 @@ int security_file_truncate(struct file *file)
  *
  * Return: Returns a zero on success, negative values on failure.
  */
-int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
+int security_task_alloc(struct task_struct *task, u64 clone_flags)
 {
 	int rc = lsm_task_alloc(task);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f94642ca34f2..9d3b5ebd7657 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4144,7 +4144,7 @@ static int selinux_file_open(struct file *file)
 /* task security operations */
 
 static int selinux_task_alloc(struct task_struct *task,
-			      unsigned long clone_flags)
+			      u64 clone_flags)
 {
 	u32 sid = current_sid();
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index d6ebcd9db80a..48fc59d38ab2 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -514,7 +514,7 @@ struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
  * Returns 0.
  */
 static int tomoyo_task_alloc(struct task_struct *task,
-			     unsigned long clone_flags)
+			     u64 clone_flags)
 {
 	struct tomoyo_task *old = tomoyo_task(current);
 	struct tomoyo_task *new = tomoyo_task(task);

-- 
2.39.5



