Return-Path: <linux-fsdevel+bounces-48804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B177CAB4C96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBA189B88D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C541EFFB0;
	Tue, 13 May 2025 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H/U5yW85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B71E885A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120771; cv=none; b=VHYv7KaveNvmcV07UOYjYZrUIKOqlDPoCU38XVPbcUuaJgTxSXlwHtRYHSbe+kDihI2koMSiBVm5GyFnqd87Dr8eOj94QjH6ZKU1QWCGP/GLd/fJ6/ZJJ57dDdYMjtjDM0xNDIqtqCuaYH38VOpmsdFgex8q54009Tyr8TviQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120771; c=relaxed/simple;
	bh=4Qx6NyBkcKaqwv3z/SzZWQwaJjYZnPIzw8EWDI4wvUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvmiDfTPKndSPDr6fow6FcaZuPUP/h1zTp/DbZTLD1YgO42HmQaS8oOQPB93GVnoMXrCLIFweTVfvSzlFEbKsAXFYKungKbhRGPrbjVqaTzXa204lzgk796avTO0h+BmUhdwX+WoRjRSuZlf0jnKMD6c+faCigye65J/x5KvkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H/U5yW85; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5ba363f1aso864477585a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747120768; x=1747725568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TJqxMXRsyTR/EBXbAx9Bxzflp16jQDj46oYOWd8r0dA=;
        b=H/U5yW85AAURa+oqqzClAcfLEsoMh1WBwUYSU/q2Vv/rkDXHkhb9HR1COSs+25UYze
         SpOm/8NOiKkpBSTS/YnFqFQxAZcE73IorN289lA1r9TBiRvmeKRsYAksoFNbz5g69mck
         s9m93BLgyxrb0xQ8JhAemfciJ/s2rUrhAd5iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747120768; x=1747725568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJqxMXRsyTR/EBXbAx9Bxzflp16jQDj46oYOWd8r0dA=;
        b=OBiagOcKkvW51Yg15nv+k6fQMuIRPLl/76rQH8rNZZE70pLyrO26qWCY4JFNkvJ+zG
         xAxhKlSZC3TlM/mj9hoij3QHSBhf4KmVwXBZ9ucKJDEIMqCJvR3Pae8amHIYvr12aCvS
         jLen3UP7pnqNzl8gWAHSBlPFieqskabjgf99hiUojC6DHH1gsWobAVvV3E6FCKeBGaPU
         oDXUNs4utopj+IFX2UjHAppjrB48fBXcIeF9ylGQbwdWp7E/PeitmLklaOczcxnKQ7Bc
         lWQ03ysNuC1o8JwazaLrRRkQPR+w6EefXkjNDPysalgWw7SaSKthip4/aPqsdqFBat7S
         TmgA==
X-Gm-Message-State: AOJu0YxU6LLaKYJfK8pLdADbKMhmZur/+S2hVHG2l5i8TZPAVBqsVR9p
	Nk1iaxl/XricQfrVt9zSqLu53PHIVpdgLM3z2bw3fNPTSAzrR78lQWhggNn9jjQ4YwcUKnyVKDV
	5X+vA051UkEteEN9ruYCXw5VEEwPFfhgum5DPzrxbBn8iKHAG
X-Gm-Gg: ASbGnctlrpeRHJTpxUpFbfGImvp1OUf55cVDGkhL7MnJf8WbpNFMfPMav16lFr7E7kW
	04kea4yCQYjQMtlnkA4MLRdISR3o1XTXO4b9b9CjniyC0OPqdTe5ftzzsO27ueG+nd3LP+UaLCw
	dNFIlfbHn4QBDgD1KGpPlsXIQjSo5pYOc=
X-Google-Smtp-Source: AGHT+IG1mb+AG3fT3eKVSsEkso4KkAupvFMGQvIDV1ILGByPvnKHDTQXZEOhZCUczNAog9mIXTITxkOhIzPwRvKQilE=
X-Received: by 2002:a05:622a:302:b0:476:91f1:9e5 with SMTP id
 d75a77b69052e-494527dfcc5mr261704971cf.50.1747120757751; Tue, 13 May 2025
 00:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com> <20250512225840.826249-11-joannelkoong@gmail.com>
In-Reply-To: <20250512225840.826249-11-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 09:19:05 +0200
X-Gm-Features: AX0GCFvvguO_3BLqDsKf0F6irP7EVNlb36-aGaxmfYb7COmrkDCTob05IkXsbJA
Message-ID: <CAJfpegs=3mhpQeXhu37HN=p846UFzxEg3NM9awwLwU+cKr1NZw@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] fuse: optimize direct io large folios processing
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	willy@infradead.org, kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 00:59, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Optimize processing folios larger than one page size for the direct io
> case. If contiguous pages are part of the same folio, collate the
> processing instead of processing each page in the folio separately.

This patch is sort of special in the series, since the others are
basically no-op until large folios are enabled.

Did you validate this in particular?  Is there a good way to test
direct I/O on a buffer with mixed folio sizes?

Thanks,
Miklos

