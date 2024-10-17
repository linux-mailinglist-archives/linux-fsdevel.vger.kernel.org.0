Return-Path: <linux-fsdevel+bounces-32185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913D9A2063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F60DB2511F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDA1DACBF;
	Thu, 17 Oct 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K99kBRdy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P99G18no";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K99kBRdy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P99G18no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AF1DAC9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162773; cv=none; b=TYiM8Kx3S19FBk06woFcp24RqhqBRtDGVARQVrcuddkwdlsOTht87dpFh7lMMARgcdst4340eTucXv8UldmUZnwRjWlnTzBfvTXJeUQcRDiRoG7eaa9J8CHd5V9t/D2kESMacUSFepqZrXDA0D6DiymkOirlxTbv9OdxqfuzOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162773; c=relaxed/simple;
	bh=CWEkn+TnCraZUxdnAno2+9xsDJdnHAI9bVUMzsDssbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NXX81oXBeXB/umNNWbhWPOKbGQDo2yEO+QLsiP5fET0eWx1kMwBVB8ncdjMw30Vg3SLTOpLCSooyCY3VxLHEQZ8SBnO3qzhgSCt19WMkPlAf3OL8Rl5yWUtq7slW/wCW0J+zO8xS1kadVCv7/aSAY3txrHcprHXYEpH8sqALURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K99kBRdy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P99G18no; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K99kBRdy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P99G18no; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59CBD1FEFF;
	Thu, 17 Oct 2024 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729162768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ApcSi95yyDqjTeXRdSEjm9hwZm7r+DDMXjgRwUU3DU0=;
	b=K99kBRdyQvQjKx6nTy150xXGW/qrqh6hNqVQgcXybZ7v/pmxD+1o9fRomgqNr++8RHgOYu
	BygKuyZ2Ozrfsh1IKkh4betJqE1d4DN5sxg6mA7D5JxHCM5o51bKQB1wm6ihhE8FVR+cmz
	TcIpXMav/IWWAST+6fmkMMas1rvcBb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729162768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ApcSi95yyDqjTeXRdSEjm9hwZm7r+DDMXjgRwUU3DU0=;
	b=P99G18noQu7bwD4+zgpYXKnsKlARvigPKWBL0aP/Nh2PhxcGB6tPpXjHkUALiXJKUfhTZa
	9DqomDKvHhHBqgAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729162768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ApcSi95yyDqjTeXRdSEjm9hwZm7r+DDMXjgRwUU3DU0=;
	b=K99kBRdyQvQjKx6nTy150xXGW/qrqh6hNqVQgcXybZ7v/pmxD+1o9fRomgqNr++8RHgOYu
	BygKuyZ2Ozrfsh1IKkh4betJqE1d4DN5sxg6mA7D5JxHCM5o51bKQB1wm6ihhE8FVR+cmz
	TcIpXMav/IWWAST+6fmkMMas1rvcBb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729162768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ApcSi95yyDqjTeXRdSEjm9hwZm7r+DDMXjgRwUU3DU0=;
	b=P99G18noQu7bwD4+zgpYXKnsKlARvigPKWBL0aP/Nh2PhxcGB6tPpXjHkUALiXJKUfhTZa
	9DqomDKvHhHBqgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9B113A42;
	Thu, 17 Oct 2024 10:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ul7sEhDuEGdCZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Oct 2024 10:59:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5B88A07D0; Thu, 17 Oct 2024 12:59:27 +0200 (CEST)
Date: Thu, 17 Oct 2024 12:59:27 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>
Subject: Dropping of reiserfs
Message-ID: <20241017105927.qdyztpmo5zfoy7fd@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

Since reiserfs deprecation period is ending, it is time to prepare a patch
to remove it from the kernel. I guess there's no point in spamming this
list with huge removal patch but it's now sitting in my tree [1] if anybody
wants to have a look. Unless I hear some well founded complaints I'll send
it to Linus during the next merge window in mid-November.

								Honza

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log/?h=reiserfs_drop

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

