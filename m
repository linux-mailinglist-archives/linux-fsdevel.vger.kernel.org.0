Return-Path: <linux-fsdevel+bounces-33068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A076B9B3255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 15:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA991C228FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CE1DD54A;
	Mon, 28 Oct 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aNe4lK9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6D1DB95E
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124022; cv=none; b=OwxExuYuqDgsZCp5K/ZNGYTsElIdQtAgNdD8cjk50w/+q8ZpZeiKDEAr7LUB9yTqRpikDb/jmqG7X0f24YC1iNOvi0NeRKR5B1boqqmRW0TMwaw1lsTAQ54kH/AnBjX5u2jT3fvG10TBFKCSR1+egr91bm5xHJpGRm94Aa85tZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124022; c=relaxed/simple;
	bh=v2HK0A45xfCW6LF3YFD2TPmEq4ihQfGG/Qxy38acCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2NO7LEpSLOwMPEZ6Uhp4eHvZKoshmuP2vtXHt7zEsfAsufv1bwk+7NSWS1Gv0nxAwWlmAt8JNHOYMs1/yUUD9c+E9eMF7m8xfehHerRfGlj2KVKD5W2oQWR9Uo0Ha53uvVAuQSvAbEL5xMPvRXmIOdBWe7SNqkQ7AyANyF12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aNe4lK9f; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e601b6a33aso2494770b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730124018; x=1730728818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FihaM4IoEI/TwOyPoeUguS8WS7IqmB9x82K637EGe5Y=;
        b=aNe4lK9fRYs0brgi0ZiIPyRw8NmUo0obkPXCawojqJlIMKj/ka38Ak0yvj7cXS6rn+
         Aslkr30lDPMowwatyN1o8R6nLDEE2Iptq+JvpIfHgLQ06WztZ0Ej91IjhGRXMVgmazth
         1c2ru7VoW6pOEf5n6ho4RLcA3aoOMuDdAYB5rH++aZ7+F8DDM2X2StdcJ0ksAbBzH/g1
         TUp13wwYymwEa/oGDc5avaEQWbQxAef4xkIgSUgqv2r2gt4LSjduLYpbjEca8iXgWNJw
         nyc0XOw1SgCyV99O5388VKEtKVun3p9OtdOpB1C8nQPUobFjmcceqSz4QTtz3YVHsHLz
         odhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124018; x=1730728818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FihaM4IoEI/TwOyPoeUguS8WS7IqmB9x82K637EGe5Y=;
        b=UjWePyreHlksQTI5uw81oauTr1XJ5IAVlpPpHKCEf2p8efRoT4UTpeo2JPiIYxYEbv
         vQ1wjWMD+XevgHBagAqCd4qRNn9sxPuqDTeAfA36UpQQ4LOlCzy6jnG17onHRx4A+BOB
         93wkVaqc5GbM6VejoziK72+4OXuCPUJVo/beG7Mf8MHJtXqCWbx1E5W0dZA1zjyGfwXF
         +i0EkjdM2WZ+KYnmgPSc21soY8dIvhZhZT1jKPsiSeAFeHBnwQRln0btl8r9fXvjeNk8
         vJOGsmXslprf94gz3V9gF79pkZbZVyrnTYY5njwT77/aI8GEAyrY+GmYuXgBEy1UsyBi
         y04w==
X-Forwarded-Encrypted: i=1; AJvYcCUbiteHEhGdQcdrS18crppl/Rxks/TVm7vYO6tCs4d56aAerwiEcbbbIPVIdg2g5TFarMxvQqoHZ8H3liSM@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7ye+AXjLd+EEM2aKjiIYRrV+U++9Vxo3I/OVoKSxVudyEXNq
	/VXYJAFieLX2OZuwm9IsUV8kc3sYHT6SliZq/EtX9+pycGJztlExfEm2lcSYgmg=
X-Google-Smtp-Source: AGHT+IH9co64vboTin+h8OS63UgFbBeD4w6rdjM3nCxgpXXvLvMDezoy7l2Ep0U63nuT2u+Cay9MJQ==
X-Received: by 2002:a05:6808:444c:b0:3e6:4c48:8942 with SMTP id 5614622812f47-3e64c488acamr1321455b6e.35.1730124017959;
        Mon, 28 Oct 2024 07:00:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f5d5sm32494226d6.23.2024.10.28.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:00:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:00:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty
 tracking
Message-ID: <20241028140016.GC10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-4-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:23:00PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the dirty stat updates do not race with the charge migration.
> Otherwise it might update the dirty stats of the wrong memcg. Now with
> the memcg charge migration deprecated, there is no more race for dirty
> stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

