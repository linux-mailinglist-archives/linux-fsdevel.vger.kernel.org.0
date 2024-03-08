Return-Path: <linux-fsdevel+bounces-14024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37D876B40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 20:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987002829C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438C5A7B5;
	Fri,  8 Mar 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVTCME5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uCH3Nep4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVTCME5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uCH3Nep4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF52C699;
	Fri,  8 Mar 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926635; cv=none; b=NsNf6kg3HEUbA9cJAculQEnvVC/tW2Ns90bz6bUd4OE6eJa8MJM8fwCPHbk1iIYelWmTKGR5OlGlUXjCOlK959Nv7J14f7gr+ZljGeFvN9yiAvvWydSWHB2aUtGwh4l+N8zBA/hqhk6K4wjDTxzT85rgZaVU3esHi+jsd2DYss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926635; c=relaxed/simple;
	bh=AYGxzqtWFZzjVFm4jYl0RBSDkqII6yUctYob3MJlJGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r/d1wGfly6JsdJuRyP/XW7cWdLRlmCZfbnuRMMvX5fc8COCUZypOXbBanmLLx3hhAsHLr7yfGqLJtaRG8sIH0EOZ65oCEJ7WVQjUx3vS8ziaPilQRyIaDbgYht/RqRcU1gf3hFaeZGgxQVf6qFu6bDpHlmt1j35arMDmhlH4h2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVTCME5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uCH3Nep4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVTCME5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uCH3Nep4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 867BC5D4B8;
	Fri,  8 Mar 2024 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709925398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kab6475NNC9w/20248v/V/kqivMNMdqsH2NoWAUHlNA=;
	b=dVTCME5npzzOIHDurrdqJrMn7ka+G5xyG2QtkbzwJn4Mbj8a7F8qmoIyVjOD3FZFZEHHrC
	RObd999zwv7Bm9hpq8vl4/Moht2w/YgAw26gH2NtlsNO5BoTtgq0wbGSTWmiinYwC9kV7B
	Zl8sRIg+pv/BJ6T7aBM9LssSle5rHj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709925398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kab6475NNC9w/20248v/V/kqivMNMdqsH2NoWAUHlNA=;
	b=uCH3Nep4vF7IQHASNx+5tSLqMV6/MtzHFhRazpLudWfqhmuLnZySbRdMtPAgfULNWv/eqS
	jSMcXAr6OMtXZRAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709925398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kab6475NNC9w/20248v/V/kqivMNMdqsH2NoWAUHlNA=;
	b=dVTCME5npzzOIHDurrdqJrMn7ka+G5xyG2QtkbzwJn4Mbj8a7F8qmoIyVjOD3FZFZEHHrC
	RObd999zwv7Bm9hpq8vl4/Moht2w/YgAw26gH2NtlsNO5BoTtgq0wbGSTWmiinYwC9kV7B
	Zl8sRIg+pv/BJ6T7aBM9LssSle5rHj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709925398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kab6475NNC9w/20248v/V/kqivMNMdqsH2NoWAUHlNA=;
	b=uCH3Nep4vF7IQHASNx+5tSLqMV6/MtzHFhRazpLudWfqhmuLnZySbRdMtPAgfULNWv/eqS
	jSMcXAr6OMtXZRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E03B13310;
	Fri,  8 Mar 2024 19:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QfALDRZk62VBDQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 08 Mar 2024 19:16:38 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: linux-fsdevel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: krisman@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308183215.1924331-1-ben.dooks@codethink.co.uk>
References: <20240308183215.1924331-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] unicode: make utf8 test count static
Message-Id: <170992539715.13713.18221873605558734700.b4-ty@suse.de>
Date: Fri, 08 Mar 2024 14:16:37 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.43
X-Spamd-Result: default: False [-1.43 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.13)[67.35%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO


On Fri, 08 Mar 2024 18:32:15 +0000, Ben Dooks wrote:
> The variables failed_tests and total_tests are not used outside of the
> utf8-selftest.c file so make them static to avoid the following warnings:
> 
> fs/unicode/utf8-selftest.c:17:14: warning: symbol 'failed_tests' was not declared. Should it be static?
> fs/unicode/utf8-selftest.c:18:14: warning: symbol 'total_tests' was not declared. Should it be static?
> 
> 
> [...]

Applied, thanks!

[1/1] unicode: make utf8 test count static
      commit: 0131c1f3cce7c01b0eb657a9e9e1a5e42c09a68b

Best regards,
-- 
Gabriel Krisman Bertazi <krisman@suse.de>


