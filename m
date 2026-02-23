Return-Path: <linux-fsdevel+bounces-78017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA7kCjrcnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C291617EACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D78FA302FFDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6237D11F;
	Mon, 23 Feb 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i91I2jVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DC34CFC4;
	Mon, 23 Feb 2026 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887667; cv=none; b=Np02Sd1kipOaRJBx9H8OlCgUdKPL3GYxM8iQYnvszO3Uhp5055gjBlXFGbQfpYrtzVLJ6U/9erSHcrvA1Nw/ZCi5v1Vt8sO5v0BPeUcUqqwLzXZmvWu9nSJFJ6rOW3nMb1G4OhQBqzYlUoMUgybizOVA+7IqEf5uhyB6zPtralI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887667; c=relaxed/simple;
	bh=UJZIjtLDQtB03raL/aPNWIOBYh2KT5S4I6TFvYkTbpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLIb/fivgUy+rrkSToB8RNcs37PoxxAD2OgSaqxPwl5fHpQ5YTWADdZhj5VLZnKb1FyrNNU/3CdSnt+MdQvtRoLP+2Au8o+pO4Hy54BvW37IFmBkdml0W4t38ko1Y3xetIWfc1ad2CKd/T749sAi6pwnCUCSs1bK/WXWFxqF+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i91I2jVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB0AC116C6;
	Mon, 23 Feb 2026 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887667;
	bh=UJZIjtLDQtB03raL/aPNWIOBYh2KT5S4I6TFvYkTbpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=i91I2jVBGi6jMPC9Rg7043uqOCr4yiPgj/F5spOFgH9JAJZ4WtmWHiOY8x6jw1iVw
	 K5eR4g6xMHfjrCRXP/8YofVCRXIHA1oBThXwQ2q6b/fvNxjjA4U/ZJzB+HHa+D2/kT
	 MocboznoB0ahMH+Ew42Cp5ftMNjk5IdkyAaff6k81AMJzHkhhj4EDb+Edn7wrS6DFH
	 VgjbhvUfnMqTkhsusNduiXspi7Eg/+yl4LV7L6a3+xHcppBViKvB6ZTfyF2fm33vYd
	 FmHB7ucW9BMJKcOlQJIZVeO6iv3bekU9rLujpTwJiyd8I1ud+oLsG41ofaZ54WLHWX
	 8JLDPLOxzNuBA==
Date: Mon, 23 Feb 2026 15:01:06 -0800
Subject: [PATCHSET v7 3/9] fuse: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bpf@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733698.3935601.154959695370946923.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78017-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C291617EACF
X-Rspamd-Action: no action

Hi all,

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: move the passthrough-specific code back to passthrough.c
 * fuse_trace: move the passthrough-specific code back to passthrough.c
---
 fs/fuse/fuse_i.h          |   25 ++++++++++-
 fs/fuse/fuse_trace.h      |   35 ++++++++++++++++
 include/uapi/linux/fuse.h |    8 +++-
 fs/fuse/Kconfig           |    4 ++
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |  101 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev.c             |    4 +-
 fs/fuse/inode.c           |    4 +-
 fs/fuse/passthrough.c     |   38 ++++++++++++++++-
 9 files changed, 188 insertions(+), 34 deletions(-)


