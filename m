Return-Path: <linux-fsdevel+bounces-8187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC4830BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FE3287B71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD98225DE;
	Wed, 17 Jan 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz3ZGuPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACB224E2;
	Wed, 17 Jan 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511841; cv=none; b=KMRypw/eFm7U7Tpf1ICFA1uMG+GD/InSGq6UL5H/pAP9Hl2xdfCsmUu5yW2fa2I8HyoPSugGKYlAa1TM/KlHbYdLGHM3LFfqiWnX9cjYGd2rG5OxVImFlXwdINkOeH0DGvSkzb5jO3icPEUe7AMwv5CkEwYvuWyGsJRkIzqRf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511841; c=relaxed/simple;
	bh=ejjzp/N6GXN4bKMnwIhWefZoBsy9/Ncj1iYqg76d+58=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=M6qspfOgsXlC04t+N1b2F64eQm6Dr8Ow63oA8yNVqRXyRZUBYplDejbMHfZYH/E7jDyIH8oZorTLObq8ZilYvTsBvVOe5EQgNoqz1i/3Kgj7tZYI/QYJbRxbgPB9+JMq4hRSFo1ZkG7kIAH/RcGP1t6lwH/+tFsVi2F9iuR3Zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz3ZGuPF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso8894851a12.2;
        Wed, 17 Jan 2024 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511839; x=1706116639; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSQYgrBx5fi8DsH2MSKPE2LLO3oMaLJBOPol1630iF8=;
        b=lz3ZGuPFXJY9Un1zMmQ0Fj8dEg2EOOVA1TLPeggyGfky/IeF08RUe8w6PDo4xyPKDK
         NksAdoc5L+gkqL30SYcHFepJYmKYN7Moe/eseUPaTAvhp3rxRSKuoxnmQY9Nb6uwla1N
         0MtV4pfplvXh+AApg4IRW2Rp3FTfBnU0mGVS+EB9kaVSjQWvB4L3BYI1r96v2v3UGQ6o
         SzabGSQVB6HeJWeg4bIN0y0ObizMzUGV2IzDJBp7rDtKAe15R8u+dHd0DDk2dMiPfJOM
         fwa+p0Zu7hbqMpCCifGMo92VdeFfnRHaEzSVugqnHFiATzPAM0N9+fyKRbMNe+aGLRLj
         OWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511839; x=1706116639;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSQYgrBx5fi8DsH2MSKPE2LLO3oMaLJBOPol1630iF8=;
        b=mphvV957IBUkLp00zBWyC+I6mrSmj4Him2AevkC9+MgJxTFRXAE4G4kgnSpHU2k4mC
         oPQ2FhkX5h/p3y8o0b9zkBNqh3mIkVKBa1HwLHpcL7yTyd8ekzgw5qAsye3SaeaxZy5W
         cjk8IDjdYvFsx+/INgl2FWXEq/IAS75zzcd0Eqm6dlyXIQfQKHlDsBv/QluRPTq2Q2sl
         eUdA0hS5le2J4qRdg8sknugmQbURHmKVD3VNDfavSFYaljE4wnk1wqQNhXWXMBCEnbfS
         /SBi2iB0RPD/lPyIBroODZoTx0xOtp86fAYJkkdwbOZq6Q7hdQ4F0dyMPCrFOccRyRdG
         OINQ==
X-Gm-Message-State: AOJu0YwTckMRqRlKQRrgOOBktl5cCxlMZVBWmBM4sqYdu7XlolcNVJuI
	n6hFsybg3MeDRMNGcFTfPYk=
X-Google-Smtp-Source: AGHT+IHZLiEhkAGCO6fxuR340lb3hy6gE48f7FNrKp4J/ab4F+00vkM6h8bDVacvwPY5snvCFhrYLA==
X-Received: by 2002:a05:6a21:a597:b0:199:144b:e205 with SMTP id gd23-20020a056a21a59700b00199144be205mr10417656pzc.99.1705511839576;
        Wed, 17 Jan 2024 09:17:19 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id jw10-20020a056a00928a00b006d9af59eecesm1685787pfb.20.2024.01.17.09.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:17:19 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] afs: Fix missing/incorrect unlocking of RCU read lock
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <2929034.1705508082@warthog.procyon.org.uk>
Date: Thu, 18 Jan 2024 01:15:02 +0800
Cc: Marc Dionne <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D21C0923-8182-43A4-A3D0-0DB9DC07F638@gmail.com>
References: <2929034.1705508082@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


> 2024=E5=B9=B41=E6=9C=8818=E6=97=A5 00:14=EF=BC=8CDavid Howells =
<dhowells@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in =
both
> places before returning (and not lock it again).
>=20
> Fixes: f94f70d39cc2 ("afs: Provide a way to configure address =
priorities")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> fs/afs/proc.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/afs/proc.c b/fs/afs/proc.c
> index 3bd02571f30d..15eab053af6d 100644
> --- a/fs/afs/proc.c
> +++ b/fs/afs/proc.c
> @@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct =
seq_file *m, void *v)
>=20
> if (!preflist) {
> seq_puts(m, "NO PREFS\n");
> - return 0;
> + goto out;
> }
>=20
> seq_printf(m, "PROT SUBNET                                      PRIOR =
(v=3D%u n=3D%u/%u/%u)\n",
> @@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct =
seq_file *m, void *v)
> }
> }
>=20
> - rcu_read_lock();
> +out:
> + rcu_read_unlock();

What about using:

	guard(rcu)();

Thanks,
Alan

> return 0;
> }
>=20
>=20


