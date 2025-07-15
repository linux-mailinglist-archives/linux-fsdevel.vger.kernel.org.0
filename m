Return-Path: <linux-fsdevel+bounces-54941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FEB057FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01AB56092E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4822D8DB7;
	Tue, 15 Jul 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fMP/2/5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5A2D6406;
	Tue, 15 Jul 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575839; cv=none; b=d6Ch5xdzIZsdS9qioSJcnDUm88DvEE2wW96Sgh59XgozHjHOvAJsIsxkZDNwLvjuSoO1s5Gl7ileBERwrOc4ImxqIRk0DyZC+l9J2cM7D8hgRwt5tJy2dN9TalVsGFeY0nLoQogcGPK5VaoF+fAJEZ1JgbJucSlcaeYWIbbaKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575839; c=relaxed/simple;
	bh=bRWQnGaBFkqATicoOZBNn07+yA+dB5OA8yMdsKFlD70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6/wLOPxBzKQrMt5PY1T+36JV7oXS7UWRPbTkONzJC67zGAtksRiL6e/jYV/xtsrRtNFcjrDk7SslI7yY93+JJU8lgTpUE0iCq+n0wAmyBZC9vxROWeg8J9bsejQDZHIiyJAod+vwVxBZkvzB/p6/UrGhmysBme53oDIMITqmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fMP/2/5a; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bhFxK0fpGz9tfC;
	Tue, 15 Jul 2025 12:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752575829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xkTXIjd3OsRf0eTlKAZhhSr2I1Js8WnKPTLus2lYh/0=;
	b=fMP/2/5aRy89wVDDtWPiLpWM6+NT4rbhDFrN85k+PQgKFGsy4ZXffGVAec+4b5FgwGyCwM
	oD46fz3Q2+c4FsgaI8YglSL/grUQh+xJkgXj15S22kPzJzDcb7BG93/TyRdSw5hzORxjXq
	wgR65uD+K5QrgY35TxnvacbTa7rsWjKxQZM12m23t4J6iXFr6K6ZvnRoHV8uREBohXqHKX
	Z3WCtVRBTkZx1ECuRCWFcrKAZeJJz+6uW6dyxXf+q9d0vTG85UxqyZhzp168fnVXkraT9o
	Pownt3fQ8fLxYQAob3n4GAVHSVWmg07H4xsJ1mNlB7NW6tqxEbRJQukaMYqRpQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Tue, 15 Jul 2025 12:36:59 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
Message-ID: <f634msrtbc75cspm3pysavmxc5gfzlut56bee7qtc72ypmd4ap@p7tmmjisdc72>
References: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
 <68710315.a00a0220.26a83e.004a.GAE@google.com>
 <gbzywhurs75yyg2uckcbi7qp7g4cx6tybridb4spts43jxj6gw@66ab5zymisgc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbzywhurs75yyg2uckcbi7qp7g4cx6tybridb4spts43jxj6gw@66ab5zymisgc>
X-Rspamd-Queue-Id: 4bhFxK0fpGz9tfC

> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
> > start commit:   835244aba90d Add linux-next specific files for 20250709
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
> > dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000
> > 
> > Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
> > Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Ah, I see what's going on here. The reproducer mounts ext4 filesystem and
> sets block size on loop0 loop device to 32k using LOOP_SET_BLOCK_SIZE. Now
> because there are multiple reproducer running using various loop devices it
> can happen that we're setting blocksize during mount which obviously
> confuses the filesystem (and makes sb mismatch the bdev block size). It is
> really not a good idea to allow setting block size (or capacity for that
> matter) underneath an exclusive opener. The ioctl should have required
> exclusive open from the start but now it's too late to change that so we
> need to perform a similar dance with bd_prepare_to_claim() as in
> loop_configure() to grab temporary exclusive access... Sigh.
> 
> Anyway, the commit 77eb64439ad5 is just a victim that switched KERN_ERR
> messages in the log to WARN_ON so syzbot started to notice this breakage.

I was also thinking the change we did from KERN_ERR to WARN_ON was catching
a different bug.

Thanks for taking a look and fixing the issue Jan.

-- 
Pankaj Raghav

