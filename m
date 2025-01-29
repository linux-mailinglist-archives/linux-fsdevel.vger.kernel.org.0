Return-Path: <linux-fsdevel+bounces-40288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B53A21CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72E61883E04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567B1B4240;
	Wed, 29 Jan 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTLnDgOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0125A641
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152274; cv=none; b=TqYm2u/8UIfh14TCZy0cZEb1wF7fBS3wkbaiQnXxHyhbP6gYo+DD9xRumW5Bu7fi3dG0g9dtKhHKTYyGPkISS7q5IjmASl+t2tlJiFAmz+EonHK5olmykYVtLxFvWMi08vHPPHbi02dgqo+akvVZrIHuQ+P2RxMmzh/TWnC3QgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152274; c=relaxed/simple;
	bh=oWk4DUKJZ6yoIdjlsuxJHS8MBn3Ac8EQFaHlX0JgzfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9HI3igEkQHVS6bDzfTcB3oUsVTHGu5OUNYRQk+RMeFXDAOtnuSSaGsGF+0T/pRRE/qsJ6Yb6KEqZzMJSMYLyvWhHH1AZoAzw0dly5YttmJEk/mYSSg4rQrIQDouJbweUXh1UM25TBIbF4G4nO6Jy/SHSuAMHuvSDm9YLNBXc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTLnDgOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738152271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=80okTPQ2PJl/fm4vGCET/EdrOzH8xpGJ2Pg/W/uBXHM=;
	b=YTLnDgOrufUeiW8Vh/JC/lM/5SsB4dfpqGe5O4j0+LdneFI+i4ZQhG3yihPeIqh6GigC9/
	26A/XDP0eyFVMMPKt+ieX2XtbaGpzwBMs6IiGsqbnLSLIU2yxfV/qxLA80nGTB4EijGhb/
	2xX5jRfaNomWXrP19VaYRXUKNflBUQ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-xx8BmEi3MFyYEN7WMG68bA-1; Wed, 29 Jan 2025 07:04:30 -0500
X-MC-Unique: xx8BmEi3MFyYEN7WMG68bA-1
X-Mimecast-MFC-AGG-ID: xx8BmEi3MFyYEN7WMG68bA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38c24ac3706so5225776f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 04:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738152269; x=1738757069;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=80okTPQ2PJl/fm4vGCET/EdrOzH8xpGJ2Pg/W/uBXHM=;
        b=vK7tlfc5Oe6wzgeJsJjYE0U7sXfMai+iuPgrPdFjNlZ7d2uYNoW2KkzT94rZG6jPnZ
         O22cDjRiKwd/dualRMWqldvVP2RkRkWQ+jLrLKWwy9UmkRdfs+T7lkXC/92XliSPSp/n
         JKbL8AHtcEiCYz8d0+HFyLN4DsERdKZPK1cE7xXYKVsT7ak1BkF9OP1nBwJGpeBM9LFf
         RpeUZBVOekQwBLaRAmEzhBE0b0x5m55e8rJVMjHfECncxo1RRoQdATfbpQnu+4Fj+Wsb
         jyUe1RhJb65x/B96A+pLvB7weGCUG7JIeqM6En1ax7U3K/1TFnDE/e/emnSfhmPTS+U4
         M8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDprKOO5tEJ09F4RRLMFeVUiH0Qz/x1RgEuwec3xLvvBoeR8pXpjOGIz6i4ZAMF+PZL+1koEBIMHSufbr@vger.kernel.org
X-Gm-Message-State: AOJu0YyY002P87z59OTu64yWtR5vyMuw51iZqfO5BrmuXPMSiMWm4gs4
	hJ5ntRQv1LHqGLY8Qg5Kjb9kIQH+Hi7/JATt7Tq9pRP7kAE1fwkc7hyLN9w7BzhnLz232J6Ng76
	uh/h/VwGGgYjDoXwOMwjOfBAf35Qr7ZuKdTdXaZicyQaEQR8AgcPHCFsHX282vtA=
X-Gm-Gg: ASbGncuOWqAFKFfCN1Ka/cliVdF/twoa+brB/j1dAUkzUT6au9KSFHhNR/TtN7ZnLyR
	GR2stHFRs8jh67of/nON2aVSWxQU/RqTQzE/xAIq8/oijFMFiVIjuQIcgqoDd1ql8rRaL3/rs9M
	wbRtrroAFClDHyl2PEAoDtnrX6LKZRpN/HqWGeMo8ICB0eKNWwel8UALwWxcx1PbfzQkE8nvlNi
	cOKdbtepyhJ7ZWZEJ/cjBjjtQxk8NMelHyIUw5b3nFRUEaC6UtXa/4kcsmyOVGx5XqUANhJPcK4
	wglsl8qKVliJJH/ePrbg05CXDLdKGVWcD8ytHUDfDZFmeM6yNol/vKFwMoNk4uNb4xF98qZreCM
	T9PBiZPG0jc4TV6EO37CsledHjUyRO5J+
X-Received: by 2002:a5d:588d:0:b0:38a:68f4:66a2 with SMTP id ffacd0b85a97d-38c51b600f7mr2400411f8f.31.1738152268838;
        Wed, 29 Jan 2025 04:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmvm8bqTJ3qSRw5r8Mj7MSzGnmmQPtsXjLJ3ZqChgBYSnWzw2V+p98T6ykQ5lHuFrnwN7sGg==
X-Received: by 2002:a5d:588d:0:b0:38a:68f4:66a2 with SMTP id ffacd0b85a97d-38c51b600f7mr2400381f8f.31.1738152268505;
        Wed, 29 Jan 2025 04:04:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3b00:64b8:6719:5794:bf13? (p200300cbc7053b0064b867195794bf13.dip0.t-ipconnect.de. [2003:cb:c705:3b00:64b8:6719:5794:bf13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c4a160ba3sm5209497f8f.18.2025.01.29.04.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:04:28 -0800 (PST)
Message-ID: <f57bfd4a-02a2-40d6-a03a-afb64bf9b62e@redhat.com>
Date: Wed, 29 Jan 2025 13:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
 <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
 <CAJnrk1ZEuCsDe6hhUy2Ri_a-KXk4zXUftrCHKvhN8GFrTFQVtw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1ZEuCsDe6hhUy2Ri_a-KXk4zXUftrCHKvhN8GFrTFQVtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.01.25 02:25, Joanne Koong wrote:
> On Tue, Jan 28, 2025 at 3:10 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Mon, 27 Jan 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>> Hi all,
>>>
>>> Recently, there was a long discussion upstream [1] on a patchset that
>>> removes temp pages when handling writeback in FUSE. Temp pages are the
>>> main bottleneck for write performance in FUSE and local benchmarks
>>> showed approximately a 20% and 45% improvement in throughput for 4K
>>> and 1M block size writes respectively when temp pages were removed.
>>> More information on how FUSE uses temp pages can be found here [2].
>>>
>>> In the discussion, there were concerns from mm regarding the
>>> possibility of untrusted malicious or buggy fuse servers never
>>> completing writeback, which would impede migration for those pages.
>>>
>>> It would be great to continue this discussion at LSF/MM and align on a
>>> solution that removes FUSE temp pages altogether while satisfying mm’s
>>> expectations for page migration. These are the most promising options
>>> so far:
>>
>> This is more than just temp pages.  The same issue exists for
>> ->readahead().  This needs to be approached from both directions.
>>
> 
> I was assuming the cases for readahead and writethrough splice was
> going to be covered in the more generic mm session about which
> existing things in the system currently lead pages to be
> indeterminately unmigratable and which can be handled vs not. David,
> were you still planning to propose that as a topic?

Heh, deadline is February 1, so I can still propose it as a rather open 
topic to gather some other cases people might be aware of and what we 
can do about them.

-- 
Cheers,

David / dhildenb


