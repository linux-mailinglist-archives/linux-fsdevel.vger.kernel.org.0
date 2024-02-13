Return-Path: <linux-fsdevel+bounces-11474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B304853E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B91C231BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AAA626CD;
	Tue, 13 Feb 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRPAZtKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B5626C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862661; cv=none; b=bs1sppKFjMBX65vHDEw+QK5GXf3jtKDurSAHW6YmlSagDZ1Of2l6CjbPpbtw3DVNcZf63blgctKCKsYkBGz/m8hV5QLcGaUKCxpzKET1TgKGB3cBGGjxo8qfOhz00VINwChJeqsLJpzykF92HUOKoWi63bi9Gwa2bHp2tYtkTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862661; c=relaxed/simple;
	bh=8rvVOGJK5G0bW1+vry5drj6mEJOTeH3T5v0nCt6fKJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5YgUCjrZg7CwexCi79lOlmFqeu37Yyn1pp4AHlPvhqNfrUVKZDFhkIcLJa0uXldA9xeARBKKO1+mSj7qJBZ4Rp43Zmcs54ldQ0bjcNdGr68en0vhVHfwHfdgCpfEHnfaOa8w2PPWkXNwtmAvRxcpRI3Pek6O9k5F2mtitUsF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRPAZtKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707862658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCcHtaszOKE9Vsf07irwuhOuZ163lqjSaVd6CZ9ODTE=;
	b=iRPAZtKipeR0q8NnKKWo4IhHxjI7wwFqVhBJFUejpESTGt+l8mEjFVp+fHdWGYJNwWmSs/
	KPMwkLId8ctih3dG8kxtZuZ5V84U5TQNDHke9xX7zlNn0O+XhMnfGqnO+VRxj7TSJ9FHoS
	C7uU4VwYUCPtTijDLryz7w063j+SKJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-hcyz5om1MOuTIxnitVwL7w-1; Tue, 13 Feb 2024 17:17:37 -0500
X-MC-Unique: hcyz5om1MOuTIxnitVwL7w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b0c264adbso2851639f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862656; x=1708467456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCcHtaszOKE9Vsf07irwuhOuZ163lqjSaVd6CZ9ODTE=;
        b=MqWASA2bptf4OMM2jBNK2iIyiiICO+ewHjw/kzB77MoAguGsouU51dQtX77S7GoJ1k
         tdtIz6glqvWoUZ5z/Kio32uI/KgxYid7eihcewNicR4XGbpTYPz/WBOlSHABAJoabwsC
         Kwl3EHeAaRJ/FcCX/EpA8nILmMDTmv97oop53ku4bCSF/4ZpvOEgoA/JF2zGbTi42LGT
         Ep0IFkutviC4tkYkXF8mm8uyYSgkghNvU47ZhDP25eNKbmefKsw9/to/MD+8srQ91cW4
         qWdzWaj6MFH70A5ZqovpkpTPt7NZt5jCEY9cetiEsHzVRYk+rBlj1J/GGyYP0SXp/ZNx
         ZKng==
X-Forwarded-Encrypted: i=1; AJvYcCV/Nbz2H+GVIWQz03upTATUDauF3cMllhmz+DuaVH6uWFrGX5ZOlFc6coM1TFB7nRLPO1JAK+qBWe4xHeYwkxXKj8MWEXMKU9m8O5lxjQ==
X-Gm-Message-State: AOJu0Yw0GZVRw2TQa5HkSWmVi9tyXV6HzPNrlUx6GH+3dzc0iF2DIKH2
	QTEkhMO7mVelyGDlcCZLopCO/bhx6tid7uYyjo6AhI3MUgp3qoP3hB0Lr8yaYHNu75o3qiy9vQ4
	PzZheM2hm3XD3xjJetXFGEjej5zOtxyO3jtZTwklHaK/u0rvyhodtBsLaKS5NGTs=
X-Received: by 2002:a05:6000:104c:b0:33c:ddf4:742e with SMTP id c12-20020a056000104c00b0033cddf4742emr417637wrx.22.1707862656063;
        Tue, 13 Feb 2024 14:17:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0u4tRLYxr8Wbu4Etuf8Kb0cSQQoNXaCggyJ3xo82iccJCWEBHgyRkhNW4ZESCo8cWB0ObFw==
X-Received: by 2002:a05:6000:104c:b0:33c:ddf4:742e with SMTP id c12-20020a056000104c00b0033cddf4742emr417626wrx.22.1707862655588;
        Tue, 13 Feb 2024 14:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b0033b50e0d493sm10564789wrx.59.2024.02.13.14.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:17:35 -0800 (PST)
Message-ID: <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
Date: Tue, 13 Feb 2024 23:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 23:09, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>
>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>> [...]
>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>> we've gotten has been that even out of tree this patchset has already
>>>>> been useful, and there's a significant amount of other work gated on the
>>>>> code tagging functionality included in this patchset [2].
>>>>
>>>> I suspect it will not come as a surprise that I really dislike the
>>>> implementation proposed here. I will not repeat my arguments, I have
>>>> done so on several occasions already.
>>>>
>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>> this debugging feature will add a maintenance overhead for a very long
>>>> time. I can live with all the downsides of the proposed implementation
>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>> acks by MM developers so aiming into the next merge window is more than
>>>> little rushed.
>>>
>>> We tried other previously proposed approaches and all have their
>>> downsides without making maintenance much easier. Your position is
>>> understandable and I think it's fair. Let's see if others see more
>>> benefit than cost here.
>>
>> Would it make sense to discuss that at LSF/MM once again, especially
>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>> away (May).
>>
>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>> consensus on this.
> 
> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
> need to see a serious proposl - what we had at the last LSF was people
> jumping in with half baked alternative proposals that very much hadn't
> been thought through, and I see no need to repeat that.
> 
> Like I mentioned, there's other work gated on this patchset; if people
> want to hold this up for more discussion they better be putting forth
> something to discuss.

I'm thinking of ways on how to achieve Michal's request: "as long as 
there is a wider agreement from the MM community". If we can achieve 
that without LSF, great! (a bi-weekly MM meeting might also be an option)

-- 
Cheers,

David / dhildenb


