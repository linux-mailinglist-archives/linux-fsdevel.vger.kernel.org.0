Return-Path: <linux-fsdevel+bounces-35066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F59D0A73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3E282001
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C1152160;
	Mon, 18 Nov 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akNalX1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51D15C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731916690; cv=none; b=nkr+5nFGTm5vSAyPKoPExSre8/D87dq7W3sA0TvqICMwPrRR3ylTR5Ufel//dqCWaPHuTEC6jk/pC/lFSFbZVOJ5y/qerxADDENq0ekDgUvZUzYSlBcHNXC+ix63Xx+u2eLZiDxxWzRVMLWBkFBOc8V/j4vcwsqqp/OEUbWx67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731916690; c=relaxed/simple;
	bh=5pPi6xKQaofhZUWR446CR2u+CiVaiisuNOSPdJrX1G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abb8FXXkY0vaZ9ngVENZOIwedsWcPURvFWao3+uElpevEE7YcctJsP4xt28cdsPOq+rDPi9saFVBm1K4Fi0PW+8XcnlaVbK/581ZPpVxlpBdlr2VgogBCZEzZxnJa1fPcxEp91Ol8fvuxFiiE4OQAQS23pWjNSmnOYWmlXHr8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akNalX1T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731916687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hyFt22iin8wQhi7T2JKypG+2tNQw0cEw4s0cRXi7n8s=;
	b=akNalX1TxV5OZ4eZoz1Eo30wT8/QQJfT0K2tI1B8QXTMsRiuBLlpNpt9J+zjqqKejIAwim
	blaZN/PvOWkvWj+Ua5M85TLhxHwt6UPJFCgONDcCHeo+eF71bLto+R1eqWoImF5DBB26ND
	sKi96sLIzotuo/R2hQltGSohmAQ671c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-mQKxnTKsMSOCwB3BCJKBOw-1; Mon, 18 Nov 2024 02:58:06 -0500
X-MC-Unique: mQKxnTKsMSOCwB3BCJKBOw-1
X-Mimecast-MFC-AGG-ID: mQKxnTKsMSOCwB3BCJKBOw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so18517675e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 23:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731916685; x=1732521485;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hyFt22iin8wQhi7T2JKypG+2tNQw0cEw4s0cRXi7n8s=;
        b=xOxe198jIB4qcLzW3Xl4Ts28wCH/mVxtpvXAxhclMShNMnV4/vxqUQhnbTpc9ouqNe
         KiUDmsCDf1d7pTdIoyrVeX1GL85CMQ8wC5h4NKBiBwEQpOHZF4e9KohA3DcKdwCzOJwB
         rZO02NIezu/E+ky0xxmKtxQGxKnulNhFNXoKeiH3ILLpz5Fv5nRUMb4iir6BDRP2R+T9
         XEwg0a4MDDD4uRPQxN2ubDd1nMsXL/js+0JRF3BzW5GfAD/Ax61QDpfH/vopa0FvJ+Vo
         sCzaxpnJxHjX3JaUHSsF9ZQnlwfRDGRcedNGzMXua/P5rCOViXYq/kQDMOoxeGsJCvSI
         n3Lg==
X-Gm-Message-State: AOJu0YxtJTOPWvC3Q5IGq1mN0TWqlsDLueCCe2qd0zh72u1Jv3YI3ie1
	RBYe0jA8wEZ00i+pxKqFwELE2zdWjaNVr7XvlxO69qyihpmA3VhsO5iTPPG0ROP8S3N2CDeBAJ+
	ojT/Cfupn//RbTDN+ekkn8jU5MB2NveJQzDS3tO3RopeTwBxg89hb4nYrzaiRvzg=
X-Received: by 2002:a05:600c:510b:b0:431:58b3:affa with SMTP id 5b1f17b1804b1-432df72c886mr97500385e9.9.1731916684902;
        Sun, 17 Nov 2024 23:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjKHsr81s25cB3L3ZoNX3hfoVU+74IJ4OJKX8x3YyW4uFWZgDmL9DMg8KgMA6Avluyn4gzbg==
X-Received: by 2002:a05:600c:510b:b0:431:58b3:affa with SMTP id 5b1f17b1804b1-432df72c886mr97500295e9.9.1731916684632;
        Sun, 17 Nov 2024 23:58:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c743:ad00:d0f3:7f1d:5dd4:a961? (p200300cbc743ad00d0f37f1d5dd4a961.dip0.t-ipconnect.de. [2003:cb:c743:ad00:d0f3:7f1d:5dd4:a961])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80821sm144559615e9.23.2024.11.17.23.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 23:58:03 -0800 (PST)
Message-ID: <882c420d-0cb1-40dc-9c37-01f5e320449d@redhat.com>
Date: Mon, 18 Nov 2024 08:58:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filemap: Remove unused folio_add_wait_queue
To: linux@treblig.org, willy@infradead.org, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241116151446.95555-1-linux@treblig.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241116151446.95555-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.11.24 16:14, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> folio_add_wait_queue() has been unused since 2021's
> commit 850cba069c26 ("cachefiles: Delete the cachefiles driver pending
> rewrite")
> 
> Remove it.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


