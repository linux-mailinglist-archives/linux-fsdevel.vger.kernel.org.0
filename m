Return-Path: <linux-fsdevel+bounces-78027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFR5IzjdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75117EC51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB2830FCD06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A737D128;
	Mon, 23 Feb 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShbEXSQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8936330B22;
	Mon, 23 Feb 2026 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887823; cv=none; b=ijj4elAvXfrPQ93sjFcTFIF0H5ha4QRE8Tcgj8FEZTvpqFfbZH3DxI39UJx36h4TD5Aubi8cD9GV1RBa3UIyKOKNWQ9gTmpIhaFdadu5zKqSarEjJ2F7U3kcECloW0cV/y+//DSxPhcnXUDpIm6IoAqYhbz0Q/pvqpQoubPAuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887823; c=relaxed/simple;
	bh=7Vlzskmj8dccUAXG9vQ9GDNylG7UqqItX4j8IWAp12w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXlotZ8Wi+DeU9amN6PI4Nc8qgK1/QuagVx5MI6kN0sOP8ONgGUB3Ta0BSiYHeAmGquLXuh14wsPI60FzcnkmnE/r+Ze1Rt/rxgtYDZ8rJHjl2EJnk6bLByvcmcVBEExRi++FVw02euY2+I7Lmt78ppYj8X5civzR9QXZ9lWJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShbEXSQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A053DC116C6;
	Mon, 23 Feb 2026 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887823;
	bh=7Vlzskmj8dccUAXG9vQ9GDNylG7UqqItX4j8IWAp12w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ShbEXSQbf1OXO8KqLsXnbC37Hst/mpYytycc3b67lBCnbaz9mopKkwp/JB2+sFM2Q
	 jYSRQdKgnTCYpi1q6ZCQ+uJ8WJkwf69N1dhoFHtlT0oI0zfJDpELCb5jklrXQgB2cD
	 YO9bG5HkzpSmXQt3qqF9E4mkJk09W3UkhE1niW3W0DESUIl8pSJ+RmJ3ZqhxjZ3in9
	 inXYNoCMVBQGxDOst1c1fsX4X1CkqJVWlN6rZc8GON9lM3vKzFN0VozLf/eDp90UdR
	 vYt8HjOTeDznmcXsZdD18K4HUZv06lk+jNb/Ky5OfRP1Eh7ujWuLg9T/xzMlKOV2HK
	 xV6Hb/ox2omig==
Date: Mon, 23 Feb 2026 15:03:43 -0800
Subject: [PATCHSET v7 4/6] libfuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78027-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B75117EC51
X-Rspamd-Action: no action

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * libfuse: enable iomap cache management for lowlevel fuse
 * libfuse: add upper-level iomap cache management
 * libfuse: allow constraining of iomap mapping cache size
 * libfuse: add upper-level iomap mapping cache constraint code
 * libfuse: enable iomap
---
 include/fuse.h          |   32 +++++++++++++++++
 include/fuse_common.h   |   15 ++++++++
 include/fuse_kernel.h   |   33 +++++++++++++++++
 include/fuse_lowlevel.h |   44 ++++++++++++++++++++++-
 lib/fuse.c              |   44 ++++++++++++++++++++---
 lib/fuse_lowlevel.c     |   90 ++++++++++++++++++++++++++++++++++++++++++++---
 lib/fuse_versionscript  |    4 ++
 7 files changed, 249 insertions(+), 13 deletions(-)


