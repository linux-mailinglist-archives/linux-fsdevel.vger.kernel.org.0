Return-Path: <linux-fsdevel+bounces-38659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFDA05F77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A1A3A1030
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6A1FCFE5;
	Wed,  8 Jan 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdMXfvZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sw+dNLly";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdMXfvZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sw+dNLly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88882F50;
	Wed,  8 Jan 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348375; cv=none; b=MwRnd7TLQjERq8m0Jp5Ax2k2drmrkMf7Jl/NbfgnnBD/hwbZUlniHMJmy2bf7K0v+xvLTHVAzm0HBdNd6z3s2diba9s5nQWkgWAXH68hbSfqRYLzPaEf2VM1WJQGLgcWIUedAMboHJdeOxr+vXczm/A+IWir8eTggYT195brw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348375; c=relaxed/simple;
	bh=XEqs4OUILBKlPoJMVh5wAGti+bi3A82RChSXFddKSDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5XCHQz3z4bTn4nFGAqjDfz7vYK5iZuL+jOWjCt43H/xbt5mkbzXA1YG6a4cfhnL4e2JT2AYlEG1yYTOKvT27o0+gRvqTiR8y01Y9eVUfdteTxXXJFI1NwKQaTkjQ5V3dsPmiMcbHz76/8H0RN8O2R7y8zzYBlKuqfDahxkCv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdMXfvZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sw+dNLly; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdMXfvZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sw+dNLly; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE53D210F7;
	Wed,  8 Jan 2025 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736348371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFNBNmRCBKOvcgi5aydfabhGS4kn81gC41YewBXHhCk=;
	b=qdMXfvZL8JNXrN/e29GuLAINGk6LXwkcd9jUnCSRxlP2DovI6V/d/5BWUXnovAeOehiEgc
	P6+qTw7AS1ep2I98SZDmML/oZdeD8IvhrSFjBPmSM80zTkIYgR2pcpCIdnExC0KCtYPakH
	tzey+UOWJbbmODgkuCibxQMcL4xkfMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736348371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFNBNmRCBKOvcgi5aydfabhGS4kn81gC41YewBXHhCk=;
	b=Sw+dNLlyLqgosAomdyvcLR9luT7f9vLKcTM6kjbi8uPtTJkzNcBupKZwsVYyiIFlC+2E04
	2qdHLHOUu0s0zhCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736348371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFNBNmRCBKOvcgi5aydfabhGS4kn81gC41YewBXHhCk=;
	b=qdMXfvZL8JNXrN/e29GuLAINGk6LXwkcd9jUnCSRxlP2DovI6V/d/5BWUXnovAeOehiEgc
	P6+qTw7AS1ep2I98SZDmML/oZdeD8IvhrSFjBPmSM80zTkIYgR2pcpCIdnExC0KCtYPakH
	tzey+UOWJbbmODgkuCibxQMcL4xkfMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736348371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFNBNmRCBKOvcgi5aydfabhGS4kn81gC41YewBXHhCk=;
	b=Sw+dNLlyLqgosAomdyvcLR9luT7f9vLKcTM6kjbi8uPtTJkzNcBupKZwsVYyiIFlC+2E04
	2qdHLHOUu0s0zhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA0FA137DA;
	Wed,  8 Jan 2025 14:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZJNMdOSfmdCVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Jan 2025 14:59:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FA81A0889; Wed,  8 Jan 2025 15:59:27 +0100 (CET)
Date: Wed, 8 Jan 2025 15:59:27 +0100
From: Jan Kara <jack@suse.cz>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
Message-ID: <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Wed 08-01-25 12:08:56, Kun Hu wrote:
> >> HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> >> git tree: upstream
> >> Console output: https://drive.google.com/file/d/1-YGytaKuh9M4hI6x27YjsE0vSyRFngf5/view?usp=sharing
> >> Kernel config: https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=sharing
> >> C reproducer: /
> >> Syzlang reproducer: /
> >> 
> >> We found an issue in the __bh_read function at line 3086, where a
> >> slab-out-of-bounds error was reported. While the BUG_ON check ensures
> >> that bh is locked, I suspect it’s possible that bh might have been
> >> released prior to the call to __bh_read. This could result in accessing
> >> invalid memory, ultimately triggering the reported issue.
> > 
> > Well, most likely the bh pointer has already been corrupted. Again, nobody
> > is likely to be able to debug this unless we have a reliable way to
> > reproduce this problem.
> 
> We have obtained the reproducers of this issue for multi round testing.
> But, the crash location seems to vary. The crash log shows a possible
> deadlock occurring in “gfs2_trans_begin" in /fs/gfs2/trans.c, with
> duplicate registrations happening when attempting to register a
> "kobject."

OK. Checking the syzlang reproducer the same comment as for other
filesystem bugs applies - please run with CONFIG_BLK_DEV_WRITE_MOUNTED
disabled to rule out corruption of a filesystem while it is mounted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

