Return-Path: <linux-fsdevel+bounces-21825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B578590B561
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B916283D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049713C3D4;
	Mon, 17 Jun 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8caibj2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CzGYqVHB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8caibj2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CzGYqVHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD03BBD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638924; cv=none; b=QBd66cJdtyFdwbV+qhHphVVgK7L0cOd6BpW0GNxwP/fzTu5T2B+yFDiZioa4p0H6fY/WBXPkYRNFFbkaOygfZKRYg3d1r3wNwHS00UC6kdfEIgTxBcMK92dTZ1T6D8O4y7iayQGFoJqtpLRejjt7q0Prj4bgrGQdhfONuG6Hf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638924; c=relaxed/simple;
	bh=Ds3zZm8tNX4zxZdUY3QirJm6Vy941ZFt3soWdsYOke8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teb+O8iXINC/HO6wfQjSQImFzOxZoickYtgVKiQGdud/rA2UrgQpP42qCrf+oeIw6f9adBOS0Fm+JjxH9Vu8A1k5c0utXlQJUsuVGzvHyLI7KK7I5UCk0vNLqSb1Do+Qu8WlDMK/UewzXsNje4ghgjAJSy4TBY1tipUzKHlZOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8caibj2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CzGYqVHB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8caibj2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CzGYqVHB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A46D6602EF;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z4V9DehUgY9m0GwRC2TPfprhZy7/YoEhhbbKWWYGlLs=;
	b=X8caibj236l5q/LO7Jf6I64oLfy4b6bduPHYA+F9CLOQr5p07JwaKIlJ2EdtldYhmdHoi3
	D4TnpER0jC9HwR4tV3jNSFLgFZZ2WGGBj0ci3lAjdU6kf+DS/4T/6zoi2c7W2ERDTNY4yD
	UEgXma/+5TxJk90/YLlmh4dardamQm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z4V9DehUgY9m0GwRC2TPfprhZy7/YoEhhbbKWWYGlLs=;
	b=CzGYqVHBTMSk57a4Qr3mbKCTJLmYDUhDTw4N1FWQny7kt/tq6ENmUQb2rhr1/xMefaUXBs
	TXEAepjm86p1vPCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z4V9DehUgY9m0GwRC2TPfprhZy7/YoEhhbbKWWYGlLs=;
	b=X8caibj236l5q/LO7Jf6I64oLfy4b6bduPHYA+F9CLOQr5p07JwaKIlJ2EdtldYhmdHoi3
	D4TnpER0jC9HwR4tV3jNSFLgFZZ2WGGBj0ci3lAjdU6kf+DS/4T/6zoi2c7W2ERDTNY4yD
	UEgXma/+5TxJk90/YLlmh4dardamQm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z4V9DehUgY9m0GwRC2TPfprhZy7/YoEhhbbKWWYGlLs=;
	b=CzGYqVHBTMSk57a4Qr3mbKCTJLmYDUhDTw4N1FWQny7kt/tq6ENmUQb2rhr1/xMefaUXBs
	TXEAepjm86p1vPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97FE913AAF;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EhzDJElZcGYmcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E556A0887; Mon, 17 Jun 2024 17:42:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] udf: Fix two syzbot reports
Date: Mon, 17 Jun 2024 17:41:50 +0200
Message-Id: <20240617154024.22295-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=152; i=jack@suse.cz; h=from:subject:message-id; bh=Ds3zZm8tNX4zxZdUY3QirJm6Vy941ZFt3soWdsYOke8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcFk5L4WLckZy9hXwqy9bSKOfQSWFnNU/foeMJUhC mtFHJRSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBZOQAKCRCcnaoHP2RA2XmtB/ 4k1mhsZ+YErK1xa0S3CkrWQikSaeXFmQA8B3ThHk381yi3EAtZDTVQK/goZQTN+KG23xBYbNitaknO U0DOPp8ibSW4vux7t+W0zvlnKuKXTgj+9ECthQSOLaPaSLwb/L6UZjUGHnY5Lyg5/72bp7CPAdibeS 1KIlSxcWfG0uS5zC7mP3yBk2MZYSXNoHmMsVyaJxk/wPe0tVN23dFpAq7U+YixUMZzaFGok+cZU60V S7hKMQBAZyN7N14qQS9tDcGJmH6NpznvBt6P9ffEJ9NSSR0CSTr1lMo2JNxxGydcYx/dJihNUhjOuQ Gfva1FjLny9KLy4/GfnaOdMxyyRa94
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.08
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.08 / 50.00];
	BAYES_HAM(-1.29)[89.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

Hello,

these patches fix two issues syzbot found when fuzzing udf filesystem images.
I plan to merge these fixes through my tree.

								Honza

