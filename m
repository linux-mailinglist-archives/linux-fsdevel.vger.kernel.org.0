Return-Path: <linux-fsdevel+bounces-22121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C425912836
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBA4B234B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03492381D1;
	Fri, 21 Jun 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l7XCHsbY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6G3ldeC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2sR3Hd42";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h930d4L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31F28DD1
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980971; cv=none; b=j+AKPUvqLqYXQUpCxkJ0HwTiSuHEemGhJqwV0HYnbN4UY5EbVTJGCVCvHw+38HZi1N7sQ2Ed1hO+7TFm8TrCW/oRAYhb8NKYcd8lVdsyAgw6DENpXY9cjzjoe4yp8kdigysrwZzHE6c9M4ZgvgUTH96gg5n7FCStfwRJcx37JtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980971; c=relaxed/simple;
	bh=BD6+H1AiEhZIpjyMRaMQHs7QtlSbq3tWQkm5Wb1u36k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i87ib3H4iHPVjyyckAak1j+7hvmYKE16OhLUAbEQLtRmUpPQ/SziG4AKjaEXSi+BVqRwGaDruJ1QIki/7rKB2cBbuLGHDfmDFXDdAhcS7zjr10m/jScF5ck+D/yte6s5b9gAsr/5YwHca3H/vRqiT/uRfiTvzK8X5tAA2YPer04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l7XCHsbY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i6G3ldeC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2sR3Hd42; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h930d4L0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDB2F21B2B;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WLqngU/9/7iYukuOoWC0OzMddeM7SBbNKQcb2W7rV7M=;
	b=l7XCHsbYv2YMbmqSSSlBkX3891LGdYoC3ry9ehzmrxt6SUwjzD3ejoFL9Q8lcmVVC8zq6q
	LALDEatC5EKNGyxgxalPQO3ZB3cWBJA7HdDfVN2QrSdrzwdUDQZMhTK7h91P5ka3/iDuoy
	6R8hdXxOHT3UXPAek6ZRoyIs3g3Lu9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WLqngU/9/7iYukuOoWC0OzMddeM7SBbNKQcb2W7rV7M=;
	b=i6G3ldeCcUMUwkjNQNKqENXeYP3Ox3JItI+GKHtAkJYtetTjUt6kkXWl0NWDRlCh4y7Wqm
	3aQeUYFffugMuUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2sR3Hd42;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h930d4L0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WLqngU/9/7iYukuOoWC0OzMddeM7SBbNKQcb2W7rV7M=;
	b=2sR3Hd42jMmche67C4ByI5VaLToNeMhtnsINiehFO+Hb1Ghvz9ZLyR/zIA9bH0KAMZPUN5
	Rdnt2qmo1KVsCmnImywHQeVSeVQRRMmnCw9kC69jrgCVK2ES6FHIQrhI7wLFrTNl2JFfH1
	mpQaZGJKzj8T/KbZPg36evR3tn7z6h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WLqngU/9/7iYukuOoWC0OzMddeM7SBbNKQcb2W7rV7M=;
	b=h930d4L0IzUjNnRkrDeS61QMxna7WcegYscXF/QZtV8dzLdIUQpgA1qYTbIcMT7ohlkGMv
	4ZZXEp0T0uMXVxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF50613ACD;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RYN2KmaRdWY8LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 14:42:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45FA3A087E; Fri, 21 Jun 2024 16:42:46 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] mm: Avoid possible overflows in dirty throttling
Date: Fri, 21 Jun 2024 16:42:36 +0200
Message-Id: <20240621144017.30993-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=181; i=jack@suse.cz; h=from:subject:message-id; bh=BD6+H1AiEhZIpjyMRaMQHs7QtlSbq3tWQkm5Wb1u36k=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmdZFXWrLzHHh0XC2Dd/I44RRpZ9rtFei9sPPaFuuZ RjFhpnGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnWRVwAKCRCcnaoHP2RA2SNHCA C65oUwL5D5VELHnOZ8BS39ulBJcXnI+s57gs/4U0Fgnye0rCf3E3yhizB4UrM9lCv3KDxzvB27f63U wP4Fu2xwnkdZKnYFhYTDMMhSGSuI3tGkgldy89LG1ASNz9EYZ6KMnJ6KTTI1REE3WluNt0FGClK27P uo3puwcEKApVORW721ADiYWFR+y0YTs60j7WIOmX7eRKLlURjlhgGI6gCZ5H5XRoR0NaIo0SnDumIs VH/2B1USxOiUNY7oZDMtTaiGAyu5grYzojR2nnYyXAfCWhmivm30/iS0zL3th40QGDCwEdOs4RVXdD hMdHaMVyvDRikegw5R0QPO+43TdDf8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.28 / 50.00];
	BAYES_HAM(-1.27)[89.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BDB2F21B2B
X-Spam-Flag: NO
X-Spam-Score: -1.28
X-Spam-Level: 

Hello,

dirty throttling logic assumes dirty limits in page units fit into 32-bits.
This patch series makes sure this is true (see patch 2/2 for more details).

								Honza

