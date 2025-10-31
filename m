Return-Path: <linux-fsdevel+bounces-66545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2CC230AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 03:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599F2404A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0C3081AB;
	Fri, 31 Oct 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br1+UGyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE62C3271
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878499; cv=none; b=DYGmUTSOo6Jbit7Bkdi+mmqTf0+EP+nQ2A6p4QK6SDMwuFBk7dzhLeOJELQ7+bSiaZ+u8GrNvP9ZHDinknxIk1Jb7jcUGVMd8cI2+UUBanpPT0FXeTJfgndqWkTWkkE7jFHJwbYHWCzroNBIlF1WS8TKsaGJtMcgRXYTl2kYwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878499; c=relaxed/simple;
	bh=2u+ToT4fF4FadWMbfDJ+MqfqCPPK4iSxquVlDoG35QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMk+fFx2VthyPZtraXiDBbw+Vj/hy2KF32z3n+8LFbPxrx4FGp96a1bu/OubsS2DjV/G3XEm55yqVFMU+fjZL1ZT/qq3J/H9bRLczFGEXclOGcAMh52TjnZBTIwnfsBouCAxK+j+p0ZEwqYc5+bGr78qWjfOfh28WC9uv3gwDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br1+UGyd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4539dddd99so422576766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761878496; x=1762483296; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8K4f+qBwafVznhIbPVk3RvAHNaTQKFSCyEiTyB6/Js=;
        b=br1+UGydjZeR7RfirmrzEThgo/pYw2KNaNfuHtaOQY9DnKNwFLgs9cbBMQ52mcUAtI
         3Is+2LsBi3lWXGGYC4hNchKp0SP4BOF3hcvd5ig6DMBO+grmfHj1c1E2JOyg6lG1PxW5
         Wz4wiZLQP2K/RvIY6l15eaFLoWnpb2nDmUmzrtwF4Ab2LxJWDLzl4MgesD3tcWuHsKDi
         wNyf37VfW9cL/OZqTZKzKNFlQ53xamlJb9AziWmz2WSb2K9FpZOdh4vbQbpRCGeRBeXu
         gXF0nz5B/Ed7BP2HBCAMd2Wldr5qK5ZaQhJ4m+XD9/ARYkrbzqj6TlHvfLHcDvC54Lu3
         x6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878496; x=1762483296;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8K4f+qBwafVznhIbPVk3RvAHNaTQKFSCyEiTyB6/Js=;
        b=rWpyb0QUqREm3OwoEo+cNGeUcUVeTHgcbuY7wDTyOAw1rWsIKXlAmdxas4QwwxE+i3
         JJ7LxoD7fHfystkMtFsCPnEQgoT0IfDwTCtmOlU03NaRPbm/yOXjnXnEuQXkYJuCE/Ko
         yEqaG9Eaonr8GraFdTRAD1uImJaxE2UQlWh9OT9DE1k9wI+GX9O73+aexcWKwDjG1dLL
         H9X/hkN+l6KcHh01u+uYq2z+l80qkQwS13uKBfLnndJGdt9O/VcDo8Ob8FmmrH4jDo5o
         mqs5py7j6FguKmq+mq32mNJAdmIGJX0xMUS+k13vF5EiDl+HUSYBbCL6Q7NJEa90tp2v
         AhSA==
X-Forwarded-Encrypted: i=1; AJvYcCUl03pkOD4GNuMkW41Lxg6WLcIwzyHl7OQlg5NmnE/MV4d4rLjWzRaCMoPPeRz23Qq//hRNBvNRFqTPvUI+@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPn0355ovE7FehRV3pS1trbbmPH0wn7ZU82TA0QYFuXdA26Kq
	Vw0YOlGJfwBZP5UBqUaXKYYFeFaxomYjQp2KFBrwtcCZMHUYYyw2gBbw
X-Gm-Gg: ASbGncvi+NNJnXckQXq/z+KCWCPWChENswd+CSWwD0ITqwySAp0wLEDPcWWMcpZzEPK
	wNMG9aMu4skqL5Y7IyRkCRjVfhQ0ofw9MvCNF+f1XIsYnTl5ll4DPlG9LzV/5O5qg2X2lOkWS6m
	PLW1Qg/cFKqmZ2suP6LSBypgwHLU43+KERfnRxO3dic1uddd3/XVRjhFDdEVNsz4pWxGkSQV2YB
	4FcwzYVE8RQvHrYe2qTyhA3ZolSbmHIwozreslOlDGBrSZfEER2UhQ+mAB7tdfFA2HezoMXdC/m
	vi6lxHLn1tTuc1RNBWgx7sTTJZV3MZRCopCiXQzAIHwI6AFKojEb5oUZbXqHzy2b9/5+ZOOSRu6
	B/lMUwFUEmOG/HiSsSpyIEVMED5O8mgfjguJwMnSzlNx2yqW3EEJtc8lbZeN5Ii4iW8UU8LHK6T
	w3xwd0oI2d4A==
X-Google-Smtp-Source: AGHT+IG1AXC7Sm6OYw7C1ZASw22VMDmIY0Y536r5bQC6IFq1Acx29vK0ChgCjRiB9igtB/mts8AWKg==
X-Received: by 2002:a17:907:d90:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b7070844419mr177169766b.58.1761878496225;
        Thu, 30 Oct 2025 19:41:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779ac3casm49556966b.24.2025.10.30.19.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:41:35 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:41:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <20251031024135.r37lpni2vw32wkiy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:19PM -0400, Zi Yan wrote:
>Large block size (LBS) folios cannot be split to order-0 folios but
>min_order_for_folio(). Current split fails directly, but that is not
>optimal. Split the folio to min_order_for_folio(), so that, after split,
>only the folio containing the poisoned page becomes unusable instead.
>
>For soft offline, do not split the large folio if its min_order_for_folio()
>is not 0. Since the folio is still accessible from userspace and premature
>split might lead to potential performance loss.
>
>Suggested-by: Jane Chu <jane.chu@oracle.com>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks reasonable.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

