Return-Path: <linux-fsdevel+bounces-48549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE4AB0F80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8DB503CD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198028DB64;
	Fri,  9 May 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdXXQiAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480B26A0BE
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783954; cv=none; b=Edw8HRXJJGjUZZkPy/g/jzzzvqizSfXF7z0KE8lKfYcZuPOIXdzdFPlbIcoAo3mFB3xbVKRw3Tp9YCUcxOMue4P017FAf9bsgU87N4F9PkCSP0536S+2GkX/oQLEb4UKnLneyvJph8u+c0+6lUUGgr7oKs5715jHRNCKSe09Ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783954; c=relaxed/simple;
	bh=vEzeCbOr7rTbW3vMJ3X1Zk3anzpiN0GrGnLgFbq6fqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1tZLK2K75e/CxxULzWz0Tct/NoWcH9hdWSYba/bdlGALMKCwDwkNZwgDKinMxYT5FwXjb3N0uMiJSnR56brV450UaGwxzosn+FoYU2bcO3MkRTuLeLuHF2XMlubF6itF2Nw44aQKkrX8P0laMGwV0yYLnqc7SRgPKWxYZBGkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdXXQiAu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746783952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bu/8JLoeCoD1WqiQs57tUFU7TywIqe2UBHBIdfA/PFw=;
	b=IdXXQiAulnCcjmlXnaVRgtT1LlJjruluDlhk4rn2mJ9DmFHMm5rcuS8f//B050gbFfNyDp
	mMEBJAtGednBLStWwlvbOpkP7ngCwffK9/Vh1LDKlWaoos3JTjsLr0PXntCmioA4k7q5Aw
	SLOBjBl8N7dTjsiYuN4S97GMWlyz1/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-vwj7qh6RO3y75wAaTObH9w-1; Fri, 09 May 2025 05:45:48 -0400
X-MC-Unique: vwj7qh6RO3y75wAaTObH9w-1
X-Mimecast-MFC-AGG-ID: vwj7qh6RO3y75wAaTObH9w_1746783947
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so13331675e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 02:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783947; x=1747388747;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bu/8JLoeCoD1WqiQs57tUFU7TywIqe2UBHBIdfA/PFw=;
        b=CsnhjNsRDfReGfw15dUA7lkXgO5krwBMVrvNm6W3qlNRHTq7l9roxGh0gfhaW8A/vo
         e4GCv1/6H6fDnLPCStklOXGkzMOzOVdapSHlAxAgkbKuhc/EpzmOt8uiD7l7BIDe9Ck6
         hPXxRwpVlewhmJUiegXOv4GMZ5voEoJFsdExtX1DeXakhmeYCwShIpaj/KAxrE2V5fDv
         GBP1VLd+W2Pmjk+CqOc4rZV7QNhCdXzhjfuqiBbvqqp+X70Vme5twb4aySoQOFT94xpg
         CRQecMeegQtmx9aPgSej30HNy/oPXu6yUDe4pYuFGIwwUUo95tu6H3Ftpwn8pQQ8zP2O
         5cVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rEdQQj7ZxSqdYl0xMzNJfj8PLZNpqsS2PvtdV+GhaWFG3prhQZOGE3ZvkYBX6GFjGZEgd8HgW2QdF+Yl@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPb95i0wQF30EedS+C395XT8WYOSrYZp79+8/e7jz/F8AlG7U
	qZHmLKDtYGCkcKPE4cFMTvSvLUhdtirOECKjq238DNraIaVDJVC8sbG7IFt4kNX11gMo0xtV91R
	N6RgxQtjxQ/pQyL4s7nclhFvJOgt13GbAxzgQeDP6DKO4EvXitEwcccdgdYCcRAw=
X-Gm-Gg: ASbGnctyQ54N3rkHnYy4hwkVj7S/u4ct66lCCK5RwM3yWHxHS9L5AdK6+Hogx7y0E5/
	xqD5YlApNApn15CBVIOLbZAhI92d8bAEABoTNi/7++18SBalFs5/kFw9HcQzRV95Y8NAnrOeASY
	XVsdK8Ia29Mu1cGZLlIaZlvXSk2xafjUyFEfngAYtCUiuPb5FF7OCJYZLS9/oOLW+47DtON9YzR
	4EjvE65SZbToXEtUp9uB24vu/9aqEznVFWKr5HIhnc6c59JjXgRkGTu7I+ZKfwwofqvK7DYn/Bl
	vvxOexikqqPll/ZNj/7FfQzcGGV2R24Lw+BIlcWTYhg7PuTQtVNj6ud+4O6lr/KXG7xc6+MCevz
	l2xUV6E96aecCOuvyENdCLEMId/w6jadeZ69jYq4=
X-Received: by 2002:a05:6000:3107:b0:39e:db6a:4744 with SMTP id ffacd0b85a97d-3a1f646d9abmr2212119f8f.32.1746783947554;
        Fri, 09 May 2025 02:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWyAH3LOt/3cZP9Rvihrl0+ejLa3IRZjY7TLv9wiabkFRe6nuDbo+0JpbmOS1yW5BiT5eqA==
X-Received: by 2002:a05:6000:3107:b0:39e:db6a:4744 with SMTP id ffacd0b85a97d-3a1f646d9abmr2212107f8f.32.1746783947216;
        Fri, 09 May 2025 02:45:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de087sm2762774f8f.16.2025.05.09.02.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 02:45:46 -0700 (PDT)
Message-ID: <71cb8335-ad53-409a-b947-d7ded8a3ef02@redhat.com>
Date: Fri, 9 May 2025 11:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/vma: remove mmap() retry merge
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <e18be1070e9fcd7a43cd72ac45f19cf1080e73b5.1746615512.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e18be1070e9fcd7a43cd72ac45f19cf1080e73b5.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.25 13:03, Lorenzo Stoakes wrote:
> We have now introduced a mechanism that obviates the need for a reattempted
> merge via the mmap_prepare() file hook, so eliminate this functionality
> altogether.
> 
> The retry merge logic has been the cause of a great deal of complexity in
> the past and required a great deal of careful manoeuvring of code to ensure
> its continued and correct functionality.
> 
> It has also recently been involved in an issue surrounding maple tree
> state, which again points to its problematic nature.
> 
> We make it much easier to reason about mmap() logic by eliminating this and
> simply writing a VMA once. This also opens the doors to future optimisation
> and improvement in the mmap() logic.
> 
> For any device or file system which encounters unwanted VMA fragmentation
> as a result of this change (that is, having not implemented .mmap_prepare
> hooks), the issue is easily resolvable by doing so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


