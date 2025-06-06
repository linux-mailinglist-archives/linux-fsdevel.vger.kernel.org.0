Return-Path: <linux-fsdevel+bounces-50840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C439AD0196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B90189D1CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0E288531;
	Fri,  6 Jun 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO/YvlNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C705288512;
	Fri,  6 Jun 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211182; cv=none; b=QvgZEcMN0dnWGttdsBXlwv49LiQ7+ZdgblAkF2gwslA60snHbJAR3ymMysGhk0710IhDvR/zxZ7ZhGYjdnpd/qmSBCgq/ljHLwBttN6oEOHmi7i6BGuyV++G4j3309gSYGGkhiKq79EmJ+38XYQRMf0VGZgf1/D8NuMmcZPjGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211182; c=relaxed/simple;
	bh=NLvxgLiSwmCva350O7nzLbptINcNkO/BdNtdmPgqvHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESfQB6NbTPoye4cHtjPkL0gVN5p72+DCh3zWNBQjJm2mbfd0/38XYmLQn5Awi2UH4y2rUMz4h1TifnCaVrPYnkRfNrNwcJNfq/6mY3tpfcrCIt7GXi4162Q45I+3tl4j6VhdSJkIfA9f21qftim/Dba+r0aIzVI2UCH446Mau8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO/YvlNg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade30256175so46055066b.1;
        Fri, 06 Jun 2025 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749211179; x=1749815979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmUWlsWrraVeinmVRofjXaqZbS/GW/OwgmarsrAe2FY=;
        b=YO/YvlNgwNiLhuYVEHan+8n0QtsLD/8DzOKnI1HbvTFCWu+w3aKa7+udN4UaTef996
         vC35GZpcz1HX5NOb+qaazGB5a1e07yF2xZH4CKV8u/zts0ystnEHTWKXiF2fPWK2dQj+
         U+gp97an2oa+XV6KESBcpyN1o+4f4xoxNDhqMSodKQiDlvoRdFo3CBFGH2D0EC4AoCNB
         XXJ6X3FNbA9RzXeycm8yujV0DWsJcthSpgrImDO3+Kb0XAGp+iGrrSHViaUIIGDF3Jva
         6pOymSORvjbJ8gQfWfSdfjquvoDQNu4TUHoL8OYLft0POL95zC3uNr45FWYFIOdt/vFt
         tY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749211179; x=1749815979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmUWlsWrraVeinmVRofjXaqZbS/GW/OwgmarsrAe2FY=;
        b=txJc4m/ADmTTU99jdmOHRIYX/+5YpG10FG9uk0EJwU2GZcZWI249gAS8ogYE5UWeER
         PwkNKLSC3/g0yTtnjoJmvxQ09dm4FDJRHklXI/UTU886CgSktURugpYeAV89LG+sKqu2
         Eg6xGMUOsoAziIfNXbjZoJV9jf21WHd47JU6MnqcYjtbRQkZQlznW1o8jwJxwSPGfVch
         UN5zJ8bvx5npqT+DTyB4JCcDT31WTznSfbpfrOoVyriXrR9jASlVoJel28w25Bc3wzUy
         xkFFi/qok5Gcb892jv5HyA+2VxnB59ENlGFrdQqPyV+jQpZsFS3XwTqMqBJ1nPtgPJeL
         3CtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9642T8h4sP6twZD3n9NS62+UgLz4vnOT5VFegjloxFq0HPzNmUEpkIJyoxj5dX+eTkh6x1sRxPYXl7NYWew==@vger.kernel.org, AJvYcCUnhN0VFrc7FniG9c0wiNPPATNQFMiwioVpCWfgaNc2qByeynwwSL1B/5e6FE7oFDbPInI96xnRkV+wzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/qGl6NfiO5pT2DzlTm9LkNc7vmESf/0VGb+7iiTB6BzpC9oQ
	h6YZHGTUBnneNkQ9kfzGZ73an52oUr/uaIvuV2pGmQgSOUsyPwuN82dME0uPkMnyHRn7DKFtbbE
	597Yvq+IGFaq/fxYoL1hlytlw+Q2PYQ==
X-Gm-Gg: ASbGncvEyU2V8HP0j4KP6FlG5+Ta0hAVxsVKgnifcFeJTjPAxfKi34447C1vi2oXblK
	F65/zjiFmFOaYMxN3W/+4mjlshbqqJ1QmByaqmsOlna3R6Y9X8qc7Ff/JIhwXD/D5YbmSv+HnWM
	99uW/5oSzxOf/wZEKwXhSHKga2S9by9V1U7/bi+PpRq7EI72HRLaQsc7UygSMr3MbG4up/o/uF7
	Q==
X-Google-Smtp-Source: AGHT+IGuAVhDuKk4Tc5pEPCP/53Ju5rt6SIGT5m4MDH2vNfgJIraGRbQvbTKpI053fLTjcMfMcbkBpepZxUJeBvD3TI=
X-Received: by 2002:a17:907:3f14:b0:ad8:8719:f6f3 with SMTP id
 a640c23a62f3a-ade1a932e69mr253948366b.22.1749211179058; Fri, 06 Jun 2025
 04:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605150729.2730-1-anuj20.g@samsung.com> <CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
 <20250605150729.2730-3-anuj20.g@samsung.com> <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Jun 2025 17:29:02 +0530
X-Gm-Features: AX0GCFsp8juhknUXDp5sOulFNclYQn8fpeoPEV3LFMx8t21OLoGFonqOrOPc3Bo
Message-ID: <CACzX3AujmHHvzBVta2fjrQvytscv5kS0NSgt4iUq-LtXP167BA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info capabilities
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, jack@suse.cz, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, ebiggers@kernel.org, adilger@dilger.ca, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:37=E2=80=AFAM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Anuj!
>
> > A new structure struct fs_pi_cap is introduced, which contains the
> > following fields:
>
> Maybe fs_metadata_cap and then fmd_ as prefix in the struct?
>
>
> > +     case FS_IOC_GETPICAP:
> > +             return blk_get_pi_cap(bdev, argp);
>
> FS_IOC_METADATA_CAP?
>

Hi Martin,

Thanks for the suggestion. I see your point =E2=80=94 especially from the N=
VMe
perspective, where integrity buffer can be larger than just the PI
tuple.

However, since this ioctl is also intended to work on regular files,
where "metadata" usually refers to inode-level attributes, timestamps,
permissions, etc., I worry that FS_IOC_METADATA_CAP and fs_metadata_cap
might be confusing in the broader filesystem context.

Using  FS_IOC_GETPI_CAP and struct fs_pi_cap seems more narrowly scoped
and avoids that ambiguity. Do you see this differently? Or if you have a
better alternative in mind, I=E2=80=99d be happy to consider it.

Thanks,
Anuj Gupta

