Return-Path: <linux-fsdevel+bounces-47324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CEA9C083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B565A8462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1D233716;
	Fri, 25 Apr 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mppd4iNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB09635;
	Fri, 25 Apr 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568698; cv=none; b=lgLoqnfSnSICA/U5C4W0LVHyb8uyCBvGjSzL1rDlMDEQ0j7oUDjvnVgos+kODRvyYl6aMZLaRnxsKPfJDqMH7WupDxbqxXqcA5cxvQ/hPiZGtdG1vF4RfrdRgrZiWeOWkalbIHcO1RX/muef4maRx4NO+t36Asir0Yn9+5zcpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568698; c=relaxed/simple;
	bh=OeoGTzqIXWKG0WR7yHzhaa/n/JCxUB6HHr/mg+IaKuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ta+MFnxJezFbhUa2tTx1n+I7lefaKe0lKCQoHoC70j39eg4edfnJfC3uladcTb7s5oj6ShErgq0ZNrhRfsvvxk7UQbiSaV+MLHKFrH/zM9/IRX3kE0kEiDjNv2TcBnxjxdRiWJ3kF307CPdP8Wr9KRazO3rDpsxaCt7DIdG/Vp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mppd4iNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56A5C4CEE4;
	Fri, 25 Apr 2025 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568698;
	bh=OeoGTzqIXWKG0WR7yHzhaa/n/JCxUB6HHr/mg+IaKuU=;
	h=From:Subject:Date:To:Cc:From;
	b=Mppd4iNVhd9GWibmBwC3c1UnwRWgNMjU/c+Z0OBQ9T3vJxYdIycqDAsheEwCzFFdB
	 E4vlbqINVwZSLeSzm9W4W+GuqCEglzcET5sRpG+zK8gnFdXlWb18j26l0+89vS8C9j
	 1ZwNzhrUZSHK2nCbciM03Ch0kmgL13B3iG2AnFYmT7X7EfxQ2oIPgQ0/6Czqnkbp5R
	 dxNpptU2V8z9FE3EToGg8JwI0/Mauett5tSibh5VKCZXUI+sf2y9MNJFpNv57LZZ77
	 a+qLlB4yKXT4yLvhTzOF/8IyJugkOX88mwgBhAGeFmOqWeoKyDqqp+3IEZ2zTmRHeC
	 4G4hbCfupdeuQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] net, pidfs: enable handing out pidfds for reaped
 sk->sk_peer_pid
Date: Fri, 25 Apr 2025 10:11:29 +0200
Message-Id: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALFDC2gC/12OOw6DMBAFr4JcZ5E//JIq94gowF7AIrLRGjmJE
 HePQUqTcoqZ9zYWkCwGdss2RhhtsN4lkJeM6alzI4I1iZnksuSFVPDyNMNizRDA4Qq95qIRslJ
 GNSxJC+Fg32fw0Sbuu4DQU+f0dGRi0qpcVPlZOITJhtXT5zwQxaH9tor/rSiAAzf6WktZm6Ys7
 jOSw2fuaWTtvu9fwfaOIM4AAAA=
X-Change-ID: 20250423-work-pidfs-net-bc0181263d38
To: Oleg Nesterov <oleg@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, David Rheinsberg <david@readahead.eu>, 
 Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Luca Boccassi <bluca@debian.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4586; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OeoGTzqIXWKG0WR7yHzhaa/n/JCxUB6HHr/mg+IaKuU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwO2/dIKbh7Tyt03Ty5ylcYq0xm3NyOFbz7g4XMrAw1
 0i+Jva8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKfljAynFDr+SU3QdPg3YSL
 +o27P/ovSXVaUdFzi3vCpMv5T62M7Rn+u82VFte07z3psE1W4mb+iapv0Zzd+i+PXzVe2vD9hJE
 yEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SO_PEERPIDFD currently doesn't support handing out pidfds if the
sk->sk_peer_pid thread-group leader has already been reaped. In this
case it currently returns EINVAL. Userspace still wants to get a pidfd
for a reaped process to have a stable handle it can pass on.
This is especially useful now that it is possible to retrieve exit
information through a pidfd via the PIDFD_GET_INFO ioctl()'s
PIDFD_INFO_EXIT flag.

Another summary has been provided by David in [1]:

> A pidfd can outlive the task it refers to, and thus user-space must
> already be prepared that the task underlying a pidfd is gone at the time
> they get their hands on the pidfd. For instance, resolving the pidfd to
> a PID via the fdinfo must be prepared to read `-1`.
>
> Despite user-space knowing that a pidfd might be stale, several kernel
> APIs currently add another layer that checks for this. In particular,
> SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
> but returns a stale pidfd if the task is reaped immediately after the
> respective alive-check.
>
> This has the unfortunate effect that user-space now has two ways to
> check for the exact same scenario: A syscall might return
> EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
> particular reason to distinguish both cases. This also propagates
> through user-space APIs, which pass on pidfds. They must be prepared to
> pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
> stale pidfd from the kernel.
> Userspace must already deal with a pidfd referring to a reaped task as
> the task may exit and get reaped at any time will there are still many
> pidfds referring to it.

In order to allow handing out reaped pidfd SO_PEERPIDFD needs to ensure
that PIDFD_INFO_EXIT information is available whenever a pidfd for a
reaped task is created by PIDFD_INFO_EXIT. The uapi promises that reaped
pidfds are only handed out if it is guaranteed that the caller sees the
exit information:

TEST_F(pidfd_info, success_reaped)
{
        struct pidfd_info info = {
                .mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
        };

        /*
         * Process has already been reaped and PIDFD_INFO_EXIT been set.
         * Verify that we can retrieve the exit status of the process.
         */
        ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
        ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
        ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
        ASSERT_TRUE(WIFEXITED(info.exit_code));
        ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
}

To hand out pidfds for reaped processes we thus allocate a pidfs entry
for the relevant sk->sk_peer_pid at the time the sk->sk_peer_pid is
stashed and drop it when the socket is destroyed. This guarantees that
exit information will always be recorded for the sk->sk_peer_pid task
and we can hand out pidfds for reaped processes.

Note, I'm marking this as RFC mostly because I'm open to other
approaches to solving the pidfs registration. The functionality in
general we should really provide either way.

Link: https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Fix typo in pidfs_register_pid() kernel documentation.
- Remove SOCK_RCU_FREE check as it's already and better covered by might_sleep().
- Add comment to pidfd_prepare() about PIDFD_STALE only being valid if
  the caller knows PIDFD_INFO_EXIT information is guaranteed to be
  available.
- Fix naming of variables and adhere to net declaration ordering.
- Link to v1: https://lore.kernel.org/20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org

---
Christian Brauner (4):
      pidfs: register pid in pidfs
      net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
      pidfs: get rid of __pidfd_prepare()
      net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid

 fs/pidfs.c                 | 80 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/pid.h        |  2 +-
 include/linux/pidfs.h      |  3 ++
 include/uapi/linux/pidfd.h |  2 +-
 kernel/fork.c              | 83 ++++++++++++++++----------------------------
 net/core/sock.c            | 14 +++-----
 net/unix/af_unix.c         | 85 ++++++++++++++++++++++++++++++++++++++++------
 7 files changed, 183 insertions(+), 86 deletions(-)
---
base-commit: b590c928cca7bdc7fd580d52e42bfdc3ac5eeacb
change-id: 20250423-work-pidfs-net-bc0181263d38


