Return-Path: <linux-fsdevel+bounces-27563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354B962668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3441C20F38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109416CD2D;
	Wed, 28 Aug 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKMyzPd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1A15FCE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846018; cv=none; b=TSURTn4cDHV3E+sZ98fgQpxvhassDGTj3UxKbxoyOwh/XK87biEpv8ZJ36Jvkkh+DLxwYPCWnMAxIZ7AgIDyeo0onBbs2Ns5gpSm5WV1YDXRhSsZPzRrqO9UXDIy975mUIhXO7EtYCq3rcCYz8lHNdLZ4fhOUph26nJqGmGdM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846018; c=relaxed/simple;
	bh=CENLyNdDhgcWFi6agZtY6YkqFXEfyhWLH7RldX/xba4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvxsJFY+rM74NxfdAyQXEvf48PYqLUP+/Qx0m9Tzm+lIIpOnrAGiGDWjWcEqfFeOLyvkUj4ZwShGLWAxmjWetB0mc2898yjbgrbRZK6BxLrokkRC2SuR+r8WHqIV5RdmLKOfiS+8ZGn5nTZhuiGihAgGLD8Vk7By44kh3wWexRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKMyzPd1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1dcc7bc05so430075985a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846016; x=1725450816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDUPIgEg8rroOBWEOBK84+CMyAj/BV1AKtlwun+83bQ=;
        b=jKMyzPd1noXWpbrJ3xR7ZogThQes6T0NYXlksFfUGumim+pI+toxBFJa3AsfJ/LIYT
         6Ni5XuyaM1+buSxe4ySJZ48yASCtp/FrH69XYKVhLTp1wsOX6qBUsLKOikau0QJ3wqq0
         xLrAdMlrhHeM9sIZSbiOmKYU1krZc+zFvw7VJ0+wbZhxMCF68O9j6K8SWIzKw+saDdVB
         6z9hvJUKsCxjXvASdgKJEwYD6ykl7nEBDgmTo5Ra5ke7U/vtVUIUfQDjjtrL9FYJgnvG
         fASaA6vzefRzEkQB7MOOGs5M+XK21AzcFsvNLXqH+3ZD6BkxB/D1foBDwkmnuejxoJl+
         SFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846016; x=1725450816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDUPIgEg8rroOBWEOBK84+CMyAj/BV1AKtlwun+83bQ=;
        b=EPp/WA6yz6hCRcTqDGd/b8CvekCLQPGp5EYDarjnQpNgE8I1TF3NJYSQ1QGiBOqnKo
         gsWj/cG7gOYuqtnVNAvl51i1CRt7uI5HFORvgx49Zkq1kKz/sp8afmS3omIxykOMF4my
         y1oG+SufgYSsNtUd1j2UGCYu/sTcBH5SHiRD6GE9Zr7JCn3q/Czx9HcKSlq7mt6i9fb7
         +l6ZWJQq1QxyBfHxalewLuYp32sBDp+LkWrTyfdOcT6pWEUuGqY7WsieCUN0Wc7chj0g
         SJV6vZj/PLyut6Bp//MauRchB2oZtjQj5/rF9dh3pZkEyk2lSlI/eVttyYran2Vf98jW
         HLQA==
X-Gm-Message-State: AOJu0YwM7+mInv/Wp8DW9ivBWlK+IYZy45f7W7DBwvPcYuPEDrq3DqKl
	YVP2irRnTJGsxjtmWnskOmy2ouObZB0oNaPu/Cozqk0YKHuzrHTqkULBL89p3ethqQu4fMxm/C/
	OgdHc/1xAeedaqyQdLtr8AtXqPeax5qtN
X-Google-Smtp-Source: AGHT+IFkWTtMCdY3DN8zidZpx6uw2pmvljcLMkzkmZ28Pw0iWt/MbLBjKGiICVgA+3AdGTuZ/gvSYZTRfW1N9CmFdQI=
X-Received: by 2002:a05:620a:c4b:b0:79d:5b21:804a with SMTP id
 af79cd13be357-7a6896e3855mr2254649985a.14.1724846015849; Wed, 28 Aug 2024
 04:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
 <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
 <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com>
 <CAOw_e7axjatL=dwd2HAVcgC4j8_6A393kBj7kL_VHPUKfZJaqg@mail.gmail.com>
 <CAOQ4uxgFbBCRLFM4QdQYK3xESMixWqxtC1Q9Hk4p=bjWeWk1ZQ@mail.gmail.com> <CAOw_e7YD6f4aOAr6cuOGQOzhPtOwsNWv7-CqTE1iaF8qq-eR4w@mail.gmail.com>
In-Reply-To: <CAOw_e7YD6f4aOAr6cuOGQOzhPtOwsNWv7-CqTE1iaF8qq-eR4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Aug 2024 13:53:24 +0200
Message-ID: <CAOQ4uxi4vU2dVvrLENjfZUKVG8mmsqRY+RBRMigUdC_RePC3+g@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:02=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.com=
> wrote:
>
> On Wed, Aug 28, 2024 at 12:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
>
> > > Similarly, it looks like the first backing ID is usually 1. Is it
> > > guaranteed that 0 is never a valid backing ID? I am not sure, and it
> > > would certainly help implementation on my side.
> >
> > No guarantee.
> > There was some suggestion about special use for value 0,
> > but I don't remember what it was right now.
>
> In a file system, not all inodes are backed by a file. If 0 would not
> be handed out as an ID, then backing ID=3D0 could mean: this node is not
> backed by a file (and doesn't need to unregister the ID on
> forget/release). If 0 is a valid ID, I either have to add another
> boolean to the inode, or keep calling the ioctl until I get a non-zero
> value.
>
> Reading, the code, the call is
>
>         id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
>
> ie. start=3D1. In other words, if the counter wraps, it will start at 1
> again, and 0 is not handed out.

Yes, I understand.
I think the rational for reserving 0 as special value was for the
future use of FOPEN_PASSTHROUGH response to mean
"passthrough to backing inode if one was already mapped during lookup".

So yeah, I am personally ok with the backing id handle being > 0
as it is in the code right now.

Thanks,
Amir.

