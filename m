Return-Path: <linux-fsdevel+bounces-78620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC6YCOaPoGkokwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:24:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CF1AD8C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B58E30895BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA23859C3;
	Thu, 26 Feb 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzj8Wu3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9535A398
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129576; cv=none; b=ePgVZi7AdMmfu+5NBxFiwu7I4vsFzpTK2MlIM0FVphd2EITYIhfPUDD9UXjrn+6p+ZhEhiaLBQehTV9mXhQKCnlnVlzvj7PKBGb+nWIagmFZ5I3iflF9Q4cL9+PQ0QGeHc0uwgkfbF+VnAC95PBuQq32rN9/iN7FKkmLyWlH/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129576; c=relaxed/simple;
	bh=qd4htCK0khVMOChBbrnbti4dbvAOPxPrp95JVEVtiy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9INH0nknFs0Mov78uWDt+A6T1okqMUxmIrMrqUDVWdyV+6HIg6vo56hLnvSE6hGukqEu0xjZw/AIlJUSaTceKs4kOVvnXaOb4qNLdzdctNwLhj9zVSoa4Zn8GZ1LbMplgrV79Vnu07d9dNihC02+YWa4Wc9L0W1sz3svwmQVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzj8Wu3D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483a233819aso12140125e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772129574; x=1772734374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2j0mCsqK2RFrAtvcYatwWJXN0hTJzKqIFFkj8FFAuA=;
        b=Gzj8Wu3DXatAaF6K2p57YiQz/dyT5lsr0/k6efGl3VZuVmClQDoKwgjj77yeroPlvs
         zGZ0GrzyiaT+htafCkOT+N5Br09iKDe/lhZRCg3PvAFtRSIzwjiqWGvoSWtIiV46TfiH
         G1P//mbBGUVHfQfPVnwLWH6yE3ITwTfuI7FepJINmWDjSq4/uyCuM2JwlRyLKWt/iN+l
         2Rg24Ztvhf019/J6sivyM/nRCKegGiiLFK2FTd3RwklrE264mOIj+3p5gZlXJMyNdJ/0
         pb+NdFuvj+G2Jk5PcajCjX7rmCMtFZixZpLz6SLfki1gU8NYfqw6rSYzdjnyaWlANEfv
         Ciqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772129574; x=1772734374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2j0mCsqK2RFrAtvcYatwWJXN0hTJzKqIFFkj8FFAuA=;
        b=xVcdh99QtfDWRjKweC3ivZUURmYBB/AWVMX5bhzmvC/1JX3a30rl7TVB0lkGers+HO
         DOABUyy6pvNWW8R5S1UQp/WgP6ti3Gpb9mCDu7KZoDed0mCwYu8NUOY0dzBb6b9cSj5Z
         P1KuQr5br0uzJNUJAN74gXV60AeIrWj2F3m8+W8oXgwYb3q2rDttBH0x2OEsgUeTfJFl
         14+3JexdIVVywSJBQ5NAa2DhOUhee7teK98i36WsmlmVlomCuPZ52x2jhvh6Z+RNr1xh
         TbNXMskqCSfms6qYqG9Gn3ZRRqalUZDx2mKmnNnqq1eyRSsIS7xyMPcwCxUOsgYX4LGp
         NgiA==
X-Forwarded-Encrypted: i=1; AJvYcCWrhA39GswoeH0nbpp9nVBF59Lc5EhsmOHCVLvdFjU+tP5BEbBhffFME9ul97VF1VQm/f0s8hpFF0atK9X+@vger.kernel.org
X-Gm-Message-State: AOJu0YysPmNkNzA3m60zTiQ+e991aammB40Ok950qd5hWH/u3K8mpzeX
	6c26ojZvdy/oYBEg1giK691s58faQSu/4vy3GSwxrDTCv2wagmO4rihO
X-Gm-Gg: ATEYQzz/Iu9NfDYCIyJDg4978qeZX3kKms4syRTzIM6g2DPhjZz3CVUx89ThPcq2tjy
	yNp5H0ARSoWkJQIibc9mzOxLKu6fmbiGt3EcGME/C7snjRJlSjSlqmOJfRnF1xaa2TowxPk4Y+j
	PkZTo4HYRWkXmEAZp6QO+gVGFGUqYiEkZSw5F3+T1p5Kh0CDeCqGHyg8EZbHpYi4zQtWhPPgGo/
	OuYS8xhLskCdWRcWD36zaat/cAiiCqmoWDeVktoGBbEi8x3hhCvCZHa0uG/s7qS9mphB+RedyQn
	NnD3ypNZPjNdid4p29vcXqbVapNwigHiowAyyapYhvmMKi7lHFkz9YMU4qyYD+nbKoJl3nqQV4t
	XbAaq4AqlHnZ/+Pl8YeCmUiqeR695AZfbMs6uV+F0F1sCtJ14VFEbhN951GoXp/Jpwsc+Z+x4Bj
	yB8vJeHllxteu0/HSyJRaku7fR/3YJzqjHb/Hgm4Hf/tqKY0NCt/nmg48iAsD1uel40ofSyj3si
	Xc=
X-Received: by 2002:a05:600c:348f:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-483c3dd7806mr58474925e9.19.1772129573518;
        Thu, 26 Feb 2026 10:12:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm65498285e9.6.2026.02.26.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:12:53 -0800 (PST)
Date: Thu, 26 Feb 2026 18:12:52 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/61] vfs: change i_ino from unsigned long to u64
Message-ID: <20260226181252.252e68a6@pumpkin>
In-Reply-To: <06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
	<20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
	<06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78620-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,efficios.com:email]
X-Rspamd-Queue-Id: E13CF1AD8C0
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 11:16:50 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-02-26 10:55, Jeff Layton wrote:
> > Change the type of i_ino in struct inode from unsigned long to u64.
> > 
> > On 64-bit architectures, unsigned long is already 64 bits, so this is
> > effectively a type alias change with no runtime impact. On 32-bit
> > architectures, this widens i_ino from 32 to 64 bits, allowing
> > filesystems like NFS, CIFS, XFS, Ceph, and FUSE to store their native
> > 64-bit inode numbers without folding/hashing.
> > 
> > The VFS already handles 64-bit inode numbers in kstat.ino (u64) and
> > statx.stx_ino (__u64). The existing overflow checks in cp_new_stat(),
> > cp_old_stat(), and cp_compat_stat() handle narrowing to 32-bit st_ino
> > with -EOVERFLOW, so userspace ABI is preserved.
> > 
> > struct inode will grow by 4 bytes on 32-bit architectures.  
> 
> Changing this type first without changing its associated format strings
> breaks git bisect.

Or find all the format strings, change to %llu and add (u64) casts.
That should compile and run in both 32bit and 64bit.
At the end you could delete the casts.

	David

> 
> One alternative would be to introduce something like the PRIu64 macro
> but for printing inode values. This would allow gradually introducing
> the change without breaking the world as you do so.
> 
> Thanks,
> 
> Mathieu
> 


