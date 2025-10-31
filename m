Return-Path: <linux-fsdevel+bounces-66626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC5C26E63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC41A24531
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997903254A7;
	Fri, 31 Oct 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI/PtMzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DD3002A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942867; cv=none; b=Zba56sivIZnxJwqJWAhEu1LWztR2IXI6o24OrF7AFqQUNnzT6G+IeoPlquycDcjs/hOl1CmDw1l4Y5Hgk//hvw1VFr2y0hM824dtD3CgTIOEJoMhDujMGBD/rSP1lXqnCBNPa8ILkq+h+Sc8NH8x05JA7LWkPnrkylj/ooDINWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942867; c=relaxed/simple;
	bh=htvbbyuLizdd2EyBJsklrXXtxab70iENexSgPdZge74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0UUySPADg4ni2AY2PfH13PuUERIWUcdF//rgHni0LNrOA2NGlMJL17oL483hCU8vg8AEclcG3tb+ChJhWC144613S9q0RBPa+lr7vXeMx95+L11tj5epKBQ/rJunDVhHuarEwgkqCT+U5xhwnkzVGKvwlRZmFM6yFO7+5+82VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI/PtMzR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e8a25d96ecso40381241cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761942864; x=1762547664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDDdID9QoXu76MfnHvL4AObFRmpVopoqQ9rOn2Y4kzc=;
        b=TI/PtMzR039fAlJz0SMreLWF2jZ34oNnowibS6wEt6lk3lqtHo96S1BXN9H04V1vVq
         G2dUYwP8MeOSIZcV/6teERBXvfLZuJWz52788STm+FAGXjobM4xDDVVtfnBuo4nLNnYR
         OIjpGMqDbbUQTLs8ZG1s+5vtyuhkcYbm7lTBl2VQSq3ZJmhZ4obySkJlUBN2ynI9sV3i
         k6FWG/Zsm9QVk7lV94uhrMRvvQLHf3AuROeUx2dC9G+HYSAeBjCcij0eHLHxrL7uv180
         EFL4yOI81fS45TKBI+A05cJsmFzkD8OONhVADdrgW8//Drrl49lSbqxBLEF5b/HPH7j2
         ZQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942864; x=1762547664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDDdID9QoXu76MfnHvL4AObFRmpVopoqQ9rOn2Y4kzc=;
        b=Ipvle4DXCTxJ3t6boqZMkM5cjvWkmXgmej/o22jFem0IlBUYtf5p1wdNIATparxrqk
         rQ9fsr4RyI8DREDFF2rFbFcC0F+b/kiksVaOocOWgIIJwtPA/DD3hVBNLOBoH6vzgGSH
         uKGSV1w3/Rh93EM9fB6G/FHDtSODyvMlWz8fMXaKyPk1ezIZKhFefBz+rCdYTORZlSgH
         7JKd8LI5amm+krktlJPJvbuey5sCV860v4RZ7xrjES+aQWZ6KebNKoKGDUDucPo69I+v
         42p+hKSbH6MYefHK1Rahh/C8dERHtXYj6fuw7lycBQ46SQcoUeBiSeOC26QpND2iEttj
         /4/g==
X-Forwarded-Encrypted: i=1; AJvYcCUownpAq5iBQKkAB9Bu6HMu7l3qt+5sNEbHkiwkQo9ndi2rHPNOL+gR3Wtq/0tu+m4R/tYzIQH4QTMn/YKo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x1cRpm4B/ePlH9JWjkWZ3sPkMtzqMvNy6oC6mWRrxB3qtd7O
	Yd2E6oOdyBO/5d0DHqdhXXoSqf6KELb91pUztLoGKKkoP/3f4ZFnskl2nb22c29ju+Ylgrod3Y0
	qF7cDKgFl1IBqEdN94OiT0mSivLapE7M=
X-Gm-Gg: ASbGncuKYpQKQhSNsvOvWUjKQZZYlfEZb3lOebWhZW3CndewJNc967foer8VZ3rcpfA
	rxhlq8W7nxOs8yTMhyaD4SIf8LTXza3Wk7G1vg6mMux7g6FT56ZmLlLFxWNVUEnVg2f+s2ComPP
	ZmlZ5SctnxNJ/LEDDRBncmJog47lSjM8o1cLb1D6ee1QMNvKrpdlAdFBqAY6ur53xr3BUdUoeme
	NkwU+viv0052D/INFevCilTw634G2G6G2uiaoQu9KIIa4NADrqYoLk3Q3eVVVHXIcOFCzDcOlSz
	BmzWVaW3KnGJNOKMRdRRrH2KO5m3A/hvU/0xN91X4Bo=
X-Google-Smtp-Source: AGHT+IEDvrBjTUOHf5upPxqP1SCh5zjuQKC+EBItLAQ29olE59LSxgnMb+U4nQAv0GZ8g2QKtkPg6xQmbM1hE77cX6U=
X-Received: by 2002:ac8:5f91:0:b0:4e8:a97a:475 with SMTP id
 d75a77b69052e-4ed310aee0cmr66087181cf.79.1761942864310; Fri, 31 Oct 2025
 13:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
 <20251028181133.1285219-3-joannelkoong@gmail.com> <aQHSig7TWRQyRDi7@infradead.org>
In-Reply-To: <aQHSig7TWRQyRDi7@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 31 Oct 2025 13:34:13 -0700
X-Gm-Features: AWmQ_blRr1ErabTzXSFW_hLdcI0NVVnyI6VGyWJ9C3EzP4Zn3UxBmVITKUsqSfI
Message-ID: <CAJnrk1Y15ZvvLLKW0PHB_-Tudd4eO2s_VWvfvLsKxug+wUtxmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iomap: fix race when reading in all bytes of a folio
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, bfoster@redhat.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:38=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Oct 28, 2025 at 11:11:33AM -0700, Joanne Koong wrote:
> > +              * add a +1 bias. We'll subtract the bias and any uptodat=
e/zeroed
> > +              * ranges that did not require IO in iomap_read_end() aft=
er we're
>
> Two overly long lines here.
>
> Otherwise this looks good.

I will fix these two lines.

Thanks,
Joanne

