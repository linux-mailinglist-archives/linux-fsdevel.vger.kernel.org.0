Return-Path: <linux-fsdevel+bounces-49437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF5ABC5B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F4A17A67E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48625288C35;
	Mon, 19 May 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hdm3mqTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100E2746A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676439; cv=none; b=Go3pzrg/LT0bsldoKOgspKaC9L/xPk5FWX79IoWS0rPGw3Bl4hJHB7PzJ4sKv8ALfrSC+OcdFCqBwLeax0qo2yF4AQeDAjtjUrvQw54l8AUhyz8FQ7Imk5cXpHAnxLLnqHgVPh2pzLhc6ky3zRj/Wy3KB91ZrJ1HSXwRvWX8+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676439; c=relaxed/simple;
	bh=SGYRJ/Pa/rCRIAEp2DzT9CKDo2DR1Kor41Jpn068XTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBIZqSzEd2l7/VBgm9rGZUKEt0su1J/1676528zp2UK2N1LvOxup3Rp7TI+tRfsSnE1Rph4goC41tc4VpEE4WlF6v/ZbX0MsmKU6WU/0igUsAJtsoOzW7zXSjwdv5yuIOlPxrDugRrkfiY+GohfJ+BLuTnSh311xyue/XJTHGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hdm3mqTL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747676436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K36xPLX2EO98K8la7E6clUlgO3MhKSVoAV5X8FkiL4Y=;
	b=Hdm3mqTLERqz81R9IGFxrHW8/3lBaHV+7o+ObJdJDxTIk70cY+oKwsU9nCwXdb4+ZdwTY0
	gpjUhCaE1o0WPpaV21snSdU09fJoVmiQ7wHICjBvdp2s1vJt+lqlQyV+R6qzQGyKBs7N8J
	MgdVj+hdBx2WseePT6R7BNRj+bcwrZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-i34N3bFRMzej5orUelbFpw-1; Mon, 19 May 2025 13:40:35 -0400
X-MC-Unique: i34N3bFRMzej5orUelbFpw-1
X-Mimecast-MFC-AGG-ID: i34N3bFRMzej5orUelbFpw_1747676434
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso25027665e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 10:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676434; x=1748281234;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K36xPLX2EO98K8la7E6clUlgO3MhKSVoAV5X8FkiL4Y=;
        b=cl4etEsTkLWlSxWtKXXcRfKE7bigFx0SjN/60DmaY2OOCmzyzES5TdD5AmJ7hlbfhB
         LMQSlVb/17LREYyYFJqYDpktpa0NShEw/48T5EoJtVBvoe0YVyITqIjkc1wn7ZPqGkBt
         +6p8SNvbtqCZ2l55xAM/XR0lc2HYWt+2v17tiSZcqQRxKNwtZ6J9FsKc9aDPGWJ7GFRF
         xHtoOonJ9AwpNCNTcyaN/MJOkqnsJOtsYbAJGQgeOXUlLpfN7Ae2AQGTQIcuMHSh7yQT
         O6sJciCRA03wB+jeX+64Hg3aNHHn/Jze3Gp6YdRvcjWf65TPHRWI78bvMWP6+GzNLs/2
         oJXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAAuqDtr6pvAdHbM/VzHapsBsjQOYqiwQPK+KlcR+OMU808GJzhfEgpkN4sUEoDXx5MzLwQIofknaWPjBo@vger.kernel.org
X-Gm-Message-State: AOJu0YweCqK6xcY3KbLe20qul7bW/DPRuVTiYt/igLsOIdba09gCAP/Q
	1JznSLwZUuLllVtDI/aRBQPJuGgQ4SuHfNePiqv3LMC1KYw/4y0DfRtLcVJew+wbYlsC8cQK2lw
	anYUGV3qLxQCarBQmZM/tp9Fr96o/Im4Datux23mN9lH4sbCQu7XxXcUCOQFj8QE92Aw=
X-Gm-Gg: ASbGncsKd1HnxkkD5twnlJTii3BeLYtVf5efw3sndz0lkgb71j8KZEti9DWkgiJjwbF
	cpKyRBO+ohkkcdR9B+kPPlCKepjHTYUdUV2N/gkkI5eWnwSDWMObbl2FTIzV5rXVqHxkoXz/+er
	YfSJuxfu0Bb3/AmI1M6Bo6q5lxL8GXTyl0vDr6+QffjFCIUDewAbkXEqkzJymgAWsqcFu1CxiFi
	LIU10ubIDwcY7dvd9Sgr2cjH/jNfbst7tzsPvzLDA5JQM4b6h6GQ4YSkPcqgNcKfIt+TCfP5zYv
	pqcnmE6ckATTf8fF69dEsbT8W3yXzjO1kP8ZvJeGFTzAJpkLToCQE+b1kQ/sqit6nQxo3o04k8C
	5jmE+8Iwdz+2YYcTv9eg76uXV4AzTkCL33820rLU=
X-Received: by 2002:a05:600c:a46:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-442feffb5a0mr148453295e9.16.1747676434478;
        Mon, 19 May 2025 10:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUICFVfnitZqeXCiHKTi2mEcLXl0asuTZmmpVM4HpKVDE2zGdtICR9BqQW79GLRMernQBoBA==
X-Received: by 2002:a05:600c:a46:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-442feffb5a0mr148453035e9.16.1747676434156;
        Mon, 19 May 2025 10:40:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583e84sm143807005e9.25.2025.05.19.10.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 10:40:33 -0700 (PDT)
Message-ID: <1296c1ee-cb0a-456d-b5b4-e6153928d32a@redhat.com>
Date: Mon, 19 May 2025 19:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: ksm: have KSM VMA checks not require a VMA
 pointer
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <daf12021354ce7302ad90b42790d8776173b3a81.1747431920.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <daf12021354ce7302ad90b42790d8776173b3a81.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 10:51, Lorenzo Stoakes wrote:
> In subsequent commits we are going to determine KSM eligibility prior to a
> VMA being constructed, at which point we will of course not yet have access
> to a VMA pointer.
> 
> It is trivial to boil down the check logic to be parameterised on
> mm_struct, file and VMA flags, so do so.
> 
> As a part of this change, additionally expose and use file_is_dax() to
> determine whether a file is being mapped under a DAX inode.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Looking all good :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


