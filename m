Return-Path: <linux-fsdevel+bounces-15839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B268944B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E421C21712
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41154F217;
	Mon,  1 Apr 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEl8l8Le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52D4E1C4
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995779; cv=none; b=HDBaHINj/NhKcTLXl8SGdtVMteKFh7Z5gu/LXw4PRpjWh0I+sUSfoKre36AMESJ5BIfBFKLH0R3cBvsWJXkPVhWJj+Fj+r6AzS/DRJ5Ih+x9lXTrT+GOQFbs/6xBAsAlHdR6/IPM5IOH7jN6OVULFYAIT6bEJefta1TX2WVEcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995779; c=relaxed/simple;
	bh=hQLk/BGTOPAEUco7vFSpF0kWrrAOjibl7vxNLyiMvWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho5c8rpxhMVj3HSTEw187AHnC/dvQb3U21tCwKvkdlKpVnWpZSeudUR51vVxzvBQ+86jA2heSxeUA9bJiTIt2S8n98zTjQUzE9PgbF4tY1gP2ECLuieB0RvLLUZ5w1ieTaB/kQeBFeoM2JcmcDSkZeE9N3nRcJUePSW3ihuJJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEl8l8Le; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc742543119so4222302276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711995777; x=1712600577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqcL6luk6kscEpuGjrpNuwg4YQx24thmV194uTw7GBg=;
        b=FEl8l8LeHWxwNj+qNd9ZszhJJgJxmIYmoSpMsXASsXiD9DTXqsp2D5+Dne1TdnjXm5
         wpN1X3UasM8OanklKNyHAjxz2ok5QcMcZuE/iDM4VFM6xqq+1F8zeWtpcr+ML2jEusKO
         82kSeEotTKjCesFPX41Iq43yyRZ4SwpHApYdhPdihGv3d6P4ycZ4bAB1fIfls1vVWcZ2
         wVZKkluYIUlJaoyVSQ5zVgm1lnCiMP3ZWRVUgQovvWfV/wSnJzqYUyINEUTd5lOjgTkj
         3CZ0+95vzXFXy4DNMmo7/tgBSjd4h9Kk80R3qHDOhv1rcdyn2fe85/t0fndV7f8Otrii
         pEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995777; x=1712600577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqcL6luk6kscEpuGjrpNuwg4YQx24thmV194uTw7GBg=;
        b=ACM+EV3AYgHutlAAVgZAUwCAQ/VvhhZOON95d4H2lOAJw+wvNGlcwu2BKjDxwPp7rX
         vm3OWnIhizydxJPO6+aGoJusYmJQ/Ruo/DHHIr+w0hCZM5raQvnPeWPU/wKuePKd3UKo
         BTCzsjhmbSPHsTm7Q6AfyER1RDYlx9GD6QaTA5OWhC4NAn35S/8XBASBIlLLIcdJZfNk
         sYmLeVlJGcL+clcybXOfqwi/3vGJx2iCA6md6y3CI3tWw2LR18j3JrwMtxd+J2DSgOip
         NLKIaetcz8x787le0hG1XKyBDvC2JHM/dEqCWXBSkgWApBocx/XdW2tSHwJfcai/y7we
         AaLA==
X-Forwarded-Encrypted: i=1; AJvYcCUlZy71F29xs+TYm2yOhBdnRYdOH5xOZqtVbqpS7zX7kYAvEG1iqGCauZufuWFF2N5c5Q8t0blJUdTaEoU9BL87JrWS+89sF61nGxG1Bw==
X-Gm-Message-State: AOJu0Yz8VTiH43D0Esytykz38E0l9ZztXUlA8DEvA3HBpo7m/dg67x7T
	ySnvmUrkLG0dCEtoixWAFMYyB1FKvMStlU/Z05NwWo72WRS3pad6
X-Google-Smtp-Source: AGHT+IHxP2y4eXn/f8tnGNAOq5CveogplbH+cEh9XzTpR0SsDVV19XB03S8TcCwCWNKt7Q2mp533Jw==
X-Received: by 2002:a25:bc48:0:b0:dc6:b812:8ab3 with SMTP id d8-20020a25bc48000000b00dc6b8128ab3mr8579699ybk.26.1711995776837;
        Mon, 01 Apr 2024 11:22:56 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id s123-20020a25c281000000b00dc6e1cc7f9bsm2138104ybf.53.2024.04.01.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:22:56 -0700 (PDT)
Date: Mon, 1 Apr 2024 11:22:53 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 02/11] mm: migrate_device: use more folio in
 __migrate_device_pages()
Message-ID: <Zgr7fYRd1M6gnEBi@fedora>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321032747.87694-3-wangkefeng.wang@huawei.com>

On Thu, Mar 21, 2024 at 11:27:38AM +0800, Kefeng Wang wrote:
>  
>  		if (!newpage) {
> @@ -728,14 +729,13 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			continue;
>  		}
>  
> -		mapping = page_mapping(page);
> +		newfolio = page_folio(newpage);

You could save another compound_head() call by passing the folio through
to migrate_vma_insert_page() and make it migrate_vma_insert_folio(),
since its already converted to use folios.

> +		folio = page_folio(page);
> +		mapping = folio_mapping(folio);
>  
 

