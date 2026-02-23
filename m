Return-Path: <linux-fsdevel+bounces-78015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KsaHCDcnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:00:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7017EA94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF8230177AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34637D119;
	Mon, 23 Feb 2026 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8aiTuDv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27795DF76;
	Mon, 23 Feb 2026 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887636; cv=none; b=JzHaN+6d07bThoWxfhvPkYjhY7IRKUDb3ltLosPuejEb3FEEbhEK7PrLVDkMCzvAn6oymFlxw0b8Sonhfd+LNDN0Bfpi/I4DCgZ5U5lucCNiDrwIqni8VD6pD2qHkHLHXA/GCVOLzYVm+GKy/gS15LlmSZ9IjOYF9/zNirodc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887636; c=relaxed/simple;
	bh=YpZ5OpeMXKrE8sbA93Z8skOqx2dzjc+cN3W19GUT0oQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Usz6GQ14dUeX6YXRv16Y1kiekmgd6WxvA60GLcASevcoPENO6l7xX0foM0FNLRin840pNDsIUsIT12OHqsGgpEYde925+Wfm7SyG382lW4Yc+7IV9dEeQjNYGzf8YNxhxXdWeSCd69kuY/ya9ShHkrRRCR1jGDx9y7+zZmaVV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8aiTuDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC61C116C6;
	Mon, 23 Feb 2026 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887635;
	bh=YpZ5OpeMXKrE8sbA93Z8skOqx2dzjc+cN3W19GUT0oQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D8aiTuDvFhtTvHmNRUTRDqT5KKmL2I1ho6pIFwau0GW+12L5E3/zaqitvVSB7qXUd
	 DvhdCOlw+vaXqOic+LyGiG7HkbPyeZRD6QSIcSsZnOmz9g/kcahTEpjQ48fNifT729
	 2KCgUUS49+POrwL7NFACxfgUStJzSgsUj90n/b6oSe3lke40P+fz+TNOXal8dk1+6T
	 /P799/Io67fzvymliaTc3yj0oYaxRhuCIB5aJSYynSKfnZPG0DnkaJu/oW1yHV21XC
	 qhEzyEwF7tgfdX/QV+aQMwLgRJdcqvgmoq9k6/P+iNf+2pAVBGWhbM/bXNH19b57hy
	 NNlnD/+JCC78A==
Date: Mon, 23 Feb 2026 15:00:35 -0800
Subject: [PATCHSET v7 1/9] fuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, stable@vger.kernel.org, joannelkoong@gmail.com,
 bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78015-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAE7017EA94
X-Rspamd-Action: no action

Hi all,

Here's a collection of fixes that I *think* are bugs in fuse, along with
some scattered improvements.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * fuse: flush pending FUSE_RELEASE requests before sending FUSE_DESTROY
 * fuse: quiet down complaints in fuse_conn_limit_write
 * fuse: implement file attributes mask for statx
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
---
 fs/fuse/fuse_i.h  |   48 ++++++++++++++++++++++++
 fs/fuse/acl.c     |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/control.c |    4 +-
 fs/fuse/dev.c     |   19 ++++++++++
 fs/fuse/dir.c     |  105 ++++++++++++++++++++++++++++++++++++++++-------------
 fs/fuse/inode.c   |   16 ++++++++
 6 files changed, 267 insertions(+), 30 deletions(-)


