Return-Path: <linux-fsdevel+bounces-45937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418CA7F8B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEE63B69BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CED266F1D;
	Tue,  8 Apr 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyP9lbJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE426462D;
	Tue,  8 Apr 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102230; cv=none; b=LHmh4mn/4Ak/sSvuvOQxfVmpeMHkAVDcOHJlaqzSnqjRiJDoAITZq4QfguYnZgDGxYq0702MG/RQLVPpIuq2HVSAqAO/VrCh9LHwyKlY8PaBIqnbHj12MDAL/4w95EA5i6PNnL59d/4ZU1P2VVNPgjZE1mg4LAkLXUqCw2dgUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102230; c=relaxed/simple;
	bh=kvno2XNJCoOEd8y7jk1x51GXvEbEnR/POktSN1aDqNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEgfwFquqlDzWQEFqAKdC7k2IDF6hB3lL4cPM5txUpB+INKKlTOmw6uG9HuB6dDwjmW5+4JyFnaunIHiUMQQe3vYn8KUdotqBJmH78DhTG4c6sB/b3QR1yV6McH2KQyOoUHTIc0iNsaKqwqmqwQ91hXG2TkeuhrPcvD9pK9hbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyP9lbJU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c7e5fb8c38so3286199fac.1;
        Tue, 08 Apr 2025 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102227; x=1744707027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvno2XNJCoOEd8y7jk1x51GXvEbEnR/POktSN1aDqNU=;
        b=NyP9lbJUt8w7n+2hwpr2dfXjednJiDYbrj0IbVQYZ2URF3qri+FLy6NDTYR59ObgOF
         UMNduLWe33THHT4d59WhxTc/fshfGk/1ejPgIc5P08y9236H6KBkc3rzmXFiI2oieuMH
         ntd4fNNnsYdPCRZnLBFLp4yLkAhh6621ojKTbd2z/ILE9Yp3ZIGAJ9j/knDuShee+N6/
         /NKzL5QYNdZ2G1/4OvbVIHYYEtGoy2d0cRmIk2zbOc8bJa20GXqSDFu86/KRE43XvYnf
         GUbsBzComolimsXdHslCojhcaxCABTpKu+ARVQgfVrhi2s9c1iLFnTW81KwFhs/U7aMf
         /1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102227; x=1744707027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvno2XNJCoOEd8y7jk1x51GXvEbEnR/POktSN1aDqNU=;
        b=kL5yyrqmVxTAd2Pr5F7I98zvWvGZUbLVvbUi+FJYxRs7cOSBvmzoD1jeiHO6rjJCJq
         63m8+5CnqavxcjsNz07pHJbJJIMq5ZbaDSMTwom7NlWyeGERPqDKY0csb/YsRvn4vDue
         3ThjNJbMjJke9Yzj4OQi7JSmQruyxbP+I8dJv4gcp6imYnhQ4A+JjEMFeo846aDN9Ymo
         +AllXYhncP8xszUaXHQNAT0qMWfSBgaf+hGhRxr5c1xNFAHATRBH/5PukAhZ0S9mufpf
         oO7KeTW8LaACyrk92A7sKU0D3eINWM5WmcMar0qZZ2BXZZW3Mf9lHcKP63F02CRlpPo3
         oX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAvdSMSFhjTFCSq8aZZFvMzFBX5iG+wKh1nKmCFSqSMP7k5MDeCV+mIXQY9qD4e5ngB+/v5gVDsr9uca6w@vger.kernel.org, AJvYcCXQatgm/i9bc63S4KY/AqCDnefiPA8cGPPKn+qnEVz3HCoQNZvgKlu0sI4eMGOaSMg2EYHUPYfOuIzSk4fn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4WsI2ZtqBZ7eM3y2EojGvEd7EVOqH3DzrZn/4XneZSxsZ45W
	OiFkmUG/antzj3RQkN6JXPzGL+2s1w1ALe/Av1fVxYCs0sC3fDnIgZpG0fGfQhXnnkY+1W0efrF
	N71lJ5Z7fSdsCHZkU1vueRPc6XKA=
X-Gm-Gg: ASbGncvSPORS+U3o9Q4I0T8+UFuWRpzCn2inIkX/j/lCvseWNzUKskGfOVRTYv/9SGN
	1GUo3fh0tZY2/0iMkbWI/LSJj4Xoapf/ByDFOdiSwU9HVm37xwbwubjsgsuYkaOvOts7S/O3PK/
	IUe5KAjpQqfU2OTA9glkI0qzF32Cl6
X-Google-Smtp-Source: AGHT+IElkjUVk8HyJcE/EurtA3ynUdnQAqCdAv+9kFaWS45a0PKPx3vJizRsJE1zRkqykB+F2L+uvgSw4iddQc7pA0Q=
X-Received: by 2002:a05:6870:3306:b0:2cc:b75b:402f with SMTP id
 586e51a60fabf-2cd331bf9femr6272351fac.38.1744102227293; Tue, 08 Apr 2025
 01:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner> <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
 <20250408-regal-kommt-724350b8a186@brauner>
In-Reply-To: <20250408-regal-kommt-724350b8a186@brauner>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 8 Apr 2025 13:50:16 +0500
X-Gm-Features: ATxdqUGvyU9DVooNsVhuGwxOSXydA50hfWufsPqasDOcq_Gl5FeYL9J7OVH_a4Y
Message-ID: <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
To: Christian Brauner <brauner@kernel.org>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:24=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> I have a hard time seeing what that would caused by. I'll try to look
> into it but it's not a lot to go by and this just shows a hanging FUSE
> request which seems very unrelated to the change you point to.
>

I could perform another bisect and identify the subsequent commit that
caused the issue if I could revert 474f7825d533.

--=20
Best Regards,
Mike Gavrilov.

