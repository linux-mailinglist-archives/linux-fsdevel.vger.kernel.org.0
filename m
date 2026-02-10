Return-Path: <linux-fsdevel+bounces-76906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CGVEL7Ai2l6aQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:35:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CA1200F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693CE3095E63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30C32694A;
	Tue, 10 Feb 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODD70gbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13031282F;
	Tue, 10 Feb 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766307; cv=none; b=l88SWkV+ZQxFSf66+OMOimSuu5swKZuEfQcQ6J1pcag+JXVyW28qC/UhdX6O2EO+1rbBk2jYldtHaB7OPso9cC6PZEr9i+NIzgj3dZkz53iEk+LdWtdZMpZxoLT7ddzI5N2IUpaf3YuS7EAC1Vh1eKilTTD2IPlzYS6F6CdL7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766307; c=relaxed/simple;
	bh=TOqUM0gKcdyJgf4TcdXODa2MWGtT445k1Q/TV7PcXMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgK2G74d52mX4avFrltpnPpylUNP5pw/iROewxdKSPAe+OJOFss3zC80F5aGqPO0HdRWzA9Ui5t4GA83ejt/qUlo8rijMITm7utvHJ7CfRFgUWEghGfVZYiH2HVzsZXS7X/KKm0311W2zcGQy7DVXm8UahLj+vAGggglxHowiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODD70gbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B3AC19423;
	Tue, 10 Feb 2026 23:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766307;
	bh=TOqUM0gKcdyJgf4TcdXODa2MWGtT445k1Q/TV7PcXMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODD70gbxQJOvtLnzj6+rpGcdjtLgP+yQ8xVyDkcmrn4PWqv5Bgzo2Pn09v/kO4PA+
	 U0YYjs7lqaFuj8o96uL1t2YKC21JeKisjRNZvgjteKrpghaFhDMZzXXhC83peBkpEc
	 yLg869o67CtwPqILDFPkWH9PVDVhBn0qwwpUAXyQnHiUbd1ld7ZeIUHPw7YfbfM6XW
	 L5uEsofIVENaFdxjD7nEPk2uHGTs3cpaBzyBkaZGvbF4GslxsB1GFqNU/BvS/viv4i
	 eyqqER9TzEmImRNDSfedndcPJ6iazjTbiVF8frKJ5Nmpmp/En1pqqjw3VVtqLyoQ+i
	 lEpWh3Ll899Ug==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Deepakkumar Karn <dkarn@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
Date: Tue, 10 Feb 2026 18:30:59 -0500
Message-ID: <20260210233123.2905307-14-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76906-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A56CA1200F4
X-Rspamd-Action: no action

From: Deepakkumar Karn <dkarn@redhat.com>

[ Upstream commit b68f91ef3b3fe82ad78c417de71b675699a8467c ]

try_to_free_buffers() can be called on folios with no buffers attached
when filemap_release_folio() is invoked on a folio belonging to a mapping
with AS_RELEASE_ALWAYS set but no release_folio operation defined.

In such cases, folio_needs_release() returns true because of the
AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
causes try_to_free_buffers() to call drop_buffers() on a folio with no
buffers, leading to a null pointer dereference.

Adding a check in try_to_free_buffers() to return early if the folio has no
buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
This provides defensive hardening.

Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
Link: https://patch.msgid.link/20251211131211.308021-1-dkarn@redhat.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

`folio_buffers()` exists in all relevant stable trees. The patch uses
only `WARN_ON_ONCE` and `folio_buffers`, both of which are available
everywhere.

## Comprehensive Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit describes a clear bug: `try_to_free_buffers()` can be called
on folios with no buffer_heads attached when `filemap_release_folio()`
is invoked on a folio belonging to a mapping with `AS_RELEASE_ALWAYS`
set but no `release_folio` operation defined. This causes a **NULL
pointer dereference** in `drop_buffers()`.

The commit is authored by Deepakkumar Karn (Red Hat), reviewed by Jan
Kara (SUSE, a very well-respected VFS/filesystem developer), and signed
off by Christian Brauner (the VFS subsystem maintainer).

### 2. CODE CHANGE ANALYSIS

The fix adds exactly 3 lines (plus a comment) to
`try_to_free_buffers()`:

```c
/* Misconfigured folio check */
if (WARN_ON_ONCE(!folio_buffers(folio)))
    return true;
```

This is inserted after the writeback check and before the `mapping ==
NULL` check. The logic is:
- If the folio has no buffers (`folio_buffers()` returns NULL), emit a
  warning (once) and return `true` (success — there's nothing to free)
- This prevents the NULL deref in `drop_buffers()` where `head =
  folio_buffers(folio)` returns NULL and then `buffer_busy(bh)`
  dereferences it

### 3. THE BUG MECHANISM

The call chain is:
1. Memory reclaim (`shrink_folio_list`) or truncation calls
   `filemap_release_folio()`
2. `folio_needs_release()` returns `true` because `AS_RELEASE_ALWAYS` is
   set
3. `mapping->a_ops->release_folio` is NULL (e.g., `afs_dir_aops` doesn't
   define it in v6.14+)
4. Falls through to `try_to_free_buffers(folio)`
5. `drop_buffers()` dereferences `folio_buffers(folio)` which is NULL
6. **NULL pointer dereference crash**

### 4. AFFECTED VERSIONS

The specific trigger (AFS symlinks/directories with `afs_dir_aops`
lacking `release_folio`) only exists from **v6.14-rc1** onward,
introduced by commit `6dd80936618c` ("afs: Use netfslib for
directories"). Before v6.14, all filesystems that set
`AS_RELEASE_ALWAYS` also define `release_folio`.

This means:
- **v6.6.y**: NOT affected (afs_dir_aops has release_folio)
- **v6.12.y**: NOT affected (afs_dir_aops has release_folio)
- **v6.13.y**: NOT affected (afs_dir_aops has release_folio)
- **v6.14.y**: AFFECTED (afs_dir_aops stripped down)
- **v6.15.y+**: AFFECTED

### 5. RISK ASSESSMENT

**Risk: Very Low**
- The patch adds 3 lines - a NULL check with WARN_ON_ONCE and early
  return
- It's completely self-contained, no dependencies
- `folio_buffers()` and `WARN_ON_ONCE` are available in all stable trees
- Returning `true` is correct: no buffers = nothing to free = success
- Reviewed by Jan Kara and Christian Brauner (top VFS experts)
- Could be considered pure defensive hardening in older kernels where
  the trigger doesn't exist

**Benefit in affected trees (6.14+): High**
- Prevents a NULL pointer dereference crash reachable from normal memory
  reclaim
- AFS symlinks with fscache enabled hitting memory pressure would crash

**Benefit in unaffected trees (6.6, 6.12): Low**
- Defensive hardening only - the specific trigger doesn't exist
- Protects against potential future similar misconfigurations if other
  patches are backported

### 6. STABLE BACKPORT SUITABILITY

For trees where the bug is actually triggerable (6.14+), this is clearly
a YES - it fixes a NULL pointer dereference crash in a core kernel path
(memory reclaim). However, for older stable trees (6.6, 6.12), the bug
isn't reachable with the current code because all filesystems that set
`AS_RELEASE_ALWAYS` also properly define `release_folio`.

The fix itself is trivially small (3 lines), obviously correct, has zero
regression risk, and is well-reviewed. Even as defensive hardening, it's
the kind of patch that makes stable kernels more robust.

For the broader question of "should this be backported to stable trees":
The answer depends on which tree. For 6.14.y and later, it's an
unambiguous yes - it fixes a real crash. For 6.6.y and 6.12.y, it's
defensive hardening that prevents a crash scenario that currently isn't
reachable but could become reachable if other patches are backported.
Given the negligible risk and the fact that it hardens a core kernel
function against NULL dereference, even the older trees benefit.

**YES**

 fs/buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c5710229..28e4d53f17173 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
 	if (folio_test_writeback(folio))
 		return false;
 
+	/* Misconfigured folio check */
+	if (WARN_ON_ONCE(!folio_buffers(folio)))
+		return true;
+
 	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(folio, &buffers_to_free);
 		goto out;
-- 
2.51.0


