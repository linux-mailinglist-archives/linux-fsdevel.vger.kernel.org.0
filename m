Return-Path: <linux-fsdevel+bounces-41637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9AA33BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 10:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584ED3A91FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D85211474;
	Thu, 13 Feb 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JB09AI4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B3210F58
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440726; cv=none; b=Xg62HhohuSsAaT8J55uR+jdwQolrtt+7u+rZJ0zNsNgJnWdrMWck0HqfZ7xB6sxbyxPF4ZHmlildYI/mmowwn6jHZYVAcXBgLXMPsyoYsgDE+fbB4N8zTCyZQcYyj+Uw7dYgmnCm7z7nAc5EqSoxTIqbjmasAHgWBIjz058sCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440726; c=relaxed/simple;
	bh=StmPhKIFQywwGqms2juyWiG6YmrqmqzTO5aFCTovbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBXYdNdtWoqO63A5EVtzyBr6g57y4KJxap0numGs+l24SUyPhhRCNEWteqqE46IFc1l9AEqfM+NMn3CAN6sCf9EcOMEpxwGdkwwwTkoJk5JPytguC3nLefrL7kIWnDjh53u3takUdPBkp252MpN1PpS9CYrEet+HOjDV1IVjf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JB09AI4y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47196e33b43so5686751cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739440722; x=1740045522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmoXKEPpDiwYiwkcoL499qmaoS2UDsoaVvwbvblraKY=;
        b=JB09AI4yl6sRlc6DGAObx2YDVob3X3a+6/Kx0Fz3HJbLXIVyp1AmhlKgacBupTc69f
         1quBqNEK+36Q9NlfdyB5Mk/ca+e2E5uSqqvUzMMNOgTpL6o6k+Z18qXO8IqWB1fQ/PEV
         UWUE22SjXj5jokKzM+d9hO2dlmNpLSwBgMb+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440722; x=1740045522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmoXKEPpDiwYiwkcoL499qmaoS2UDsoaVvwbvblraKY=;
        b=RxRq5UJx8RzU7tSyVZPhTCMplSkT54ZL2rQ84Ff9GsLpvp3k+d2YA9n48vPWuuK1xG
         GsDdInv2S36InLroIO8qAgsDV/qVTWsyilT/zvpYk6NJrrgZnNSTH8URGhgB+UzHUoSX
         5OURiJfldrHWBB0zGqlOC7UJ9xxCDK9gLrneQmM3BYDkgjN24zi50FlvxWorJxiqim5J
         nE4KTTyiQKO3CqxOTAqcuVyfpPej0AyUY0sK1k8uIXInfIsD4FkJCIHtT0YzXqn96QXg
         baOh/XhbYJr9KPShBANBGe8xjLFgmyCy9aPH2qAEd4X6qic4bvBM/xfvqvgoajTD76P9
         zuIw==
X-Gm-Message-State: AOJu0YyN54xVOWHopv97Rc4+blkKgvRkSIOx8jgIFV1oYkybvDymIJZC
	Zu2x+PeeRq2UnMDpxXDc+W3D9TvKwXycrsc6kAnimJDmSaQQmSePLsxEms2Z1a2/A1BoCTYFE0b
	EcwvJvO3pXPNNjjbTpUCRWuAoRdIBPzDjdN6KcA==
X-Gm-Gg: ASbGncv523bgV9t3ORzwj8xR1BtF7W0o0L+WbjXIVK4PGAwoGvL0TtkcoHDR4lw/z/z
	SRzcQbKEfabOyZVYdvuLmY2b7GGX7fIxM8Xfwb7otnEr5YRkqRS/dhm+B4mDZzi172zOf6w==
X-Google-Smtp-Source: AGHT+IGSqjKRN/qEtF0plKwAMR3j5yFbisFJsZyHey3wBo/dTXRWorFVhgTAnrgiHCuTo0+THF4t8yk2WP8sKZfeMac=
X-Received: by 2002:ac8:59cd:0:b0:471:9ce9:449c with SMTP id
 d75a77b69052e-471afecd36amr95520201cf.41.1739440721742; Thu, 13 Feb 2025
 01:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34823B36-2354-49B0-AC44-A8C02BCD1D9D@jabberwocky.com>
In-Reply-To: <34823B36-2354-49B0-AC44-A8C02BCD1D9D@jabberwocky.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Feb 2025 10:58:29 +0100
X-Gm-Features: AWEUYZmm4NWlnL4czkos9InKJpLOZZUM7PmapWGLBOELkGXA6q3CCJNTZD33Ag4
Message-ID: <CAJfpeguq5phZwqCDv0OtMkubmAmo6LnQxZaex2=z4Xhe4Mz3fw@mail.gmail.com>
Subject: Re: Odd split writes in fuse when going from kernel 3.10 to 4.18
To: Daphne Shaw <dshaw@jabberwocky.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 21:01, Daphne Shaw <dshaw@jabberwocky.com> wrote:

> Can anyone help explain why one of the 4000-byte writes is being split into a 96-byte and then 3904-byte write?

Commit 4f06dd92b5d0 ("fuse: fix write deadlock") introduced this
behavior change and has a good description of the problem and the
solution.  Here's an excerpt:

"...serialize the synchronous write with reads from
    the partial pages.  The easiest way to do this is to keep the partial pages
    locked.  The problem is that a write() may involve two such pages (one head
    and one tail).  This patch fixes it by only locking the partial tail page.
    If there's a partial head page as well, then split that off as a separate
    WRITE request."

Your example triggered exactly this "two partial pages" case.

One way out of this is to switch to writeback_cache mode.  Would that
work for your case?

Thanks,
Miklos

