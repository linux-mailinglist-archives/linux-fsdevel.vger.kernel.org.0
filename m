Return-Path: <linux-fsdevel+bounces-66414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA4C1E512
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A623A5593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 04:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E12E3360;
	Thu, 30 Oct 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC+Om3O6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25672E03FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796917; cv=none; b=GhByC2GiDQg9W//R5sXN/lVSCdoy2QuO8zYu2lLemONU5fXSekIRmneqk0JCgSUMEpc9Rqr1D51K8gjun+yOyZVjcw/RkBwa43KFLq1/oIZJV/l9HcRmYU6BU17O/3rup2t/6IP1jfNXBQqUjngxLYXGd5BD2HKyHmUwAKWuo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796917; c=relaxed/simple;
	bh=XvJh8DPPRrrqi4II6H64eXLOtWkRl/bvQSKOoolKeXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lryGb10w4wtavIBacTnxk/Hfra7fiVQfH1wbkKHcQUEz0p7n4K8d5bZToQLI3x5BIq3c/ox99i7WBxQwj/47nWZIjmA0wzZ50YKrMCXKmblhYxIKVUF3d+981CHZiPmGqApIGyRJ3XeqbDHo7DO3Y1NDy8UhkGC3qp1iI+obI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC+Om3O6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89e93741839so33442985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796914; x=1762401714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvJh8DPPRrrqi4II6H64eXLOtWkRl/bvQSKOoolKeXQ=;
        b=BC+Om3O6ShLmz+JSmUk6m7IiPKJOlmHt1IwSWVvPd4dUav/Vwpe1K2pHhaZ6vySOsp
         EteBQ+ESikurnUITseY4xUWfoMuK2f6EcozcsgDq/b9dQXdgkRqPgBg6X6cqD3wK3wI8
         KdOf8Kz3uNEKEg20BoTQaaip8xxW+t+tAdakgb8IJcL6nMf7jcILRmJFzn8n9Tbnqrf7
         ZPhZSuQgoFipOHzwkP1nFbE2n8p5Xl4K5hteTfeOsp70dFeU1x7APr6MYK0pgEVuj9A0
         kNvKV692l1bj8zZW2AgpPzeknzCXMa8Cb8ElY8u7/LZE+HC5+PtTXjmpKitPRpk4YuHF
         jfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796914; x=1762401714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvJh8DPPRrrqi4II6H64eXLOtWkRl/bvQSKOoolKeXQ=;
        b=HBmUmwyBqGi9Bfw4MH72KF1iMdABVv3nj6coxC13sR8Ys16gECa1KN6L0YrF89+Z4u
         r8Q9B1tKVU7hD1Anyec2x10zFKUkLbg3d9BrZ4wytJpivnGyhy/dVQnM8sTyoDcWfD/b
         3wV1CZDkA4/vE569JXMFukHI4pEddJ8yUlyHCRipzi6CyQFCo/EJ3005wB5vyl/5xznY
         +2L1AauPdwH2o8mNzZjfHWZ9dXsJ5aq01aVZRrMIMTXFYCoSZNM9lrzGYhWAmnsAmtWp
         BWdD+t8ce2J/6UvafgNp8ODrF9DaY03Pnl8XJZEN/E68HSJfnyxmZe7YHl4YlYlVbA4j
         d+IA==
X-Forwarded-Encrypted: i=1; AJvYcCU+gs0Th4B+o34mG1gqmWgiNlj1+3IbNSpofzRnH/jZ31PM+kXKKMtUr3saBrBKt9G9u9pPi4Se0akY25qJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2/pHWaEVotXdszWBuVEXC9ME+c5IjbP0dgKhEgWo0GMZ84gg
	FlOFU9lMeT6gQwwiDkj2RQX/wApFBQNZF2IsH4ijaBAkxM1z3ZuEsfbaAwNZqieR9d27Ep339Cc
	Wt8wM9M8t3M9DaCJBamUAdkqkrHywgx8=
X-Gm-Gg: ASbGncsE+zuwf3WCeGK6QDkt9XVJd/jLBYbLIaZ/sUV7w6PwV2IlkJYD757Ug96cOlr
	irSIQ4QCGczLIEFxpn0vODScW5wdbcsRrGdcdv3V7wSWnFxspvVzM4u6umVJ7m5BcKJA5/SiVs3
	Ah46fGqnfnK/JCSUT6ANIxC2YazyF9aIZ74riurjxyrueJuHf4uHhQP5vkB526dgvcuwhZAHfu6
	DyUNvNvHuyb1bNT0Mxx61UkapVS34yclGDoQWZ6uVk/B5e8j1icrfDf+cXdOsxxTj/yhOKnMzYs
	uauvNEspRFlajOLG
X-Google-Smtp-Source: AGHT+IF48vQzRiKqweTZJJggP+JY0guU0TB/X2xEN3pnwgukLV9EXGhO/3BkSXX3dJXXucHnKD2G70eNio4983qJvIM=
X-Received: by 2002:a05:620a:190a:b0:85e:24c3:a607 with SMTP id
 af79cd13be357-8aa2c658c8dmr223728585a.29.1761796914185; Wed, 29 Oct 2025
 21:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030014020.475659-1-ziy@nvidia.com> <20251030014020.475659-4-ziy@nvidia.com>
In-Reply-To: <20251030014020.475659-4-ziy@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 30 Oct 2025 12:01:42 +0800
X-Gm-Features: AWmQ_bkyqj9_N4hgF69gIn9WT1YpTuvv0DmQVRfDzno9ZsTJybifNix7pDy5cOY
Message-ID: <CAGsJ_4zgpMqVHix3faFHRarP4+o4cuPbyWd_oT0Ym2i40i1E7w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
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
> try_folio_split_to_order(), folio_split, __folio_split(), and
> __split_unmapped_folio() do not have correct kernel-doc comment format.
> Fix them.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>

