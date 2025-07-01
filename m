Return-Path: <linux-fsdevel+bounces-53576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DBCAF03CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3261C20ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CB28136B;
	Tue,  1 Jul 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KioT3ObY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C225B1FC
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398325; cv=none; b=fI1AggwcKcMEyEjwFMi0VsfFl00Fk2svw6mQW1yKcagemITVRWJy7fdY8VqwguPwJaJ4pPLNNz0J72tgTxYGesrFwgwyd9mArnAB5nU4AJepO9VHqOONj6+XJOxsTpeSWMUrqJqyTMCJtxt2ebaMzmMsYpmuaA70HkEsJvwxJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398325; c=relaxed/simple;
	bh=kXopyC6c5M9a9rWPFBYHZbv8zu6NBxoYlUYtgbPR6Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccjxZSoqnf6rQDPnd+TpD0kAYpHGIVZ5wYJdE5u5Eeeg6JNYkcfMGIq4KUHxKR2dHw2hMRwb0zTGrlEi4Qka7eWLQUs6HgkQN2zoRnTuTesJPY5rehb4Zq44GOPsdGb27rzyof3jh0N/grDLjXhC8cJXt6+5NkqLWaabhk1VHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KioT3ObY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pan++p2TzQShdGmkALz5U+1UZhqUiE8i0SNRToHfyJg=;
	b=KioT3ObYk4WraBSDwnKFFpJ6ZKq0YMx6eX3lRc0wLV2U0QsJcOzxpgqN9yZAv6ucCS8cim
	dOR9FZcgQJeCP1+JJPpFEXqL3nIytfi3XP5OTHZKvryDnE2TDW3+fdx9Zhc9DvR+hqiUyh
	pnBq+Vff4sibl6tVfmoBdXcwMEJNWSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-3ZGRSu99NRGY9QUUtQ73uQ-1; Tue, 01 Jul 2025 15:32:01 -0400
X-MC-Unique: 3ZGRSu99NRGY9QUUtQ73uQ-1
X-Mimecast-MFC-AGG-ID: 3ZGRSu99NRGY9QUUtQ73uQ_1751398320
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451deff247cso33309015e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 12:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398320; x=1752003120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pan++p2TzQShdGmkALz5U+1UZhqUiE8i0SNRToHfyJg=;
        b=Cqe4t1yXtJsNG65DkWT6P3ydIz23EYG7i+e7mWHEvbNHZLryuzT7mG7Nfff1wRmveu
         t1oclTLqUoij1ox7mOgWlcH+3PmcexEmL9tUVrI0KW19rlMk6HV1gkjzWxQhjHsjcGiN
         kwuaV0M9Neta8NoXZ4GdKYxSkpQovl94m8hfRobuJxucCA4l84aIUnzvMmkzbvDLTN9C
         k8bTXMmqXSdmFJuiAMWHHdtMIMBXEMPde5V6qGCd9aanyC2bMKX75UR5oaCyCNFUbQyp
         IsjxKb3IM97DmkNjcBkJoFDABlOTyCEUFpvk7/ER9aP15cppHA0Q2kp4CkvRABDkRMyj
         oSSg==
X-Forwarded-Encrypted: i=1; AJvYcCUvPLEss/5H8H7uHWFP+DFJumHGI0ECCQ9pfXNTIHOHaczCNviAM0uWFLU2htDGLKodP6rMCVcGgtogU+vW@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF2YWCtvK8CTvnFeW+4TNYvHW/ntEXkZQR5paXDMmOWNHWa8A
	wbBU/fbZZvPE8YfTS489K7YVwLgeKeViEWgxOqoKmpjodPIo1uRt40QOG8QvK+J1ML/EZrM4tKa
	UpFsvJYPseWSdne4TB0n+zlfT15YzQsmeGIiCPyqfvOBH5PixiyhJzkTUNP3MlacSBcM=
X-Gm-Gg: ASbGncvL2jzjjEfzp+gYMttNs8TZqCBkDEbxpdAiQW0NLVyfHBwqPLJFCngV7VUb9hA
	7UZZSBdBSnmimg/OhuU9S1uvewTTEliWam6hvOX6iwG733bQQR8Qzodr4FoRWWFEbgpwAhIlabQ
	DrenNvGeSwTGRhBnYRC/xKcxTYL7c+oz04bOuCDUzCWfmqpALTFlBVyv9ahnOGadZSkL1VzuKsD
	PGbuPSEPYoJyJjjZWombobwYTQk6t1J/RKB33a8qIyAYiNRqV5+FxSr/hDvsvC8ua3MC5x8FkJr
	dMlg4GT4hjiozWab896HaGLfBi68W+Iqh1rd0KKEhUe8ZVB2xscLi+Pyjc9o36dGAUCtNcbMEnH
	MA12inL4MPsqaKcwaeMvRGrfGFMctnXRI52/GWJHtnSmVic14DA==
X-Received: by 2002:a05:600c:8211:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454a36e495amr3357325e9.5.1751398320071;
        Tue, 01 Jul 2025 12:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5TyN7r+4oBk64JocA+5QoglGL345dK2Fcu0b1IazgnSHOIgn7V2SOlRTU0EkUwtcUGQo9tg==
X-Received: by 2002:a05:600c:8211:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454a36e495amr3356625e9.5.1751398319493;
        Tue, 01 Jul 2025 12:31:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm206159325e9.22.2025.07.01.12.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:31:59 -0700 (PDT)
Message-ID: <48e9a5de-3131-4e36-8a21-5f77669116a9@redhat.com>
Date: Tue, 1 Jul 2025 21:31:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to
 PAGE_MAPPING_ANON_KSM
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-23-david@redhat.com>
 <5357d4d9-d817-4351-9927-bcd03794964c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5357d4d9-d817-4351-9927-bcd03794964c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 14:54, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 03:00:03PM +0200, David Hildenbrand wrote:
>> KSM is the only remaining user, let's rename the flag. While at it,
>> adjust to remaining page -> folio in the doc.
> 
> Hm I wonder if we could just ideally have this be a separate flag rather than a
> bitwise combination, however I bet there's code that does somehow rely on this.

Well, KSM folios are anon folios, so that must hold.

Of course, now you could make folio_test_anon() test both bits, and have 
KSM folios only set a PAGE_MAPPING_KSM bit.

That should be possible on top of this change, but not sure if that's 
really what we want. After all, KSM folios are special ANON folios.

> 
> I know for sure there's code that has to do a folio_test_ksm() on something
> folio_test_anon()'d because the latter isn't sufficient.
 > > But this is one for the future I guess :)

Yes :)

> 
> Nice: re change to folio, that is a nice cleanup based on fact you've now made
> the per-page mapping op stuff not be part of this.
> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!


-- 
Cheers,

David / dhildenb


