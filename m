Return-Path: <linux-fsdevel+bounces-8305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCF832992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D7283752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EB51C2A;
	Fri, 19 Jan 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PIHLZzXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyvIawtr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PIHLZzXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyvIawtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97831A61;
	Fri, 19 Jan 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667743; cv=none; b=euXTub2PsIXCRVNyERiHpp5gnhUwRWh0O9DrBt/DCxHTA49fPjXh3KfT8hTklzozEIgoUtQX5Mwycy5Hu03K5c6zFpuL+5fhtBUYLCVWLeA9AqjtrWt/L9ygCVUhWlaoia9VBsKm7YeNwUG/gOe3VJ+Db7JRDJR7mlsi1WfbNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667743; c=relaxed/simple;
	bh=jffCLdTIcCbL45wgt6ffIq58KrNnm/BVIQW3BkJ5reA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxbmwEdkXkG29C9Ecs7UwsZABWLDKNS6qIJRol0K0eBNTA11C5uVwoFP45JYz5EGsxb08pAq/mu4DXbw0mDxi9UlhpYY+kClUVdEI34qFX1FH6Wd7TZ5PqLOs0xMQroCMTxERkUUp4/MsBUTNTtE/ji10Ma8DS8sptuBrT9H7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PIHLZzXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TyvIawtr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PIHLZzXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TyvIawtr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 988731FD12;
	Fri, 19 Jan 2024 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705667739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU34e5h97GyB4Ieq5hCIWgoIR3p0l2c/abRaH0dJLdU=;
	b=PIHLZzXQscL8ilb/su55FeqP+6NLQxlTf8JT4rYUkl/QKbpDt8VPGrB9PhZQRy7qlFOcCd
	9ZxrhzuuuppabX+Nz8e/RtlnYzFqwukVAGVr1y75vqKmTv0OHMJPowGOifO2GTvmjCpIaI
	UQr505l5Vo34Wtb2k+G8QEePBhtN1kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705667739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU34e5h97GyB4Ieq5hCIWgoIR3p0l2c/abRaH0dJLdU=;
	b=TyvIawtrrb+VKlnoLFwjoK/wBmqSj8HDPhHbCYhNDEZnfQla8zKMnDiwOdTWBvN3dV4oc2
	/omv+eDX1T0aWZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705667739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU34e5h97GyB4Ieq5hCIWgoIR3p0l2c/abRaH0dJLdU=;
	b=PIHLZzXQscL8ilb/su55FeqP+6NLQxlTf8JT4rYUkl/QKbpDt8VPGrB9PhZQRy7qlFOcCd
	9ZxrhzuuuppabX+Nz8e/RtlnYzFqwukVAGVr1y75vqKmTv0OHMJPowGOifO2GTvmjCpIaI
	UQr505l5Vo34Wtb2k+G8QEePBhtN1kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705667739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU34e5h97GyB4Ieq5hCIWgoIR3p0l2c/abRaH0dJLdU=;
	b=TyvIawtrrb+VKlnoLFwjoK/wBmqSj8HDPhHbCYhNDEZnfQla8zKMnDiwOdTWBvN3dV4oc2
	/omv+eDX1T0aWZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88B6813894;
	Fri, 19 Jan 2024 12:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X4pXIZtsqmVSDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Jan 2024 12:35:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E04AA0803; Fri, 19 Jan 2024 13:35:39 +0100 (CET)
Date: Fri, 19 Jan 2024 13:35:39 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+5dd35da975e32d9df9ab@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs] WARNING in ea_get
Message-ID: <20240119123539.xgws46tptxbrzavq@quack3>
References: <000000000000e38e4105e9d6e741@google.com>
 <000000000000ab49d0060f4719a4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ab49d0060f4719a4@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.04)[59.02%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5];
	 TAGGED_RCPT(0.00)[5dd35da975e32d9df9ab];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.86
X-Spam-Flag: NO

On Thu 18-01-24 23:05:07, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b95fdbe80000
> start commit:   49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=5dd35da975e32d9df9ab
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1173d7ff080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2ea70880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

