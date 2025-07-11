Return-Path: <linux-fsdevel+bounces-54677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919AB021F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18510162ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3B2EF9AD;
	Fri, 11 Jul 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e04bJeVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31722EF66A
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251936; cv=none; b=sz2hikmOFdUuwtqAf1AonYK/HzJYlkB2UigoR/8pnFLdG5Ni3pCHKouFlEpFAIV/T2gZjxN0QGqr5CMckNFNnAUEaqNnXeXeeHa28lg8OIFHqNrPpmGCenJVp9QImbkwN+rABY5xB9XZkEj6D+gCt7JB4cj5l1LyNSGLsXXYJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251936; c=relaxed/simple;
	bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDuRbKmBdEI5ZxPHV+evJ39aUnkDpDsQ1ev7DNDTGt8OHXN9tV1TrGObfjaieT4RZSJ22pXs47cV4MeG3g2VzwFTC5tfyBT6PFI5cOO+8LPE+zN1T/aBIX6wbbZ4nP22oIiudVtnMbX0iovodIYQ74E23Fc7WMUueELJaQ7g3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e04bJeVL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so261a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752251933; x=1752856733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=e04bJeVLhcRswe4mTIUzewlyQiA64c3rHvgp7J4vnEC8jv6gMUPdTIaaeqljIRXeMq
         ttWFcFx0W7Me790mThOJdd5YNZCUYPPHGZjb/H0i7nUf8uf1xunGps8iWlCTbx5mtOmt
         3FzXhKD3AOlvw51G30chEbIKtssSNuj12q4fECjRzDsa4XLq3X+H0z8wiBaOhVjyfDnY
         Ghk9LVCnMgYMcvnPREauQcmj5wHeVOwnGqpDkKoXH3dHw/wC4RZ++kixW4H6hB1iQ5it
         gdTpdLD/ozQFUkIiBKOEAQaU1AXDWkdAsWuZglaXz2IsygngyJHUh7QdZtGWVUo+v2jv
         GsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251933; x=1752856733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=U06yr0+NR2oRZsD2Lnge/usPv2Ul8TEuh/Z2L9vH/eUVEHlrgMF3jy9JxEK24S2m3G
         td7itRVO2VvJ3e0DFrAOYAcNDhKfZ85tT2fF5zS/VJA9sUun71ALLdoAQFsx+qO5sXmw
         yI1nx4+azOpDFrNuLKhel+b6odd1qvLVQ34Tq1jXleM4S669UECTywrdrM/23CCrhCFz
         Gqs+cit0GRtWf9xW3goJJZ3VQiyYiXHz2VZJ77yzISNEHc8+fN0UGgG1CbTrIerHXhgz
         3MeO6tfSwHgFLzOVa7D16HI9yYCVYqQrViyGnMA94wOSUeFNAtpCYmqfQ/GFedeONeGE
         7ajg==
X-Gm-Message-State: AOJu0Yx9BaVRoxwGDnkA2gXo9NfKvDlzb6K3IBfKAsv2H8jur8IdX0or
	5WK4ivminmfSky9hoG7nK1VjrRTU7Tj2w+iGPfvXhHIsJ1tx/mZjYoJYxF3GLJze/Wr7Cw0D7Bi
	h38gEoSveOHR55o4roRIhGvv2MDQOUy3E2YJJ5qp6
X-Gm-Gg: ASbGncu0+q7ISruhTyjx7uZIr2BPDNHI95vZjI632oRvxthM5Tt1BG3i38MOU5J9sC6
	iJhvoeMCCMKbVKFe9ol0ldWCc+2Gu2EFuSHG99l45G3nq2Ifannrokc3u4e+/Q6/T0a+jUXfBH3
	ZKVAUdvavlvMLSVtHchYKfRm2FUI63hHY2lVGT3/xYx71Gu/bRFeDQUH2uk8PurAwTJZUCQ3nlQ
	/T+VVOmgHQ/uQ4WhXsaNjzXJAP6787Ajw==
X-Google-Smtp-Source: AGHT+IFMqWeUnIhM2GUfvqZasar43+JRQEzyaYqWWnI+VEdWQL/yjU8uiXyK3Tt6lYFu66zeKZ//khzG9Fk7nhUZTPA=
X-Received: by 2002:a05:6402:5519:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-611e66b19acmr119955a12.0.1752251932816; Fri, 11 Jul 2025
 09:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
In-Reply-To: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Jul 2025 18:38:16 +0200
X-Gm-Features: Ac12FXxBR0x-gWBXPHgR-w1y-RdUePMpUnV9bTKOU1Vmk9DbTBaD1sVhfK-yPDI
Message-ID: <CAG48ez0fWFjw8-RCLfKGXR4aNaRfZ37-GdDH=Rw2TFupAhocVg@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: Fix semi-unbounded recursion
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> A more thorough check is done in reverse_path_check() after the new graph
> edge has already been created; this checks, among other things, that no
> paths going upwards from any non-epoll file with a length of more than 5
> edges exist. However, this check does not apply to non-epoll files.

... of course directly after sending this I notice that I put one too
many negations in this sentence.

s/does not apply to non-epoll files/does not apply to epoll files/

