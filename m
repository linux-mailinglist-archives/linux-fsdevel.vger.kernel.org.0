Return-Path: <linux-fsdevel+bounces-41150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8714A2B9CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 04:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CF01675FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA0188596;
	Fri,  7 Feb 2025 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T4npwCYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1dVh/zX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T4npwCYF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1dVh/zX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B717C208;
	Fri,  7 Feb 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899666; cv=none; b=aL2zHh1kpcnc6PafaiY9HagEARC4ahF3B0xKv4QGqyGutrLK3ALzujt/cy7pA+kckdsjK9B5d1TYHLWJbND93f8fLdIQdRcnLMJBBc3JinkqCvLL8D6Z781/jIr+LC1WmewIi67HJrXG12N1OR/SneNcWjRLsb4emzEptKVYC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899666; c=relaxed/simple;
	bh=JVOG5FL3W8Eu+Cn2Hq9bt4LEAaxlYlJuRq0NmOihM04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivYDGLSU0FA52JR9KpChYe0MbnFMUkNfEeFnGHJaHmWgkr3TQGjvchh6AiN6F6N2t0/AzYwY3ug1whlyBz9U4l3kJUUgR7OEvTxWkPYC+4OGtFX9FvT8MEQMszSWYkQI1ntSZxW+aFO2o1itSlu819XkfgdyXgv+9VAzITc3gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T4npwCYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s1dVh/zX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T4npwCYF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s1dVh/zX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C29D21160;
	Fri,  7 Feb 2025 03:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738899662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yGbXX/7s9iOpX6fxR/q+DsUQ+t0c9mc3Qj66EA1S0OM=;
	b=T4npwCYFu6SlxJjxU+z/iaMXCwhVfYvHMSG+AUW5gOjI7eNH2+g4T4wVD/tE+R6MVDCIIR
	B2sWr7ZA/IbDXbZrT4oFTcRvDoMkd/yUuPspe74aXtxfxWujqofnm5MJhsNaUqlGCnTbv6
	xlhFFcYyWtxF95X/tz18mkI5KqbMxwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738899662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yGbXX/7s9iOpX6fxR/q+DsUQ+t0c9mc3Qj66EA1S0OM=;
	b=s1dVh/zXSIqvMMi6NBEjM7uIIdnJoq2Kgnv/ZU0ZvjRehRwwvf8IIbgJhZ3XW4TsfWmRBT
	1gdf212ULrih6PBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T4npwCYF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="s1dVh/zX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738899662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yGbXX/7s9iOpX6fxR/q+DsUQ+t0c9mc3Qj66EA1S0OM=;
	b=T4npwCYFu6SlxJjxU+z/iaMXCwhVfYvHMSG+AUW5gOjI7eNH2+g4T4wVD/tE+R6MVDCIIR
	B2sWr7ZA/IbDXbZrT4oFTcRvDoMkd/yUuPspe74aXtxfxWujqofnm5MJhsNaUqlGCnTbv6
	xlhFFcYyWtxF95X/tz18mkI5KqbMxwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738899662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yGbXX/7s9iOpX6fxR/q+DsUQ+t0c9mc3Qj66EA1S0OM=;
	b=s1dVh/zXSIqvMMi6NBEjM7uIIdnJoq2Kgnv/ZU0ZvjRehRwwvf8IIbgJhZ3XW4TsfWmRBT
	1gdf212ULrih6PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AFA813694;
	Fri,  7 Feb 2025 03:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FOzE8eApWehfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 03:40:55 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	audit@vger.kernel.org
Subject: [PATCH 0/2] VFS: minor improvements to a couple of interfaces
Date: Fri,  7 Feb 2025 14:36:46 +1100
Message-ID: <20250207034040.3402438-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C29D21160
X-Spam-Level: 
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.99
X-Spam-Flag: NO

Hi,
 I found these opportunities for simplification as part of my work to
 enhance filesystem directory operations to not require an exclusive
 lock on the directory.
 There are quite a collection of users of these interfaces incluing NFS,
 smb/server, bcachefs, devtmpfs, and audit.  Hence the long Cc line.

NeilBrown

 [PATCH 1/2] VFS: change kern_path_locked() and user_path_locked_at()
 [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()

