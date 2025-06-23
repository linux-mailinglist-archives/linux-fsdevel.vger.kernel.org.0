Return-Path: <linux-fsdevel+bounces-52571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D8AE458E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C823B17B585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372612550BA;
	Mon, 23 Jun 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCVi3yMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0112517AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686695; cv=none; b=blIN9S21iX4PYytmjHIiv2ITdYyi68HEJzb5y1N+iucJPp9kTlKJZ8xUIq/FyR6HjpLg7XRLwUj7uCQIjVIsmpkhdCY+t52OnbrY0iNTe9J1DgIFzWaqv4CYV0s5f5WP/1pmL84ZN/HUjB/sXsexqKVlTW8GnKVHLsx13QuWKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686695; c=relaxed/simple;
	bh=HJmFXLX/j3dETufjqwrf6ToA6QYlCLIoKTQ0NUDZnU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTtAUtZu42yOQ/uD9vAiM4Rn4noIBbdqqNyzAnfi/HgrMR2tv8wVG3uVIa/3EarOQ2OzP7Lw1m187CcYPjanswfMehvYFI1MX71ELDkZDFsmv2u2nNBXgL4untd6JLpCrsD8lFf3J8sQibGpfwCWAhwmqcvQQjSt+Ee2n5U51g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCVi3yMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aTMs4wV4SuVKhFSHjMzqgPgB1cu77va3GYx+Y9ijEiM=;
	b=YCVi3yMBtV1eitR2jmTdmMxizul893Zq0QV5b3OIXrDuDtMBARDTYTGkupU1FdSq3kUxQz
	eJ9T68/CercMZW30wIlXO1LAlJHEWtBI/FrUL8UqDI1wV7l0wKpP68tErmFf/r0rGZhBno
	35mbhYt2Zho68OfSaWF94lGPUPvzR0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-VMVKTsIfPK-3NVdMt6CF1g-1; Mon, 23 Jun 2025 09:51:32 -0400
X-MC-Unique: VMVKTsIfPK-3NVdMt6CF1g-1
X-Mimecast-MFC-AGG-ID: VMVKTsIfPK-3NVdMt6CF1g_1750686691
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535d300d2dso33760185e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686691; x=1751291491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTMs4wV4SuVKhFSHjMzqgPgB1cu77va3GYx+Y9ijEiM=;
        b=eUbrULknV63eKXbumrfAFI+chcgfqIzRIl2m7TtRwvHVZid+f22TZGzCFnm8nwmK0c
         DGwCL7/PgL0CBbXXZ2pR8Pb30SgPslzjpUTNz2nzrvfzei0+o3oAADugB5QFJGKb/VoM
         PGi0c9IrsNGoNmmY6NC1ecnEtUiQiw8eFsbU43X1iMCVbnUkSa4lETYxLnPV6w+cWVRO
         97q7yL5Eq7l3Mt+BJan6PXHM6LDBer0sQNQjKR6O+TGEsAnJuWLU/F7jQCE+3NI65aR8
         mF/jr3P3qziORmOxMk0YP/fQSsGY2V1EUNzlKiG0oOhpkvlPvoaJxhLu9oGJJ9YNW5Xx
         /CMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzCptm/WFD12D44xycFWsw+BbmD/TUc/nMSG9NvFzhIIfBaO4ZxDsq+Trc2kcC9gXHz5JMirIGGD/Qz8G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SPr0Qa/pLEkcA1WHWYAaxQ6sfgvLSkYC+SohA5qdwRpiPOVD
	5rtLtlTK1JEtC270l+jlVJV+eSWf19YjzKTMISACCHWyXE/wWc8omj3SD4OrFZ22QHxSVU+o2Ff
	nS+kAaBkmAOSLpj1D17g2CVHbHK0DZLXmW8pdSZRlNnClwSKiqoss41NgcBke//krtGA=
X-Gm-Gg: ASbGncvrcEPIfLL4jT4g08JqmyXDrJHb4R4UHUgxxL3FVmuZn9Htb/bZHrR+C8eOsbH
	nxpBz6ClPt+WcwKFkLJ11Avp3Ys1d2rqmpGaDHswVH1V+T7c1ut7uIuxeWXsEE0gS56/7olcopH
	AYpoSHtDreZuUS/shlybjR9GnFz/hZehFkBcrOisqJKbXa6VF6VysZQ+oFwh2DwFpiTsMEMARoD
	NBVYWnXFari+9OPQu7lglA9BXx/GSEnHKIthlybboSzgNfu72zZv+cfOSk/nVeblnhdz3v/iUPK
	Cg38Cgup/8zoWn26PlGx/LxVvLza5kTKbIzCHfKi+SVxJr3xCZG00tq8sdJlTkRnj3b5SzKS45n
	N8DAp56BA94c7C+cSigymb5RS9LxdwRTJM1Nz8n21mrUSSrdpbQ==
X-Received: by 2002:a05:600c:3b1e:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-453659c0c47mr137895935e9.30.1750686690830;
        Mon, 23 Jun 2025 06:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3wPA2NDZGNU+tezB/9zWFnuVdchez0lrMy4aiZ6nmbAqIOhTpniZoMot4ic342DXsB/1krw==
X-Received: by 2002:a05:600c:3b1e:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-453659c0c47mr137895525e9.30.1750686690404;
        Mon, 23 Jun 2025 06:51:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eada7adsm147297065e9.35.2025.06.23.06.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:51:29 -0700 (PDT)
Message-ID: <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
Date: Mon, 23 Jun 2025 15:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 brauner@kernel.org, paul@paul-moore.com, rppt@kernel.org,
 viro@zeniv.linux.org.uk
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250620070328.803704-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 09:03, Shivank Garg wrote:
> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> anonymous inodes with proper security context. This replaces the current
> pattern of calling alloc_anon_inode() followed by
> inode_init_security_anon() for creating security context manually.
> 
> This change also fixes a security regression in secretmem where the
> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be bypassed for secretmem file descriptors.
> 
> As guest_memfd currently resides in the KVM module, we need to export this
> symbol for use outside the core kernel. In the future, guest_memfd might be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>


In general, LGTM, but I think the actual fix should be separated from 
exporting it for guest_memfd purposes?

Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does 
not exist yet ...

Leaving deciding about that to fs people.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


