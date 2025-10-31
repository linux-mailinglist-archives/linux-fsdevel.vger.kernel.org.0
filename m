Return-Path: <linux-fsdevel+bounces-66544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79BC23063
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 03:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888354F13BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4682D7DE5;
	Fri, 31 Oct 2025 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNNeqXve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F742EF65C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877940; cv=none; b=g203jXo5Clh6Xxwbsd9gjfxJer1BF1duEIo6QgD9f5vRykEg1F8icNuiZrSZlT/aXx3aGexMJuGGi363i/JJDwCUL2fFmnkBQ8H44hDJwzu/rshzCpDvsrDazNaFNGZ9azx6VydgmLx2oj+UBKk98YZrrmU9WUn1NFlt/Opx1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877940; c=relaxed/simple;
	bh=p5yxsag2OECAEXhQk/zhvc5agc1YOH3y+Ya/dxbEMtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BerA8ZP2Txbja21l2Jfh2aH34MsxnYvZK7ELOKaW6k9rLeNglu2LgU1HUIMwJ86HSmyHWtbk8Vhog7lGTqs6FyiLFssmDBmDB9mQCBuNfqCwCKLfHjMywUanRVy2heoIV9PVeqBNSXk6qZoevTC2K9F+ZyyoTz6BpWcqyxu+sPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNNeqXve; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47114a40161so19090445e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761877934; x=1762482734; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV9/aau8/kBCbnurL+VQAEoEEwOJQQtoJW0VC7kNSaw=;
        b=jNNeqXvePL7g6NWhRIMtpomQg+dLCXwIWc+FiZyuCJviVFRqudOhs1pixnLtj+UIzv
         PrSJ6qA8wrZ5RdG6bTxc3O9AG5YGko04Y2ghM/mVLvY5fS3WJzqFYzt1Xe/LLAVuT5Yq
         u/1YyF8yUwOr35z06ImlgQ2hK+WYwwOgQAbzuobRdKTC+XAdz5xOg3HFasFgz62Q9NNO
         R9EusmYVq7Y0gMsfqOzdpGe4M1UGw/KnvB2R4QXAeA2RnpWmSeg8R8i0ZgB9ufTxPhhS
         nvs8Xf9EaLYa7Vh+NSDOCDHFtiQLLjkgopDmjB4G1NJMpHRGUsaRjfVR6OswIbLeFLl9
         i74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877934; x=1762482734;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QV9/aau8/kBCbnurL+VQAEoEEwOJQQtoJW0VC7kNSaw=;
        b=gdM0dnxMgzgcgP+EqwivVCbiMuzCkN21O1+AlaR7nh6BpMQ1Bf/3YakHdChckriEMh
         mWXfOK6muVFlDITHBgccEqo2I+L271KGB52VgQa624rAftjZI3FvRyxeOuqQzp4fHiSM
         MGSQYY52H5yruJ/K8Eiru8C/j7xQEf4zCowClbvTW5jcTlm4sB8e1+o4EUzd00SNSYE1
         oF8hKlArbHkbRsHnszeeXF2xvwxh2/WncyIqluNXhlMzAoYXOHHj0G2ut5ppygnLLqxz
         9qQ8neUK33N7S4qb2PjeyBdujopwVlbsf12J3bws8nhWrbVQl/EQadEtq/JuJt8ESGoO
         7/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMgpDWmMpHxZx15V0RvBC2RdML0oXbFcGjwDbRp57hIMdDQ5an+V/AegbDJ+9nJCGR7n+I48j0BauD2g+r@vger.kernel.org
X-Gm-Message-State: AOJu0YzHI956kRxyjUo744GB8KnMxYMvyyqX+8gjFseX96ufzweF5uA7
	68YdtM+ZrKluydsb76D4tVamdrNREzuNonHQHkD/e2pIx3ZFkF+/59g5
X-Gm-Gg: ASbGnctQbse2kYo4eAT6SW3TRlqNI0X1oQi0sv4iXILeNWuHI0zthqUnWmxjMbM2mg2
	oTA8Ve3ftTdSudY3NvAmA3bgljuKGYL36qo3uFdYJXk/EbiSEFLHu2Jknlc18M7I5k/6hfp6dqn
	0ukYxLs8kVlENdVbDbbiclrLGR/O39ozlbXISJIYFLZzXyW/3jIFoMzMIVefQeVy9RUES0fECay
	YPLKLnGWlukE3ZeVYCiYeRbrWmZtma/SMS6Z0p8NlUp3vIuZXUJNcYPBaC5w1uKibgYVcv5QlyL
	uD5lglXvDAov95YoesEc6LYjxDuMQ+ZqLrDAb817UoxQ71LBhjR2NHmnkDDaOuN33+6vvTSluAI
	7ZwJHFSB+DZXx4ZzqIOtIx6+DfOMMXs3F/nkdEZqU6Ml1O1G5H0rcUlqVm2Kb0c1pKvspBv8eQD
	LosyLXVQzGTiOYl5d7IELw
X-Google-Smtp-Source: AGHT+IGDjmSI9ZsALv2eCXVZl/4MAYrL8m6rIPSbY8ME0ISG3yZXFfPvYoXo+3p6G3qEwgFPt/dYzw==
X-Received: by 2002:a05:6000:4387:b0:429:b1e4:1f74 with SMTP id ffacd0b85a97d-429bd683753mr1506395f8f.20.1761877933879;
        Thu, 30 Oct 2025 19:32:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f192fsm735011f8f.38.2025.10.30.19.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:32:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:32:12 +0000
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
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
Message-ID: <20251031023212.mghlthnfscnxkfhj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:18PM -0400, Zi Yan wrote:
>When caller does not supply a list to split_huge_page_to_list_to_order(),
>use split_huge_page_to_order() instead.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

