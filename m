Return-Path: <linux-fsdevel+bounces-18445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF858B8EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5938D1F22256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DF18C08;
	Wed,  1 May 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocbawflw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29218039;
	Wed,  1 May 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584110; cv=none; b=cIsv7F4iR/Hl11AsgmK97TKpiP4Znk4OUprQ1iOsqIsZ3Rx/Fimru/TYpoKp2ELkJYteaAMu49OuIIyYcDxsiSd3aOBdTkOyTXsZW3p86YCwvkIYPEeFmX1MDo9526jKoibvkguVNpgdrDI9KyWhNl9o9nUMRM7sqnynU13Kty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584110; c=relaxed/simple;
	bh=f9NbR2C1vz1kMtUqZtAOeLSPst0xWunQ3Td1Ojgfhl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz+6AMhaIH9TyY5KgqAQIilMLOCYH/PtzqkkXkxbLJqz+fdrJpU5RJqgSBJVtPD/kyhwg5uovqWvVWltVonh+0IoY4wIHkTH3TaUUSlnsAET8VZ546v3cbUEAsCGxiAamfDiN+jZ2gmfYh/fE2tpgXri9vkPrfeMqNqDHuKkZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocbawflw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed5109d924so5993431b3a.0;
        Wed, 01 May 2024 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714584108; x=1715188908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LexDuQOmjtzlpv4qE2uqvocvD18bmhUjJZSZg5SoNA0=;
        b=OcbawflwmY4wQ56SC9NvN646KvkqxIuTUBUdyest0M9tir5inwrJ2t76f3EtRF9c3h
         sKtCaQSuhsYEGP0VQzlcLQByS4EOOinF8ItDmrSJqjeC24RTFaRWImB92HlHzawLNuyt
         DATJv+JhTKVwmH3bZOT6Z7oXItiVjSLoO8koVnyl1nxZyarZa624t5sfPkQpg6dHumBf
         EKjpDqQQXsp5RS5unJuRvANNkJz0Hxp0Pj4AFalrkRfinjmxKU+rz3rT0j9wP/UYNAwG
         riAZ7e561o/1R0PYVdDLraDz402GRalepi1vIeluozDTODYj81a4kt5p+uPiUSW7wrUU
         QxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714584108; x=1715188908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LexDuQOmjtzlpv4qE2uqvocvD18bmhUjJZSZg5SoNA0=;
        b=ixelM3oB9uE0xxH/Z3o4Xm85NRiXvJqVICPVExbhu1lF3mFKmhEzN/j2LlHaoUDS3x
         fQeEDPlsIj5QMDFK7p8y+zDyL4xF79uVT3+2zQAeWs9H4YKNZXvI4V333Q46LmuS+kIR
         L+a1lGGi87Ctx8t/5tIekzZQ03NkHOHowT5dGCelOLpDj6RVgzplPh7R17Vh0toUiDGR
         X/OOPU4CR4aU2v5+9Vv+PnyQ1ujC3Um931BA8q/Pm7Jro8RnXUOSZVnDJuBOe7jI25fS
         1QHOc+YH+C5P28+yNG0EYrzphNniRFcZdsABawZanGSRo1UmWoPLy66G2uWztY/lC0gR
         eLrw==
X-Forwarded-Encrypted: i=1; AJvYcCUgDQbe//qtG2Ro3wQUeGnojxg6ns21WLtFaQIVRtkBMPTKR2ddrcg6+FJGhCu0x2wq6zEDexH2NdZl7vlZksRfyhzvyhWaBSexKKxhND9mGESgBLqVdfjqirCSMQ/5ud7ogHjr0iJSFnb3pg==
X-Gm-Message-State: AOJu0YxI9ZxwFp6/xwnTtqlM3ejbg2BYuO257own2/D2KLbO77bOdKNh
	nC9amh/I/y4p1IwOINiNJPa6PK4rvW8vyrptLVed0czGm3oa1euI
X-Google-Smtp-Source: AGHT+IHK/wLyV3K/QzXF9pqwZ6J6d0M+0hwoRFoG6aOfCbTX0amPvEOE/Fg6ieIZOTieO+jYYcvm7g==
X-Received: by 2002:a05:6a20:6a12:b0:1af:35da:16 with SMTP id p18-20020a056a206a1200b001af35da0016mr3837422pzk.52.1714584108140;
        Wed, 01 May 2024 10:21:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d20-20020a63d714000000b005dc36761ad1sm22843164pgg.33.2024.05.01.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:21:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 07:21:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] writeback: factor out balance_domain_limits to
 remove repeated code
Message-ID: <ZjJ6Ki_dozaIDDTH@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-9-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-9-shikemeng@huaweicloud.com>

> @@ -1809,19 +1817,13 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  
>  		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
>  
> -		domain_dirty_avail(gdtc, false);
> -		domain_dirty_limits(gdtc);
> -		domain_dirty_freerun(gdtc, strictlimit);
> -
> -		if (mdtc) {
> +		balance_domain_limits(gdtc, strictlimit);
> +		if (mdtc)
>  			/*
>  			 * If @wb belongs to !root memcg, repeat the same
>  			 * basic calculations for the memcg domain.
>  			 */
> -			domain_dirty_avail(mdtc, false);
> -			domain_dirty_limits(mdtc);
> -			domain_dirty_freerun(mdtc, strictlimit);
> -		}
> +			balance_domain_limits(mdtc, strictlimit);

Please keep the braces with the intervening comment. Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

