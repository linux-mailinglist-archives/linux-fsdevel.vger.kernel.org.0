Return-Path: <linux-fsdevel+bounces-8188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C43830BD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F21D1C216AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF222EE1;
	Wed, 17 Jan 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaHc4hYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53791225AA;
	Wed, 17 Jan 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511842; cv=none; b=YOC5ZAP6vubbg4KhDTMG8/mHSgrZ2E+6u5sk82oh5r0+vUI5gN6BtMUlmizL7XJ6jMhY0sTn5Wz80zK6hnb/7HKGVl+KFPb98WLwkFCpmlB0Bv3eBsJur2oRs+gaDMt+z0CapYAHqVoJxEadFKWRa6rZ44vZmHHPQ5+XONSsDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511842; c=relaxed/simple;
	bh=ejjzp/N6GXN4bKMnwIhWefZoBsy9/Ncj1iYqg76d+58=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=U6Myn7eTDnErKKIE9rmnICr3FTBA55XgMVdDt/1ynwMTkkf3RsP/fXujkXohpB+FULGlqQJDF3qSD2Wmi6a8MbD/j10SW9AZ4wQRULeXcwu3ei+cFSqeBmp3u+/ul6OD/BWk9cdN+NaXWbuPvL1WvzhQ8FOvNdJyJziPboGyBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaHc4hYF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so9618144b3a.1;
        Wed, 17 Jan 2024 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511840; x=1706116640; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSQYgrBx5fi8DsH2MSKPE2LLO3oMaLJBOPol1630iF8=;
        b=eaHc4hYF16m7O4UgJrzS8kKbamFWUPlGZeby0bxzJj5hFr3zxxqhr/12REjNdck62D
         4HDHq7BgBB9Q7uh+fab8sVUuE07it9XeubQMriCkq8ZuRfcMEizw9XoFYXW2QESN/mAQ
         3MfxixqBRF1rG5hs888O3UErtUMWPZ608Xgf/e26kIx6xnpJm94aED0Z15Vdl6TAhDHq
         3SpoiyJpraJd072FR8Lx4Q011PCIDHyWTFgJ1CIzy2Et34VuFPoRA2mNYropTHgJ87HP
         rfqTC1ASkKoOWlQt0WEy8HzwTNi4GN0H6dYoMKBHeTalGW35mGkb8GM/Wql8Cm0R2Uxp
         xK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511840; x=1706116640;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSQYgrBx5fi8DsH2MSKPE2LLO3oMaLJBOPol1630iF8=;
        b=u5JHMg0rKTYRZ+bonTWNr3wjT/vzuX4j2TQEy+Uw0TH3hZdE7FQyFr5anN0ny3b4cE
         njnJNLBZeJLaFI3f212rbUdM7H07TeGlW12H+pDarvHiTv0885moLyj+IpxoLAsaNYlJ
         xLnxVtQ2CF55dfj+nKScvGp/ZotpxQGxsjJWMKK9pdYEgnalHPhzIcRhfgvHOYY49h4L
         bK2oE4xEDQ081r/83sxu6r00HzR4dOOJr25Te20rFPQl64DmkQx5oazZZyTxXqSCMh6Z
         1FEND6CZmvndPMrn0R/MwHp5ngwvItjf0Ii2Dl7WXMSWzYY1liW6wAN603SG43V0VmnD
         cPuA==
X-Gm-Message-State: AOJu0YwqJ8CW9ouEI+epYhNL6UEkkksa6sYqiqhYqtZUjqdpyTlV2Zny
	Cm3zHvN1MNHc0svle2CO8Ch1b9YbLlc=
X-Google-Smtp-Source: AGHT+IFWTGb9xYZFECeXFelpO983ecVwxf3/NuG3OaByNzdfXT3Bicm/R9UBrTHf/Ukswbi9HSryBA==
X-Received: by 2002:a05:6a00:10d4:b0:6db:7038:fcc1 with SMTP id d20-20020a056a0010d400b006db7038fcc1mr9849124pfu.11.1705511840490;
        Wed, 17 Jan 2024 09:17:20 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7984d000000b006dacbe57efbsm1742854pfq.90.2024.01.17.09.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:17:20 -0800 (PST)
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


