Return-Path: <linux-fsdevel+bounces-8589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD321839293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4811C2776F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD765FF10;
	Tue, 23 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UVFGWmGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4CYOrx0e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UVFGWmGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4CYOrx0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A595FDB0;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=uRkey+oV762bDF9rBSeOD9dblDc6r4KezFC7B3rRvE3VTJsMQCFFcLZYP5lEkSIIekIKKcWrtCQ1w7kRQ4O8WxsVx4MBpDk1aQdD2evYNPbB7PtWDT78J3JhAQuBa5y7o3QMUZmkiughL3cCaSamqRWYJANC+qNcXDNUTdSpDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=lEmWPyNIBMzXtzOiSDcFTB9lefq9vA4PXF6F8c3utzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mp6v/IyKGPaVLKUV8ekDWHHk+nAUsB4NAVfg+DUWpppWClAqPkk7v2y9HR2PMzcdaWZ+0xbnaRx4+LMUmvCK3kPgq4GFJcJ3SWzsBUBexYX7MgaFw29RiljVf5pO5Kmr0jswOzw/zwMPxRigVFPnymHRNQLr7T0v56bzQbiN5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UVFGWmGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4CYOrx0e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UVFGWmGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4CYOrx0e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85ECF1FD6A;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Whzq9kgBQEQAVksO1vcWGIG7EKjfI+d2goYvtBE2ZeQ=;
	b=UVFGWmGY+AaegX4bvc84BJRbas3z8kKI4mts/u1l1eJ/lyvGsP6oNR9EdJiUctJAx1aEGT
	WBW5yarlRmW2S+6t3LZoUb7DmPWchilGTKJM6lJUOTykiy3EQbhXMAPycIqMjvtHLJFIJG
	fA0fQbSAy4WJuNuJePKyDILQFO68mes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Whzq9kgBQEQAVksO1vcWGIG7EKjfI+d2goYvtBE2ZeQ=;
	b=4CYOrx0egWNDcZ2pcjtsi75zgOXIF/dXl2qxKKKgduU4GNpnSFgYSVRsuqekLAeLRu53mX
	JbGRPSd8UzRyBZDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Whzq9kgBQEQAVksO1vcWGIG7EKjfI+d2goYvtBE2ZeQ=;
	b=UVFGWmGY+AaegX4bvc84BJRbas3z8kKI4mts/u1l1eJ/lyvGsP6oNR9EdJiUctJAx1aEGT
	WBW5yarlRmW2S+6t3LZoUb7DmPWchilGTKJM6lJUOTykiy3EQbhXMAPycIqMjvtHLJFIJG
	fA0fQbSAy4WJuNuJePKyDILQFO68mes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Whzq9kgBQEQAVksO1vcWGIG7EKjfI+d2goYvtBE2ZeQ=;
	b=4CYOrx0egWNDcZ2pcjtsi75zgOXIF/dXl2qxKKKgduU4GNpnSFgYSVRsuqekLAeLRu53mX
	JbGRPSd8UzRyBZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C1E2139B7;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itofGmXar2WbdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CF2E8A0803; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9] Remove GFP_NOFS uses from ext2, udf, and quota code
Date: Tue, 23 Jan 2024 16:24:59 +0100
Message-Id: <20240123152113.13352-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=482; i=jack@suse.cz; h=from:subject:message-id; bh=lEmWPyNIBMzXtzOiSDcFTB9lefq9vA4PXF6F8c3utzY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pHlqU7PKDbUSDIp0ut5SWW585/eMDf4z185lVO WA9vhZeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aRwAKCRCcnaoHP2RA2dOVCA CUYRVkEep2ENt/4VaZhMlWiDcR6qOa8UKx1ElNy3oMb2nWKOld6vZNTEnugs7ny9zL2LRdqMBwljq1 DTFmAYL6Q1ssi5ZKxPNT0o3cEzB/IO2/mcfWyz0uWhRq3sdHiA7shKHteM2zhavaoIyV7gcWOoc8vr ZUL0VHoLZkAhLpO8Dmr8+O1Oq3XMDzcKeM2SJhNNjmFuNq3zzYBeDG/ZV351Q5CYnOzNFCyiNKLISX 4a6Y3coMu6MUX56vWoe45bdTh7KQPFpRKwMFTgaQ9sUQqvwcic0v+KBNs4RXgLKmA1v4+MlATVLOcS iqoDf5zlPIpoEfZCSpwPfQb6zSqqqb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UVFGWmGY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4CYOrx0e
X-Spamd-Result: default: False [4.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.89%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.68
X-Rspamd-Queue-Id: 85ECF1FD6A
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Hello,

inspired by recent Matthew's complaint about frequent use of GFP_NOFS in
filesystems I've audited GFP_NOFS use in ext2, udf, and quota code and removed
the uses that are no longer needed or can be reasonably easily replaced with
the scope API. So far lockdep didn't barf on me during fstests runs but I guess
we'll really know only once syzbot seriously stresses this in Linux next.

Unless somebody objects, I'll queue these patches into my tree.

								Honza

