Return-Path: <linux-fsdevel+bounces-63515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E369EBBEE5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9A164E74F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC51D61A3;
	Mon,  6 Oct 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IwdhxAVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DD246766
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774513; cv=none; b=Zlo+GW/2PXUFKFPeNvzXroBaH0m2qHeVxVo9ocWmWIzfTFZ1PyQ6u72e5QX91hW5HfYE842rrP+yrvAKDv2rpaHhuA0P5X9rVjoE7dkK9Lkeyrwi6zaiwLKYzq88+I/wojpG+UMSoma5TzOYEMN3FI5sTNfnB4asJLW/tcpet98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774513; c=relaxed/simple;
	bh=6KBDZHR58px1OGgtFtHwdWI93G3z3DNj8TlLWsV5yeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3PumvhHGI8A8ToTH2/+mmPNiz+diidH/dl8N9OcnzlDO2RZpkcsDVPzyGstKD2tk9SHqtEtGcp4geBWpSCQuxkvbriyjWOXkZbFDQxYQXUkdYoCBOCwF2Co7yA2Ua/LmlP4uLMI9q83kEr7ui0Y7ILQ2niq+EKuaJrJklSMMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IwdhxAVq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d5088259eso770232366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759774509; x=1760379309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+IrJM7m+IGfKJ5wujAoW0yQ4XN9nNk26XjqZOP2OaE=;
        b=IwdhxAVqRIb/gGCvT1z8AQyAX7LBwJMDryxGsdq9IIePf9O9ujtWl7cj1IjSfLdSMq
         UIQH3oLb5c6+1EI6KbGNiJ2XHCBCxbOzQWK5wf26Xnwi/3zaatmJJgdNQ3b4tVjZaSjI
         4N6+n4krA3Bil31Z9lUtO8ilmMZqOetJ0LkwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759774509; x=1760379309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+IrJM7m+IGfKJ5wujAoW0yQ4XN9nNk26XjqZOP2OaE=;
        b=kwEECG1BEidsCdwYR4uukf9Iscyw0zmhKJUsaE00SeHUjPGE11IPMY76v6CIUBX//8
         uG5P4fZVfNEeMZmPGCUmnzdLoFAPNdWotmgH2q66K7Is9O4SkOMTmblbpjFrj5pr2+fB
         RVifOljnHhlMe23WR0rFJrCvUTA9qBAxTWWvp/+8ekNKqBbsf2sLiv7+CwJvjhXbkqlf
         kiguz2H9w9HI7JRvtT7nvkuhkc4PTPp+MUMj4dr6dt6e8OqwsrPEv01Ce3wY3o+MRFpZ
         xFHK5g6OqPpa1o02+avD70RpW5AxVRGXG/5hnJUwnweuQ1JOeEB/gjw3oJCk8m5UA4P2
         XiXg==
X-Forwarded-Encrypted: i=1; AJvYcCVv9457MT73GEt4ZAbiUNYm9h4V4cq8S4mVnNHR2h2IIkqEDfSVCwH72b7WpdBdg8OoEmXjrlUNPuJIgHjP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b+y0typjkTWVAEt0YvaGz5yQw7PHbCTIn/gY4D4X9NlIOUL0
	ep7VyH+F5AQe4sCQCqT0uXSfvecj4Mqq/Kj1qTaMIw/R9KhhO8gmAq4pgau0pI05QStWgZtSr4A
	WI0TKJhA=
X-Gm-Gg: ASbGncvkwZ6Vv+aTogFFBqzhVSmuxbgFwwORsKMxTsk2XZSvLiLI1Xrio0yT6P7PU3q
	y6GaH7ZI0hlU5gEUBVENEFemTYYliDzvk9mJLf0FqgMVE8a+jpQzPcqt7OV35vmPF5SkL1Kif5g
	I4GviiRgMc5pKSmMG+9zhBWnRqQZISNiYTn4v5wIm2O5vQHudb50bL/LlEd1BD2ZGGCNMgGgiEI
	h18RXhGbRMrCXACBqyh6jtPs2sXZASSt39fNjlWQCTrevEa0u3vYVn9MmpVS10yn9S0/nfoH+rU
	0hZODrwjjr1A+bIQX7E4bZu2hdvXEwdm2Y82zODxbUE/GR7MbtsZYvNryhO1sXB//pFYJ9S5lgg
	+JEDADXhLsZg5gC0mMYjKBl4CWFser2a1GLi9i9Y4yh+px4EWLWuP6QB9UFMIah6QrT2c+ZbV+9
	pGflajOB+fOeGSx7QBe0d3UJb2tgrekzc=
X-Google-Smtp-Source: AGHT+IF8yLpaJWQcjZwsg8lUnRCx9n94Q/NTxHPPoqX2bBETelZY+5QeQKKaeGVBi5Vh2+L9T5WpOA==
X-Received: by 2002:a17:907:94d4:b0:b45:7cb4:7d3 with SMTP id a640c23a62f3a-b49c3b25ecamr1766552766b.32.1759774508755;
        Mon, 06 Oct 2025 11:15:08 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865986505sm1189147766b.23.2025.10.06.11.15.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:15:08 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a16441so860236766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 11:15:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGpicl5PzIsoOiRVb4DhyrO7MxQ/wSFkfc1qhPrEsqdEISB46HEGGJlokXdicGPa3QuqgVIUrXDp4xq3YJ@vger.kernel.org
X-Received: by 2002:a17:907:97c8:b0:b3f:b7ca:26c5 with SMTP id
 a640c23a62f3a-b49c44b0c80mr1722317966b.59.1759774507739; Mon, 06 Oct 2025
 11:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com> <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
In-Reply-To: <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 11:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG4TYkS+Ns0hbx4XNbvQN-BAvq9_ABJz1bgBsA4NPDAw@mail.gmail.com>
X-Gm-Features: AS18NWBukV_xtmU11JJsDRqxO_VMhKc_Ul7jDhpyeBLq29Yx3q9wMoG-6X-gkno
Message-ID: <CAHk-=whG4TYkS+Ns0hbx4XNbvQN-BAvq9_ABJz1bgBsA4NPDAw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 11:04, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > So I think you can just change the seqcount_spinlock_t to a plain
> > seqcount_t with no locking at all, and document that external locking.
>
> That is not a spinlock. It is lockdep annotation that we expect this
> spinlock to be held there for seqcount write to be valid.
>
> It is NOP with lockdep disabled.

Ahh, right you are. Complaint withdrawn. I had the "lockref" kind of
thing in mind, but yes, the seqcount thing already have an external
lock model.

           Linus

