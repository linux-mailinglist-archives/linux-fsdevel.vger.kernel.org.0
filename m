Return-Path: <linux-fsdevel+bounces-47326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA2A9C089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C24D1BA5C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06422356CB;
	Fri, 25 Apr 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgcSoaC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA21FBEB3;
	Fri, 25 Apr 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568707; cv=none; b=dI279usLoWSk/4eAHRX4ARQTsXDNmeU0d3FNP45qCGAtZNFtLC7DO5ZoJke2I0EWwKt7Ssvj6IFlfWwUJ6/ky1kWPIIWluJ019Rt34iGW5qVxyDRJHhVEjbMVyX/MuEO3Erh0LalaYBSQoT94yO1iy9fo8KLJLQBoAk/Y8gP+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568707; c=relaxed/simple;
	bh=TIzb1XjY5m+NMEkrlE4sVETjtxq1jNB+I9PJv+21BYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ4XKgkbqzq0tW+WiT9M+2ukzxKRpQjdQzOaJ20wg15P5yoOHgZv8e4aNSNWLzYoxCSQs+/3VdEBhwb1i0cknhQSApDCi5pp7g4pXirBHp+PxxW3ostLxPiWRNQClGrFqHmlHfWedJVF6p7lFi2tp+YUyXwSF2R0upD6zGd3/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgcSoaC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3B0C4CEE4;
	Fri, 25 Apr 2025 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568706;
	bh=TIzb1XjY5m+NMEkrlE4sVETjtxq1jNB+I9PJv+21BYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AgcSoaC9ENrczjXekusmTk2YJHw5pqb/nh7/8igwvSbSTwV5jIau4/nJGggavGhlX
	 oV0x3Hq62GKEGJfZfNTRkCHxA+MRKpqcjbFxVqZwgUY/YWHuXSzGTNZ/VcSXhBSRqn
	 5U/8CE46WiW3A2X5fBkKI/+q4KhxVLpzCbdcZGua0WOO9bLzXdWdeTlEFwrjdu+znT
	 hylu6KGhczMEqCilB0h+oTrJlVPgpKbXYrPBgj/B9F4bVhoT8MTMiw6bzxguhYpo5K
	 BcpKD79N3Oz9M6LBYEvI91eRekO0ZhAUJibEBqmsxCtSmo6ucY1tUjDl3OoLKzBtzW
	 kvFj6jVllLRkA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:31 +0200
Subject: [PATCH v2 2/4] net, pidfs: prepare for handing out pidfds for
 reaped sk->sk_peer_pid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-work-pidfs-net-v2-2-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8886; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TIzb1XjY5m+NMEkrlE4sVETjtxq1jNB+I9PJv+21BYA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwO299IrjBUjFvs0vqmpNnWDecfyM8qVA8u7e+UcMk/
 8ubf1dVOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSbcfwP8H72hyVqkd7rixS
 CF/z/jSjJofd6SlybO9Ynx0NEZtnYMrwP3Ftjnjf8cffrJaePBGUc+fL0RyurJ/XfZhV1U/fcmi
 z4QMA
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

Link: https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f78a2492826f..472f8aa9ea15 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -100,6 +100,7 @@
 #include <linux/splice.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/pidfs.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -643,6 +644,9 @@ static void unix_sock_destructor(struct sock *sk)
 		return;
 	}
 
+	if (sk->sk_peer_pid)
+		pidfs_put_pid(sk->sk_peer_pid);
+
 	if (u->addr)
 		unix_release_addr(u->addr);
 
@@ -734,13 +738,48 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		unix_gc();		/* Garbage collect fds */
 }
 
-static void init_peercred(struct sock *sk)
+struct unix_peercred {
+	struct pid *peer_pid;
+	const struct cred *peer_cred;
+};
+
+static inline int prepare_peercred(struct unix_peercred *peercred)
 {
-	sk->sk_peer_pid = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	struct pid *pid;
+	int err;
+
+	pid = task_tgid(current);
+	err = pidfs_register_pid(pid);
+	if (likely(!err)) {
+		peercred->peer_pid = get_pid(pid);
+		peercred->peer_cred = get_current_cred();
+	}
+	return err;
 }
 
-static void update_peercred(struct sock *sk)
+static void drop_peercred(struct unix_peercred *peercred)
+{
+	const struct cred *cred = NULL;
+	struct pid *pid = NULL;
+
+	might_sleep();
+
+	swap(peercred->peer_pid, pid);
+	swap(peercred->peer_cred, cred);
+
+	pidfs_put_pid(pid);
+	put_pid(pid);
+	put_cred(cred);
+}
+
+static inline void init_peercred(struct sock *sk,
+				 const struct unix_peercred *peercred)
+{
+	sk->sk_peer_pid = peercred->peer_pid;
+	sk->sk_peer_cred = peercred->peer_cred;
+}
+
+static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
@@ -748,11 +787,11 @@ static void update_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	init_peercred(sk);
+	init_peercred(sk, peercred);
 	spin_unlock(&sk->sk_peer_lock);
 
-	put_pid(old_pid);
-	put_cred(old_cred);
+	peercred->peer_pid = old_pid;
+	peercred->peer_cred = old_cred;
 }
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
@@ -761,6 +800,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 	spin_lock(&sk->sk_peer_lock);
 	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
+	pidfs_get_pid(sk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }
@@ -770,6 +810,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	int err;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
+	struct unix_peercred peercred = {};
 
 	err = -EOPNOTSUPP;
 	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
@@ -777,6 +818,9 @@ static int unix_listen(struct socket *sock, int backlog)
 	err = -EINVAL;
 	if (!READ_ONCE(u->addr))
 		goto out;	/* No listens on an unbound socket */
+	err = prepare_peercred(&peercred);
+	if (err)
+		goto out;
 	unix_state_lock(sk);
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
 		goto out_unlock;
@@ -786,11 +830,12 @@ static int unix_listen(struct socket *sock, int backlog)
 	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
 
 	/* set credentials so connect can copy them */
-	update_peercred(sk);
+	update_peercred(sk, &peercred);
 	err = 0;
 
 out_unlock:
 	unix_state_unlock(sk);
+	drop_peercred(&peercred);
 out:
 	return err;
 }
@@ -1525,6 +1570,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
 	struct sock *sk = sock->sk, *newsk = NULL, *other = NULL;
 	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
+	struct unix_peercred peercred = {};
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb = NULL;
 	unsigned char state;
@@ -1561,6 +1607,10 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
+	err = prepare_peercred(&peercred);
+	if (err)
+		goto out;
+
 	/* Allocate skb for sending to listening sock */
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
 	if (!skb) {
@@ -1636,7 +1686,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	unix_peer(newsk)	= sk;
 	newsk->sk_state		= TCP_ESTABLISHED;
 	newsk->sk_type		= sk->sk_type;
-	init_peercred(newsk);
+	init_peercred(newsk, &peercred);
 	newu = unix_sk(newsk);
 	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
@@ -1695,20 +1745,33 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 out_free_sk:
 	unix_release_sock(newsk, 0);
 out:
+	drop_peercred(&peercred);
 	return err;
 }
 
 static int unix_socketpair(struct socket *socka, struct socket *sockb)
 {
+	struct unix_peercred ska_peercred = {}, skb_peercred = {};
 	struct sock *ska = socka->sk, *skb = sockb->sk;
+	int err;
+
+	err = prepare_peercred(&ska_peercred);
+	if (err)
+		return err;
+
+	err = prepare_peercred(&skb_peercred);
+	if (err) {
+		drop_peercred(&ska_peercred);
+		return err;
+	}
 
 	/* Join our sockets back to back */
 	sock_hold(ska);
 	sock_hold(skb);
 	unix_peer(ska) = skb;
 	unix_peer(skb) = ska;
-	init_peercred(ska);
-	init_peercred(skb);
+	init_peercred(ska, &ska_peercred);
+	init_peercred(skb, &skb_peercred);
 
 	ska->sk_state = TCP_ESTABLISHED;
 	skb->sk_state = TCP_ESTABLISHED;

-- 
2.47.2


