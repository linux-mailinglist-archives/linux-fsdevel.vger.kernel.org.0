Return-Path: <linux-fsdevel+bounces-34336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE89C48FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B36B2DCB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38721BC9FF;
	Mon, 11 Nov 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bj9OHT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C5150990
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362883; cv=none; b=Uw29UYE7c0fN05HpIMmwxeHdBw/WPmErZiK2bnGfVcWbfinXhH4DfCOTx9nZX2pwqbxaBmElCjVvVX9AOQOF/KlZ14xhw3fn5aoYcfdMWujbBbndml7APVD9sily6li2UukZ5P2U5DppIP031j7I7MwdnlR/Zwl0D043gR8pqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362883; c=relaxed/simple;
	bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQJlJ9SDxMaiX0kZXhS8VbJOamd55PTLkTjnVFKriQsk592rsdko9NJyYxceq7rSylg87th5lbQprglYCLhfYhSsYA6hNuv9eIDK8WA3S/So6fMhPVS5IOuiUh0MfBsvSOFk3Kjr1AehjloRTj0EtK1ecUk12pYMxhtfs9cz5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bj9OHT4; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fdb038aaaso1631237241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731362880; x=1731967680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
        b=0bj9OHT4NDD762ZwKsKRkpOlf3fMbGnSYP0Q0IjgkuCX4mzA+3xmTbzvS/+98aJmbC
         x9Cdhrxu9PDDSvBSsQ0ev0LgPTYPPeP4U0658R6shr34d7nOaG5fJ8lRc/LmncGbhgPi
         wkCvrcxe43qhp+TAehCzPCTnoAYuhpytBK/frxZo+oRvKFmgy8u2ajjnCF+u8R3XUYSl
         QuU9uygEaM3mVjxEaVLqXlopoL0vernuSifEIfbXJlI0TMuXoONkxtLT6uBA270BU8Jm
         0TPbCznueXlvGESjuUukuk6d9vuy54+nPsFKX/QsJMy+vAuBqMbnfbAqSw/PFbVJ+rX0
         0jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362880; x=1731967680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vkw9aiH8d9WZpxuAadKWoblhX0idLaFADugfMPK2FbE=;
        b=ssV+GQQ+3XSTQPTe80Uj6vVl1YkjAP3G4WyHMaMpNrAIuQlZkeGm3Sw58+IwSw1fg4
         g9KTyKMAUmOCEcT+9JqiR3t+EgW9wbtJ2dhWzqLwginPMTuFezcwPfJwrRDIKrn+B7IT
         Svc3azasiSw0J6C+pw4xeN5N7/i6gCVUUuHVXgUjCIQ8i07vYJcPYusJfuoSLzKZ9sm6
         MxxbzeoNtj060hYx4PzgGFaxC+YbxS8wadEUkV02NfOOLbrDQeB3xF8DbpUUQkR3RLUZ
         hVsDVMwlxzb932q8TmYuR/KHTBCLHAKx4iDEWpO1UUtJ+kAt5w/b9vvJ/B8vudfcBmd9
         yJVg==
X-Forwarded-Encrypted: i=1; AJvYcCW7TjMOHioQ7kHI1QpXU63CDk5ZZhoCDjtN1wjQ3jY5Yq9kdiIRQbIgqdZ4F2wQVNTO5/rhS9dctO4lY9O9@vger.kernel.org
X-Gm-Message-State: AOJu0YykDlTCwAEXL7E7J3WmNfkTbH3tG92rCZn9M20d74PwoXK9b2gP
	9B2Hwl0BjYvKnEeQuPHBzxmH/qYbs9F8B6znuhvE0orc+sTIwK3D/y4qj3ZpVNq39lntNoUeKf9
	brqSuROME6J7i5P8mUwgeyBS53geTrqM2zXz+
X-Google-Smtp-Source: AGHT+IE+mJ8YJxgETrhDpFyAtuqtDnXfdwAd4OrI/XYP3rp++8cJXIhZ4Rh+GEw10wPDdRd2IdP9vdmQ22jlVDEDcUA=
X-Received: by 2002:a05:6102:fa9:b0:4a3:dd83:c0ac with SMTP id
 ada2fe7eead31-4aae1634755mr13500294137.20.1731362880431; Mon, 11 Nov 2024
 14:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110152906.1747545-1-axboe@kernel.dk> <ZzI97bky3Rwzw18C@casper.infradead.org>
 <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com> <ZzJ7obt4cLfFU-i2@casper.infradead.org>
In-Reply-To: <ZzJ7obt4cLfFU-i2@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 11 Nov 2024 15:07:23 -0700
Message-ID: <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 11, 2024 at 02:24:54PM -0700, Yu Zhao wrote:
> > Just to clarify that NOREUSE is NOT a noop since commit 17e8102 ("mm:
>
> maybe you should send a patch to the manpage?

I was under the impression that our engineers took care of that. But
apparently it's still pending:
https://lore.kernel.org/linux-man/20230320222057.1976956-1-talumbau@google.=
com/

Will find someone else to follow up on that.

