Return-Path: <linux-fsdevel+bounces-74638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AmzOv1ncGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48B51A83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DB70AB61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD459429817;
	Tue, 20 Jan 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xia2QmRY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSbeE5iF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xia2QmRY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSbeE5iF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F6426EA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915405; cv=none; b=PU8TKefhASsCsKVycr8a45LkZCgnaJiy++LLnqsIxd8xag+fxcSQzrEDbyvq8Wt+FpBoA90Xlcbq0+mDCGunyubul0gpMSG1wefrLkR+T2HtcP8PhvT2FRmf4SF1+iYHa3M3oc2GI8m1q4u8Gov2AdNVkLz26uCckv0BK6CCgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915405; c=relaxed/simple;
	bh=RSnAP5kov8TzXVzG0DzDTtt1Q1tlWKy62y7WmxK7zXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7Jdb/auimyl+SPy/bUp1/fqxXKd6Oz+/ipHNdzgOnwX5ikPWGhClPeICGTRXRNHhpnwZW5mZ3+1FS4zht+gMVO3DtBTHiK2br8iT3sEdv08H3BmDG2mD4YnWRqYVUea5egxIJzdequIuz2r0vPECW3b3J/9W9hVk0c1+BoSVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xia2QmRY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSbeE5iF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xia2QmRY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSbeE5iF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BACD5337D1;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=shjdKVBi9iMYn6as1Pb2M9c8lWteAgz+cIl/HIvy3gQ=;
	b=xia2QmRY6HNOSKrS5I8YoR4NnTjk3qiKK/8trulrRr0L2qov9SxVx4tlqy8Mh6sJA7OtfE
	IHALHfhzy73//DdtxKrA0Kh7OtTkROi4kzhZO9e73CQtlQayGBaEqk2qyUYg8f5EMPI864
	pOKVdXzHc4ZaEAT2Mck/CfX5Eh0EEDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=shjdKVBi9iMYn6as1Pb2M9c8lWteAgz+cIl/HIvy3gQ=;
	b=iSbeE5iFqY+Rc4VU1ar64p9Wc0fgDOmlKthC3EFxlwgWTgF5onmMlEGLQQcdtKaC1Q++Ha
	mfGwxAqcVnSyycBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=shjdKVBi9iMYn6as1Pb2M9c8lWteAgz+cIl/HIvy3gQ=;
	b=xia2QmRY6HNOSKrS5I8YoR4NnTjk3qiKK/8trulrRr0L2qov9SxVx4tlqy8Mh6sJA7OtfE
	IHALHfhzy73//DdtxKrA0Kh7OtTkROi4kzhZO9e73CQtlQayGBaEqk2qyUYg8f5EMPI864
	pOKVdXzHc4ZaEAT2Mck/CfX5Eh0EEDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=shjdKVBi9iMYn6as1Pb2M9c8lWteAgz+cIl/HIvy3gQ=;
	b=iSbeE5iFqY+Rc4VU1ar64p9Wc0fgDOmlKthC3EFxlwgWTgF5onmMlEGLQQcdtKaC1Q++Ha
	mfGwxAqcVnSyycBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B074E3EA63;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AumcIsmBb2kgHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 13:23:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3FAB1A09DA; Tue, 20 Jan 2026 14:23:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/3] fsnotify: Independent inode tracking
Date: Tue, 20 Jan 2026 14:23:08 +0100
Message-ID: <20260120131830.21836-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=jack@suse.cz; h=from:subject:message-id; bh=RSnAP5kov8TzXVzG0DzDTtt1Q1tlWKy62y7WmxK7zXw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpb4G7UVJR2fqtOSZnBwyvdE3843BAxFvwdpTQA LCGu3rOstGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW+BuwAKCRCcnaoHP2RA 2QKzB/0br0k0B2c73iMlADMp4IuaA1PWI8nzfO/aAZngRbUYceVlOXiwFhk20yx/0tnn3O17hug 6sAADNpJG8dzhx5OYB/9iDCxroYBtNMiVg1Ye0s0y1VDiZvRvcymc0pRoTzGayUfre0zWorQXVH Swm4g5j96JfyNIdH5FD1c1A9tXXmtyxleiKul1BknzPKnoeUaQMWsY6k8qbOSTSLBDtdlMIZaXp zuxki4kGR4S2MjsliKkvCRqNbTGqtX4IK/ER+ruhhY72Cl0MdTlkTA33xgsto7k4b2/TKWYvrUO OGef+zVL1etvxJlcgFADMzoTOU0h23MZ9DldLmsiyBJcWMsW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-74638-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F48B51A83
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

Changes since v1:
* Remove pointless srcu protection when tearing down inode connectors
* Remove FSNOTIFY_CONN_FLAG_TRACKED as it isn't needed
* Use ihold() instead of __iget() as we don't hold inode->i_lock but
  the connector holds inode ref
* Add Amir's Reviewed-by tags

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20260119161505.26187-1-jack@suse.cz # v1

