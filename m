Return-Path: <linux-fsdevel+bounces-47228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4586A9AD4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C85924EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7C238C04;
	Thu, 24 Apr 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD23BqKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E8230BC0;
	Thu, 24 Apr 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497514; cv=none; b=RxEm1Q4e2xNslnNv6LEq/iik7aJgf8Sb369SfQFt5OOBSRX8MmlwNXaiDeYbeVtjFZtjt/9iHvX7cNWCvrR2kgmEWzHYdT6VD3W228CDCJ9hGlbEB+IqQ53izn6Cvq0UllwJS1pu1IuG8nkq8wXxeH8y1MUwVd4PGgEnSxK+rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497514; c=relaxed/simple;
	bh=H85T7UL7vYG9a6vaHAoCybvewWCdAIkCbhDvrv1eS+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GRjwWRcNGe/vNXlPwbQBTX+eoCZuLo73aDxKonfdP3TwizA7pvVTN1ldwM/jw5F4QgBd2mskIa7EXhIUmyy+SWzS8+CYpwI5FaD64T2IZZlklHC4gLppEUrWniNxXS6082GUbConSe9eokwF8Ur6NMQLQuLg7rwThXoY/bp93W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD23BqKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7E5C4CEE3;
	Thu, 24 Apr 2025 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497513;
	bh=H85T7UL7vYG9a6vaHAoCybvewWCdAIkCbhDvrv1eS+M=;
	h=From:Subject:Date:To:Cc:From;
	b=QD23BqKgWk9drOUY4Y9QR6+T7l+8feIj5Yp/3k4t3zx5lbKVAMUrZsUDw6r6p/fQ9
	 vyXFHapMSfJRVJPRVK/mmEKDxiHOMf4aPS2idnAcmBPaRGb3wa3UuRZ6MvAbYxU6gl
	 ewoahy5JF31WAzBaYZ3Tpr+B6v2QYgvdH/gLqguFqt64pxQw1xgIKVHAyQO5widdgE
	 6JNjBJRJ/X90jzfW251uhsGK8zRJX2mJXvn6pSJ8pZp5a0Kgvf1F+K7x6lsTHaaSaj
	 d3PyyBIn6BEPa3HMKH8Vo9Bl3YNpjQzP4mNHibTcXgN0jp6gQ9cEL9yOZTFxXeTWvn
	 xm3bq1mBNh79A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] net, pidfs: enable handing out pidfds for reaped
 sk->sk_peer_pid
Date: Thu, 24 Apr 2025 14:24:33 +0200
Message-Id: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEtCmgC/x2MywrCMBAAf6Xs2S15aCheBT/Aa/GQx9YuQlo2U
 gul/27scQZmNigkTAWuzQZCCxeecgV9aiCOPr8IOVUGo8xFnY3F7yRvnDkNBTN9MESlO22cTba
 DGs1CA6/HsIfH/QbPKoMvhEF8juP/tdTWtdq1xwb2/QfFUJTwhgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4056; i=brauner@kernel.org;
 h=from:subject:message-id; bh=H85T7UL7vYG9a6vaHAoCybvewWCdAIkCbhDvrv1eS+M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw6S7N0bq2fM3X7qRi7csRtho/shLD52q9uKqj8vli4
 6Tpa/dxdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExktgjDf1eb1gvWkqv0Q50z
 Ex/E3PwpxyEY33g+bqf7ywPHvpyI3czI8PGa6KHpUSd/5rKf4jddbqVzs9au+YjdItU4s16Vohf
 r2QE=
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
Christian Brauner (4):
      pidfs: register pid in pidfs
      net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
      pidfs: get rid of __pidfd_prepare()
      net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid

 fs/pidfs.c                 | 70 ++++++++++++++++++++++++++++++++----
 include/linux/pidfs.h      |  3 ++
 include/uapi/linux/pidfd.h |  2 +-
 kernel/fork.c              | 78 +++++++++++++---------------------------
 net/core/sock.c            |  4 ++-
 net/unix/af_unix.c         | 90 ++++++++++++++++++++++++++++++++++++++++------
 6 files changed, 174 insertions(+), 73 deletions(-)
---
base-commit: b590c928cca7bdc7fd580d52e42bfdc3ac5eeacb
change-id: 20250423-work-pidfs-net-bc0181263d38


