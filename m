Return-Path: <linux-fsdevel+bounces-62034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11246B8209F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E164A3380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6D30C63A;
	Wed, 17 Sep 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V61z6OaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B30E83A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146064; cv=none; b=A5JvGNL0mG396zM1RZ10wfC9mCbJQFZ+M884Wu+Ic/jGDjgr1F8w1pJygbwHPeyeqxKvcC/vTPEqlVo5gFwtkaDWa827inLsBd8VLa1c8mwd+2L/P2KcTCeGiiOS8IUz9A2QdqaryqL6mHPxbgeoPYAu4YIwngCPSjGS0VXbNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146064; c=relaxed/simple;
	bh=dnV2B2wqRFCgH/cdihnqismdKFVf2tJOPij7DasM7fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9rlAqXIZvZ3yB0wwDRkF7STRCnr83Pv+jPDIgTJ5Y6ShKemoNoTfgfXMDhOhw2OTIwUgyfCT4jlbIRXGVQHxZXFV+1y9Bo9qVsyo7pNIoXFkUNFxOxriCFSCGlt5ePy40a/2oa+c7/HvCMwe7AOE9SJw9DI6vXXLAW4XXiPQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V61z6OaS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b79c8d1e39so3599391cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758146062; x=1758750862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnV2B2wqRFCgH/cdihnqismdKFVf2tJOPij7DasM7fE=;
        b=V61z6OaS/2R/tgaS6yfJtz48Y+M3TsCTWj23/iSwNTeYMtw7qSyO0G0pMMpLpAOPm6
         rV/yIr+TQ9Nn/zYD4GINOU9HTJy0ywMcjjqmD2mB8LDNDSScioHfvRoSUdlFAIqsghjj
         zIFn7NNAqwpzHdqVFXe9iqB6QfySea7QPqT/fvU6U9xZj9Nz0QpzMCDwPxTTUTM6l+e4
         Gq7WEGoD7Pmhgo6CcICwSUcpkg2+BUSFOLiEeaS4EBK00SLnLvYKPjrOnXx/J4BjcQqV
         oXr+3UmtGpMiFfuPXnYcZMv3hvZhuwuF2LyVIcCRplAvZaYRCpbf3Gz2hZ0Nu/11q8Nq
         qECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146062; x=1758750862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnV2B2wqRFCgH/cdihnqismdKFVf2tJOPij7DasM7fE=;
        b=KdEum4Ty8br5nz47+MxG8UWgwSpO9UqDTvhNbaCH+pXylGBS9qQfNJYhkDYeybB98D
         6SJh4qA0dtHFxfHvQWvmqYiMNsLj6A21w9/22onVIJXpeaw1yc2Pk96U1b01ugRhROAp
         KxBPoaPsXnjniu1hvu6ITggBjNOwr7PV0Cd745lznQfgNP0zKAUoj+4WB43IAE8kjYQ7
         0dE2zE5CF2LfKAr2qmOsGOqXQO3fHd/nLMwDF7i8KYyEm2EuNqfIFpZxyMElhmhXvLdG
         Y+Ec03XAGuHmdqOGzX+Bv/TkDX+UvkPTbbkgtkKjVBeLONxicStrBFSeVgVt0AGxjy8J
         BBlg==
X-Forwarded-Encrypted: i=1; AJvYcCUChInPZY+3yUiXQ/a4emic9736LtdQfd+hxgQoW69R2d5nTmwNm0ywK+WV6D+GfInLlspso5FyNjUR85Wr@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYM6NqgYMCaNRhCDA8RwtJCtgvtkh4vcBZu3Jt3VGK5SiJljZ
	SBGABoywezc2lpSep29A/qTOAt4I2JoNiY9c4h6ZszKlLUHRcFHplp+ltOtFI9OmIESd9MeSrl2
	UVLYKxO7yssvksW3KHp0CW/GebuItC1M=
X-Gm-Gg: ASbGncs48UhEtPZHoiZdt/29wSQYvnPIEk/XAWj+7okhXGPTkJF9TYYA1rdzQTB/lMD
	rNellCEpOEYLWG9GUep8pFq8A7Os2a4zHj5m4vPb8xqQzvP1uTwy0JimXnp0KaL3N893pxrSVEu
	Mz5MkbVVJEfnkLpT5LJl9P82b9tmP2TmYSUMN7fEqh0DFQtjAnc/26eGHwuvUWkwpF9QYJN58jB
	beRdGOW8aHRNGr4jesp4iFKsjrJaAngeB1tsXADszBFY4zwu3qcHxvfsoc=
X-Google-Smtp-Source: AGHT+IESe+5RLwo18Azrwu0hE9yXBll8YB55nGRdLYKUg+cEVS3wNYJu042VXJ4a2p+dJQeCAwvBG97Uhl3N8ggwvXg=
X-Received: by 2002:a05:622a:4e8e:b0:4b7:a74b:fd42 with SMTP id
 d75a77b69052e-4ba66187296mr50706291cf.13.1758146061722; Wed, 17 Sep 2025
 14:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917004001.2602922-1-joannelkoong@gmail.com> <aMqzoK1BAq0ed-pB@bfoster>
In-Reply-To: <aMqzoK1BAq0ed-pB@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Sep 2025 14:54:09 -0700
X-Gm-Features: AS18NWDD15N9gC12pISzbipW6vqaSb0NUMNu6g2F-8oXpI7B6SHPZU6jDCawaNg
Message-ID: <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
To: Brian Foster <bfoster@redhat.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:08=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 05:40:01PM -0700, Joanne Koong wrote:
> > Most callers of iomap_iter_advance() do not need the remaining length
> > returned. Get rid of the extra iomap_length() call that
> > iomap_iter_advance() does. If the caller wants the remaining length,
> > they can make the call to iomap_length().
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> Indeed this does clean up some of the calls that create a local var
> purely to work around the interface. OTOH, the reason I made the advance
> update the length was so it was clear the remaining length would be used
> correctly in those looping callers. Otherwise I'm not sure it's clear
> the bytes/length value needs to be updated and that felt like an easy
> mistake to make to me.
>
> I don't really have a strong preference so I'll defer to whatever the
> majority opinion is. I wonder though if something else worth considering
> is to rename the current helper to __iomap_iter_advance() (or whatever)
> and make your updated variant of iomap_iter_advance() into a wrapper of
> it.

That idea sounds good to me too, though I wonder for the naming of it
if iomap_iter_advance() should remain the current helper and
__iomap_iter_advance() should be for this more-minimal version of it.
From what I've seen elsewhere, it seems like the __ prefix is used for
minimum behavior and then the non-__ version of it is for that
behavior + extra stuff.


Thanks,
Joanne
>
> Brian

