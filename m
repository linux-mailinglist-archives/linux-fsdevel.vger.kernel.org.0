Return-Path: <linux-fsdevel+bounces-36383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B89E2DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A848283562
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49C20898C;
	Tue,  3 Dec 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lveP4p6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98470207A01
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259993; cv=none; b=mrsyr/aztEG/LD7w5IV/QEqRrVBrNF67tK1c1oRvyWvuLKNyuWyI8BBYx+S9bQkl0Ntfwfw4ea2Qq4jdKn7UUNScjPC+dy0amk8pAh2X5CyVCalDtxdl/HfFPPKvwlgO5062H6VZcd30FQjLtuOPfV+9kKELObeebpqvgGMMP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259993; c=relaxed/simple;
	bh=IHe0rZTsCmUdSNMZvoPfQP7hyC0VY5l+g+ZM4qZAzX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mx5wpSXf6HEYBIwSeVTfBfyuQ5CdMUQ2IAqwaLiXrJaB8L3ke2vcoYjxHWqecGfXyhm2aWxcEeCoOmVtXUPFKdQTKRAJao/c+d0e6it4AmPM7X0ljZz60GKNShJz4DoM+bSgvO9OsB4Rq9+NmAbHXSHJsm8tDTFJvVcPOJQShIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lveP4p6C; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fcfac22a30so71854a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733259989; x=1733864789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnzGgkEaIO1YU5OTIUHBDrM4xb3yDtLiV8SeTTeyAUc=;
        b=lveP4p6CTxyII5OIveJEHKip8+1p9IX42naG6hsO81jKHerm3wsQkbDPdR89JgrWuj
         qYLb7x8Hc/tZQ7mKm8kZKtInLWdVKd+0UtsuJbMYJ/AnPJ6fMj9k3wKvNDd0i0P8bHvK
         WHVj6mJ0H4yZunYKfjo/kY0O8yjVnLZ+V9iL2ohpIALzJwYDkso519MVdNHdrxyzIvlw
         TS52cYftp6Id8NFTCJUZb2Wdfi48DlL9nAt5RvlNlnzfGZC7P5BfGAVxjlEh+MCyzNls
         l6bTlgqg6jvllam629oYNJewJi8+mnXwXJlO69QrNXnnO8b5UlLHgjvue+bcZUA/f62X
         EuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259989; x=1733864789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnzGgkEaIO1YU5OTIUHBDrM4xb3yDtLiV8SeTTeyAUc=;
        b=bSHCQxRKHFdt28as1HAwU4Y8wSbWexzyyD4DEuTDNu27GjnrPNEIYdfWixfEE164ke
         cJLfDlG3FBxJD1W2A5ZEbqRDBwvq0b/n9TCY1byAgQQ2yw4zINU7187EsApFe5fc3cJl
         zeO0gP2dUIQyWiI9ej5ffypXCvFmMVIAnYF4f04aROe9t94tj5RsjhWLoi8lPLDQFW+N
         Z3dzKpvX1nQ4QnZmNCtSevpCtNyB7n0M/XTSOE57xXXW/rMjhN9u6sx0LkRgvIjoTVF0
         FpIv1vTpP1tvwpqOUZsusZgC9+tQT0P89e/zsIHdp0/mbymTih2Aoyh+Jhq0kJ35zeNN
         WjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfV1nU0rFsG4xYp0L467b31EpHfBGNe7HZVZ+vYMNExTTWp6rBVjfuCU/H1m4Agrh3KayEqQBetRdMy9F7@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDPM3RuVZEr4lc05pY7V1uTQ7Dj0xLIo9dMpBQdbUpfuGnjdK
	fjcxd2AzvVknP/fmEFGcUxEm+ZJEsjMfdNb7qEI4fN6R36kwVGu9iIQOvA1DCmE=
X-Gm-Gg: ASbGncsYJzogSDejksNpLdetRblJWBlP6GDSl7sNcWH5pt50KLOIbnV8QQVpEM64yIw
	eHFK1MkjgMrXkCnE3345+juobsobozRV88YHRjD6K3HkfDosK45vwMrwDKyTrK7kV31TOyImAVn
	lZ+Od0n3p6iQP1eKu/RLaz8hhwsrQQZFbBuxE4sNGDX/RmLLt3qGz5ViSo/BXwn0kKMOoW991Ki
	dFHGrpJ9KFCln0uLU5+IYsY04Muc9cVxE/a693ffNRjmiv5AyLk9g==
X-Google-Smtp-Source: AGHT+IHLtUhYOP8x/EeNOo7mxbflhPk2h0afAiOBUuwFAjptj9RoE9EE7f69nEAnj73i4fSUgDgpaw==
X-Received: by 2002:a17:90b:52c6:b0:2ea:8d1e:a85f with SMTP id 98e67ed59e1d1-2ef0120fa31mr6447628a91.17.1733259989471;
        Tue, 03 Dec 2024 13:06:29 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:18a::47e? ([2620:10d:c090:600::1:fe53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee90748a61sm6341601a91.52.2024.12.03.13.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:06:28 -0800 (PST)
Message-ID: <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
Date: Tue, 3 Dec 2024 14:06:27 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 11:23 AM, Christoph Lameter (Ampere) wrote:
> On Tue, 3 Dec 2024, Jens Axboe wrote:
> 
>>
>> So here's a new approach to the same concent, but using the page cache
>> as synchronization. That makes RWF_UNCACHED less special, in that it's
>> just page cache IO, except it prunes the ranges once IO is completed.
> 
> 
> Great idea and someting that is really important these days.
> 
> However, one nit that I have is the use of the term "uncached" for a
> folio/page. An uncached "page frame" refers to a page frame that requires
> accesses not  going through the cpu cache. I.e. device mappings. This is
> an established mm/cpu term as far as I can tell.
> 
> So maybe be a bit more specific about which cache this is?
> 
> PAGE_CACHE_UNCACHED?
> 
> or use a different term. It is cached after all but only for a brief
> period. So this may be a "TEMPORAL_PAGE" or so? (Similar to the x86
> "non-temporal" stores).

I actually did consider using some form of temporal, as it's the only
other name I liked. But I do think cached_uncached becomes pretty
unwieldy. Which is why I just stuck with uncached. Yes I know it means
different things in different circles, but probably mostly an overlap
with deeper technical things like that. An honestly almost impossible to
avoid overlap these days, everything has been used already :-)

IOW, I think uncached is probably still the most descriptive thing out
there, even if I'm certainly open to entertaining other names. Just not
anything yet that has really resonated with me.

-- 
Jens Axboe

