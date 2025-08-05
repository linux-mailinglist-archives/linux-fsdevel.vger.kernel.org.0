Return-Path: <linux-fsdevel+bounces-56724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54BB1ADBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175823BF3C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5A21A424;
	Tue,  5 Aug 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="bBjDfKYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE3175A5;
	Tue,  5 Aug 2025 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754373243; cv=none; b=ZBp17RtvMN/SPj4VqTRlHUJrzCBkQVSGk+8KHj1xzTk2Tuo12vypppyeB2IxUORm2oXeYchWy1Ygr1yh8KCyalqU1NKWrKsyl0daUedYDx4vxJsDPVGC1fz0UOEqrHLbZF77zKIH4YCW8goPzpTwbGy1pD0bl6z7GSmBmcEd4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754373243; c=relaxed/simple;
	bh=b3qLvidQt2IQmyqEcAsLJbmTR+wVyp6SbcerHb1qMcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hy2vXOhRTo/c4zigZyhpweHyn1q2wDksmrE76+qAsU1UMAWCu1ch6Jw47tSkM1FynqTTNe4u0jny3VAb64+hmCfT9w5DYfkU9IASUpF2EodOtzmjQoshbe+CBtVoiUOhcKW84AOeykvGmk3oDQtdKL9zn9TwJ/P1zIq1lUtpNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=bBjDfKYW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bx2T60Psrz9t8l;
	Tue,  5 Aug 2025 07:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754372730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bPF4WdQCtv984o72KwXLxMISxhU/aJPqgLwzYtsm72M=;
	b=bBjDfKYWT21NFwvhbyK5aFKtO6yFlm8WKPH9dWAj5oD5m1o+cPDeaf3RswmG9jD83irGDi
	OpSvCvXeZuBix3/tg2FMC3AL8+gyQwrHiZibGBamiSy0+gusfknYSXjoUG11XufHr79v3u
	MlViEwFLGuQ3lGIcljKeXIn8m4w6+Fsj6atzQWPSheC0cBLTAigLG/UyXtsbl9AnMLXxvE
	Xh3lR5sdmm9nFCjCaZpezk3FnoxlEBuDmYJ/6vqSp4OH4Sn5xcuTJsiKuPM5+mqs78ViPV
	o17N3NWGq4KpbOeOgNto/Uksx9Cu4EwpetVbqhnax656nKXT5VIaTRzEDWBH9Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v4 0/4] procfs: make reference pidns more user-visible
Date: Tue, 05 Aug 2025 15:45:07 +1000
Message-Id: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGOakWgC/23NTQ6CMBCG4auYrq3p9IcWV97DuCDtIF0ITWsaC
 eHuFuICA8v3S+aZiSSMHhO5niYSMfvkh76EPJ+I7Zr+idS70oQzrpgGTUMcbJto8K5PtAmeGnS
 gjJACWkbKWYjY+s9K3h+lO5/eQxzXDxmW9Ydx2GMZKKPKupoxjQq4u9kxdE282OFFFi3zrSAOB
 F6EigNqdM6gZDtBbAV5IIgiSFsZZWtgNRd/wjzPX4EKj1I1AQAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7460; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=b3qLvidQt2IQmyqEcAsLJbmTR+wVyp6SbcerHb1qMcs=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMnJV35/6lhU2bWe6c99t5d/cht20Cy821S3StD09t/
 V617E/f4Y5SFgYxLgZZMUWWbX6eoZvmL76S/GklG8wcViaQIQxcnAIwEekljAwv5yivvVnkLrSR
 vfXk4+Wpn166LLTnnrJ5VZB6vEPwv6z7jAzbNp5fo5x/vczhas+Cjh1/LR3a7bbue9Pf/bPhdPe
 dCiEGAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bx2T60Psrz9t8l

Ever since the introduction of pid namespaces, procfs has had very
implicit behaviour surrounding them (the pidns used by a procfs mount is
auto-selected based on the mounting process's active pidns, and the
pidns itself is basically hidden once the mount has been constructed).

/* pidns mount option for procfs */

This implicit behaviour has historically meant that userspace was
required to do some special dances in order to configure the pidns of a
procfs mount as desired. Examples include:

 * In order to bypass the mnt_too_revealing() check, Kubernetes creates
   a procfs mount from an empty pidns so that user namespaced containers
   can be nested (without this, the nested containers would fail to
   mount procfs). But this requires forking off a helper process because
   you cannot just one-shot this using mount(2).

 * Container runtimes in general need to fork into a container before
   configuring its mounts, which can lead to security issues in the case
   of shared-pidns containers (a privileged process in the pidns can
   interact with your container runtime process). While
   SUID_DUMP_DISABLE and user namespaces make this less of an issue, the
   strict need for this due to a minor uAPI wart is kind of unfortunate.

Things would be much easier if there was a way for userspace to just
specify the pidns they want. Patch 1 implements a new "pidns" argument
which can be set using fsconfig(2):

    fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
    fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);

or classic mount(2) / mount(8):

    // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
    mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");

The initial security model I have in this RFC is to be as conservative
as possible and just mirror the security model for setns(2) -- which
means that you can only set pidns=... to pid namespaces that your
current pid namespace is a direct ancestor of and you have CAP_SYS_ADMIN
privileges over the pid namespace. This fulfils the requirements of
container runtimes, but I suspect that this may be too strict for some
usecases.

The pidns argument is not displayed in mountinfo -- it's not clear to me
what value it would make sense to show (maybe we could just use ns_dname
to provide an identifier for the namespace, but this number would be
fairly useless to userspace). I'm open to suggestions. Note that
PROCFS_GET_PID_NAMESPACE (see below) does at least let userspace get
information about this outside of mountinfo.

Note that you cannot change the pidns of an already-created procfs
instance. The primary reason is that allowing this to be changed would
require RCU-protecting proc_pid_ns(sb) and thus auditing all of
fs/proc/* and some of the users in fs/* to make sure they wouldn't UAF
the pid namespace. Since creating procfs instances is very cheap, it
seems unnecessary to overcomplicate this upfront. Trying to reconfigure
procfs this way errors out with -EBUSY.

/* ioctl(PROCFS_GET_PID_NAMESPACE) */

In addition, being able to figure out what pid namespace is being used
by a procfs mount is quite useful when you have an administrative
process (such as a container runtime) which wants to figure out the
correct way of mapping PIDs between its own namespace and the namespace
for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
alternative ways to do this, but they all rely on ancillary information
that third-party libraries and tools do not necessarily have access to.

To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
can be used to get a reference to the pidns that a procfs is using.

Rather than copying the (fairly strict) security model for setns(2),
apply a slightly looser model to better match what userspace can already
do:

 * Make the ioctl only valid on the root (meaning that a process without
   access to the procfs root -- such as only having an fd to a procfs
   file or some open_tree(2)-like subset -- cannot use this API). This
   means that the process already has some level of access to the
   /proc/$pid directories.

 * If the calling process is in an ancestor pidns, then they can already
   create pidfd for processes inside the pidns, which is morally
   equivalent to a pidns file descriptor according to setns(2). So it
   seems reasonable to just allow it in this case. (The justification
   for this model was suggested by Christian.)

 * If the process has access to /proc/1/ns/pid already (i.e. has
   ptrace-read access to the pidns pid1), then this ioctl is equivalent
   to just opening a handle to it that way.

   Ideally we would check for ptrace-read access against all processes
   in the pidns (which is very likely to be true for at least one
   process, as SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set
   by most programs), but this would obviously not scale.

I'm open to suggestions for whether we need to make this stricter (or
possibly allow more cases).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v4:
- Remove unneeded EXPORT_SYMBOL_GPL. [Christian Brauner]
- Return -EOPNOTSUPP for new APIs for CONFIG_PID_NS=n rather than
  pretending they don't exist entirely. [Christian Brauner]
- PROCFS_IOCTL_MAGIC conflicts with XSDFEC_MAGIC, so we need to allocate
  subvalues more carefully (switch to _IO(PROCFS_IOCTL_MAGIC, 32)).
- Add some more selftests for PROCFS_GET_PID_NAMESPACE.
- Reword argument for PROCFS_GET_PID_NAMESPACE security model based on
  Christian's suggestion, and remove CAP_SYS_ADMIN edge-case (in most
  cases, such a process would also have ptrace-read credentials over the
  pidns pid1).
- v3: <https://lore.kernel.org/r/20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>

Changes in v3:
- Disallow changing pidns for existing procfs instances, as we'd
  probably have to RCU-protect everything that touches the pinned pidns
  reference.
- Improve tests with slightly nicer ASSERT_ERRNO* macros.
- v2: <https://lore.kernel.org/r/20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>

Changes in v2:
- #ifdef CONFIG_PID_NS
- Improve cover letter wording to make it clear we're talking about two
  separate features with different permission models. [Andy Lutomirski]
- Fix build warnings in pidns_is_ancestor() patch. [kernel test robot]
- v1: <https://lore.kernel.org/r/20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>

---
Aleksa Sarai (4):
      pidns: move is-ancestor logic to helper
      procfs: add "pidns" mount option
      procfs: add PROCFS_GET_PID_NAMESPACE ioctl
      selftests/proc: add tests for new pidns APIs

 Documentation/filesystems/proc.rst        |  12 ++
 fs/proc/root.c                            | 166 +++++++++++++++-
 include/linux/pid_namespace.h             |   9 +
 include/uapi/linux/fs.h                   |   4 +
 kernel/pid_namespace.c                    |  22 ++-
 tools/testing/selftests/proc/.gitignore   |   1 +
 tools/testing/selftests/proc/Makefile     |   1 +
 tools/testing/selftests/proc/proc-pidns.c | 315 ++++++++++++++++++++++++++++++
 8 files changed, 514 insertions(+), 16 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250717-procfs-pidns-api-8ed1583431f0

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


