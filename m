Return-Path: <linux-fsdevel+bounces-40285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810EA21AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF90C1888900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741611AF0B7;
	Wed, 29 Jan 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oEjLPLnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3uNhU259";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oEjLPLnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3uNhU259"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89717C68;
	Wed, 29 Jan 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145240; cv=none; b=O+ir9D59XiZoUHITkIuMG64i4CZsT8M7g/TR3ixHY0TeaJjf2ms7mXKbuYT9bYRFB233ZSVIIZqjTSGs/bgYQmewZk0hQU1ouxkL8h2p5XzDD9QStp9MASI7P+veuj36nQ5eFQhAXFwcLOCBzqXB8uC4rATryifzBbOT061snGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145240; c=relaxed/simple;
	bh=HuZejSlG6IdpE2oQPe87gvGRu66QyO3BnxFsxXOH+ho=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=u1C1goCfxvutxZCNVpm2MBrX1yqrrCt9nX6xm3jZW/dxnluvf3EVRScM3KFNYEtALjI6dXKziOtYXdPJnVjs8o9r9YBefFs/NmuqN2E7Yt6z+loYkAWyUTtr3kT4Zguar+3pEJw0yTlnrYlmBHwIZnD4Zs1bKyMwjituCIVaexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oEjLPLnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3uNhU259; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oEjLPLnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3uNhU259; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 56CD82110B;
	Wed, 29 Jan 2025 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738145236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5ikMhmS5uA6dvME6rfAVoE9R8KwgeLx7HG7MYXnof8c=;
	b=oEjLPLnlMT6TYPAXEs/HijeCUDeDHFEUpWcXfmevnnQnFsWOmsLd09xlswPgq0UMMH1RwJ
	QPQlGH1mT/8GZwrgXQT3R1vtX4mJukQ7u9kXzhxtkg39HFpbyTKwZdMWTt9AzjTvbHfZjP
	ZgTCEaq/D29QPNsjwWbAfwFvtdbSYSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738145236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5ikMhmS5uA6dvME6rfAVoE9R8KwgeLx7HG7MYXnof8c=;
	b=3uNhU259tVrZHf8CG0+hxpUJzPh8Fk/fBcQcaRl0clkapH+YqI6fBpvrAMY2402FJlcRu5
	OJWxMoFyKJQZr7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738145236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5ikMhmS5uA6dvME6rfAVoE9R8KwgeLx7HG7MYXnof8c=;
	b=oEjLPLnlMT6TYPAXEs/HijeCUDeDHFEUpWcXfmevnnQnFsWOmsLd09xlswPgq0UMMH1RwJ
	QPQlGH1mT/8GZwrgXQT3R1vtX4mJukQ7u9kXzhxtkg39HFpbyTKwZdMWTt9AzjTvbHfZjP
	ZgTCEaq/D29QPNsjwWbAfwFvtdbSYSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738145236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5ikMhmS5uA6dvME6rfAVoE9R8KwgeLx7HG7MYXnof8c=;
	b=3uNhU259tVrZHf8CG0+hxpUJzPh8Fk/fBcQcaRl0clkapH+YqI6fBpvrAMY2402FJlcRu5
	OJWxMoFyKJQZr7Dw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id DF14C4AAD7B; Wed, 29 Jan 2025 11:07:15 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Subject: Multigrain timestamps do not work on RISC-V
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed, 29 Jan 2025 11:07:15 +0100
Message-ID: <mvmv7ty3pd8.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.18
X-Spamd-Result: default: False [-4.18 / 50.00];
	BAYES_HAM(-2.98)[99.89%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url]
X-Spam-Flag: NO
X-Spam-Level: 

The statx06 test in the LTP testsuite fails since the multigrain
timestamp feature was merged:

https://openqa.opensuse.org/tests/4800409#step/statx06/7

The issue is that the nsec part of ctime does not change from the time
the file is created:

$ touch xx
$ stat -c $'mtime %y\nctime %z' xx
mtime 2025-01-29 09:43:44.677442605 +0100
ctime 2025-01-29 09:43:44.677442605 +0100
$ touch xx
$ stat -c $'mtime %y\nctime %z' xx
mtime 2025-01-29 09:43:51.641581658 +0100
ctime 2025-01-29 09:43:51.677442605 +0100

My guess would be that something in inode_set_ctime_current is going
wrong.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

