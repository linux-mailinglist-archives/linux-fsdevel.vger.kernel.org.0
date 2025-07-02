Return-Path: <linux-fsdevel+bounces-53590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F401AAF0AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520381C02990
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C91953A1;
	Wed,  2 Jul 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Oiql1wg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FC10F2
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433813; cv=none; b=keb5rfMwwStwHhcbZyKHuY3RoSI/viMLVKF47KaOiXYRJp5Qk1uDpt5p7p6glrQduqMw4FzWwUxN0tGInLA9JVKR8ytuXUFPeriWaacLQTzo9OO4YRyTufXD12+ENiy3nLMcJ1xBvnxC+lHjN5ryX43cMJYiXq+GYqnksUuC6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433813; c=relaxed/simple;
	bh=HljA37DGp7LaeTvSIRycl+hJI0gYUTguTqAJkr0vei4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWk2kot0kJBs21trvqm9+A8ykSL1glIt1DmnmSQjdT/ViMTJ7+fJXJuBKB/h2z/XR2JZDkwOwOXLscxQX1mZyAQH7kPH0FXnLD7krZaIJuARw/37PmusM155IcGvxxkDfjh3E1oX9Ms+fhq5VazfB3TOsybv32ZgIKCIUFSqqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Oiql1wg7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a5851764e1so127822311cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 22:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751433809; x=1752038609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HljA37DGp7LaeTvSIRycl+hJI0gYUTguTqAJkr0vei4=;
        b=Oiql1wg7QmScQfw1KTh/V/SzRBVpLOBvcMiIQM/OLtl7R22eVT+4Q+NHLt9eQ6vVYR
         nAvs/3Hf9dmhieTdlzEn5q+i/7oy16MWo3bS5yQS0KYHhJ0Z0hHIjwp32Ikf/Qv3LE1+
         qw3U4F4RuEq4st0gIyn6wjGcoza7wUyQCr/pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433809; x=1752038609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HljA37DGp7LaeTvSIRycl+hJI0gYUTguTqAJkr0vei4=;
        b=JGDCCXjEv6OLca67f8DFsJtbuASqaf0l1W17lxxM42T85S7E0pMSZt+fj5Z5NAlovp
         vXfmUvfUl+9w2tRptxJUhzI/8WpdCk6A8o5yoT5bh9PfdFQbMkTBAx/a07olOG7DVI7K
         aQPILHO4bd1JE0xUYVBu80q9jYJCAie1PgwIenhXhg+mnsWNYeyNylUXZJE/4xDE4q3X
         RGeGZcy58KzgeZO8nPd609FarGDJijZl6N6f804LceA+CF/TnTx5gu6BDQJETvXzybrR
         TJmoiI39SGXA9DdYU2B8mcGA5dFCC3njv3niJ5LeCSVZn1/JTXmCkLF3Pmg2eQXC2NJK
         jKpQ==
X-Gm-Message-State: AOJu0YxQsyrYXMSTc18xSk0ZEfRIt4UbI9a0e7l/YqLu/jWJCLy0BLRX
	mcCtNSo5GuYhhgefONbGfPSsjJXq1lIMD/T2bfxpy7BG70/7x9MDS4/HIgp8hUSgpG76+fI1Oom
	VWdXpN5uWfQwBiD1EO3Zf7c4aqwIWUzulFUCOIltoQg==
X-Gm-Gg: ASbGncs2N/AJ9gdYJLKuLKg/gcqEpgGSSE1js1MyS3jtiKxIhi3w6lRrJBKtDpUgwYr
	wmHNn85gXkbSmW9T5aE2SFsINV0WnjFyAnl4rrrn83gXR5RWZp+V4zIXVno5GvQiWfF6xXL5nJY
	L2rHllyyptC9BN/cJwQMeA4nHYMyU+3rcDgi7EkXz1ZeJJtaSo8iA0WxIhV1rHzfiaTHhX2ce1i
	lIS
X-Google-Smtp-Source: AGHT+IGEh6SB30fkcmC+199qbpjX0r3BqIKS3sw8e3lSBzWmK/ljta1EXwOIfbMVsKhuNEa8XPpUCG8Qlsu99yKtbwY=
X-Received: by 2002:a05:622a:4c8f:b0:4a7:693a:6ae8 with SMTP id
 d75a77b69052e-4a976a5f504mr27032481cf.52.1751433809683; Tue, 01 Jul 2025
 22:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520201654.2141055-1-joannelkoong@gmail.com>
In-Reply-To: <20250520201654.2141055-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:23:18 +0200
X-Gm-Features: Ac12FXxE-mtsbFeXsaqVlaKP9PBrFjVnAcBl4Si6f8e-uuNsZCH8bywB8dsLYmk
Message-ID: <CAJfpegsj9jeD5VSNLXy5wPFhZ9cyQirNTd9GXNufiWtnZ+yZcA@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove unneeded offset assignment when filling
 write pages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 22:18, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> With the change in aee03ea7ff98 ("fuse: support large folios for
> writethrough writes"), this old line for setting ap->descs[0].offset is
> now obsolete and unneeded. This should have been removed as part of
> aee03ea7ff98.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: aee03ea7ff98 ("fuse: support large folios for writethrough writes")

Applied, thanks.

Miklos

