Return-Path: <linux-fsdevel+bounces-40040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B954DA1B5F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159A2166438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39021B192;
	Fri, 24 Jan 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNamcsVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832F2B9BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721761; cv=none; b=FmBVt7+FheXv9cW2j1hFXpVduJ+zQopnsox/Qylf40On+FyLBrIFdpEXV+tdJtLyTrY14txUGPChUotn+hT6TshW1LC9TsgaosqbV4lGdZhr1187AyfkqZXOKWo05zzHmXqq5u2O9D8o4z8BHY61njwV1eiASla+oCwSyoa6sF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721761; c=relaxed/simple;
	bh=1F8L9U80uDb7zROwJCq8vaWcrHjfPkb1uTC/7e6REok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYNNAjGjp04zrqIzn8bDC9d1NfH6bDMjzSSiuEvj7IjrK5qx2/Uv0qEwihji4zhCjaupIzcM1aG7AiIlHKAzCKsfBAHyLn97nUmNW9DuXzEIhV7ZZ9Rygsv7eVBhtG6arl5YonJatPX4cskk4bbxH/gkJukqzr2iUK1PL2+Wfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNamcsVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737721758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uzNNADQqsihjz1QE1k9xZq/dJCCB1GqR7cfoKiywk0M=;
	b=BNamcsVk6eHRHPYzeLzo9g1zqy2m0PtZk41ie3uXgW6ZMibFCbpPMOilYnWokkD2r/STd4
	fJ1MvT0RQbEqH1/mcJBfPmmB5RSc8fg4/2BGpu2uVlDT2LlJsCmrSRmQ38CQhoq8Uwr41G
	TGdfmM10tf/7UWzja2hOKAvQug9kq7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-pHr5noQ-PrKt9qZBsDmK_g-1; Fri, 24 Jan 2025 07:29:16 -0500
X-MC-Unique: pHr5noQ-PrKt9qZBsDmK_g-1
X-Mimecast-MFC-AGG-ID: pHr5noQ-PrKt9qZBsDmK_g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so16395875e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 04:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721755; x=1738326555;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzNNADQqsihjz1QE1k9xZq/dJCCB1GqR7cfoKiywk0M=;
        b=EWYAwgrO1a2SkKVq7hNo2DepfahYKhEF65rkb4tiZFYguxKVnNZXC8mEuuyUWqH8Ej
         YV6Nf3kF2jEC3hU62Q5x3h+hjEff9TmTmPC3aEaHJ+ph9VqRKPi7JY2NuRQt1SkUrYbN
         RbFGLLmSAKy2ncdjS7h795sLZbuUYyNq8F+Zi1XM8i/OeLHRxxaxbLRYWv9LLWBHnJ4+
         tjjJdGG1ljnHenKrMoZPIO+Z0E3SldQo6oMqNyKOyICW4CBlujfEu+YjVYFEZ4+//sfS
         DolpKz1mR2VIv1bWlYM/aj735xEm984NCwDvO1VBvPPpJWjPbqOM2zBiwkgqKakoTS5b
         pKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV2S1PLNuqO1vTfka/EHYR7cw3Wk0VQj/VM9mt2lds6VKJA2/ZboykQ6ANPxJFPq1etvAK2WonaVCoMIe8@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvvaYWxiIJeA9ZbXTAMqkKbExdk//RbCtJyGRFzPgQh4Z3EmN
	VjnJU55Dk28eyQPVXzGPFv0/sBPkbPxZ/MzGxmF2o5YRGPBIQJ7tNuX35jc/LHHeujqiMN7gYX8
	OO05G6atwYR4uw0Evu5loaBSgGvGuy62VzwCv4dI0G2w12l5svLDZhibvzOWrp1w=
X-Gm-Gg: ASbGncthN7G5rGtK2V4nfZy/pgUPJzQFaDewuAhcOcMecwd+mgHr9dAiw++JujfDpqb
	D4TjVsJeJxCeS7z+sn1mvNMB0FMTxcrR7kqeRbJMgj/0rXhej8lB7kz9h52llmALWkJuSxhr4sK
	rOW/geA5L0BzhdWZnlkGeG0yT95AQ6WUO7BNfDfGhCfoXLlNCeBYeEaPRAbdoWG36UZAXVzntL+
	hgLkRLarzhzFA5n4YdeTrmr3KnKrp/GMoc5fjRtIi5lJYVQ4nNM1L8ZBZqkwKNHqAM6akziCUvm
	gfqljqjfUATudO0gTxIkIBCTFcLD
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id 5b1f17b1804b1-43891437546mr254934605e9.20.1737721755527;
        Fri, 24 Jan 2025 04:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGUwSi2zAR8EFej4iYSV8h5IlCgMz7INy3vAivzA9iej0YF8lQ+3GsPKUvbVgaJL1howEUfQ==
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id 5b1f17b1804b1-43891437546mr254934345e9.20.1737721755107;
        Fri, 24 Jan 2025 04:29:15 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd5732edsm24173295e9.36.2025.01.24.04.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:29:13 -0800 (PST)
Message-ID: <752b098c-345e-4374-bf01-37193b402890@redhat.com>
Date: Fri, 24 Jan 2025 13:29:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
 <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <3c09175916c2a56b55d9cf61e4d8c0ea66156da2.camel@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3c09175916c2a56b55d9cf61e4d8c0ea66156da2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.01.25 16:49, Jeff Layton wrote:
> On Tue, 2025-01-14 at 10:40 +0100, Miklos Szeredi wrote:
>> On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>> Maybe an explicit callback from the migration code to the filesystem
>>> would work. I.e. move the complexity of dealing with migration for
>>> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
>>> not sure how this would actually look, as I'm unfamiliar with the
>>> details of page migration, but I guess it shouldn't be too difficult
>>> to implement for fuse at least.
>>
>> Thinking a bit...
>>
>> 1) reading pages
>>
>> Pages are allocated (PG_locked set, PG_uptodate cleared) and passed to
>> ->readpages(), which may make the pages uptodate asynchronously.  If a
>> page is unlocked but not set uptodate, then caller is supposed to
>> retry the reading, at least that's how I interpret
>> filemap_get_pages().   This means that it's fine to migrate the page
>> before it's actually filled with data, since the caller will retry.
>>
>> It also means that it would be sufficient to allocate the page itself
>> just before filling it in, if there was a mechanism to keep track of
>> these "not yet filled" pages.  But that probably off topic.
>>
> 
> Sounds plausible.
> 
>> 2) writing pages
>>
>> When the page isn't actually being copied, the writeback could be
>> cancelled and the page redirtied.  At which point it's fine to migrate
>> it.  The problem is with pages that are spliced from /dev/fuse and
>> control over when it's being accessed is lost.  Note: this is not
>> actually done right now on cached pages, since writeback always copies
>> to temp pages.  So we can continue to do that when doing a splice and
>> not risk any performance regressions.
>>
> 
> Can we just cancel and redirty the page like that when doing a
> WB_SYNC_ALL flush? I think we'd need to ensure that it gets a new
> writeback attempt as soon as the migration is done if that's in
> progress, no?

Yeah, that was one of my initial questions as well: could one 
"transparently" (to user space) handle canceling writeback and simply 
re-dirty the page.

-- 
Cheers,

David / dhildenb


