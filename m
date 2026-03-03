Return-Path: <linux-fsdevel+bounces-79095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPN+D34spmm/LgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 01:34:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F581E7236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09DE8307839E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 00:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4A1BD9CE;
	Tue,  3 Mar 2026 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwSDGUxr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC84964F;
	Tue,  3 Mar 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498014; cv=none; b=jdzg1N5UmEiquYlemDcsMwyQHG66v6Vd9n760Y54rTP2I4zedfHAwfdBPRebMeR72xnYfghvWXkMtRKIQT6hKTlv0gNjls/dC0kBEL5tivA10f72Yk94PXZ8egKH+B4qom1N7Ui7ZYsacdo/Gdsy5hg4D/dAHNBExcvt1q4G8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498014; c=relaxed/simple;
	bh=IWMBBhqrsrMPeSEuIdpQhx7hc1Ro92GogvTdPorRhrk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucmG0+ef/T0PBv31zR68XJwTJFa4GRxC9Fd+vxU+qsSw0qLhqtLSdl4SBcUIjj3W5c3ApppLfkzUwLhiARfoSqdlbzIeu+cIVOXdjKk/64kNr2O81mo2SLtaYHqhsKUz0wDspAMLg+fNdGKmubbwjFKx2pYsDbOfO2T8iD0HL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwSDGUxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96686C19423;
	Tue,  3 Mar 2026 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498014;
	bh=IWMBBhqrsrMPeSEuIdpQhx7hc1Ro92GogvTdPorRhrk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZwSDGUxrtUS633iB/gsIZZuEU23Ze6gEoQXwKs4XKzcuuXjb7LUHZlzTd/55odQik
	 Y2Rb+1jzRiS45GmLsMQSKi3NLuKfNO/5Xma4fi4mnr2qerP2IX9G7gxtF2PKg9Ukis
	 E/BrJOwhm6QRE/MXfNhPWdt1iHJInggsDnYPJOnh8cb11L1JRLG4cdPADlo0Jsi+qD
	 3k1laiEPsd6Ma1dT3xcjw06yUu0fbnatrwfLW3ns3wCHKqCG/2LbGGUZAPR8CBAIVl
	 mTEn4KlJH1dkoqsh8S9roIhsmcMc5+QN70ZqhVBZiJgGaQWrIqVkBocigLxZUMhrwp
	 axAEjt18WBKDQ==
Date: Mon, 02 Mar 2026 16:33:34 -0800
Subject: [PATCHSET v8 1/2] fstests: test generic file IO error reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, gabriel@krisman.be,
 amir73il@gmail.com, jack@suse.cz, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
In-Reply-To: <20260303002508.GB57948@frogsfrogsfrogs>
References: <20260303002508.GB57948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2F581E7236
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lst.de,krisman.be,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79095-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi all,

Refactor the iomap file I/O error handling code so that failures are
reported in a generic way to fsnotify.  Then connect the XFS health
reporting to the same fsnotify, and now XFS can notify userspace of
problems.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=filesystem-error-reporting

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=filesystem-error-reporting
---
Commits in this patchset:
 * generic: test fsnotify filesystem error reporting
---
 src/Makefile           |    2 
 src/fs-monitor.c       |  155 +++++++++++++++++++++++++++++++++
 tests/generic/1838     |  228 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1838.out |   20 ++++
 4 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 src/fs-monitor.c
 create mode 100755 tests/generic/1838
 create mode 100644 tests/generic/1838.out


