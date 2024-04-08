Return-Path: <linux-fsdevel+bounces-16355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1489BCA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42127283AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C052F7E;
	Mon,  8 Apr 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="MsQeusz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4871524D9
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570691; cv=none; b=tln+NqeydByPGCKVACDcr52uamBVEO/fQi/26wv++EHAihSZD7jrH7RLsJJqdA/2VAwba3tPM5yuKaVp65lXYDjdtT1tncMPYtaSKHcmlHVtvn7dn27egqZxybCSvFhQDQiCOFqRyHlFU0Bkuu9zo+JqoaR86iVj59PAXk4lqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570691; c=relaxed/simple;
	bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jxnW2zMqZPFjgXRJMBKyarsQ2kp/x/C6Xq8Wp2ZJKtor/FBlT7o60HqvjTL0RAAnfVjqaSDBmWUEr0u42Ml2sq3Eq4aIBWdjzWyl3XnFy4kaZ5qRRn9GQ2DDyHSaqQxF1hPgIboHIOqY3DZymzbIUSlwU9QQ728XlMGICio5sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=MsQeusz7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6646d78bso504600a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712570688; x=1713175488; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
        b=MsQeusz7E8s563WyEiqyVREI2y/4W/rKdYvH1mAfhft6xwCelgS3gJtr5tX41j16U3
         ONxlPl6+QpdbeFydnZc5HcrQiBC0WSIKHaqulvp5XYr3y3zNCtWpIidIv84e/22zgefq
         Kzf4WLfQvzCKY0vQKiOJfuxNuBSLWaGaAESU/z1z4bNkTlx/eytlIjWBPgxPMY4EtdZp
         ktYN/9hYfn4CJHFjKaBg6hKkoQZeya8ODjnHGWtzGSnasVsg+6gxW582LU5tR3B8yTEo
         6shUkF6srpLlb6QKVs2wN2NmYtYC1yaq5eqliTVYkY3MyqifQojrx3eCRXiNmmxdvQh7
         G/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570688; x=1713175488;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
        b=oq9hJOg8Gpr7KT6H+kiYcmU398e0EoUNvfEybdNDLEP66J5UDok1LjZFkxkvhTuDdy
         Z1M2aK+Bj6y2/rodkfe4X40UBNUW0eIWqCxOvkh7p3VPXm1RgtiFCzM4tnjXxPBjoITH
         QCmeWu6tNijRpZAlSvWmmN7CQTVfPamHlTPk0UwJMeMDk7pHjVq73BrfO25u5gEsqORH
         jmo5ccYylOJt1YqSaqLyRtkF6LE41nib2z/uOpPP1pXxhw7Xi7yaluh7NlFNNFoiq+64
         HM0sA42SkMFfbFZ484XMponUdACuDAbDcjCdRkLaw3JFbn8ltr6upYhSXrWzFyu255mG
         gY6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlbCb0OJkHuRBDTrE1Wh1mxsDIjsg/L75bPB32dmpMSzlNAvSO/PR05O8BNCy3LUbwXIoFCEYsyl/vzZoporHf0OMPr4Bew40NsGQpug==
X-Gm-Message-State: AOJu0YxBov7b0bM0dZH1ObWrClsKeCU35XBAqf5Mcv3G2w+CNQOlo/Wp
	K0S69DUNPS6+KS/X/Krce5BT55WB1Fsqiq0vlQSWrez0W2MH+wdBS9R77BMg9G8=
X-Google-Smtp-Source: AGHT+IFApRzGDXPEnWJrIkuXggzqiy7GiiA3NwloDSeO5yZx0JiS9EZ/CR/qAyApezteLvp7g4NGuA==
X-Received: by 2002:a17:906:7316:b0:a51:d23e:c53 with SMTP id di22-20020a170906731600b00a51d23e0c53mr2191454ejc.31.1712570687880;
        Mon, 08 Apr 2024 03:04:47 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:bd98:da4e:9b4c:75b3])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709061ec800b00a46d2e9fd73sm4242441ejj.222.2024.04.08.03.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:04:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
Date: Mon, 8 Apr 2024 12:04:36 +0200
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AAAD718-D1D7-416E-87A9-3CA2BA20C93B@toblux.com>
References: <20240402101715.226284-2-thorsten.blum@toblux.com>
 <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 8. Apr 2024, at 03:48, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> Looking at this function definition:
>=20
> static inline const char *str_plural(size_t num)
> {
> return num =3D=3D 1 ? "" : "s";
> }
>=20
> It is wrong: num =3D=3D 0 should not imply plural. This function needs =
to be fixed.

I think the function is correct because in English it's:

0 files
1 file (every number but 1 is plural in English)
2 files
...

Best,
Thorsten=

