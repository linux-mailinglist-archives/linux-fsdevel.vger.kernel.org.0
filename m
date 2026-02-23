Return-Path: <linux-fsdevel+bounces-78033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MChhLT3dnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E722E17EC68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B75523038ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4837E2F7;
	Mon, 23 Feb 2026 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Y6E0r2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872837D12A;
	Mon, 23 Feb 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887902; cv=none; b=bk5KSU+WxEChqBkJeiP2A8l0txhmhXtNIJKTY5zwA0kl6vdcB0lLoRqf9E3rWcUFjGr3prqgPVpAR1ADWw0Hbcgx7oR/iJ+J3dwxSWByZnw878Gaxa8DtLyeHDUsxTaigpCfJDTg8Z/J2Yk+pardiKP8rNGToV+3pIFhe57AbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887902; c=relaxed/simple;
	bh=U314RsHz0eK6Sj3sUzHusD/sSH04E+OsdWBA4IIRFuc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVC0Q7oVE6WLe6LVt0fSl6MMT7fGF5IA8ZGgtrwRWnVQUXieDA6b7QzbZA9eyWa4C7+j8Ih570K6Yai3NhcnUgG9GdmAEcVJaguE2RCIelzzyWoTYEv8THsOVFqe8Z3B5/CZD5BmFB5jKHu4GqXaV9tk2QybuVvjakCZctAvAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Y6E0r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B87C116C6;
	Mon, 23 Feb 2026 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887901;
	bh=U314RsHz0eK6Sj3sUzHusD/sSH04E+OsdWBA4IIRFuc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O7Y6E0r2bwAEMjpeWsXzjbfWt0WVniKegD+SSzPPsn67obXiv3vORtxcPxVI/D8Qx
	 a/irKNXO89guCZqof56x/84zolUMrhxKJzPhxcSRJCF8ixINpsvb/LBFGDl3rt9q0o
	 tXVpHF8yEIt3YG5plgWbIOhy0f08qpJQmxIsYnXNy0JQ2NF3LTXNVBVzjU2ZpA6Na3
	 k9mjcLYnwlSnpUAHio+jcTDb0P3BoKSHCyXoSg/GuVqcetlqoKEYGzrowKCtDoL73m
	 x/wUoy309qJP0nujm8wLR6ZpiuInVZfo3qOTts3M/OXhLeEp/WL9NSia50AzGc579d
	 HNWq6+KjBNxTg==
Date: Mon, 23 Feb 2026 15:05:01 -0800
Subject: [PATCHSET v7 3/8] fuse2fs: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
References: <20260223224617.GA2390314@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78033-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E722E17EC68
X-Rspamd-Action: no action

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-attrs
---
Commits in this patchset:
 * fuse2fs: add strictatime/lazytime mount options
 * fuse2fs: skip permission checking on utimens when iomap is enabled
 * fuse2fs: let the kernel tell us about acl/mode updates
 * fuse2fs: better debugging for file mode updates
 * fuse2fs: debug timestamp updates
 * fuse2fs: use coarse timestamps for iomap mode
 * fuse2fs: add tracing for retrieving timestamps
 * fuse2fs: enable syncfs
 * fuse2fs: set sync, immutable, and append at file load time
 * fuse4fs: increase attribute timeout in iomap mode
---
 fuse4fs/fuse4fs.1.in |    6 +
 fuse4fs/fuse4fs.c    |  226 ++++++++++++++++++++++++++++++----------
 misc/fuse2fs.1.in    |    6 +
 misc/fuse2fs.c       |  282 +++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 389 insertions(+), 131 deletions(-)


