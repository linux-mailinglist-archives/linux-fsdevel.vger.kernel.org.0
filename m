Return-Path: <linux-fsdevel+bounces-66411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B7C1E24F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 03:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE533B2414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159732ABD0;
	Thu, 30 Oct 2025 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICYRryuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBD32AADA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791933; cv=none; b=YKmgwqaCjoTCkSKRkNaVpYocjLXxb5g2m4Q931Gb0Ylj5ALq8+Z4J/g0XLEqUWj/Wx62EPmmKHAEMSjoirvoGRrHQIuoAXqUeM/v3pOGEdr6UECll1nNaKLvyZHltP8gGgGcXHgWPkr34+2mm4IKYqrQ9pt5arGZIP0zAa8CABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791933; c=relaxed/simple;
	bh=AMq5LFLTBTjPLCaeK6notQ8mgN7CLcxdcRwOBe7Vz8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvTPDim7vGU4cQJBpkh+SrlnBjz1skUjcpN2OHQsStXiEkxi1R5Icpn3qMr/oQV0nej9qPLzlaXMaMXPb+J3afNGcNpJn1Bp3j6AMmV9L8qVO7Hu1F/e47g52rPJ6UwJNehB7jYDS5RIWcuTmDQR4ryRHvo+xLs10T75xIJPYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICYRryuQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89ec3d9c773so71989385a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761791929; x=1762396729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6nNeYJj47LC/Yn9TG11EugyfogPj0qEsWlsX47jJWc=;
        b=ICYRryuQ3Zoa61UiN7eZjBOI+unPW7wOiyiH7SWBFz55mjPypcIG92V6gpuXnYxRri
         2Nq4S6EyXzuBstu2FAb+7DoAl1H6GJ0tVH5iYOgj0vsLx+YpmfWbIww4Kn132k3B7f7W
         AGjAM1XJNonMyxfwiGQgKo9eXCD7TvIvETpicuiscPH+FIn6JOJ/JrrY6A5JAbMb13sV
         pyjpwzJw06MGfJOr/KJTx0fmSb3X9AkSFmJy2/D4pmHl608MDkx+uX6XD9MsKct7v4NK
         uO8/XIllpVboFMvcIVT8kLbAp3GYXO3JxSERhakJDmx9/b84woF2es1sTkuQhxRCb4LC
         G+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761791929; x=1762396729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6nNeYJj47LC/Yn9TG11EugyfogPj0qEsWlsX47jJWc=;
        b=SwOr/gm41ssyhl65QIBpyNXyqW/Ydp6AkZYVBeiUnWaZih3KQuY9q0rxW7zAFXJjTy
         oDIBJfb8YdN8alNiR4vnuE+8Uo/JMgTiF6T562mScIDamXyQJ8ijwfoAdo5AcXqRKbQL
         Rjx9ahgPnZU2NrtMs5lRRnM5XpN4fGgiVxg8zu0/dAxfl+0KO65od3TASVPTa3kJv7N7
         2RHaiDRBGARGDWjpaDMk1pmxIrlv0FEKBcgrkEodNL7X6QYupT10tXY+I75QrAF9JTaN
         Q1IjnWAVzUAt9lWeWKfSdGwlfAqznWu0CR00Ly0WjqEvKKlAHJzp3N1w2G8OntglJqd9
         CjHw==
X-Forwarded-Encrypted: i=1; AJvYcCVdu5O+0gwUMCar/vSoQBISV/B1NPJlxe4KggEUESrBj6JoCLuJIghB3PSLTr8B11mI+x1rsGvqzWdGUCFb@vger.kernel.org
X-Gm-Message-State: AOJu0YyikIEijDS8IgpL1Tl4481sn0gX96YGKQEL704l5OlXU3OLNeQj
	XOfwCwGpf70mE6J4VQ0Fez0b/0IoHoqDgjzo8zA9D8OCO22DfXErEKr+gS85W8d9i56kRadBYS9
	IMyHzmNJnxOdEuJgf0dSTlBz3WXUd270=
X-Gm-Gg: ASbGnctod6iBZwWp5OXXCJuGLmWmJq6N6iQji/E5M1dX0YhB6KNV5PlnuxEwcqzi8Ik
	CjylxvaYck42RSVeFyqF123TnCn+OnePkf0nxI+fkzn7bm/f64XHZ8oYPGbKE1ZSoQIsjoS4vVC
	isEkNYjV2J+Addmmk6SVqEe4FP6YnVOTQoLN6XJeUsw6guB+YnW+WlWXuBv+ndzf8JGUB2uq07N
	xG4f18PES3SVMDsuTso51PBiR2CCDUcywH1jixZzmO+3psH6m4XzLXAqF0n23pPnAreN5oAOIcq
	JSQAamxRjB15iDjs
X-Google-Smtp-Source: AGHT+IH/NdEqkxVdErKm21bKL2gsa0HivcBd1sC5JLSxUC0NTL1b+8ekEWLzZcLSO5WqylHT28D8+ZBosG8IrfbuoAc=
X-Received: by 2002:a05:620a:6919:b0:8a1:c120:4617 with SMTP id
 af79cd13be357-8a8e4ff156amr776454585a.51.1761791929275; Wed, 29 Oct 2025
 19:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030014020.475659-1-ziy@nvidia.com> <20251030014020.475659-2-ziy@nvidia.com>
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 30 Oct 2025 10:38:38 +0800
X-Gm-Features: AWmQ_bnlFtMc3CzOHCzWJ0c5wI5RvGU_i4SjVvno9Biz6ZUIiW7knGxWCgCNPkI
Message-ID: <CAGsJ_4yYrk5O29_+YdgufPCJ6h2xbEE7q4EbtFPCS6xqivWFug@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/huge_mm.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

