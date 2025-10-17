Return-Path: <linux-fsdevel+bounces-64404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29635BE601D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2091587BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 01:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D41F9EC0;
	Fri, 17 Oct 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpDHjNFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E92749C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760662919; cv=none; b=TjCIn0c6dCqdjUv1+vuk4RhvSkq+DYIFh6eLHFO1IXr2mbFDG4MoL3DB0hi867U2Jb3J7w18REabDw7RBVWLQUBNXRkHQJ0NuKiu/6bS5XjjsYsgwqIFSxTyZaMYDRUsekynJ8FkSUoLzUUi6BUDP28nHqnNQiHsXCt5s9uqE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760662919; c=relaxed/simple;
	bh=HEPZjJUFc93YXxtVt9Bv7JUcLpl8tmZC5BGGn+wKEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djtfNYgcGZG1D/0bvCo+/2ZEyduxVvrN82fut7DIazr7KY8DOoOQNT9PFfGp28KcKi2a4vvSw4upGo+RJhmd8VhevjpvEmMdSD4NeBu0iLqFgsMdFseDcN29nxbJNdM9IimWCP5J5rWhyiqBrt5zIRHnpwEh1CQKXEFy+REMMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpDHjNFG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b456d2dc440so202298766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760662916; x=1761267716; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhOCF1jngPVTEjHyyJfbBN6QhgsjGjoe1GvteHaugcA=;
        b=RpDHjNFGgYompwnFSM82j/XgdNQ+RxufxBh+XF+lCIHx1dZGxizxYX4DWGYyCw8dzX
         ECuKPXqEbonBoTREhh2kWpL/QwXEPm+zNPaU2Ocb851nVbpD561cu5x1/y3v5lmZl7PQ
         48Ubmz+cQdg6dwRw0KouhXccO8z4C9Co8BHrIjJoPTMj6DkrspYSp2eAZBCElXl86hrz
         xm14RLhr2qqE7G9VuvXRKFeoAXkL/zH4VBiwnOP5i024YtalLHyEUQK6QHS5og/Mx05Q
         z7AnnbLpIcGu+J6M4iu9DpKU8DRAYurt1CBnhRQpmyMpu8yW3JUa1mHjzvv4jBaOfsp0
         08zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760662916; x=1761267716;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhOCF1jngPVTEjHyyJfbBN6QhgsjGjoe1GvteHaugcA=;
        b=ibcNIMKeUcWM8hAeGBI/dVK+P02Gwavmz8iZ62TTZpndVveZuWHTptpgYakRoBGAvu
         h9vBtQGr4LKKSc3DZcj1bGbLY/A9+IgUYJ6QZsQMTpu/T9l1YNqeNhZyyY37gSScTmOF
         xHsJm9Ysyr7gTo2q51JdHS3OkJzQba1go/NaYLDi9bwbIiOtymhQyXJbNsewc/V58e0y
         V4RygScoy7vkIla2lwAo6Qy1lwsMnCBkaiPwE+xV28jEHdRjFAK3mX+JkKbHE4vgD151
         OtsEtCGx4GzWAlhqTel2oxeJLr0U3L+MTGYDtEmChp2brxyu7Wcerc5ngiQ6WSixVz4Y
         1/6A==
X-Forwarded-Encrypted: i=1; AJvYcCUqvpG/m7eXeGc3Mfo438kJcIHH4CaYB1h6qwf8JBIXitNzhna17tBuINpENSmnLzKPRws7CoSd0hXjM7Jc@vger.kernel.org
X-Gm-Message-State: AOJu0YylXiNzOp6rZltLLciUQqE346PYpvdbv3Z4cJykxGzReI3w8Gy3
	POaYNWAyMwhQOyYwgfR4mTTqhw3oZaBfqAYYQOSc05GPb8Z6pNyrTYO3
X-Gm-Gg: ASbGncsnmx2Mw1xSXipyMiqGWTkP8Oa+Snm3LVBQ7PUYqx2qlkkvBun7cvq+JV4hq77
	Q+ApDQgwFhcExC5+t/RJub2ihsDAYJPMyTxSPmIxP7JGyKftx6ThusdKTw9yJiKbLh0IdHmv5Na
	S0qOR21gHwnxu+du43ZPaNwmijOH+sBvYPIh7AD1w+0sbYOYNUmMB5v073FgY36cWV+rtu2GW5D
	zw4VnszCxGvI1IR48oJWer0zTpgnwoTu/S9sn37ncNASabf40I/YtFCB9c6YRYtMCc2cnyvzLJJ
	JpnDxO/wDzwvFcujCUQtxsKY8IMjIKmkhqT+T1kOq7pMhjlk6QihpStw7b/wETKcGmRyEBOU+ts
	wLF9MZBsbYlQyVClWGZP2bch5Nx3LPF+51bW4QuX1XN6FxS4i6H+cNIN4y7+wQrgkK2k4RQDPFo
	vEkjlpLG6/a8Bdo9uFH6akZlwR
X-Google-Smtp-Source: AGHT+IHw+KEl5rxSaF+lWRF3a8kte3TVt48oRokdAZeDiuuJF4LkZjJ7dkb1VCZhm2T8EQpxcxNUVw==
X-Received: by 2002:a17:906:f594:b0:b57:2ffa:f17e with SMTP id a640c23a62f3a-b64731447a4mr211558566b.19.1760662916198;
        Thu, 16 Oct 2025 18:01:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965dac0sm681744066b.13.2025.10.16.18.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 18:01:55 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:01:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
	david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <20251017010155.dnwu2bytfyoeyiaw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 16, 2025 at 10:32:17AM -0400, Zi Yan wrote:
>On 16 Oct 2025, at 3:31, Wei Yang wrote:
>
[...]
>
>>
>>> + * @new_order: the target split order
>>>  *
>>> - * Try to split a @folio at @page using non uniform split to order-0, if
>>> - * non uniform split is not supported, fall back to uniform split.
>>> + * Try to split a @folio at @page using non uniform split to @new_order, if
>>> + * non uniform split is not supported, fall back to uniform split. After-split
>>> + * folios are put back to LRU list. Use min_order_for_split() to get the lower
>>> + * bound of @new_order.
>>
>> We removed min_order_for_split() here right?
>
>We removed it from the code, but caller should use min_order_for_split()
>to get the lower bound of new_order if they do not want to split to fail
>unexpectedly.
>
>Thank you for the review.

Thanks, my poor English, I got what you mean.

No other comments.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

