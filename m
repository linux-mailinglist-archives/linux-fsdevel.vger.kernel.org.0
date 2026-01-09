Return-Path: <linux-fsdevel+bounces-73060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC42D0ADDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA17308E9A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A84828B4FA;
	Fri,  9 Jan 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UEOziobB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8D35E537
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972038; cv=none; b=LDGi4LEeNId/CQBFSA8U2YN661Wu7nlgQiBa4TD4gNHA3/N81iVChiTBVg3I6r0P23lrlsWpvHbiI1gc9Z24a2qLDOwohSE+cqV9chW493JpnrMqeZEngiTja5Nb3DThfMxJe0hTekgojpJKC5JJBJ8qUpgSd997bAJUBTASVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972038; c=relaxed/simple;
	bh=t0M918K9SVLyelsdKL/u/NgMO/Qv4Dolk5CY8Pk6550=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcOAFOxwS5lQ34odBLiQoyQIl/ZX4zE0v2Qqq8Glf5NzetvT7RqnUcXTVFMgDSdqCtnUijnzvv1qoutbIcofBQXkJ7a1QwUEJhp5rnBFOAP8v2rdukFmXqch+1UoYKgSUMyHs6c5JBoFLmjXQVPDBCQR82NThnjNoU75Zlnl7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UEOziobB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee1a3ef624so26592631cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 07:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767972033; x=1768576833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YcYpDoQkf6OKdwa34GPKr9MIobLa4irju6kImnykCbY=;
        b=UEOziobBXpeWHqcnbvg5cu0zhikyq7JcYUXaVj8b8kl3rqTwHKqe/2bhr9NIQDlEbG
         woVlgaT+EgiteOl7AV0Li3rXQ2b8T0uV2phMbut9kip7FyiLgexiFtc0bdonYLZfNFoW
         qVfEInXY+JBGHYfdHizDEiMJb8dhVVsKVL8M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972033; x=1768576833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcYpDoQkf6OKdwa34GPKr9MIobLa4irju6kImnykCbY=;
        b=TEiUnu7duKstGHP+LfCHY1tC+XWtIdtjCO99keCQourtDEokQ1qlOU0EBD36TB1UH1
         zf0VOmDaJmgtxF4vTbRje8WELcJChEwWreZUSIVbxOwPlM+lMmp8hO8RuGw/aeic1BAp
         SDy3Qjl4YC1MvaG9iksdSgQSLv7cezDTSVCU9iUFv1ayuTjD6hY0SIlm5au9G29EA89T
         BkUtDFRMJzWVIPLW97spBAXlGFhiwYA7qNey8gaPP/AI1LJyc32caVA4M+wgqWDg9tE/
         mezcG0KXVMQTEfpZHXOBaUlujWnWryHUHrRlJsBomXUI/zj1XNw9Xfw0PbENqVt6MKTa
         YjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzPycHGqZwJUsWYS11QcsrWBaINGoTvlDeEvAECNREYmGZIz4tcK+Q3djwb8/mBfYXFYjlJaKLZq5BqWlM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2sgV9HViDxGR097G648jDLr31MPtn+Wi4TQd4MMeFAOH7lG0
	IiDMbMs3bUIs+ACxCmmeUej6kdb+6rsbPdbq8ICBsqrUSIKYK8rXXTzMlK4LxeDZ8jmYCfSS+CR
	q9fQSRjRn5AY8JNqcWfdD2r9YnYYodM87uya7r5cdnA==
X-Gm-Gg: AY/fxX5hUXEOP3tF8iDDNGdNjsYpBEbiselHnbWMUad4AKzRIiXgzNYykgsiqyNm6U8
	thqH2qjkxZkgqid5JWnVO9mRiEjUzPEVzFf6jry7aIXiWnpWSoIK78oD9KJSnDAM42Go20sSkCd
	lQOGzpGDOOaKHlh2LSJLlaE60mo+GrVCHAHNWZNXZfftev+ITE8YZZ8kDsCUzE21W4B6DVq69uP
	mtswJri7j/z+ni2UDIE4Z6iMSNPUXA4U61u7bx1qg6urANNXY6jaUhOEDl2Zrt8mrxm
X-Google-Smtp-Source: AGHT+IExD+zog7XtALe+us8rDRDLzU2jZJoXkIaFcPpMDWQeZn9nkARquzs6fB9TluMjjJ/JttzHLAT5wJ6zMPU7kl8=
X-Received: by 2002:a05:622a:5c08:b0:4ee:3ece:a652 with SMTP id
 d75a77b69052e-4ffb4a44eedmr135408551cf.42.1767972032753; Fri, 09 Jan 2026
 07:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <87tswuq1z2.fsf@wotan.olymp>
In-Reply-To: <87tswuq1z2.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Jan 2026 16:20:21 +0100
X-Gm-Features: AQt7F2oGYtP6NNquWwawugC-ZB2MGxMjFyA4-T6COPWwPFmT41svigvhBAa74no
Message-ID: <CAJfpeguMs60OCWvKRpnSizCLHKxYp+DFX9uWgqpWBL++0iwSqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 15:45, Luis Henriques <luis@igalia.com> wrote:

> struct fuse_entry_handle_out {
>         uint64_t nodeid;
>         uint64_t generation;
>         uint64_t entry_valid;
>         struct fuse_file_handle fh;
> }

I'd do it this way:

struct fuse_entry2_out {
        uint64_t nodeid;
        uint64_t generation;
        uint64_t entry_valid;
        uint32_t entry_valid_nsec;
        uint32_t flags;
        uint64_t spare;
};

and the file handle would be placed in out_args[1].

> I'll then need to have a look at the compound requests closely. (I had
> previously skimmed through the patches that add open+getattr but didn't
> gone too deep into it.)

It should work as two separate requests, just not as optimal.

> And then the extension header would be created similarly to what's being
> done for FUSE_EXT_GROUPS, using the same helper extend_arg().  That way, I
> think we would have: headers - payload - extensions.

Right.

Thanks,
Miklos

