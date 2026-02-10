Return-Path: <linux-fsdevel+bounces-76910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOLhGfLAi2l6aQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:36:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F8120142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465CB30E6407
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CC32ED34;
	Tue, 10 Feb 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ucqS2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDA19ABD8;
	Tue, 10 Feb 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766315; cv=none; b=iVxk3CJuDhIN1w2UYpn4490zEEGaIzoHXtswAvpk0B8QCMj2Au8hnUPpaNbfTQqP5HOEos3md7MamuOhwaQ8zmWuNw/qB3bMI9tmZmp3dYYr8v75Cdi6BoY5di9nOzCe+trtyb35tZ9dweP0NCA8Xcf9K/GjTyGR2a0X3wAgHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766315; c=relaxed/simple;
	bh=i2LsVTJLiDP/fNc9zPNhFhVuok9lWdveDssQ+zprQY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c07Ua1G67q0XFaVYgzLlq9NGQA0Kz50qNh2X6QzUz3wxlxGKP39xQ/dQ27YXTYwDejlH+vsZm9CbTvsmhUw8CuR5NGwZC8VXivQT6UvdARlPvRAKqq0y367eAuS2AWDc0BNiKXDnLBb/skUXzxc7zuehOBgHGk8LsY4HUlUzQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ucqS2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD575C19423;
	Tue, 10 Feb 2026 23:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766314;
	bh=i2LsVTJLiDP/fNc9zPNhFhVuok9lWdveDssQ+zprQY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2ucqS2svxU9favFeUnRxtEz7ilwQNZQP8ZZ+XD8oSy4w8sD71hN9labasqWFpgSa
	 JEMefGkuSefCgeQ7+oNuqhM9OJ47GTO6qu6qS2kRo0JHo/0hplMcXP9TJLKjVLyeES
	 4glMdA4XjO9w+pVc41p1dZ+Fq6sJlfDUmjHyde8GC+k3aSAAHi1T0UQv22DidNLm9V
	 YAvuYReC5klAAXPEyRnJjtkDck4n/WpTjxMRbOTIhkxJooUDEnOiDxxXqzbMchQdKg
	 dOx5AfOnWE3z3uaO91cTFdg3c3kkEUW+LCvy6eHOxIUmVIak57d+Q06Y8h3QrKPqQK
	 C/bqgRPbjob4w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] netfs: when subreq is marked for retry, do not check if it faced an error
Date: Tue, 10 Feb 2026 18:31:05 -0500
Message-ID: <20260210233123.2905307-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210233123.2905307-1-sashal@kernel.org>
References: <20260210233123.2905307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76910-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA0F8120142
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 82e8885bd7633a36ee9050e6d7f348a4155eed5f ]

The *_subreq_terminated functions today only process the NEED_RETRY
flag when the subreq was successful or failed with EAGAIN error.
However, there could be other retriable errors for network filesystems.

Avoid this by processing the NEED_RETRY irrespective of the error
code faced by the subreq. If it was specifically marked for retry,
the error code must not matter.

Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me provide my detailed analysis.

---

## Comprehensive Analysis

### 1. Commit Message Analysis

The commit title "netfs: when subreq is marked for retry, do not check
if it faced an error" clearly describes a bug fix. The commit explains
that `*_subreq_terminated` functions only process the
`NETFS_SREQ_NEED_RETRY` flag when the subrequest was successful or had
an `-EAGAIN` error, but network filesystems may set `NEED_RETRY` for
other error codes.

The commit has:
- **Acked-by: David Howells** — the creator and maintainer of the netfs
  subsystem
- **Signed-off-by: Shyam Prasad N** — a CIFS/SMB kernel developer at
  Microsoft
- **Signed-off-by: Steve French** — the CIFS/SMB subsystem maintainer

### 2. Code Change Analysis — The Bug

**Read Path Bug** in `netfs_read_subreq_terminated()`
(`read_collect.c`):

When CIFS handles a `MID_REQUEST_SUBMITTED` or `MID_RETRY_NEEDED`
response (as seen in `smb2pdu.c` lines 4633-4640):

```4639:4640:fs/smb/client/smb2pdu.c
                __set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
                rdata->result = -EAGAIN;
```

Then at line 4707: `rdata->subreq.error = rdata->result;` (= -EAGAIN),
and line 4710 calls `netfs_read_subreq_terminated()`.

In the current code:

```532:547:fs/netfs/read_collect.c
        if (!subreq->error && subreq->transferred < subreq->len) {
                // ... this block is SKIPPED because error is -EAGAIN
(non-zero)
        }
```

Then:

```549:560:fs/netfs/read_collect.c
        if (unlikely(subreq->error < 0)) {
                trace_netfs_failure(rreq, subreq, subreq->error,
netfs_fail_read);
                if (subreq->source == NETFS_READ_FROM_CACHE) {
                        netfs_stat(&netfs_n_rh_read_failed);
                        __set_bit(NETFS_SREQ_NEED_RETRY,
&subreq->flags);
                } else {
                        netfs_stat(&netfs_n_rh_download_failed);
                        __set_bit(NETFS_SREQ_FAILED, &subreq->flags);
// BUG: overrides NEED_RETRY!
                }
```

For server downloads, `NETFS_SREQ_FAILED` is set **despite**
`NETFS_SREQ_NEED_RETRY` already being set by CIFS. Since the collection
code at line 269 checks `FAILED` **before** `NEED_RETRY` at line 277,
and the retry code at line 94 abandons if `FAILED` is set, the
subrequest is **permanently failed** instead of being retried.

**Write Path Bug** in `netfs_write_subrequest_terminated()`
(`write_collect.c`):

```493:498:fs/netfs/write_collect.c
        if (IS_ERR_VALUE(transferred_or_error)) {
                subreq->error = transferred_or_error;
                if (subreq->error == -EAGAIN)
                        set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
                else
                        set_bit(NETFS_SREQ_FAILED, &subreq->flags);
```

AFS sets `NETFS_SREQ_NEED_RETRY` for auth errors (`-EACCES`, `-EPERM`,
`-ENOKEY`, etc.) at `fs/afs/write.c:165` before calling
`netfs_write_subrequest_terminated()` with those error codes. Since the
error is not `-EAGAIN`, the netfs layer overrides the filesystem's retry
request with `FAILED`.

### 3. The Fix

1. **`read_collect.c`**: Adds a check for `NETFS_SREQ_NEED_RETRY` before
   the error handling block. If NEED_RETRY is set, it pauses the request
   and jumps past error checks via `goto skip_error_checks`, preventing
   FAILED from being set.

2. **`write_collect.c`**: Replaces the EAGAIN-only check with a check
   for whether NEED_RETRY is already set. If set, FAILED is not applied.
   This delegates retry decisions to the filesystem.

3. **`read_retry.c` / `write_issue.c`**: Adds `subreq->error = 0` in
   `netfs_reissue_read()` and `netfs_reissue_write()` to clear stale
   error codes before reissuing.

4. **`read_retry.c` abandon path**: Removes the `!subreq->error` check
   since subrequests with `NEED_RETRY` can now legitimately carry error
   codes.

### 4. User Impact

This bug directly affects:
- **CIFS/SMB users** experiencing network disruptions (laptop lid
  close/open, WiFi drops, VPN changes): reads fail with errors instead
  of transparently retrying
- **AFS users** needing key rotation during writes: writes fail instead
  of retrying with a different key
- These are common real-world scenarios for enterprise and laptop users

### 5. Risk Assessment

**Positive:**
- Small patch (~30 lines across 4 files)
- ACKed by the netfs subsystem maintainer
- Logically sound: filesystems know better than the generic layer when
  to retry
- Addresses concrete, user-facing failures

**Concerns:**
- The write path removes the EAGAIN→NEED_RETRY fallback. AFS's
  `afs_alloc_operation()` failure (line 133) passes -EAGAIN without pre-
  setting NEED_RETRY — this would now fail instead of retry. However,
  David Howells (AFS author) ACKed this change, accepting the behavioral
  shift.
- 9p similarly doesn't pre-set NEED_RETRY — -EAGAIN from 9p would no
  longer trigger retry. This is likely intentional: the filesystem
  should decide, not the generic layer.
- The affected code (with the new collector architecture) exists from
  v6.14 onward. v6.14 has a slightly different function signature for
  `netfs_write_subrequest_terminated` (with `was_async` parameter),
  requiring minor backport adjustment.

### 6. Dependency Check

- No missing dependencies: `NETFS_RREQ_PAUSE`,
  `netfs_rreq_trace_set_pause`, and all other referenced symbols exist
  in the current stable trees.
- The patch is self-contained and doesn't appear to be part of a series.
- For v6.18 stable, the patch should apply cleanly as the code matches
  exactly.

### 7. Conclusion

This commit fixes a real, user-visible bug where network filesystem I/O
operations marked for retry by CIFS and AFS are incorrectly treated as
permanent failures by the netfs generic layer. The bug causes spurious
I/O errors during common scenarios like network reconnections and
authentication retries. The fix is small, reviewed by the subsystem
maintainer, and addresses concrete failure paths. While it includes a
deliberate behavioral shift in the write path (removing EAGAIN special-
casing), this was reviewed and ACKed by the relevant maintainers. The
risk is low relative to the benefit of fixing CIFS reconnection failures
for a large user base.

**YES**

 fs/netfs/read_collect.c  | 10 ++++++++++
 fs/netfs/read_retry.c    |  4 ++--
 fs/netfs/write_collect.c |  8 ++++----
 fs/netfs/write_issue.c   |  1 +
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7a0ffa675fb17..137f0e28a44c5 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -546,6 +546,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		}
 	}
 
+	/* If need retry is set, error should not matter unless we hit too many
+	 * retries. Pause the generation of new subreqs
+	 */
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
+		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
+		goto skip_error_checks;
+	}
+
 	if (unlikely(subreq->error < 0)) {
 		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
@@ -559,6 +568,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
 	}
 
+skip_error_checks:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 	netfs_subreq_clear_in_progress(subreq);
 	netfs_put_subrequest(subreq, netfs_sreq_trace_put_terminated);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index b99e84a8170af..7793ba5e3e8fc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -12,6 +12,7 @@
 static void netfs_reissue_read(struct netfs_io_request *rreq,
 			       struct netfs_io_subrequest *subreq)
 {
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_rh_retry_read_subreq);
@@ -242,8 +243,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	subreq = list_next_entry(subreq, rreq_link);
 abandon:
 	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-		if (!subreq->error &&
-		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
+		if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 			continue;
 		subreq->error = -ENOMEM;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index cbf3d9194c7bf..61eab34ea67ef 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -492,11 +492,11 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
-		if (subreq->error == -EAGAIN)
-			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		else
+		/* if need retry is set, error should not matter */
+		if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
 			set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+			trace_netfs_failure(wreq, subreq, transferred_or_error, netfs_fail_write);
+		}
 
 		switch (subreq->source) {
 		case NETFS_WRITE_TO_CACHE:
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index dd8743bc8d7fe..34894da5a23ec 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -250,6 +250,7 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
+	subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.51.0


