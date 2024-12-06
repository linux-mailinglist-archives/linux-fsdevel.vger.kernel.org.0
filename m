Return-Path: <linux-fsdevel+bounces-36629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A839E6E77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA01888152
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9C20126D;
	Fri,  6 Dec 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lG+M9Z3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TrKShBSJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lG+M9Z3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TrKShBSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F01FCF40;
	Fri,  6 Dec 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488630; cv=none; b=Y37Ll1MeeNc0oldQ7ztGZLXwM4ufFcmOarf6NRVNozo8Hu+18d7PzqU/DNwZ2N0cNiKSibyKnno982t6ux2MFx2WKHtVopMRh3GPZ9B3rhBM3t0hBk0hfdjDI5kA1erp4L9Apy+3PY+Bu4izZvtmp+6UgnclpfaU5spNq8ELz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488630; c=relaxed/simple;
	bh=o6wRrS3k07uBZ5yBKQHBLycycX25rpyqfhX4KmiWlDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2onQvR4ZJZPp6g+fPd14a2BBOGMxf57ngJMGPUJg5TbLzHL+c9MoQxCM8HxtC24Bef7sSPQZ+5FOEo8hPsz1l51WoARK19KWguyfRRDWSpjtu3wGEAFULgPG0P9U3EzzaqKZ2vw/MLnMl37BU7+x0GG+YKRIRR3bToWo+KNzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lG+M9Z3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TrKShBSJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lG+M9Z3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TrKShBSJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 335C11F397;
	Fri,  6 Dec 2024 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uE5wJA9vj7KF0w77/4O+vlPlqnKO1saLwErislPea0=;
	b=lG+M9Z3OLrLsKUDAxHtpA1M6Rz+46AINscgR0kXPIejzsxEBUqnhLt2hBHp7dI2t1XaPpj
	JZqcKeZ1Lq0UKgaehzTymtVR0Eb7iXTOH57AORFn8tPgYhBVfI3VpSc+o/JQNaTPedwcmY
	u30sfu2UiWRZg4MVvxWM23ZlUfj2QCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uE5wJA9vj7KF0w77/4O+vlPlqnKO1saLwErislPea0=;
	b=TrKShBSJNXFDBRgrQ4E9q69zMevrNPWhnVYTHLMAACL726CCBsIiql3/JO9yPGTeTpqRk6
	0lOIzfO/UEhOPYDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lG+M9Z3O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TrKShBSJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uE5wJA9vj7KF0w77/4O+vlPlqnKO1saLwErislPea0=;
	b=lG+M9Z3OLrLsKUDAxHtpA1M6Rz+46AINscgR0kXPIejzsxEBUqnhLt2hBHp7dI2t1XaPpj
	JZqcKeZ1Lq0UKgaehzTymtVR0Eb7iXTOH57AORFn8tPgYhBVfI3VpSc+o/JQNaTPedwcmY
	u30sfu2UiWRZg4MVvxWM23ZlUfj2QCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uE5wJA9vj7KF0w77/4O+vlPlqnKO1saLwErislPea0=;
	b=TrKShBSJNXFDBRgrQ4E9q69zMevrNPWhnVYTHLMAACL726CCBsIiql3/JO9yPGTeTpqRk6
	0lOIzfO/UEhOPYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64E82138A7;
	Fri,  6 Dec 2024 12:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5VhqB/HvUmeeRgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 06 Dec 2024 12:37:05 +0000
Date: Fri, 6 Dec 2024 23:36:54 +1100
From: David Disseldorp <ddiss@suse.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: ksmbd: v6.13-rc1 WARNING at fs/attr.c:300
 setattr_copy+0x1ee/0x200
Message-ID: <20241206233654.3a3207ba.ddiss@suse.de>
In-Reply-To: <CAKYAXd8U-kQa5+fg4QvcUeOkAuX128v_VLxNz5=trF85ZONrYA@mail.gmail.com>
References: <20241206164155.3c80d28e.ddiss@suse.de>
	<CAKYAXd8U-kQa5+fg4QvcUeOkAuX128v_VLxNz5=trF85ZONrYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 335C11F397
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 6 Dec 2024 16:35:18 +0900, Namjae Jeon wrote:
...
> > 300                 WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^--- here.

I should mention, fstests generic/215 atop a 6.13.0-rc1 cifs.ko SMB3
mount was the trigger for this ksmbd warning.

> > Looking at smb2pdu.c:set_file_basic_info() it's easy enough to see how
> > we can get here with !ATTR_CTIME alongside ATTR_MTIME.
> >
> > The following patch avoids the warning, but I'm not familiar with this
> > code-path, so please let me know whether or not it makes sense:  
> mtime and atime will probably not be updated.

Unless I'm missing something, this patched ksmbd still triggers mtime
update via the setattr_copy_mgtime()->(ia_valid & ATTR_MTIME_SET) path.

> I will change it so that ATTR_CTIME is also set when changing mtime.

That should also work. I was turned off that path due to the
64e7875560270 ("ksmbd: fix oops from fuse driver") ATTR_CTIME changes.

Thanks, David

