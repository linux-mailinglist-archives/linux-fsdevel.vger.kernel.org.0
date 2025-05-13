Return-Path: <linux-fsdevel+bounces-48805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7EAB4C9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F919E2FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CB11F1500;
	Tue, 13 May 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gL97HjRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268AB1E885A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120876; cv=none; b=cbxidwWMposbMYl7X4ZOvhEdqCv9Ez+24j00A/T7xWZaQPYMiy7knX2qauQXWGhB3xZ9Q9yjEGmKnSDdfVYHW+M0XEpX02QAsCK3eF6v+pYEr0VOhpjf+D0ayOmUNcG+m2ZdL7Ze7aoGOsVaXQLzxEjmURrDAiPskzXEcgTeeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120876; c=relaxed/simple;
	bh=PLFaKLspSKToI3oqLpHdbvqIWaZvRsqCO8+SeTZd87U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWTCmgLI3/bCIlCjQy2lEuY0SCEWodHYIArHP37j/gcvepT//fG5Olr00z9SbEIwc5dFRYuoT2pIDeVfrepPd+MtqQP8d/8FUIPaI4rUAZqR8nmJ+Ny59yYjnvhdlXUQzs9MH2ClR5ngoMPQHh+caWzREfWB5FXs5TLpfzr1RKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gL97HjRe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4769f3e19a9so36908251cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747120873; x=1747725673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLFaKLspSKToI3oqLpHdbvqIWaZvRsqCO8+SeTZd87U=;
        b=gL97HjRet5Mr5ftzdY4oHXdcf61sHnOiRXx8stWd7KnxN76vS7YuUXWDkvJ1Du3xNn
         jOEudV089dHHWxkOq9mktYe4nWX14OT5DMPisHZMvY/Fr8UZPLdHCy6YfeIfKJX9xb81
         Wvdf3fW9MykoLIXA8V7lMpAX0Z6WLylH9igY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747120873; x=1747725673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLFaKLspSKToI3oqLpHdbvqIWaZvRsqCO8+SeTZd87U=;
        b=Qm42jGaO8dA8dROVPXDP5/vrY4JOHK3h+VliDzTvlO7GCotXJ8lz7+QBCCbFoHl6j2
         z4jwKFWHFuN4pFkabk21OyPxsDwWeFLUd2X+/e2tOBb1accoG9v1yqatW/n7V6SNjvaQ
         dH4ILwM8mPD5NAeFXhL7dWwizfWg7ZzOCPYoVP/Q7dCSYO1BKWGp31oIismacgHURFQb
         c2BC4PVmbDLvHPiQNaX4f4cAUouHgLS2XiLvgxm+9iRVkg/JEnzO5jCENrYCnOiPnHFJ
         UmWQb/82TtYL92nTc2iluraKsc6qR4236oxGUngJpcNnBTjHVEeJHO4D0hNHuHgGvESi
         pW6A==
X-Gm-Message-State: AOJu0YwQv+huYvGvWQq2TYISmtupn2bCpzxwwgcocc+jQUOU0tLcoGjy
	1HL1Vz2MLARj9Y+hMiv4hpj+w6C2OcjYQNnLdvPEJvD1mqOyKMS5q76ebONBh7OSEVrdqbfaJN7
	cVOgSt0hDULc66q/FWOJ+NeRE6jZy4XyG9PaU0w==
X-Gm-Gg: ASbGncvB1apRBEzxCUtti0MZ+Fj42JL6r8ocS2ZOVQOKnxvGeRdRXAgixsELlqfJSF/
	au3imd4iYnB/uZ2d9uJ23FMPHvv5f3oUaTyIRCDlmOoichLnOcUUXckN3LcLRjul/LfMcFoXgNP
	xNecWA+u5jxLX6mWcJxQDkoT6hR8Xy/e0=
X-Google-Smtp-Source: AGHT+IF0jKCY6qBfrrbWJutfc3aUfMOlMt2zBXsEqu/zkNv0mZoBUk28w6GwEr1MaUwndic1EXLiRZCU9DSDvgZx0mg=
X-Received: by 2002:ac8:7d51:0:b0:477:5d31:9c3f with SMTP id
 d75a77b69052e-494527d4685mr283612521cf.42.1747120872990; Tue, 13 May 2025
 00:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513042049.63619-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250513042049.63619-2-chenlinxuan@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 09:21:01 +0200
X-Gm-Features: AX0GCFseOYu9DYFE8yAl84-gPqgQft2sZTfecQhV4mIznFelrLabrsX9eiIzL6E
Message-ID: <CAJfpeguWa-gWj-2WBWY=UVXATHKvAPKYMj7nbxTTg-_=0+hOxw@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: add dev id to /dev/fuse fdinfo
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 06:21, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
>
> This commit add fuse connection device id to
> fdinfo of opened /dev/fuse files.
>
> Related discussions can be found at links below.

Applied thanks.

Miklos

