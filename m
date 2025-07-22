Return-Path: <linux-fsdevel+bounces-55764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF8B0E70E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029547A9D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE328B7F9;
	Tue, 22 Jul 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="G3OxleXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB223814A;
	Tue, 22 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226372; cv=none; b=KQhrKTBgIAoSnW6wQCVKftgVh1ZeM1B/OFzEO7LUr/nxybFWnuyy73I+mJvB+Cuy4srzygFA7df0LRECxNhn290ey3UVbZNLfeQhLsBkuS93Wwzz1BA0jn9jNw7QEpZdLfEDvs44BbmBeUwFX/TbUJTuceQSShpjeqktYVIMZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226372; c=relaxed/simple;
	bh=xF+2b088s8hiQRuan619eMUQ2j3jmQ9mhmnuez+gj1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DQEMWPUb44jexGlfEr9sCZjopPZhsMU3dQSRT/0ogMviNNK67Xw5V9U5GnNepYyRpyfHI4vZ+ZPMl8MtcMuzf7ZgaCryrnoZSBXRnqq7rGxMpTmzNt4KWx+L7zImsofH9EEIWUBGE5e63jyDBjQc9i6eWTS3IXuwAVJ5stW8j1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=G3OxleXp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bmtWY0Cslz9tf8;
	Wed, 23 Jul 2025 01:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753226361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pn+meOtRzfPiFzH8wA9razP9aPfpco/GgN81W9hphDU=;
	b=G3OxleXp739PaPCa2wS2Qlc6cLe+U47RAM2tlgmgep/zJ1id+auHdLUZ8DB0dsg0lFVUm1
	GLguGS3hbDGtTpPiin0RPWEXWU4wdRQi/irHn/ixFM9Gksvms+E9HAFlcrTH3muTv6LVeB
	rdXjQQJGeWTolaKOAY+AbYb4iylQ+lauaJkuG6TjX34lOjEXePDSg13ma72QznM+tnH+Ol
	b76rH7SMAmxaarFwwmtY7Hl9agkwJw6+ztbSv65w2AWgd+D1U671hIDNIxJM9m2ahhF/5A
	Ky+QC4zmu4Cq4Sit+abmATDFeWsaebbIGeN1DjTC2FZxiDce3BucD1oBChUvDw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RFC v2 0/4] procfs: make reference pidns more user-visible
Date: Wed, 23 Jul 2025 09:18:50 +1000
Message-Id: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFocgGgC/2WNwQrCMBBEf6Xs2ZVsamj1VBD8AK/SQ0m2dg82I
 ZFiKfl3Qz16fDPMmw0SR+EEl2qDyIsk8XMBfajATsP8ZBRXGLTSRjXUYIjejgmDuDnhEARbdmT
 a+lTTqKDMQuRRPrvyAffbFfoSTpLePq77zUJ79TNq+jcuhAqNdWelGjakXWfXMA3xaP0L+pzzF
 79h8522AAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5559; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=xF+2b088s8hiQRuan619eMUQ2j3jmQ9mhmnuez+gj1I=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0yOQXX7l33IFx3ruUPaH34l8EPX5uKuIRfL7GU5XF6
 tC81ddZO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEXhxhZPjb2F3VENUiVFsU
 4CF7/DvLKfXLKpunmTD9zo9e1xbZ/YGRYbXFLtfnAf23nf6e8TupO0Gh6mZgxB/GnQ07nnnacMy
 azggA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

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

It's not quite clear what is the correct security model for this API,
but the current approach I've taken is to:

 * Make the ioctl only valid on the root (meaning that a process without
   access to the procfs root -- such as only having an fd to a procfs
   file or some open_tree(2)-like subset -- cannot use this API).

 * Require that the process requesting either has access to
   /proc/1/ns/pid anyway (i.e. has ptrace-read access to the pidns
   pid1), has CAP_SYS_ADMIN access to the pidns (i.e. has administrative
   access to it and can join it if they had a handle), or is in a pidns
   that is a direct ancestor of the target pidns (i.e. all of the pids
   are already visible in the procfs for the current process's pidns).

The security model for this is a little loose, as it seems to me that
all of the cases mentioned are valid cases to allow access, but I'm open
to suggestions for whether we need to make this stricter or looser.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
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

 Documentation/filesystems/proc.rst        |  10 ++
 fs/proc/root.c                            | 144 ++++++++++++++-
 include/linux/pid_namespace.h             |   9 +
 include/uapi/linux/fs.h                   |   3 +
 kernel/pid_namespace.c                    |  23 ++-
 tools/testing/selftests/proc/.gitignore   |   1 +
 tools/testing/selftests/proc/Makefile     |   1 +
 tools/testing/selftests/proc/proc-pidns.c | 286 ++++++++++++++++++++++++++++++
 8 files changed, 461 insertions(+), 16 deletions(-)
---
base-commit: 4c838c7672c39ec6ec48456c6ce22d14a68f4cda
change-id: 20250717-procfs-pidns-api-8ed1583431f0

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


