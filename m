Return-Path: <linux-fsdevel+bounces-61936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF5B7F949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B121C815E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840D33AEA0;
	Wed, 17 Sep 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnuXSeqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A983397C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116520; cv=none; b=PolvWrDIXZ/V75Zgz7RDI1Pl7w7+tiBoq5t7A+PPWfKhuhZH67tCi/g8w0TRsxrqWppp5hVwgcCq6qTNr3s2FGrJePLYsthpRba1EnpgJ0X72g8UWYulyCiJTKHljNrSbFCP8Lm0i9SSERc1TfCHcQ/QrzbBSTkM+SN1q8F1Dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116520; c=relaxed/simple;
	bh=zX4lmKqHHvt6kg+FygaTZ78AhlYs4+hjvu2UKbDiG0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjP2+S1KKlAMi7m9AlOwi4FgYYNfAji1LBqJCv2Dbw5I+fmftAumQtcET+PRTaB2OJRJBgphMBSl3/nYnQPH4W3qg7+xJMsJW6Hnb7WAOTEfVglDg33PSonDya+6LiNcTTHI3zKWIgVfZ/OQNwwMlCdPd91lL44e8kNK8afImak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnuXSeqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j9LMOchMMyRjRRzN+kT7nX+PgJH+lWPkOhHcYp1LpMc=;
	b=cnuXSeqkDJcaC2H0Za/jygNtL8/2/DuTZMi4Kca7UrENJoY8cGy7YWomkhXnpVqz9/moqQ
	XufHibsJ9Hew7/aTaXmzQg+LPt+LGTGqeXys+FdXWR83sI+n7W1moNwklYvbs1btU6pvoU
	pxmGi87nd0uLxDKVJBlZg8PczZx2YBA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-fS1zl1KLPzKPXNpUuQMxKA-1; Wed, 17 Sep 2025 09:41:50 -0400
X-MC-Unique: fS1zl1KLPzKPXNpUuQMxKA-1
X-Mimecast-MFC-AGG-ID: fS1zl1KLPzKPXNpUuQMxKA_1758116509
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso777170f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116509; x=1758721309;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9LMOchMMyRjRRzN+kT7nX+PgJH+lWPkOhHcYp1LpMc=;
        b=Z9qC9FlNFuS/i9fAfNptAthGEeOPOc4ClU7R37AgVAzzaKi0iREGi6rOajdfCuVpBS
         MCX+fquDRPy3AeKK91AAScurKGwYg+cuNYKQanjMX/+le7wrmxHvepBDs+/MA7Dc96DR
         N1uoh8mUl3iyzDZYwouIeIu/S7U98cbRjvzDwuKxoYsZPmkV3Gr+LGZ9NDoqh5snsaoS
         nIicIX9u8bATGEYU1ix08lP5INXck7IjN/ilQT90QutyY7VwW2DDe/xvYCfOly0mk0rY
         CemdnOViLs/UKfCxpIEg0XX0wcbOr24aUTNe+4C1WIa7MBcb6B0keI9XhOrPIdvlqIrY
         hMmA==
X-Forwarded-Encrypted: i=1; AJvYcCW1pE6o5HPfbqSAMzBiKTOQ8MigyBae7dikaqEWyzmXr4dAFiEID5x2zYQ1Q6SIY+Qd3IsIsNeteJso9aou@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26Vb3m9nvQL3KbpoHfRG8kulrHATak0GhTcPJsHJn/QBUyr+l
	RGw/mPCBXR3ATs5z8qV0yXkXOUoFknAE3s/zC0U8IqF4a9603N3Akic3g+4KqRWfemZrb6qq+4Z
	YLnYBjXZnmSBDFCA+B4aIWhw2G04+pB9WLjThBhEmVZYtnNtDCK0vC6W/Ica1CHOia9E=
X-Gm-Gg: ASbGncslZY7XhEqBcVQNut+yjE/HmMqtGVJ+zQgA3CvYbriGwi8+9C/K2HbCzSR98ID
	NDBUFEBJzGA9pjYLTq5spyoGnwwjE0nDJgQo8v+DH7VyE+O6iZsH1kBq95VeXkO0pwd9wiwXcpj
	zclPY3E/L3e3ts7DkjB7eyrRVOL3vPYE8GM3ES9dS4QsAj98bFJmRH48VNe/0+QkkrXHeXFMrGV
	w4P9i5rk7upjgczNZinsT+6o16kXsdRKFSMQvoD9HzetNXto4oNqDubKVt6URC9/NUxb41YG6WI
	BNYhJCLYouKE8WO6SphXR7sc+n8DnbqLbUsi37fE1BnitYc/OqGyyG7zBP9C4JqBg2OJnQC4QDD
	3DTL73Q2I5b4zxc3v4NoGT/mGOB9EOGxrQLK5eGh0I7A+x49H9kUr0cgF5kM9B/hd
X-Received: by 2002:a05:6000:178c:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3ecdfa1d446mr1736913f8f.47.1758116508699;
        Wed, 17 Sep 2025 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2wsn48aIbLhxRJMluX1pkl+z8XXGI8sJvZ1EmUT/hfsPa2xw9d1Th60HJN9iFrZKhSw2j9Q==
X-Received: by 2002:a05:6000:178c:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3ecdfa1d446mr1736869f8f.47.1758116508254;
        Wed, 17 Sep 2025 06:41:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e98b439442sm15422825f8f.38.2025.09.17.06.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:41:47 -0700 (PDT)
Message-ID: <c955bff9-b4f5-4b93-b7e0-28473766dd2f@redhat.com>
Date: Wed, 17 Sep 2025 15:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm: rename mm_struct::map_count to vma_count
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-5-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-5-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> A mechanical rename of the mm_struct->map_count field to
> vma_count; no functional change is intended.
> 
> The name "map_count" is ambiguous within the memory management subsystem,
> as it can be confused with the folio/page->_mapcount field, which tracks
> PTE references.
> 
> The new name, vma_count, is more precise as this field has always
> counted the number of vm_area_structs associated with an mm_struct.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---


[...]

> +++ b/mm/mmap.c
> @@ -1308,7 +1308,7 @@ void exit_mmap(struct mm_struct *mm)
>   		vma = vma_next(&vmi);
>   	} while (vma && likely(!xa_is_zero(vma)));
>   
> -	BUG_ON(count != mm->map_count);
> +	BUG_ON(count != mm->vma_count);
>   

While at it, best to change that to a WARN_ON_ONCE() or even a 
VM_WARN_ON_ONCE().

[ or remove it -- have we ever seen that firing? ]

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


