Return-Path: <linux-fsdevel+bounces-74864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDlrF7TicGkhawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:29:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADFC586EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6D1582EB56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F773D5256;
	Wed, 21 Jan 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSBbJvgr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0M0sSG2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSBbJvgr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0M0sSG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004C49250E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004010; cv=none; b=UtPq+gs+1GfFKQ2PLuciZ4gh+lgv7ftOWXj6yT5ch9b3mu6DXp5SbUHjxKj9YDLWeHkFVVqqqr36ZROkqfmWuWxH4MLBrK7nZujZe3mBgXPUWaAG4/PyVvyJOlOtJUlibzJnipwcVqe7LMdyqKsxB3uRBRPDQv9E/VKBVTqzlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004010; c=relaxed/simple;
	bh=amdhiER86nj/qgw2Pe59+zBmBLGR4EbrwRmb8CEsx0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Te49lYLmDkkHPAF1r75a9YDeYetwXeaFwefJMq/rFqo8v4JMCyLAPwtO9pQVq4eXxLH0+HjK3PcOnXvEnHz3R0TK7FAEnY+VIbb2gwYWwVgYnZuSjS52Sol8N/GFfMkKSwPUQqWZoNoNbNUOHFz71smagvdJCXNajkREOiO5r60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSBbJvgr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0M0sSG2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSBbJvgr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0M0sSG2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044295BD18;
	Wed, 21 Jan 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gWOWYhBdPNLjppdv3lwOaDTwyhK+kL5SuQ2nXIzsWX4=;
	b=tSBbJvgryl9PqHzI4Qrk6x1GxD0dej6fwQmOhJ8Qi2CFLTADb5uzrInZz9Y2XQoikApBqg
	dr6tdQWsWYOwXrHbFpNMyYZL3qR+i9ALpLbDSoG1XV7i2WGyF8eetPwG/2Z8lKrji1xr/h
	D+UhtLkjsO6X3qh6EktgvLszhL+nQ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gWOWYhBdPNLjppdv3lwOaDTwyhK+kL5SuQ2nXIzsWX4=;
	b=D0M0sSG2uw6f1R3BXG8LtCi7MDyEji8DE6s7ncVwEUrR3KlHds3QGMcAHjmWAPA5Ny9ONP
	d1mD++oiFgsxE1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gWOWYhBdPNLjppdv3lwOaDTwyhK+kL5SuQ2nXIzsWX4=;
	b=tSBbJvgryl9PqHzI4Qrk6x1GxD0dej6fwQmOhJ8Qi2CFLTADb5uzrInZz9Y2XQoikApBqg
	dr6tdQWsWYOwXrHbFpNMyYZL3qR+i9ALpLbDSoG1XV7i2WGyF8eetPwG/2Z8lKrji1xr/h
	D+UhtLkjsO6X3qh6EktgvLszhL+nQ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gWOWYhBdPNLjppdv3lwOaDTwyhK+kL5SuQ2nXIzsWX4=;
	b=D0M0sSG2uw6f1R3BXG8LtCi7MDyEji8DE6s7ncVwEUrR3KlHds3QGMcAHjmWAPA5Ny9ONP
	d1mD++oiFgsxE1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06833EA65;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J8B9NuDbcGmPTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 14:00:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99EB3A09E9; Wed, 21 Jan 2026 14:59:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 0/4] fsnotify: Independent inode tracking
Date: Wed, 21 Jan 2026 14:59:41 +0100
Message-ID: <20260121135513.12008-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=jack@suse.cz; h=from:subject:message-id; bh=amdhiER86nj/qgw2Pe59+zBmBLGR4EbrwRmb8CEsx0o=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDILbp9hN198W8rgeUiy9GF55bNr1zyyfSfHp6l2/YNe/ A6Z8CUCnYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYyM2X7P9d1OaIqOZ/ZU8W 4JdhanB9dHvBfokFUcpBCuI2xZuztPfNqrkk9b1Dpzn4ogtTIR/TrFLGsyEywv5m3fkMuy577Lt 4reddTuY6gQzR8o3dZlrsbYt61sw94FTevHJe+ReB11mPuexObbTdLnr7rr9lguO6/91mQVxPDp 3gclCzzFjys9k3zS2T488MSeWNEnJiP/qcI/x+GvFNe+s4+0ZVJC8n57kl+wtuTp5gYlIZ0728T MeuNTxNregHw/0t+9Q3eipu8zp6zk9nu80LFbOmK4zXN22dGS5uk5Z3tjuf7dHNAMkJMcpNmnpX /9v1s70webfnRZxX5QpVhRtC84+1z1t5uGVv0MnAPwLRAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74864-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:mid,suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9ADFC586EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello!

Here is another revision of the patch set implementing independent tracking of
inodes that have any notification marks attached through a linked list of mark
connectors used for inodes. We then use this list to destroy all inode marks
for a superblock during unmount instead of iterating all inodes on a
superblock. With this more efficient way of destroying all inode marks we can
move this destruction earlier in generic_shutdown_super() before dcache (and
sb->s_root in particular) is pruned which fixes races between fsnotify events
encoding handles and accessing sb->s_root after generic_shutdown_super() has
freed them.

Changes since v2:
* Fix fsnotify_unmount_inodes() to safely deal with connectors not holding
  inode reference
* Add Amir's Reviewed-by tag

Changes since v1:
* Remove pointless srcu protection when tearing down inode connectors
* Remove FSNOTIFY_CONN_FLAG_TRACKED as it isn't needed
* Use ihold() instead of __iget() as we don't hold inode->i_lock but
  the connector holds inode ref
* Add Amir's Reviewed-by tags

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20260119161505.26187-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20260120131830.21836-1-jack@suse.cz # v2

