Return-Path: <linux-fsdevel+bounces-31607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3039D998DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7B61F24DB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FB19992D;
	Thu, 10 Oct 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JJ4bHiiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB8199252
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578912; cv=none; b=tylOAZft3dbwUtHzo++sz4sCw5qcFT95QIJf5LldAcoJJpaW113Hqqu7FypPKQTWGGQ2Ez3q9XXctLlsqfVYo9X4+kW/Wh1mxOnb1EVTbRYuzLrzOjcbROCiVwTmWhroE14vXAVLNuC5tn0RoqzPyEcVdtXsZuscHenTXDRhOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578912; c=relaxed/simple;
	bh=amuvSHtAg+Zgcqz2unwr5rolbrAlfKA4J5EC3jCDA+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqkT1+A+okfC/FAuAutuNb66B3u9cHhFpeRzUI+MTBuTnrPcNT9wllJS7gPQZCn4BH+QpjJ2/OIiCEIeBt1lnAbQnNX5MAHe4bsgr+8Op4RcMQ0xabdDBdKBmr3ZBu+bHHtElqA6IqXx/Aks03JUR+uj3XHDKGTBQ+aXZa+MKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JJ4bHiiH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a994ecf79e7so187034366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728578909; x=1729183709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQiBNBCGQr4DG/5Y4cFeaMzRBxYQ2OiJzW//b3dghb8=;
        b=JJ4bHiiH+EAErYuRpfHdgAtyQ55dFMugShPiTxbuMRGi9A98ujjjV3rMnDXRS1ooiI
         4YtFPIvtMjVvGOKYZovvmb7V3J0khLW+2E0nAZbsACH5Le28Vi/9Lyo8m3SS203D+RpK
         Rp70MkJ0SoH0H9qQTMMI2zwgszJ6nDK/YPNks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578909; x=1729183709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQiBNBCGQr4DG/5Y4cFeaMzRBxYQ2OiJzW//b3dghb8=;
        b=H0oH5MgWP1TJCfxzgYkS+NRo3Ajd6p4QHd3l/cwAZBvcGmj8itjo2lFs1Gloocp7mY
         Pz1f/aOoTNuPTOjKq29HiJpU0nvHVfqhWfN+mDOBLfJIfBHjI0j1U2Y+UZx08/qwIcGf
         B9afIO3RN3cv3U76yiZqS1pA6iGHBZiJwAvherFjwxD6+Fx+ZLDqtKc3PVnV5qGFiSw0
         G7w2JEGqlUuvwiw4h1TC5LwMunZ8EMKDF1ATmMCLx/AtqR+GIwI90u4lbPDIE2Kk8s/E
         /lLAZupPJCcoccB3g6LjYIBoNzfLR7RPSvN+hblUB1WKcSKMo0JApIoxXE/vZ3b+O3ax
         bqIA==
X-Gm-Message-State: AOJu0YzTYn6qx3BLm3EmEOqQ1xKajbsDi84YaNJEVzxNZsk9z0C5Pv8A
	PvoZGEagonYZN27QyQeZVhSw+gOsxkdqfHJ/JrBR8QTlY27bA0IR1Lu30o6HD73eqeMOq/CFb0P
	czPc=
X-Google-Smtp-Source: AGHT+IG3P7eCva94vW+R5NyXedDdaDyx8dn12FNmQzAuzBdKvO+AwMW85q4Fsqdhg2GvAGHTr3cJtA==
X-Received: by 2002:a17:907:f727:b0:a99:76a9:a9b3 with SMTP id a640c23a62f3a-a998d19962dmr618968366b.14.1728578908755;
        Thu, 10 Oct 2024 09:48:28 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec5894sm111703666b.42.2024.10.10.09.48.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 09:48:27 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9982159d98so183150466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 09:48:27 -0700 (PDT)
X-Received: by 2002:a17:907:f75a:b0:a99:4987:8878 with SMTP id
 a640c23a62f3a-a998d1a2576mr630672766b.15.1728578907436; Thu, 10 Oct 2024
 09:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
In-Reply-To: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Oct 2024 09:48:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBmW4hs+6PwKNDx8uwhOE2arV9FhuwSOp3_mBuL6wnSw@mail.gmail.com>
Message-ID: <CAHk-=wgBmW4hs+6PwKNDx8uwhOE2arV9FhuwSOp3_mBuL6wnSw@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: bug fixes for 6.12-rc3
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 04:35, Carlos Maiolino <cem@kernel.org> wrote:
>
> These patches are in linux-next for a couple days, already, and nothing got
> reported so far, other than a short hash on a Fixes tag, which I fixed and
> rebased the tree today before submitting the patches.

Pulled.

However, please don't rebase over unimportant stylistic issues. Keep
last-minute rebasing for MAJOR things - bad bugs that cause active
huge issues. Not some pointless cleanliness warning.

               Linus

