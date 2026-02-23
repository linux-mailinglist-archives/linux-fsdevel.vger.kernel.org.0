Return-Path: <linux-fsdevel+bounces-78019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEGpA1vcnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C717EAF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0FF9302C2A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035037D121;
	Mon, 23 Feb 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmLaBTzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE72222A9;
	Mon, 23 Feb 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887698; cv=none; b=kLLZTkD39RMKZrfaQ7X4aortuNiV/49IazF4/NdNa+vbmpLezXkO86J28osbISOkCXkw18tzseacGj2Pz23hKm4l21SyRhjCNojeMUuZNWo3QK+4xcxdBoqyFO0rtHrz/LbsbF4uEGGiyozGhRmRRpT/zYSQqJrwY9rBWgLw2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887698; c=relaxed/simple;
	bh=7XIko+RzUGeXSQWx5FGVqdcYvhFjE91G6hr5QPs4bao=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2QKQb3SvwKzQO/YKmjbPqAFBG5U5nsIaf2tCpZGmpswF6wLavCWpr3Jb2aiP2yejhAQUKJD8xcvLqwqIiiLNn80L8IJVeKPrnMDyi4nkSgVcrGyKC6gmBA0BdFS8qzekRuX8pYY7ty1tBRz6zeE+ViT5+pv3IbMBKeQT+ZGL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmLaBTzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5482AC116C6;
	Mon, 23 Feb 2026 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887698;
	bh=7XIko+RzUGeXSQWx5FGVqdcYvhFjE91G6hr5QPs4bao=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bmLaBTzJYUsK1nwVlxaUn7xNdnSkrC7vwsM8mmEp5KGBcDyB2W1fbnQjjvVCscElI
	 keZam8VwhpfvqmWdbkcX8VZIss9mMSMEnwTG1LoEVSzZX5S24PPA+GSg7tcjVfTnGY
	 usZmr5BO8EBj2Y0FYEg8HxiEdT3skWbVKO/OSOCZOq9xruUCkZN2lGY9xSK93Iwoxq
	 sFFKDyonxXbUB2DspazZAk0QpkxaGWchvUqag4d6x1OoBjXv5MarSHbAwuY88xYtUG
	 AtjfphwY4IOSS8/Ca6m/ehahQfhrcyiloalYSDsANNbX9mdWtb1CyVYcDO3T23WwNY
	 Q98XWhtAWhSwg==
Date: Mon, 23 Feb 2026 15:01:37 -0800
Subject: [PATCHSET v7 5/9] fuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78019-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A93C717EAF0
X-Rspamd-Action: no action

Hi all,

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * fuse: make the root nodeid dynamic
 * fuse_trace: make the root nodeid dynamic
 * fuse: allow setting of root nodeid
---
 fs/fuse/fuse_i.h     |    9 +++++++--
 fs/fuse/fuse_trace.h |    6 ++++--
 fs/fuse/dir.c        |   10 ++++++----
 fs/fuse/inode.c      |   22 ++++++++++++++++++----
 fs/fuse/readdir.c    |   10 +++++-----
 5 files changed, 40 insertions(+), 17 deletions(-)


