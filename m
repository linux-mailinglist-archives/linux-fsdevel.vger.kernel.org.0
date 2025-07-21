Return-Path: <linux-fsdevel+bounces-55562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC7B0BF31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF4917963B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639C2877FD;
	Mon, 21 Jul 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="nwlCbLHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17E2820AB;
	Mon, 21 Jul 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087490; cv=none; b=n+/o4cKJ5UhjrUJlZ5hTelHs1VMYaqmxr0RGRFjMjmaO9MRLvs3mOLPjdtbdqUkPMr2f9dnHBcynxy6YmhQ9/L83knUvE6DJ0lk7YoEG6BRWvubIWpYlJxGGoyd+sZjlS0+0iS1ClAYrIkCTt8JM1JtVew6z9acYFMintv+L9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087490; c=relaxed/simple;
	bh=YWX3DE0Aan818S7gIkr8GLZTXCVTsALTdSNXc97vXoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aVkTZDgGmDY0glqf+VvISrq/nNzjoQTQ385QU+6ev/Nv8EJ3ZhzM+YTJTrVUUdllKc450AE4ZQbSnC3BrXoi3toAwlkvPyPAmqLJ1exEAqewNPsC9AdyO4klgxThqhse7zPvfGKJyOWX1j9ZmGrNl4mWD9/sgNLVQz5OUD9Pmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=nwlCbLHO; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4blv8q0nvHz9scY;
	Mon, 21 Jul 2025 10:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753087483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9LQnCq1xiY9dvqH/3V8T7UlKGfMNq6Pf3NbYrD3FGE=;
	b=nwlCbLHOwI+Ln0MI9voaLlK37jpNOOjlJu+/OTwfG+cu/Ad+DBJeyZXi65oofCr4HMb2SP
	P/qzat0/F2ZpNdMy/SyzvOa02YZQHYqsHUG1ZYGzJcjYprQ2SXFd5/a6HySjJG9oL4Xac2
	i4plOWRR7KCtqEo062vbJoCaA0E7rKY/q00E0fzxjJzt+TSbfV06hlVeCU+Ywptab42chL
	gn3CbLDTWZ/IkQSKFNmqZb5DMjIEiAIP+A29Sm3k31ISqWC+DqKZylnHKKsPSGP68ZV1/a
	nT7Mfa5Ny1E1E7+oleLHsdcf2c2QgweoiKJe4fT+nSQc49zPy2vCl7rsi9/PEw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
Date: Mon, 21 Jul 2025 18:44:10 +1000
Message-Id: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANr9fWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3YKi/OS0Yt2CzJS8Yt3Egkxdi9QUQ1MLYxNjwzQDJaC2gqLUtMw
 KsJHRSkFuzkqxtbUAKGfTX2cAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=YWX3DE0Aan818S7gIkr8GLZTXCVTsALTdSNXc97vXoI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTU/n3ffy70yIV/e5bVc/yvdrzzyip3t4FgtMVrllc5z
 zz7lkad7ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATWW7D8Fdu36SyPW+7I7w9
 Dj0Jn23clTfpgLPUcps/Vq5yH2redUYx/NMV25rz/I7mTJP0pfJCVWdO2d7IM1y0cY2IuVd2L6u
 BPzMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Ever since the introduction of pid namespaces, procfs has had very
implicit behaviour surrounding them (the pidns used by a procfs mount is
auto-selected based on the mounting process's active pidns, and the
pidns itself is basically hidden once the mount has been constructed).
This has historically meant that userspace was required to do some
special dances in order to configure the pidns of a procfs mount as
desired. Examples include:

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
current pid namespace is a direct ancestor of. This fulfils the
requirements of container runtimes, but I suspect that this may be too
strict for some usecases.

The pidns argument is not displayed in mountinfo -- it's not clear to me
what value it would make sense to show (maybe we could just use ns_dname
to provide an identifier for the namespace, but this number would be
fairly useless to userspace). I'm open to suggestions.

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
Aleksa Sarai (4):
      pidns: move is-ancestor logic to helper
      procfs: add pidns= mount option
      procfs: add PROCFS_GET_PID_NAMESPACE ioctl
      selftests/proc: add tests for new pidns APIs

 Documentation/filesystems/proc.rst        |  10 ++
 fs/proc/root.c                            | 132 +++++++++++++-
 include/linux/pid_namespace.h             |   9 +
 include/uapi/linux/fs.h                   |   3 +
 kernel/pid_namespace.c                    |  21 ++-
 tools/testing/selftests/proc/.gitignore   |   1 +
 tools/testing/selftests/proc/Makefile     |   1 +
 tools/testing/selftests/proc/proc-pidns.c | 286 ++++++++++++++++++++++++++++++
 8 files changed, 448 insertions(+), 15 deletions(-)
---
base-commit: 4c838c7672c39ec6ec48456c6ce22d14a68f4cda
change-id: 20250717-procfs-pidns-api-8ed1583431f0

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


