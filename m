Return-Path: <linux-fsdevel+bounces-41810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D7A37931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFDA3AE138
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682AC8FE;
	Mon, 17 Feb 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CldnGQCD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IvNy51ya";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CldnGQCD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IvNy51ya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8C7483
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752236; cv=none; b=mmZfEY4rN8VpPNPRrFRL5uKWfcmzL4bknDNXUNxMjGNOn+hNaqLFBONpXDYK5LmlMu0itJhj5SOzUfvH9NY4LYCtsjU/znBR82GXPeVTNJvEX118hvKS3KTnYoUNS2ukJIOUtwgFblD4Aa0/DLbNakfKMtPyHy5Z/DDHkGh3f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752236; c=relaxed/simple;
	bh=7hm4UYiSQKJ02Kivb5z8jPOK2HBumg9Bq9KQ8RW3GoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLfllTAVOeBQcm2c2qwyxP2OP3Ox6cp6V0X4CHNWynLKxtNjXOnW/Ywh5Bytlmq+kkkewwnvIymAXMyXpENDv2tkISrqQEJVu8NduphHSYCsC9cLEUPxC+M5TA3Po9z83WIvrjlABpkxYGlidSQZUKpjW5LGWzIZP1339y5T+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CldnGQCD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IvNy51ya; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CldnGQCD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IvNy51ya; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C423F2115D;
	Mon, 17 Feb 2025 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=63ymESUZ1VswTVkk6f5VJa6KSQecuRbSvUUtgUBjJNk=;
	b=CldnGQCDCYZhXCSh2xS46l+IIrnv0zLHt3FxYGj06n+Vp+3gXzSYbo03GUaaI+BgKxc6yH
	TapVa1jkOIk+YcCH3AAsfTQXsAQpU/lpbfQ+WAi184zgWAX+dbyTO3oR5xIOasfnvr6GhS
	TSNNRGN2r5hOPyJPBCV3Nggd3ADjIJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=63ymESUZ1VswTVkk6f5VJa6KSQecuRbSvUUtgUBjJNk=;
	b=IvNy51yaFUotsZVwzKACLbsCqStty2csPcD30iluHLnSy5JfnJPikLtVD+vMxXe3AhNL8e
	WvhiDoifxacUO+CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CldnGQCD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IvNy51ya
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=63ymESUZ1VswTVkk6f5VJa6KSQecuRbSvUUtgUBjJNk=;
	b=CldnGQCDCYZhXCSh2xS46l+IIrnv0zLHt3FxYGj06n+Vp+3gXzSYbo03GUaaI+BgKxc6yH
	TapVa1jkOIk+YcCH3AAsfTQXsAQpU/lpbfQ+WAi184zgWAX+dbyTO3oR5xIOasfnvr6GhS
	TSNNRGN2r5hOPyJPBCV3Nggd3ADjIJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=63ymESUZ1VswTVkk6f5VJa6KSQecuRbSvUUtgUBjJNk=;
	b=IvNy51yaFUotsZVwzKACLbsCqStty2csPcD30iluHLnSy5JfnJPikLtVD+vMxXe3AhNL8e
	WvhiDoifxacUO+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0310E136AD;
	Mon, 17 Feb 2025 00:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3QfLKiaDsmeyJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 00:30:30 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 v2] VFS: minor improvements to a couple of interfaces
Date: Mon, 17 Feb 2025 11:27:19 +1100
Message-ID: <20250217003020.3170652-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C423F2115D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,
 please replace the top two patches in vfs/vfs-6.15.async.dir
with these two revised versions.

Both add text to filesytems/porting.rst

The first moves an 'err = 0' as was requested if any refresh is needed.
The second adds a check for errors from ->lookup.  This omission is
triggering various error reports.

Thanks,
NeilBrown

 [PATCH 1/2] VFS: change kern_path_locked() and user_path_locked_at()
 [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()

