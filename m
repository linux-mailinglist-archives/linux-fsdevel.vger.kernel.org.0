Return-Path: <linux-fsdevel+bounces-16444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A718789DC32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF745B2734B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E312FF73;
	Tue,  9 Apr 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKZj3Fx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1A12FB16
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672849; cv=none; b=h1R6SlVu5f/BmFrb991xpTsaTK5/b0+2+qu/tS0+tpConquEs2vP+D5S77PtL9bKB6zqNTSV5MGrdqQI7zmIPWEw44CmwuIorIsZ5TdPdkVVmRI8+9AagVPE4t4ChTk2vVYRUrzhoInHieb1DIV4D2upAGAruG4P/U7ImzjGRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672849; c=relaxed/simple;
	bh=XgGk2GbPGldg0GVhs6UaO2+nlwDkpxswGpY+s8f4tfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmDn21axIRl8P1WG78JXWuyWSNtKlDHOs6oOrYUGTsd4V6C3DZtousrYW5oIYEzk3GG0hWU5xrOL2aFEK0byRICs4ivHngQXZnKpeQuCKJ/fJPoSRD/0oFsf6HyRRueh7QO4pnE73/F0yWMxx2kuAKGCTf0cdFVNDWpiOsVXvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKZj3Fx+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712672846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J/cc8jnajbcWNcC+T++BCY91Ze3ekt0R/w1u8yeuqr0=;
	b=eKZj3Fx+baBtS/OwwqlrPkeo3tkscDGf1RU3Hm0OgPbsoWxbpGE5yDoExGMy//O9EQf9IH
	MY7mzVO/jNxIufkDBOro5crHXqxWuez5Ul1YBtFaYS77WZAiS6yVKW0y2AVLm/yuLX4aY7
	yieiXGs5y3AwwItyWwYmbrz3Na7P/tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Prqpob9eNGO99XU2sGgfSA-1; Tue, 09 Apr 2024 10:27:24 -0400
X-MC-Unique: Prqpob9eNGO99XU2sGgfSA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416542ed388so12513185e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 07:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672844; x=1713277644;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/cc8jnajbcWNcC+T++BCY91Ze3ekt0R/w1u8yeuqr0=;
        b=s7L+x/7Qh28is9KJzJT+qn9UNFArhi8d14aGEJlGvnfHP3pap6fQ7AzpnwLI6/WlrT
         xo1ieD2IuIda7AIeaqK6F6kZuyo3qN5Ya3PJ2to8h5ESd4+Ou2enBRib4eZUkESF/xnk
         CJ9QTESorF4F9BRQVWflSA0WoOY83H0SWsJQZg3FDAspakyUavq98r+PsHN3BrBOpAuM
         5rM6tY7Ezwi6XYei/v08FCbPZCU4t8RaSrPF3P0BqVmdEZG/Z+w48c1868x3pUiOAmJC
         +5oXZFJdieviZb4DYzQd3EpD39QH0Hzv6b9HavZk7iDuH2w4J/oPd76xMKmog15B0lz9
         w0aA==
X-Forwarded-Encrypted: i=1; AJvYcCUwRI3AH2BrcxPO4ZbCuUQoWXuoT1NRGdKszVNi4HZXSJ6SqSR29dCRXo95ae+QZBFyfq2kQ12vWiYsCnY+XMfJ5U7+8jZhi/IDnJJ6vQ==
X-Gm-Message-State: AOJu0YwG4Bzh/CxVBVmYiUTRQGR0kPFHWaCcxSUtmSH0IUzKDjRkYzY/
	gPs5LtuWzWMjfjOGxGk3NXUAV23WV492/J+uhOa/ddaD9Kj4F0PSMo7WCUPeGASWbBRbzTGwtFV
	ibTO/PfOV27J2kcFUvtsp7uL2JYeIuCzyO2HkYTIIq/u4HJ+ydmu2y4m43cYI0+w=
X-Received: by 2002:a05:600c:4e8b:b0:416:7082:ec01 with SMTP id f11-20020a05600c4e8b00b004167082ec01mr4789688wmq.22.1712672843734;
        Tue, 09 Apr 2024 07:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa6mDFKG9X86me+6JM4hkDdalMKQg/oZm+NVI95GsxzgutUxm4TtViIUQNKwpWQtrOPxco7g==
X-Received: by 2002:a05:600c:4e8b:b0:416:7082:ec01 with SMTP id f11-20020a05600c4e8b00b004167082ec01mr4789670wmq.22.1712672843291;
        Tue, 09 Apr 2024 07:27:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe9cd000000b00343f2cca88dsm10599873wrn.76.2024.04.09.07.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 07:27:22 -0700 (PDT)
Message-ID: <f11aa368-b7d6-4828-8791-c89be74cbc56@redhat.com>
Date: Tue, 9 Apr 2024 16:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Convert pagecache_isize_extended to use a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240405180038.2618624-1-willy@infradead.org>
 <eb153cdb-6228-435a-916a-77f4166d4cd2@redhat.com>
 <ZhVMJF6fICFVO6Lc@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZhVMJF6fICFVO6Lc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 16:09, Matthew Wilcox wrote:
> On Tue, Apr 09, 2024 at 03:39:35PM +0200, David Hildenbrand wrote:
>> On 05.04.24 20:00, Matthew Wilcox (Oracle) wrote:
>>> + * Handle extension of inode size either caused by extending truncate or
>>> + * by write starting after current i_size.  We mark the page straddling
>>> + * current i_size RO so that page_mkwrite() is called on the first
>>> + * write access to the page.  The filesystem will update its per-block
>>> + * information before user writes to the page via mmap after the i_size
>>> + * has been changed.
>>
>> Did you intend not to s/page/folio/ ?
> 
> I did!  I think here we're talking about page faults, and we can control
> the RO property on a per-PTE (ie per-page) basis.  Do you think it'd be
> clearer if we talked about folios here? 

Good point! It might have been clearer to me if that paragraph would 
talk about PTEs mapping folio pages, whereby the relevant PTEs are R/O 
such that we will catch first write access to these folio pages.

But re-reading it now, it's clearer to me taht the focus is on per-page 
handling. (although it might boil down to per-folio tracking in some 
cases, staring at filemap_page_mkwrite()).

> We're in a bit of an interesting
> spot because filesystems generally don't have folios which overhang the
> end of the file by more than a page.  It can happen if truncate fails
> to split a folio.

Right. I remember FALLOCATE_PUNCHOLE is in a similar position if 
splitting fails (cannot free up memory but have to zero it out IIRC).

-- 
Cheers,

David / dhildenb


