Return-Path: <linux-fsdevel+bounces-40769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D428A274C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FFB1633B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7542139B6;
	Tue,  4 Feb 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTRjoPse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18A2135D1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680471; cv=none; b=Mp+sIuGMa2r3eApEeKBSNNHyPDYezlJadI2SwAkA5R0wmXryFYWDYEOOQ0cRqzEqEBswh8ZJXAB6lA+ysJhI2Kjak0ECMi8BqEhkXCrBPyM2DVNCDInz5SdShEwhQmFJT11WE78qGjlc08bInbpPNu4FhD06sypBshYs4o/Cuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680471; c=relaxed/simple;
	bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVrtSWyoO5P6MtfXtJVlM2VnxEzZ5DqKPtB4HHpM6Qe+e2HEKM0jHs8s/BE8aiCHkrRgBbVI+FHCl5BnJ2nV7a6pPi2LELlUthtJcwA59W2pb3ZKek45Gj/1/LKwfKSgz/jj1FO+m1+koCukAtfGF4Cy9w5aQcvacFcQtOJU3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTRjoPse; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so9824a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738680468; x=1739285268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
        b=sTRjoPseG9HrykGS74MsmqQI99cQte3pIhv/HNb7cNIjxKd0KqDiL5gFuzHJzHnEI4
         0KP0rfTILp/pvcyGrWRegWUZCBnFU71aJUgpTehMw6bvuP0bC2dhWVHiMit7E+v6uyvl
         sTgLzUrvYruIIGZRmFVgd/DAE/9li1I2OW0QhZJDxPgdAWWJqBxOq8fK9ufJxfnI0KTB
         7KabTtP7btjPdCxMJ7TphC2Cu+Q24vU6T2FBQGne2Ai5CJbCmYOpeNTNZsRyjpbFfzxc
         THxNib3XtCK++gUQA2puc/CL/uk4WUbsl6NrJyBJASkw+h8EvsN+wiumdU9auSSVAmfa
         bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680468; x=1739285268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE4QU3PPtsAJQ4G2P1RTlCw8H+CMDJW6wqA0hhTxZUg=;
        b=T2hf55+h2nhmVKj1z5/SDiT3hIDqbyu04HmE/NFu5Nkpgwqns0buNFcRAdh11xQ2Nz
         xkdkoqheWwlkU1ydTw/h0c1/bPe3P6fhyIjK2LMmOVnyIi1ekbibzxR/rIQcEZlVl4lK
         5990moEUvnOiDdjXXSc5OObjH/5mMM1keXTFgdlkXrtw9vbYEV7wexkBZ3Vl5Aq81FQo
         WIREuPkshXD9HlQ5zJadTUMmZkTfJB1Ua6KcFWzLlJO4a0HN8BvbIy7jsDwu5CTGEuOv
         NRZiWnLlWX4a8hXDrh4wuxcvElWTim6S+hmg1AtAQOQ64Nlp0s3zSBHfFuO8sdv+1kwE
         Gd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiIYixzpcwX2rLIw8WD0gZO5DnzQU5aVDbF1oUkmzySvWW+Az71Obc5ESVeUhl2KGchSB/Xi7dVLkTvKh0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4VtBSrzyoOcWdaYiVwRzGpSeEG7nyj/UAPN9gzODDf/gSd2Z
	5hTSM7WwrtLImqZ62g2AHbIKiJiCP2pe0RLIgyShNIDdYh8Ev7ZY17gj2ImI9aQCxNP1lIPqH+E
	0g2D7rAOzm6jo4nWlScsIpa+k+kBb90HcR71l
X-Gm-Gg: ASbGncsQNNYJmPLayx23BnwMrNtfg3Why85XSVms4f6XbW700XxzC33IAOW5dPw7llw
	IgSql8WIUVljtWfx8ncdTZivG7MjlQZAiOVMEwYxjnjYV7nWqZYWGLpQuND/htECNY+W/96M55t
	5n2JFQMVqwtl7vq5sQVAvuIC7l
X-Google-Smtp-Source: AGHT+IHpUVbkwPej9K+Dlnsjsfxe5J6A8lGTV4hhIFKe9AxZm0DQVeZZQF0YTYdrn4VQ2w9nMXN2sTyauiQxpeIsE0s=
X-Received: by 2002:a50:ab55:0:b0:5db:689c:cab9 with SMTP id
 4fb4d7f45d1cf-5dcc25411bdmr105621a12.6.1738680468027; Tue, 04 Feb 2025
 06:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
In-Reply-To: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 4 Feb 2025 15:47:11 +0100
X-Gm-Features: AWEUYZl6Qivkx551CaKDtXrd_BRbJ72ewinSBW6Wih4vXJvTWtkxDxYDRb1ACy8
Message-ID: <CAG48ez0y=ZwotbWDSR4kG4RJjV8+_VJ-LHbfAEDRKT5kZm3yvQ@mail.gmail.com>
Subject: Re: [PATCH] pidfs: improve ioctl handling
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:51=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Pidfs supports extensible and non-extensible ioctls. The extensible
> ioctls need to check for the ioctl number itself not just the ioctl
> command otherwise both backward- and forward compatibility are broken.
>
> The pidfs ioctl handler also needs to look at the type of the ioctl
> command to guard against cases where "[...] a daemon receives some
> random file descriptor from a (potentially less privileged) client and
> expects the FD to be of some specific type, it might call ioctl() on
> this FD with some type-specific command and expect the call to fail if
> the FD is of the wrong type; but due to the missing type check, the
> kernel instead performs some action that userspace didn't expect."
> (cf. [1]]

Thanks, this looks good to me.

