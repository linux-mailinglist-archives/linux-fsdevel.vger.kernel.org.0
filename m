Return-Path: <linux-fsdevel+bounces-50822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053AACFF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123051893E20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5B2857D5;
	Fri,  6 Jun 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lvAG+tHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2327468
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202436; cv=none; b=ULTgJ4bEIxArlHj6BLEW+H9fghKj1qovlD0KhkOMrVZSqtyNWme0GM17sOxEmr+u1Y8mz/CTmFl12zteL/njdFKuScd25xbxTFPdxakegmGbish6HcVsOaMSAtjDifIjKBfJpGfjdsy1TGYBT4YHJ7CTQRgX9GNCvkm2ueybW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202436; c=relaxed/simple;
	bh=NCD3FsHqX/tDsdqDrxlXUdzTVx+2sqRGtUtrxLK6jAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTp85mLTHkqC6B/JtzMvMtiZZIpDqHE6qgeZNRCimS3nLfVFQ74IKIsR/jRRdsp86h5/J8nQ3c7eHqB3Oqab27wQrpbEFXr0wwf3+OPuhWcFvGxYFMwjbbQ/dKTFLsZFz+kl6gRdQT874iq9M6we3zAQ3lsFxcaoJUD/wL9X5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lvAG+tHk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a585dc5f4aso25007791cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749202433; x=1749807233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjjJoIKAqPL4Fi3nMaT3Fad+/StO4aRC+TRTWdCbeTc=;
        b=lvAG+tHkEIFwrw/yQXFUo0RH+vfERl2p/X23Pzswzv4TaPWDxbepHDZIr3RmqV7aCq
         eaYotMiBY26iIMwt2AJx45me/PQfzUI+tHBfPK4n3fEhAmGz0+VHSoA3l8qW+pik3ND1
         xvYFl1SOljGyKrq/Hwp/2q+u8k3l9uDXzQvJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202433; x=1749807233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjjJoIKAqPL4Fi3nMaT3Fad+/StO4aRC+TRTWdCbeTc=;
        b=iXAeWlM/feuIMCVK8dJ6z6Ggellh52UHetC36wGlOnGW7Wj0gHFba5ftlaO9Hc37qz
         b3BbaLfYK5wKyGF2tJgC4aHDzidTr5xvKqGRWPOe/HNW5c+BxaXOdxwI/Ke9qIo0J1Nc
         OZVny3mVc+cs6honCEEJ+6QzbolecXlcgsSb11IyX8gNN8o862EFcxHsY/of1YzW2o9+
         3UMLDhnQV2n3AR4rOAAPqb3PzLbCpssBsps/1+eRuKTK8XlBMAmsMouY2mVMdPgNWoNf
         rNE/7uB4N0lQ3SeTSLTvhn+wj5gxhT7vT/mV3C7aghwEhcd9o4e3CDMoxRMbRjHnZLOb
         Ie6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqWzOWxifXtegSNhj/8MYyBWqKGLZidkDwYXpAMDJa26s1316oG6n23wN0N2Vs8aKlaVnZ0KMBr6wov4kT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0al509CmQ6K8a75CI8963cFjxaHIZU3NdfyDuTsNsMFazZvw
	Gi7zTXXzMDlibVGzKbwOtHIMCjVweQ+j5duT+1hMcQj1f3G9zkH5qxNvGx95c3zn7vItWR1POp5
	653/4QgGMJ4L1rahfntsZliJegdUDXez2DQqO7/McuQ==
X-Gm-Gg: ASbGncveWlTLlfUfPBivo/fiHTxeLiVUP33Z7eb8NGe5Ozzc32ja5Q0ZMYlVpZGGJDg
	2YTKjjNO30UyoN9LMXktr0hTjIqj38sR8W+1Y8UhQbl4tvA0WOkw8wXO3Gof0vWrGZxC28sOWvA
	yRPfPzkGIQWfF+XhWzuAqZT7vrqP4CJCs=
X-Google-Smtp-Source: AGHT+IEpD8A+u93yY7dMI4QI7COmSAbaXPHLO6KjHqBSEgUYxk/Jw0ZYl1TrJ9sLHanEFIt9Z9r1xEAOroted7uPQME=
X-Received: by 2002:a05:622a:428c:b0:48e:1f6c:227b with SMTP id
 d75a77b69052e-4a5b9a47e1amr44216851cf.26.1749202433527; Fri, 06 Jun 2025
 02:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
 <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
 <CAOQ4uxjXvcj8Vf3y81KJCbn6W5CSm9fFofV8P5ihtcZ=zYSREA@mail.gmail.com> <CAJfpegutprdJ8LPsKGG-yNi9neC65Phhf67nLuL+5a4xGhpkZA@mail.gmail.com>
In-Reply-To: <CAJfpegutprdJ8LPsKGG-yNi9neC65Phhf67nLuL+5a4xGhpkZA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Jun 2025 11:33:42 +0200
X-Gm-Features: AX0GCFvFo8VWZRAyQvoO_OwOv8y44RwyQfaZo7GsgVMP1nOljN6vif8ZNW5sSOg
Message-ID: <CAJfpegu1BAVsW5duT-HoMGiSXNvj2VsLNfTuzvF1-RLyVLDdTA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.16
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 08:36, Miklos Szeredi <miklos@szeredi.hu> wrote:

> I'll redo the PR with your patch.

Pushed to #overlayfs-next.

I'll drop this from the PR, since it's just a cleanup.  It still won't
break anything (and that's what I meant by "trivial"), but it can wait
a cycle or at least a few rc's.

Thanks,
Miklos

