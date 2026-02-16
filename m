Return-Path: <linux-fsdevel+bounces-77286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA42BjAdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9783143DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA35A301E5DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69231328B;
	Mon, 16 Feb 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5LM061Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBD30E857;
	Mon, 16 Feb 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248779; cv=none; b=sF2TIrhTgFxHjCxpN+WGdRMwSrk/xkPkmEemY7v2HnQu2bi43+lhPiD1UrPTwXd8KJkmuovT4gyzfL61NfIzYyJ0phAQmK2/m7BQosBmF4+4rWEhEKL3zKwwdWZkzAye3ICZsi2BV0Xxy2FmInqQ3u8Avl3/p42aEVY1bqInJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248779; c=relaxed/simple;
	bh=RnCZFxNnhxA177tCuXFiB0/3HD/vnvQpBZpzUbgVZdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHZGSjaNArb7SvTksRfB7Z/VR/GSdABOjG/94mP6N2E809SvRGP6tT7FHDzeD0p6GWE9ZjA1ie823ETIMbhVSdP9/Xajv4NBPce62ZmCbG32Po470g8k2YUiiLjKOzG9NWB/T+5Ry4xpS1UZbxPx6Lwc/l2P6zLXx8+UEC5xqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5LM061Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FC7C19423;
	Mon, 16 Feb 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248779;
	bh=RnCZFxNnhxA177tCuXFiB0/3HD/vnvQpBZpzUbgVZdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O5LM061Qtdc+RkTJ4/N5R8kAr7hzZ7s50jqzOBi+fEg+kC3HEm/xE24/W1+q4z3pZ
	 l03F5nAjt3apRdw2Ksa5uYkWM9RlxrZELHlHfDvaR2dmdyieuF1gYEA+CLzHG3K5Zo
	 hveIyw8RD/3Rw11fvDlzLVH7svCb4ztZUmwvqM5vkSQy7GKP3rUm2pbNk9PGNRbne6
	 0fd1Of8J6e+ko29M9dK03PakG/AyspXn8i5AyNlU0q5AwVW4IRTwdnwYBU8AVwbTHL
	 naj6c4Bp4Vqree6WggIG5GPCCMGgeKoKzUQroxtjHX3hQr3qLjqDDj+5AvdB9eEDT9
	 O9k6J8KtHhRzA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:07 +0100
Subject: [PATCH 11/14] xattr: support extended attributes on sockets
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-11-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RnCZFxNnhxA177tCuXFiB0/3HD/vnvQpBZpzUbgVZdc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlom75pWRtWaXcMwRHq8H2a+DPy2JfKutp7ynLSYjv
 mCC2uT7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJ+cbwP5+Hi/3Amr7r9hsn
 bJbv/VPY9fvWH8bTcg+465bnyf6wTWRkuKLrFzW1XyvgQgqbrm5TX2Pi5L1dpevzl3Skn2+YypD
 CCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77286-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9783143DE3
X-Rspamd-Action: no action

Allow user.* extended attributes on sockets by adding S_IFSOCK to the
xattr_permission() switch statement. Previously user.* xattrs were only
permitted on regular files and directories. Symlinks and special files
including sockets were rejected with -EPERM.

Path-based AF_UNIX sockets have their inodes on the underlying
filesystem (e.g. tmpfs) which already supports user.* xattrs through
simple_xattrs. So for these the permission check was the only thing
missing.

For sockets in sockfs - everything created via socket() including
abstract namespace AF_UNIX sockets - the preceding patch added
simple_xattr storage with per-inode limits. With the permission check
lifted here these sockets can now store user.* xattrs as well.

This enables services to associate metadata with their sockets. For
example, a service using Varlink for IPC can label its socket with
user.varlink=1 allowing eBPF programs to selectively capture traffic
and tools to discover IPC entrypoints by enumerating bound sockets via
netlink. Similarly, protocol negotiation can be performed through xattrs
such as indicating RFC 5424 structured syslog support on /dev/log.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5e559b1c651f..09ecbaaa1660 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -163,6 +163,8 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 			if (inode_owner_or_capable(idmap, inode))
 				break;
 			return -EPERM;
+		case S_IFSOCK:
+			break;
 		default:
 			return xattr_permission_error(mask);
 		}

-- 
2.47.3


