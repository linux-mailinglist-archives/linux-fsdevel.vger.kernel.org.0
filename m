Return-Path: <linux-fsdevel+bounces-29184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66785976DA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE63289579
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287B1B1D5F;
	Thu, 12 Sep 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gRHlABOP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gRHlABOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CA1922D8;
	Thu, 12 Sep 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154533; cv=none; b=MPm46ejFffzmX3Xi8d+WaHQquWmO8DcZqxqai/dpRFITyxQzwD8eOFqkKGEQKFxMPGBlmQ70//4+qlZV8Ldre1hs+Q6aX57xOnoxhZJv+a65YPXEO4/d4BOzP2SsS8ClztASL5kgiVcUjVixtOKNl/at4HY1i3nb5Yc2QYs/wyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154533; c=relaxed/simple;
	bh=0QcA84OuXnjN3xWGebR3zUgTK14MjnFzCg/5WmodJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNXGYpNBdZPGDgqZYtrOgrKg5oiV0rIUgK6ZodfppWtHRdSlZml4pYAYRZpw4f8lpYptKO5XmDjz5Re78D+0sPk38kX6eq7UQQMp4OqpCtxfti7A6zLLoWY9fIHjeKcZQE4xeTZ2urBRHFFWAautqbZVjsUeTtWyM9E2R493g5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gRHlABOP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gRHlABOP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 029A21FB7D;
	Thu, 12 Sep 2024 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726154529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UF8MKBKKMAhRPf3iUjmfnZIiMn/naejKvI5v8uVst9Q=;
	b=gRHlABOPZmEpKbJytTwoosI0f+kTwZEJ1LyYRS0PAtLttfo0Fkpg7eatNAjyseM3pKn7dy
	JnIzcSOJ4iuwAbFuLILwybkfSe9dbiWSmRXJJE7r8beW92lOW706o9/rWDEEzEtEuw7bMP
	NGNSKkvhTeWMXP5jmCPDGao81yowdMw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gRHlABOP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726154529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UF8MKBKKMAhRPf3iUjmfnZIiMn/naejKvI5v8uVst9Q=;
	b=gRHlABOPZmEpKbJytTwoosI0f+kTwZEJ1LyYRS0PAtLttfo0Fkpg7eatNAjyseM3pKn7dy
	JnIzcSOJ4iuwAbFuLILwybkfSe9dbiWSmRXJJE7r8beW92lOW706o9/rWDEEzEtEuw7bMP
	NGNSKkvhTeWMXP5jmCPDGao81yowdMw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEB9F13A73;
	Thu, 12 Sep 2024 15:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tj4/OiAH42aEFgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 12 Sep 2024 15:22:08 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS updates for 6.12
Date: Thu, 12 Sep 2024 17:22:01 +0200
Message-ID: <cover.1726154348.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 029A21FB7D
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

Hi,

please pull the following cleanups removing unused code and updating
definition of flexible struct array.

Thanks.

----------------------------------------------------------------
The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.12-tag

for you to fetch changes up to bf751ad062b58d0750a5b9fb77d1400532a0ea44:

  affs: Replace one-element array with flexible-array member (2024-09-06 17:48:15 +0200)

----------------------------------------------------------------
Thorsten Blum (2):
      affs: Remove unused macros GET_END_PTR, AFFS_GET_HASHENTRY
      affs: Replace one-element array with flexible-array member

 fs/affs/affs.h     | 2 --
 fs/affs/amigaffs.h | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

