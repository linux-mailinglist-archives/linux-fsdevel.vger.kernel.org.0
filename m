Return-Path: <linux-fsdevel+bounces-79126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFQDEvqlpmkTSQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:12:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC051EBAD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 324073028343
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2738C2B0;
	Tue,  3 Mar 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6gbYfiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BE34253B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529138; cv=none; b=JmCLfKOgdtvGfV2who9HPzj7uEBTXpqffjPhE4ohPL7Did5UjStQiUR9FOMtz//+ysC/DSgfaP/UxWLLWwcDMmrv/35fm49qCyT7szJ4zN0CuLeY2oTu7l77SJ7Q0UwnYByExwZkCtdTuQPLK59istvX2zam6Rzcqz3Sta9vYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529138; c=relaxed/simple;
	bh=ECc7z7tsidz26oiQwOHWeZRLOlNbNjwxKg4L1JltJrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7dL3ZOI4KmL15mQVAqR5kG0P/a7I8sdBrmFuXjgVNbcEgh1FoRalfXKXmOp0KzKd3wVUPeXk6Iz558XoIvdgryK3tHd+PCr0M9KnCv1J+FE4UVrN2+8qeA68N9oZsKdiHBvKV2jfWJrwCWGYVFXMzq1WPtGLY9btOFr3xVkzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6gbYfiq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso48849215e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529135; x=1773133935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=D6gbYfiqZ9Rub9Nna+8CpTbHrvLLEBybstalgCCNYJt05H5XiJLBCCrkaJmEVbnx93
         0DeEZNj+JuPY305863XQwrg2W5OaLpXpiKDVn7ZgSmmvWJfk5840zZpwrBQoxGsVLr2V
         941nJYizTDY3i1Xx5kR8DX5eJuPf4xhvBWtjtqF28lloXnh68KfNtDSQSNkBBUKoUg/y
         75+9TOCLECMjRUoh9+A+fQk3sUCtJbO+hb0c3+hLPph8RtG3OlD/lEc8gK/my+ranH9o
         rvHNfk2gUF1JF9rJtRS/8mjTju073gBH6L927ZI6BGkoDsfJfUfkFC99zJXs7W7YsGdL
         7UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529135; x=1773133935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=TRB97OsxJ4aEgUjh036i1dXT6jkcPvx0PJrR5Eywuv7VL2c/OlJhIK19yEHpIH12W8
         TdQYgNMNPtvJurD4hYe/bxyUI13Vz32df1/Cqpagmm90SgbE6EE3Xbw4CxyDItLOoXZo
         TNVSAM52zdLswgU46k5z/MEwx7VLiHMyCce1ZPn0CFX+oRcFUeq1l6FDIckFMAXiMr/5
         PUzFe5NC/5UzSTiN2NuTlQqBGtunMPXFfXaVyvr/BEju6qf/82cfB/q+IAW5RWIEWrx+
         u890ueuwdn04eqDW3rbhM1L4uwQCBQwMuo5OnsxhHqGIyRS56lfwOFvLDIXy7VjICgRj
         fPvg==
X-Forwarded-Encrypted: i=1; AJvYcCUCURL6TtBVmAckTXLCRH3Ik9zDJPE15EtHn73krLP2HIBVx5Ko51TN5ApJxOIwlWhMN55Uj6BeFtmNUDwI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjbqh8uT29gSIwq9hrHDpLtaTDiheuWtvlOTXQqdVAAM+6GYaf
	lDyQefuH8/msDsWIW/nJOj0XuD2JI0QV3FGLrHbz51AD2GR+48kWhjRv
X-Gm-Gg: ATEYQzy5u+fZjWn/w91Yjd8gYurTzrgZpMTIX/Vve2Cxo5DjoDF6LrGLAhAuIhi/sBD
	YlZx1C+kIE44n8XCfVAy4aIF4UCTK7fm3JCj7nIwXwb9o1z5zg+2Ui6u2n1KrjSTaqa2KqSLx31
	ShcNBXLuGC69wcrhUFIKldg7iArd2M6vVFhAbbNoCtas/4kWbqIbO23Zs7NbBLvphSnxsjO77X5
	4KA2sJteXppAR4Q/X8vq9Ltrxw9w6RUR4iXMrbAOUT+IrPSs5X76K/EuZX7DyI4BpZcTBOshSkS
	sJdt2WQiZp3CXu9h0hZdzVUn95MKkFECcE8DpepohUMHBYpsV6sLHuJQPfIB2Gj9dBc8/5AMHuB
	A7d2+styAlZjaRhkHB/hXFG1mPF1qTFYOnJSSHF5kruqBUiLb6N7Y3rCqRVuY211ySXB3ocyrM7
	a3WKeXYp6pKxg8bLqNKNESZanIXYaMQFCeSnsZia9nEjXgbrY2tV/tEnwb7fbe6g+3
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr280473755e9.2.1772529134880;
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48512692c14sm13045615e9.7.2026.03.03.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Date: Tue, 3 Mar 2026 09:12:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner
 <brauner@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara
 <jack@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in
 __scoped_user_access()
Message-ID: <20260303091212.620241c8@pumpkin>
In-Reply-To: <e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-5-david.laight.linux@gmail.com>
	<e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BAC051EBAD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79126-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,infradead.org,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,gmail.com,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 16:00:26 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 02/03/2026 =C3=A0 14:27, david.laight.linux@gmail.com a =C3=A9crit=C2=
=A0:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > -Wshadow is enabled by W=3D2 builds and __scoped_user_access() quite
> > deliberately creates a 'const' shadow of the 'user' address that
> > references a 'guard page' when the application passes a kernel pointer.
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com> =20
>=20
> There is a problem with this patch:

(badly line-wrapped errors deleted)

It seems to need gcc 12.
(So Linus is in luck.)

Prior to gcc 12 the #pragma generated by _Pragma() act as the
controlled statement of the for () loop.

Trying to put the _Pragma() inside the for statement doesn't work at all.

	David

