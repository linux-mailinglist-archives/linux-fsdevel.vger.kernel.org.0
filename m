Return-Path: <linux-fsdevel+bounces-63956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F9BD30CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C3189CE5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6926E709;
	Mon, 13 Oct 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCeK9oDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C2271443
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359737; cv=none; b=foppH6I6y1QQRAOEdrm9DmnGVW+btybVrrI6GCrsw5fUNI5p1RnDZEBDH+YOd4HtZ3kJ0HEr+sGyvg7DgMzNfLqHRcYIL2SAwSkfC9yzEt0R4nTMoAbrJBYmJ9LdzgNsLDt9t/w6XxxN0jcM/i5cpwujez2VKjGbG6PUaWoJi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359737; c=relaxed/simple;
	bh=q1/1g1aOp688VA6iTlmc6G4Gt6IPhwQ6SlSbAlgfVko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGSmOi46F2qZ6EUedIad21xg9GoJ1WdnjRfJHhL013dYLrjqYJZlTthVwdl/8YYSK0PgeIbMFvJE/3Lal61kFuUKigYKQD/ktTkFWxBpGzMlviAxXX+pAoO7MBc1io4JDHgD5adArfzcJyVUGHiyk+v0M1ZpFzu9D84qSQcBrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCeK9oDb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760359734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V6YxR1nTJCDrfaOZFN3CnG2vV5jcoOfzGFCcTcZo0jw=;
	b=gCeK9oDbwUpVGMJ5X0xQoBymzfm5LIlOlFfHGArX5/g7WHLGr51MhRSij2X5tRlyKBSCae
	noFeR2Ep06+Y5IVIA08vsZ3x8Ro3M4Gw5OxZhmAO3pPVejO29nGTsMW3vk4spQnSUvfoXa
	vEyBf2buwCQswLRQJlF+bjUxusvbmVY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-Hsf0li2dOWqRR5EbpNQghQ-1; Mon, 13 Oct 2025 08:48:53 -0400
X-MC-Unique: Hsf0li2dOWqRR5EbpNQghQ-1
X-Mimecast-MFC-AGG-ID: Hsf0li2dOWqRR5EbpNQghQ_1760359732
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so22230515e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 05:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359732; x=1760964532;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6YxR1nTJCDrfaOZFN3CnG2vV5jcoOfzGFCcTcZo0jw=;
        b=dplQRDyLu8lkugCnxfVMI1Sg4lqC0UaAUjKsF8iE59w2aY/gsTDxDa+ODIuPX0SKBr
         ItEQFvhzonwZ3EWnsktFGXVGTdNQQg0Pw1vCCnRAvLepiGNPjikXn7Fye/Jqbb631Zlg
         m14t1Ro6sNIaR3ycAgArb82wFDzFUeagsngBBsidWJMz4eHPixIzMS9YjcTb48E3ihie
         3ppKiWVe1vfCQ5vXzY4TkE/sy61EKjNukTlawu5NzkP41OV8sF6+nnPPRIQAopR56PPE
         Ls17YdRocco0OTuH98FTCKdHHmMflhH/DBDWfkSjfK9fUzMsfUdSTnzgSy7QPwNdN/Yy
         ovmw==
X-Forwarded-Encrypted: i=1; AJvYcCVoCJopQ4koT0fu7a1Or9Jbs1VbdSeqtSzi28fhOUOZphfMkWrn/g331KcbgT/nfAD2ws1ohNCcpwuhmZvr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYzRvwK9hFkdCtjWwmIHGcS968smYKLwd0CF7Eycg35HAPF59
	B/r3AogSbqsQ8/sNTZCF+sX5zXnLfBGnBF4g/maYQnDbXiUSkS++NBbL5HbuVUwoiT18exCcEW2
	TOLJUqY0b/xofKsgtsQoZy4KKrmFHeFJGzAJdVLURyDSAmXD/7BUv9TvlGcNxUrdVPmo=
X-Gm-Gg: ASbGnctGlWANGx/Ov7clw3chWoxp9Bu5dJOgIaKZQT5YAfdhLvqSoGQK88Nv/1evwc2
	22kRVJDb+IqLtkRSwHCKqaft7EgJg4T0uIpwkdTpJ7W9Zye5CPlssboCIZxwOjwrqDy0E7ai9oT
	guW1nZT2tL2rcj6edmyg1LVbo3JwK2tDc8n0baBZvFzLDfKRXWb0j5NJjgRu+x72uCmHS9XrpL5
	3QpibI1q8tpN9B/eCP2YlgJYnSwrNv1S67YRFR9YtMqcBJ/lQRcabGeu0K9enrDjFqpQEokEW2S
	sKenZOZ1c/Oc45kxYyH5OnPGqeb8vJwbAjSlD9ZY/jWjV70H6d2C5CpDbms1OXyDQVRjxdAYN4y
	MUXs=
X-Received: by 2002:a05:600c:530e:b0:46e:4c90:81d0 with SMTP id 5b1f17b1804b1-46fa9a8f1c5mr144086725e9.2.1760359731936;
        Mon, 13 Oct 2025 05:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGLnouyUlx2MAgaHkKm2L1dKdQ4wuo7Nrhykv7xLHekC80pf6DEJPuKh5QZvTCPV+to9J8TA==
X-Received: by 2002:a05:600c:530e:b0:46e:4c90:81d0 with SMTP id 5b1f17b1804b1-46fa9a8f1c5mr144086535e9.2.1760359731494;
        Mon, 13 Oct 2025 05:48:51 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497aec2sm189420095e9.1.2025.10.13.05.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:48:51 -0700 (PDT)
Message-ID: <41f5cd92-6bd8-46d4-afce-3c14a1cd48dc@redhat.com>
Date: Mon, 13 Oct 2025 14:48:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-7-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251013025808.4111128-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> @@ -474,6 +474,28 @@ int filemap_flush(struct address_space *mapping)
>   }
>   EXPORT_SYMBOL(filemap_flush);
>   
> +/*
> + * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
> + * btrfs caller should be using this.  Talk to linux-mm if you think adding a
> + * new caller is a good idea.
> + */

Nit: We seem to prefer proper kerneldoc for filemap_fdatawrite* functions.

> +int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)
> +{
> +	struct writeback_control wbc = {
> +		.nr_to_write = *nr_to_write,
> +		.sync_mode = WB_SYNC_NONE,
> +		.range_start = 0,
> +		.range_end = LLONG_MAX,
> +	};
> +	int ret;
> +
> +	ret = filemap_fdatawrite_wbc(mapping, &wbc);
> +	if (!ret)
> +		*nr_to_write = wbc.nr_to_write;
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(filemap_fdatawrite_kick_nr, "btrfs");
> +
>   /**
>    * filemap_range_has_page - check if a page exists in range.
>    * @mapping:           address space within which to check


I think there is still a discussion on the name, but in general LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


