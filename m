Return-Path: <linux-fsdevel+bounces-19810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDE8C9E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0676283B6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF99136675;
	Mon, 20 May 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2ZuMAWH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WpSNzjIM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2ZuMAWH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WpSNzjIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4655C2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213060; cv=none; b=l1R3Gu6KHuNiU9efPj0eUlxFfxalHHTofCErgMGJ9EjmAA36CP1I713lQSHWdOtpDxmyjMTIluddINXi0UXxFRUtJww0OZddcLfrApNmlukZ7hfM2zH1FyjqeK/fDd/qLOd/h/dyYuuMyG3jcyBVnMqm6ewv/sjPhulMLBWluwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213060; c=relaxed/simple;
	bh=3vOjFrsaD/ogpr7yMbYh55WIZYUw3gEbPLXuJZ/WxLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGswWEpwhUhka284GeOQkNFs51j5Cg5h+QKPITeqnehhraKfcctV8l2Bt41M0o3GhK01wCy+FQzfkC8rGSM7duuVxfacfk5aANMmOfIw5fr0L3uAoXRXthWuQDHVn71NwgU4xd5zswKjIPZRTG3QGol5qAE+9tdLfxlEaQqP4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2ZuMAWH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WpSNzjIM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2ZuMAWH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WpSNzjIM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A624B33B92;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWqxU1pDTSaTKrQ7xQ4oz48onTKxnh6pUAGHEla6i0w=;
	b=c2ZuMAWHTf1Bhth4X1kgaZ9Lrid+z4fbdDXBK1rf9P0bTI7gCoIGjHxN1i2c35Oo7Pi+xq
	KwZJSQYhaNvAbTn5bQ+368ttdRHgzXhsDIhw+TFs2a/bnFMFyflR/z01HJTp1Ri2cZIDzY
	LzFouI3gxDxAxyyUfthaORy/yMwiw/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWqxU1pDTSaTKrQ7xQ4oz48onTKxnh6pUAGHEla6i0w=;
	b=WpSNzjIMH7HMauI4tV2V0vf1iUvICvrB6hfWifqTLeNTGYGxEVAST1xLzjH7MsvhfAl9wA
	saAuWrkUssBxPoDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c2ZuMAWH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WpSNzjIM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWqxU1pDTSaTKrQ7xQ4oz48onTKxnh6pUAGHEla6i0w=;
	b=c2ZuMAWHTf1Bhth4X1kgaZ9Lrid+z4fbdDXBK1rf9P0bTI7gCoIGjHxN1i2c35Oo7Pi+xq
	KwZJSQYhaNvAbTn5bQ+368ttdRHgzXhsDIhw+TFs2a/bnFMFyflR/z01HJTp1Ri2cZIDzY
	LzFouI3gxDxAxyyUfthaORy/yMwiw/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716213056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IWqxU1pDTSaTKrQ7xQ4oz48onTKxnh6pUAGHEla6i0w=;
	b=WpSNzjIMH7HMauI4tV2V0vf1iUvICvrB6hfWifqTLeNTGYGxEVAST1xLzjH7MsvhfAl9wA
	saAuWrkUssBxPoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9723613A74;
	Mon, 20 May 2024 13:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eE7iJEBVS2ayCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 13:50:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B644A08D8; Mon, 20 May 2024 15:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Correct lock ordering in udf_setsize()
Date: Mon, 20 May 2024 15:50:48 +0200
Message-Id: <20240520134853.21305-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=235; i=jack@suse.cz; h=from:subject:message-id; bh=3vOjFrsaD/ogpr7yMbYh55WIZYUw3gEbPLXuJZ/WxLw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmS1Uz98L+Kfc1rkbAbMpBJ223zeFzWDKG6bDoZqG4 4bCyDZ2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZktVMwAKCRCcnaoHP2RA2QEOB/ 9qivIzfYhNFneqI5q7K3uh0iAJ4pL/210iz3ok8rRQwcfIqh+nMMzOAydlCggCqpA3VDhXAAKDuWoC kcTPGC/gqNt5b9o1fs4eb6+xzt1I7xCxi+PQNzlSyE7wg9sCKYZT4+YPcD9wtEXjTzMni/X2eu8Sn/ kb4ZJxZK7JJSG46WQCtPRh3rRhRuXD0zKTQuV1c5cuNNPRrT+/wTk4u9ZtltWu08omaB1Ss+zl/XM0 8ywVvyAVOF92ZK1hG7sguxqM0sLsLyIpQxVg9y9IEQrIUBhfHH5kIqArMlaAfs86/OI5Y4l5MNksrA JfCnr47Hhyf6dGXOu6PW+/KUUfdAp2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.90 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.89)[85.95%];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Rspamd-Queue-Id: A624B33B92
X-Spam-Flag: NO
X-Spam-Score: -0.90
X-Spamd-Bar: /

Hello!

Syzbot has reported a lockdep warning in udf_setsize(). After some analysis
this is actually harmless but this series fixes the lockdep false positive
error. I plan to merge these patches through my tree.

								Honza

