Return-Path: <linux-fsdevel+bounces-77991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK0/Ny2ZnGmKJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:15:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6D17B5EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73FF3053B37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13933B967;
	Mon, 23 Feb 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agz2PZLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D933B6F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870488; cv=none; b=pVtiYNJ56xzSfKQjIsTyPUDtXOPsIFEgmUOdFmGnygdzz8rYoOYf9XK66f0HSs5xXw1+aQKoUe6oNQlbrDbhUoEmJLGVCzeMAt/3FQg1Xw/BCgComyiRLDpIBS/m7B7N0b2lACcekq8NjswequpZcNQM3OL/GJ+JOozakBUaAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870488; c=relaxed/simple;
	bh=tQAv/3zlskauj/ooan98LVJu0nulqwcu5uvOfzsodFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQhOaL9cuVqL1Yo3md7VfhR2efDleSDwENLBAAwSdwQTLuxCtxs9nd0vgb3YhfryCUfXxqDEbXJLrHXwpsv5GgOuMbXo1JK1kJroIyPNzozo4a3tZPT/vDJpEzR4wX00mYA3rBFZ23Xh8Gxx0jX3RITls4tCc4wSg/vkSGwOprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agz2PZLb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371119eacso53786395e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771870486; x=1772475286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62wXEeAmAwcre9J7X1M6WSbBKzh96GpDpHP0ppjyr18=;
        b=Agz2PZLbBrPcmfYg0E9lgs4od+ue/Vv5UwW5ZhMfFk+132oN7k+JVAH9dnsSimUqqU
         4OaD9It9U5stySJDldmes85remz7kljy1gT0IwfUMjMg/IPeJrO1D2ruaeaJNt+MOHeP
         9BtSLkH7rYVHvpEbqNO1tBlhC8Gvg+RbWiZs8mfVOrQr8rmIs33cofimRQYTVMKSTgFp
         1LmKCyF/jDcZeeSEzYG+20PV+bvmkQBozkQe8jjRNNbtawvlK+nW4ZsP3GexzyiiUZxo
         ANrZpue+ziidgVCw93s9BQre0fJcilP4zvW7FR4aqa4sN2XDauem0LKoByswWZGYmAEv
         HiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870486; x=1772475286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62wXEeAmAwcre9J7X1M6WSbBKzh96GpDpHP0ppjyr18=;
        b=Irz7Ita4LQ6zkAA5DL9WkXqGEEvvV2ZH48vlya8+u7mY4NtGjL6rYX+6JG6S0deKG6
         Zli43rXOXvqxUJZkl4b/Ge4dt0AduIaf+17viw/MMktFifjPBaDNpED6QO6w8Ro1oH4s
         05qIni5bHEGTKZ1H0/OUS/FpNEFNC9gsc+eAHGU3PKv/MiHTc5LnNcVHFgs3Vo8afdye
         FpFhkhYeCMW7rIeJXJSXPi4pdDKtc1ay1rCIyVC/z7XefU9s++4CVavlRMHpSISrpwHj
         R9A53cQ7OsMxS5lkxm/MNM04yNpfz5TW/3h8q0coGijqjV8o4inFV39tSbFANK2GcTa4
         j2wA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0mLxTy3JYgKmxIN/34TZrMeWLEuBa+ulo7uxV6KNjexwgmRrcxWmRp673K7u1Xof5eytVNiLhEtijW20@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/8WtHeIjhY0XH8BzcMe62sG0nBwzI5Gi8ni34uj1uciazV1S
	e9osF8YFyHW5Pmn4zozypwvMqOq1+bnp9HQEsbBHXM8wAfBuTi0w1Ifp
X-Gm-Gg: AZuq6aKegv8ZlnoWx22+6bp/J3oPUxkg4CHQzlI4rC5T57nlnbRhAR3zy+wUdGz3iHH
	CJwtlGbVB/HQ/+k7UlGQ1VI9z6uSeCRidnrews7PgRIUBAlFqp3OGnfaaV7ARc6F/22hCicz+hL
	VtOSUATwhFEXWE23Um07PpR5ZEvr+qmDzPLfYUlZfBtHmYG7H4WWWlgnYKV9G5z53rnq+5k2pHI
	q+XxX8/Fy6OX//Y1TL4i5kW+p4Wm7bmysFs7sykOwcBHjsi6vXs5DSSapkn+qDffO01Xu+RBGO+
	Qy4lkUPT+t9SqnseaJ6fKODzAuz+6aXUuJZTCKqqjSxRA5uYHFkecDDlXoRPcy7LghcuVeT9hjS
	fchRXUafkSgwc3Db50JEsZ9FdLOZf6YaPnKvoqfo6cExkgEgkqQm3eaxfEmokjJMxNgHU84vNxF
	BjtM7C+K2wYIBm93y2FCSrQP0OLy5ejcu45BSpM9f/gR1kOkX4pFCJG3PWsu7HCzsQ
X-Received: by 2002:a05:600c:64ce:b0:483:498f:7953 with SMTP id 5b1f17b1804b1-483a9637a6cmr144594245e9.28.1771870485658;
        Mon, 23 Feb 2026 10:14:45 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b820f718sm1428145e9.5.2026.02.23.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:14:45 -0800 (PST)
Date: Mon, 23 Feb 2026 18:14:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <20260223181444.1d87e3a2@pumpkin>
In-Reply-To: <aZyI6Aht747CTLiC@redhat.com>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
	<20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
	<aZx2dlV9tJaL5gDG@redhat.com>
	<aZx3ctUf-ZyF-Krc@redhat.com>
	<aZyI6Aht747CTLiC@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77991-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47E6D17B5EC
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 18:05:44 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 02/23, Oleg Nesterov wrote:
> >
> > Sorry for noise!  
> 
> Yes, but let me add more (off-topic) noise to this thread...
> 
> pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> makes no sense because pidfs_alloc_file() itself does
> 
> 	flags |= O_RDWR;
> 
> I was going to send the trivial cleanup, but why a pidfs file needs
> O_RDWR/FMODE_WRITE ?

Or why any program that gets that far through the code 'wins'
write access.

	David

