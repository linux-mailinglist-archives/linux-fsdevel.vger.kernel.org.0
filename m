Return-Path: <linux-fsdevel+bounces-74728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK7XExUBcGmUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:26:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E94CF17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5645368EAE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94A3EDAD8;
	Tue, 20 Jan 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z15zO44J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eEC60ZgO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z15zO44J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eEC60ZgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BD3D7D9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942046; cv=none; b=UC87Q1K6jpYeN0UTT8wXobhFMTXWoYGc4NVV1dHtX7p3lqXvpbs0JxV1DrE9IJnrYSQ0haZdRq1BZaPvwcBZicnHe2GbqFpS3DeBZ1/xtp8EiqT/ZPdJi1q7rkE6kjPmpqFw7oVjiHi/VZpzQ3rn4ZvP4NEA/UR2IYww+K2yYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942046; c=relaxed/simple;
	bh=TLhvhy0ekpxg9oXp7TIn2xRYueTJguqHTnkglJ0TuWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEGLI1kozzD0hEGoBXJruvyfKYTRmNulzn9hEPWgnnGUrMfAQq3o4fmRL5j/REIM7RbK2mle/OohmJ11lgePN5hAvt8rSMT5IAxiwpBkISu0U4cibHkLPrqdXB8yjjxomVIvmFnQbthK5rvBRkTeQlrERklWMqlU5Yi6b1eESAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z15zO44J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eEC60ZgO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z15zO44J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eEC60ZgO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E596336A8;
	Tue, 20 Jan 2026 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EpMQmElf7l7szI0plVsET/WFCG7JtVj4P+P6UWEg7IM=;
	b=Z15zO44JAqCet0sV+4HPohFKghIXiWVXCAtLayEA+vZyAL1jPw9v7mtlBvo5XzdhO2Sj8q
	SAdxxZtya/UxZvrdvy0DY/fBe5ZtuhmKQquAqQbCciVltaFMXuLLk++Bnn4IJy5w8D2z0o
	bqFSosmJ06+00gLMYCj9odpyL1h8WZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EpMQmElf7l7szI0plVsET/WFCG7JtVj4P+P6UWEg7IM=;
	b=eEC60ZgOjzaOMKOAp4KFzXvtmBeKm2FBB4i5kpH6G0GY1/rTc2+1Zx5wmgo6tZbT3LxFQ+
	m4I8FwT+2JUf5MDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z15zO44J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eEC60ZgO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EpMQmElf7l7szI0plVsET/WFCG7JtVj4P+P6UWEg7IM=;
	b=Z15zO44JAqCet0sV+4HPohFKghIXiWVXCAtLayEA+vZyAL1jPw9v7mtlBvo5XzdhO2Sj8q
	SAdxxZtya/UxZvrdvy0DY/fBe5ZtuhmKQquAqQbCciVltaFMXuLLk++Bnn4IJy5w8D2z0o
	bqFSosmJ06+00gLMYCj9odpyL1h8WZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EpMQmElf7l7szI0plVsET/WFCG7JtVj4P+P6UWEg7IM=;
	b=eEC60ZgOjzaOMKOAp4KFzXvtmBeKm2FBB4i5kpH6G0GY1/rTc2+1Zx5wmgo6tZbT3LxFQ+
	m4I8FwT+2JUf5MDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA713EA63;
	Tue, 20 Jan 2026 20:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WtXyN9npb2l7UAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 20 Jan 2026 20:47:21 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] initramfs_test: test header fields with 0x hex prefix
Date: Wed, 21 Jan 2026 07:32:31 +1100
Message-ID: <20260120204715.14529-1-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	TAGGED_FROM(0.00)[bounces-74728-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: E58E94CF17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed at
https://lore.kernel.org/linux-fsdevel/20260120230030.5813bfb1.ddiss@suse.de
we currently successfully process cpio header fields which include "0x"
hex prefixes. Add a kunit regression test for this corner-case.

This patchset is based atop commit aaf76839616a3cff
("initramfs_test: kunit test for cpio.filesize > PATH_MAX") queued at
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git .
@Christian: If possible, please fix the commit subject in the above
commit: it should be "cpio.namesize" instead of "cpio.filesize".

David Disseldorp (2):
      initramfs_test: add fill_cpio() format parameter
      initramfs_test: test header fields with 0x hex prefix

 init/initramfs_test.c | 88 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 13 deletions(-)


