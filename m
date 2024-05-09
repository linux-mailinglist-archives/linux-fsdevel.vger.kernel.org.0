Return-Path: <linux-fsdevel+bounces-19149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0A8C0ABD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF39B284987
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C75149009;
	Thu,  9 May 2024 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsmMdWe8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42A10E5;
	Thu,  9 May 2024 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230913; cv=none; b=Opy63bZPixJXLxDoVdZu/S6CRHUd30E3WtBa1/ekH5EltmvYJdgDAFZKp7xYh3/dIMWtJ7wJUtOY9Ts/ehLhp1RYSQcnoY1TV1ihTKZu8v+TqauAoP+hV4mxTQm9bt0+0QdF1g0QjrEGFb2NzmsLdDK2DSeBmnz5eX+uUYOnuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230913; c=relaxed/simple;
	bh=HQYQUufoJUO60eXOEzte39BjvzF1Y6VPrP/1lxXporo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmbIWKW70sVOUwpk+dgaP5KkOb7tw5WHf31Ir2pt7f1HnpJUlHBMSbeNEXPMOzTjpBlMO9R+5blWaafkfKNikAXihwc083YM5JiXNEE+aMKMN9trAHoiwC1GCmZukz0xbEBsDtyzSlu4vrc9cB2p8jhxM9TyUlp0hCS9ZQ2ocl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsmMdWe8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6969388c36fso2402276d6.1;
        Wed, 08 May 2024 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715230910; x=1715835710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQYQUufoJUO60eXOEzte39BjvzF1Y6VPrP/1lxXporo=;
        b=PsmMdWe8WYuOabpFpYE7Qr4KKjDLdsL7ZuidPDCmqN5gbKyuvjjgGsTQJxiOGMkN4h
         I8lWY8RwN/uen9XIkO3A5SS8Wac5mGoVVQ57bcPABjaqoW2aoQqgXCbvAJLsO1+JVMPz
         ksDkurTRCBNmooMRVeWEVgaiqcRrhwSw0Pvo8TGKvdZG38j62/jMUtYOM0QXoSL9rLI+
         Y4tdJPLAC27+8UPugN7UewGWUlpMINgH2RGiSfLg0jKO2udbBkvj/OC9I/TQsRQSFxAN
         YHqY5lIAIqlG//vBg7IYoChqJaHq7t6VVKWRIm2F4nfcchAOLU3yMDHkdXtvX7JbwHmR
         4Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715230910; x=1715835710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQYQUufoJUO60eXOEzte39BjvzF1Y6VPrP/1lxXporo=;
        b=dCyXsPZGOjGxsPIax3MIzpXJikKC9e9lhLY/uIqii9+vWh1EV93ya+0DQLf1/8h0u4
         682/6SDe6nIQwIZpzH2bmhPrhuh4DmedHYh4s+MyPiHlCpYKsiKVpA9LgcasrhhENk2O
         ZzP5JPMx758aE2PrLlGR70SSrR28Ibs1vC+QPOLhNLz4pR1oUPqYBAapK5kEIOJtrrZF
         DyacQDeXCGCACWdL+uapJAQ5mjmwpFUtAYxMdMX4JyVoUYlcdtJc+jOszBvqgBnLleQX
         fsioKKcoCJ5pU1MkE7n33Z+RFO8e52TDi4Ff6RghBmlW0MKvMPRMGCKUJeCSdV6MzDAf
         fgqg==
X-Forwarded-Encrypted: i=1; AJvYcCX9yVkdH3xMwzsV6P06zc6hvpb6DB45QZLprXytfzhXXeAt9/ytUt+XDTEW4xOIPM5UoSPaYdyPHlfjCNKmfJPB1DJAQyi340uXn3lm6gMdzPr4OWUmK05E42bH2lj0BO6TH0cJWj5WSg==
X-Gm-Message-State: AOJu0Yx3s4zCZwASHt5B3WdbsdPczq9q1KezBM1ht6PlwrgjqzAmlM4Y
	6+PpqZffENqfOy9DHL7ZfYqlWSZ8hQkp18x4UDx3Gm9HXYgXozyhbJhSGPXVWkZncNzT3i903al
	MZCbrbencIPhjlzec+kSlv46kXXM=
X-Google-Smtp-Source: AGHT+IG28C8sng3KpIoI9gzACQFN45URoMWK66xDhLR/e+fuOzJZ/XVNeR73Pv/Qv95TtE26L2b+e1wIfstme1CjWZQ=
X-Received: by 2002:a05:6214:2426:b0:6a0:cd65:5996 with SMTP id
 6a1803df08f44-6a1514330ecmr71019676d6.8.1715230910676; Wed, 08 May 2024
 22:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
In-Reply-To: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 08:01:39 +0300
Message-ID: <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
To: Luis Chamberlain <mcgrof@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Chandan Babu R <chandan.babu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:42=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> How about an XFS BoF at LSFMM?

Let me rephrase that.

Darrick,

Would you like to list some items for the XFS BoF so I can put it on
the agenda and link to this thread?

> Would it be good to separate the BoF
> for XFS and bcachefs so that folks who want to attend both can do so?

I have set a side 2.5 hours in the schedule on Wed afternoon for per-FS BoF
3 hours if you include the FS lightning slot afterwards that could be used
as per-FS lightning updates.

> How about Wednesday 15:30? That would allow a full hour for bcachefs.

I have no doubt that people want to be updated about bcaches,
but a full hour for bcachefs? IDK.

FYI, I counted more than 10 attendees that are active contributors or
have contributed to xfs in one way or another.
That's roughly a third of the FS track.

So let's see how much time XFS BoF needs and divide the rest of the
time among other FS that want to do a BoF in the FS room.

If anyone would like to run a *FS BoF in the FS room please let me know
and please try to estimate how much time you will need.
You can also "register" for *FS lightning talk, but we can also arrange thi=
s
ad-hoc.

Excited to see you all next week!

Thanks,
Amir.

