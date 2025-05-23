Return-Path: <linux-fsdevel+bounces-49789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447CAC28AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2181BA5E34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A02951D9;
	Fri, 23 May 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvGVPBJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2781749
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021573; cv=none; b=c5qyK0L/F5DzMc2vBqqSZHGOt2dgWvgkZ1MTUKrTsSOu3NwH32fJ+76FITcvAm9FruU6ARCzrKbXZau20bEDtY3tthFHqRTYdt6CMGxSg245aWGQL1msnLE+PKXe1NEOV+Sp4R7qbWTZ7aKTIw1uSAiJZoR5VAuJlNkimjnsayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021573; c=relaxed/simple;
	bh=lPD35zujyKAUWqfHry5EYRDdZKEcfN+I+m5/T5gyTOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMejvhFsj6OqyD+cQcSuAUpJPTp8kiBHIiXYOLUR6/nFQplFn32OxIRjGrz61SQBuxH/NAkJCjZNrvIXBdmTFfNHkMDIGUEE83sHjYPc7hafuw79uLKhsRBVLuoNcmcBHbE5YZ2pbPNOWDZayTYPYgb2cl+KiT/eUO4x+PodOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvGVPBJP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c54a9d3fcaso4233985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748021570; x=1748626370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjnM8on5voW6M0QCUcTIEhuZftpLqfuu3XEvaVJGn1A=;
        b=OvGVPBJPPas3n2t59Njc9KPt2Klm5E6b+OqiWDReb0Viah9XU3NM3j0IvdwyorI1ah
         WbX011Kc288YhB0ll1AM6AlEWJLsdw0HxtnrTXdabOaA4PU2ugphJSdJBnZlVTKVyG2p
         3xILCZ8ifCUj/ojQPve46iMhgyqIi+9UErSBhKeDWhi/NMMsCVViVgL5sL83RJA4JYSz
         rvwzJKbzama2/yK3SotuudVfYu+oWta0E+eHb8VwLuW0iY4ExdzIaE6q1Dum+Tty2cms
         VBv8jYOvR1Grs5yGOCYMPyOyILTCsLLD/bmIMR5r1lbuRodj/03LvO9sUnP6ZC+XlvvK
         ZPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021570; x=1748626370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjnM8on5voW6M0QCUcTIEhuZftpLqfuu3XEvaVJGn1A=;
        b=qpOF/uDZgRMtaf1wH4mWmkpjl9yOAX9wLxxP9LIlxKsPlSvFRofH63UzS2fbiFvD4Q
         uVGevPQScpQUI7xQl3+Kt67kE2PY8ed6SGryvrmlIJyUM/BmI3osVEGMwlrUWKdNZ1UX
         MdlNierNcC8q4nA9kUqq00aGckOB4RJGxr1dGQrReHEXpNGJnaQ8SYD2Yosx+mJYC6v+
         Nz6JqwK1IKGJihJ3EoUEXd0j7fEPD5WB+mAYiMOWHYhuV0tdLhRa9CfkgDgSsmolMKt4
         cC27zhMPZ5KRvmjE3BfwVH+zdxCXa7J4HexsHOTht92yCuC3jXSoZxv3la7OpWspvnRM
         fgvQ==
X-Gm-Message-State: AOJu0YwtiSP1LN0U51XnKejtytCDtoyUETzUg7pQfcwFTrfATnr0uXWF
	tns08gJe25cVnBSxinjk53QPBv81o7VV5fBxSO32r+iWkGZQqy7JJLj1Hiu8zfBBTpn3YyBoTs0
	vCr2TaFELqXC/TC30SvgrWAtGAajsYKKgsg==
X-Gm-Gg: ASbGnctDdDPIwIe3Fcwnysu4iIQjxI5WwUeNN4rRBT0O0VrxMAj+jvUofXLuViITfr4
	4yJ9n/CpnGG52dW70G66GP53RKYGeEIfM5pC6KG3303etox0bApFF0dEapHAb2MVTVNnPzCdUWs
	e7G7wFMBzslgXDPl0J2OZ5S130ls6O/xiD
X-Google-Smtp-Source: AGHT+IFlW3ogc6Dqo3SbJbcgloGVGBYjb7c85CfOMWM0fOzM3CmBdEcoOAzOxlUM9qeKhUaan41ixQj/DEAdjO+75UE=
X-Received: by 2002:a05:622a:114f:b0:494:993d:ec30 with SMTP id
 d75a77b69052e-49f465595d0mr1076841cf.16.1748021560365; Fri, 23 May 2025
 10:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aDCbR9VpB3ojnM7q@stanley.mountain>
In-Reply-To: <aDCbR9VpB3ojnM7q@stanley.mountain>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 May 2025 10:32:29 -0700
X-Gm-Features: AX0GCFtID81gREf1w5rg0m6busMra1EtFLymFFqeMqcHiAaR0Cfh08YI_36CUEE
Message-ID: <CAJnrk1ZBOw4RwrGRZk8Qd+vDXUEF=O9NC-TSpS3Cs9rhNDAf=w@mail.gmail.com>
Subject: Re: [bug report] fuse: support copying large folios
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 8:59=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Joanne Koong,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit f008a4390bde ("fuse: support copying large folios") from May
> 12, 2025, leads to the following Smatch complaint:
>
>     fs/fuse/dev.c:1103 fuse_copy_folio()
>     warn: variable dereferenced before check 'folio' (see line 1101)
>
> fs/fuse/dev.c
>   1100          struct folio *folio =3D *foliop;
>   1101          size_t size =3D folio_size(folio);
>                                          ^^^^^
> The patch adds an unchecked dereference
>
>   1102
>   1103          if (folio && zeroing && count < size)
>                     ^^^^^
> and it also adds this check for NULL which is too late.
>
>   1104                  folio_zero_range(folio, 0, size);
>   1105

Thanks for flagging. I looked through where we call fuse_copy_folio()
and we'll never run into the case where folio is null, so all the "if
folio" branches inside there can probably be cleaned up with a WARN_ON
check.

I'll submit a patch that fixes this commit and a separate patch that
cleans up the if folio check.

>
> regards,
> dan carpenter

