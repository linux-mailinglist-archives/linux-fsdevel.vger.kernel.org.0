Return-Path: <linux-fsdevel+bounces-9680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBF8445E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63F31C247AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02312CDA7;
	Wed, 31 Jan 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6eti3Jo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbHH6htc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6eti3Jo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbHH6htc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145A1EF12;
	Wed, 31 Jan 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721530; cv=none; b=K0NawIozxj4/Eh/Q2mso2pbo0lndjtavKUP/e34Q4ZoUirQxWUUM6oTXu2PrbPMNgE0xKnx0sNQ7TyK0PnYGFd6skxn5Jr4FRXgnIygz1aai2jTtQOGOT/jqqlGyo0cdN1p5OYwQa28ILNd+aK8kxk9cCKdoYUGVwO6xnZd1xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721530; c=relaxed/simple;
	bh=IIUrR5YxqrFodLFFKzfNxQbgIV0lT446TBY2XEfvZHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCUb1V1r6Tfqu0/iW2IjEympeelhZxytQZ3EUr1AAklhakBiM/hq1bzmyZk1LFCdn6RhX7lpsHLdFMUTP8FmJoc4ygUeom/5dF4b5WRFXtdq+tL1DGY/WkJn4CGLvVBCYpsKyi4wUFUGexHediXywbD/fovkt6FXEkv/HMnLM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6eti3Jo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbHH6htc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6eti3Jo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbHH6htc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2BE22004;
	Wed, 31 Jan 2024 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706721525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX2DnOrLwWKLYumNK3TzC8Reh/LhxYlUXHdH/lnaQVY=;
	b=T6eti3JomHWyQK2w1ouQcH9N4rpG3PELNj74ZN4VaqatpzG0OGvDMrbfaCGpulVE9HVvK5
	6V/stfT1hSlW3BChIjK1gikbVn5HYP9MKe2/UutxHWafVFnPZflIK4VqdaGX8SGo19ABer
	d9IsW/MUWk3AJRNXq/DGzvGtKYGIKPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706721525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX2DnOrLwWKLYumNK3TzC8Reh/LhxYlUXHdH/lnaQVY=;
	b=tbHH6htc44POBCV+ShlckMgx2UO6ThqfIflJtvq/Rt1bmAUh4Z30usoPGlC0MGwUa088KV
	OQBUbijpEzcaSgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706721525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX2DnOrLwWKLYumNK3TzC8Reh/LhxYlUXHdH/lnaQVY=;
	b=T6eti3JomHWyQK2w1ouQcH9N4rpG3PELNj74ZN4VaqatpzG0OGvDMrbfaCGpulVE9HVvK5
	6V/stfT1hSlW3BChIjK1gikbVn5HYP9MKe2/UutxHWafVFnPZflIK4VqdaGX8SGo19ABer
	d9IsW/MUWk3AJRNXq/DGzvGtKYGIKPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706721525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX2DnOrLwWKLYumNK3TzC8Reh/LhxYlUXHdH/lnaQVY=;
	b=tbHH6htc44POBCV+ShlckMgx2UO6ThqfIflJtvq/Rt1bmAUh4Z30usoPGlC0MGwUa088KV
	OQBUbijpEzcaSgDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 604E3132FA;
	Wed, 31 Jan 2024 17:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pDt2F/WAumXQFwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 17:18:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ED1DA0809; Wed, 31 Jan 2024 18:18:45 +0100 (CET)
Date: Wed, 31 Jan 2024 18:18:45 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel NULL pointer
 dereference in reiserfs_find_entry
Message-ID: <20240131171845.okzidcm6gylcy4gw@quack3>
References: <00000000000073b6d905eb48de3f@google.com>
 <000000000000e3d3f9061040b2ff@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e3d3f9061040b2ff@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453];
	 TAGGED_RCPT(0.00)[4654552e088ed458b10d];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Wed 31-01-24 08:52:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e6fb5be80000
> start commit:   51f269a6ecc7 Merge tag 'probes-fixes-6.4-rc4' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
> dashboard link: https://syzkaller.appspot.com/bug?extid=4654552e088ed458b10d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1177c895280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4b2a5280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

