Return-Path: <linux-fsdevel+bounces-27534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CF96242D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B54287890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD1167296;
	Wed, 28 Aug 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIR/44MT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B371598F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839242; cv=none; b=SpzWIU00wlq2qHQubh2pPZ+8ZBXBeL7tes2ua6BnL95rVZ3seLPAN5VNzpXXw0l8HNVvvCaz/1M5MpPK3L5DEKxbB2ugKWP2Dvxe1fvuS+mJjNnMRwcg5hTThWl1OIWLq9ZmTKqvDEzpBLKL3rqS2PMcnS2dPcfK2ZQ22A3SMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839242; c=relaxed/simple;
	bh=HsF53tQj631/pG19CAwpi2d0ZerKH0/fjiNJ+ox/Duw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXIBHDOaZX9lC43qVOe/qEtHynxRw0hP8RnacJJqunacFphtIyfVUgwObJW+rOis+zEpnX5vYCAYwCRRsM0N1XefOWMbR8p7IZNqZ04cPr8dubHZcC8c9L3xinYxxRTEMZRXp+UisKdA4U0YauFl59l84fTxLeW9HugzKd8pHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIR/44MT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd9e4f550dso2091094a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724839240; x=1725444040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsF53tQj631/pG19CAwpi2d0ZerKH0/fjiNJ+ox/Duw=;
        b=XIR/44MTFauCA3yU8tyRkg1EnnAhUdzq2nL42JdeIuvoMPtKZ+AZtd1ZLaliCRvYpO
         we++Vpe7e56mD/Vni0H4XGZ2lC0SwdLu3TvEnuvfA9NKgATkfQRLH0cKhRRGBxTTEqQE
         94GblJwCHlsw5lLNjVIWytSH9lc2yMm0s0COcASZlo2YUO2Lzx8UMCBe3F3NXQOZZqUP
         UGzScGQohwfgNfIylkuHorqtFK0ZxW+bYdxsNeamlhb37Wn86AlVVkrYpp2IQ864WtZC
         nidpL7JuUWqk1hfcenkWjVSKqCDMYDFYPxDf+WnEdyNJf5Wlvz1gGYZD8ms5PezKRvHY
         ULPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839240; x=1725444040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsF53tQj631/pG19CAwpi2d0ZerKH0/fjiNJ+ox/Duw=;
        b=t6IUUDssoQ6PDyWiYF4IGkazy1p0gno9iQ/UPepy9/I5DV9WE4oV0cyQ2pEXEAyThS
         HNQV6sXxZj++Pe369/qb0cdnHAG92YUa6J3bPNdnq+oqIvii29GYlh4eexrFjk9w+C8B
         OAbiOXSMbk0YlQufkrryx+B0VaTW2oBwnAGwzCMsK7DVzs6t4LMLXQUHD/SqSAmAdXCN
         r0OqhZbCDPu86xeb9Nm6aw99lECALn1+TJ0TVL0gKNhKnpsvFpfxLrofK361rSov7zfe
         PcYBWsJ2D7GhJt20rnyK79jmEBxSgO/54Mm0tERo4J3Pu+bHuzgVq5Q/NyZwND1i3BCO
         IyLQ==
X-Gm-Message-State: AOJu0YyYl5GPP+N2Ms5/lMGB8d4CAbrXmBhWbxU76WPPI2BJB/3NDe+m
	8aPoC6vDnzUwBFu664TIK8+muiIKTMIhqmIpou+Ocu1md2zTJCzKQ+I0BBGldqaA9XlpcQMjRSg
	OPBbeIJ2EuMQfg7Xj7i1VurtNDSY=
X-Google-Smtp-Source: AGHT+IED8qJIDOu4fg88yKcfrc8Dn07VFq/NK3m5X36bP9LQcIQaeg3nJEYuUdMzOI6unognXRQkLV4yZKxrefg+x74=
X-Received: by 2002:a17:90b:1a86:b0:2ca:7e87:15e6 with SMTP id
 98e67ed59e1d1-2d646d49234mr15700940a91.38.1724839239848; Wed, 28 Aug 2024
 03:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 28 Aug 2024 12:00:28 +0200
Message-ID: <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:

> BTW, since you are one of the first (publicly announced) users of
> FUSE passthrough, it would be helpful to get feedback about API,
> which could change down the road and about your wish list.

I guess it is too late to change now, but I noticed that
fuse_backing_map takes the file descriptors and backing IDs as signed
int32. Why int32 and not uint32 ? open(2) is documented as never
returning negative integers.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

