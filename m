Return-Path: <linux-fsdevel+bounces-38424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B5A0244A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C071645E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C01DB924;
	Mon,  6 Jan 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zR6Bz44l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TblNmqPR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zR6Bz44l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TblNmqPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EBE18A6B2;
	Mon,  6 Jan 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162948; cv=none; b=BiVRmTVERN7EnjHZ9UStD+FAcv1vDu4K1fc+o9Ct7o4+s0VYeNmtEZMiBywjffWhWpRvHo+d+fsmuEFvcH/L01PKYy5O2o9iHOdJwQDwq12kJshngrmCoCu/bfsQ8Zf07UbQ2wuUutV8TwQywDjiKlGlgl6bMClSzLJeehcS/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162948; c=relaxed/simple;
	bh=xi/vALZ9gVTN/+LrfoKD2Q5KybzGOb0aT0908yFzayE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsAb4cCsnYcB8S5f2X1Utgsr7urydH95WsWY0pYC/M7ZPmVN+MuHpv35ppYHVUdSix06wZfFLXgnwqw1rWHYVcEyck9At178NSYAEcsNGroxx4MzcFfhXxFcDPHDMSCU9WBJKDm4C3g6G4xy/FpRjI6LkCtF+MQ9Pdpo/heYXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zR6Bz44l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TblNmqPR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zR6Bz44l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TblNmqPR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26A2B1F399;
	Mon,  6 Jan 2025 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736162943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0sBa4lg8WWY1wSiBxYcNlBoUKjd3APDh5hdQLOP7wE=;
	b=zR6Bz44lXKZvyG4/mqE3LTE9Adhpp1C3zyZFzkvuozPBT6MXSd3Gp5sYxkWbuWEj4rCubm
	PmJU0eMfUBNQWdogIOp7UpFUm0aj2zVc/F840p+05EqHgBE+61PTg7HeIFA/sBFK6IYMVs
	vIy2n6iPrhqbc8UDX0DecPKNcU8DfTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736162943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0sBa4lg8WWY1wSiBxYcNlBoUKjd3APDh5hdQLOP7wE=;
	b=TblNmqPRRF2T8RJW7yGHz6gOzPYRwb5HMis6uauVooG+td0VEmq7HLFfcs3woc6yq+FcKP
	EpPoW8zWmkOxplBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736162943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0sBa4lg8WWY1wSiBxYcNlBoUKjd3APDh5hdQLOP7wE=;
	b=zR6Bz44lXKZvyG4/mqE3LTE9Adhpp1C3zyZFzkvuozPBT6MXSd3Gp5sYxkWbuWEj4rCubm
	PmJU0eMfUBNQWdogIOp7UpFUm0aj2zVc/F840p+05EqHgBE+61PTg7HeIFA/sBFK6IYMVs
	vIy2n6iPrhqbc8UDX0DecPKNcU8DfTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736162943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0sBa4lg8WWY1wSiBxYcNlBoUKjd3APDh5hdQLOP7wE=;
	b=TblNmqPRRF2T8RJW7yGHz6gOzPYRwb5HMis6uauVooG+td0VEmq7HLFfcs3woc6yq+FcKP
	EpPoW8zWmkOxplBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9F6139AB;
	Mon,  6 Jan 2025 11:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jmt6Bn++e2frDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 11:29:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFBAAA089C; Mon,  6 Jan 2025 12:29:02 +0100 (CET)
Date: Mon, 6 Jan 2025 12:29:02 +0100
From: Jan Kara <jack@suse.cz>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
Message-ID: <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Mon 06-01-25 15:23:06, Kun Hu wrote:
> When using our customized fuzzer tool to fuzz the latest Linux kernel,
> the following crash was triggered.
> 
> HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> git tree: upstream
> Console output: https://drive.google.com/file/d/1-YGytaKuh9M4hI6x27YjsE0vSyRFngf5/view?usp=sharing
> Kernel config: https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=sharing
> C reproducer: /
> Syzlang reproducer: /
> 
> We found an issue in the __bh_read function at line 3086, where a
> slab-out-of-bounds error was reported. While the BUG_ON check ensures
> that bh is locked, I suspect it’s possible that bh might have been
> released prior to the call to __bh_read. This could result in accessing
> invalid memory, ultimately triggering the reported issue.

Well, most likely the bh pointer has already been corrupted. Again, nobody
is likely to be able to debug this unless we have a reliable way to
reproduce this problem.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

