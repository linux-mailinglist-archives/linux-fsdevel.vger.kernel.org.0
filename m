Return-Path: <linux-fsdevel+bounces-17215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFFD8A90CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D872D283A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DD37149;
	Thu, 18 Apr 2024 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUYyNaE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD83D54C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404417; cv=none; b=CEpMxVCRTXJAS+rf/Z1FT1H5HMVaS50zUtdnIjcGy33AVqMemDq4Egc519Ja49xL2AeHAz0ouFcqGdyUhNeLylU7+pSKQXoSn+oHg7UujJxOdw3xbh6y7NzPSwA26LDO3AtQ5bpbRGFVJiqK1R6opaB52OJvmhJyo2MMYMS62Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404417; c=relaxed/simple;
	bh=e3bCTdtHrF2UnBnEbVCk1MkmyVmZb9X8WMo8KFpypjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUnr+PI19ypTVV1wT94dm7xl0KbadtZI9+JGGvHN1MH4lVc9y7WuuV0yG4zqU0X+tUwdrGURO/1CY0g/CMdUx5J5cYDMe2UZv7Wmc+Rc3BIawZAOlHxQ/ClulwwH9FOzlYcI7DpQoqYf8Lg1prEG9jroRIh34ajuiZCk900R5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUYyNaE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713404415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVgKAS9nz/LG4ge1C9xAdcQzyy8X8VEwsLz7Mq7LgFw=;
	b=OUYyNaE59nhX1hFemxN7JRcAnh4LboeS+3TooRZrV3qx/Jzr66JtjjKwG/BIUk8ElLDofC
	c0oPfXEuYoatmr7TzibhVHN0AmyKtwxLGZ34ElR6CgFlfIJPs+XB1jrWWvCllpM6JMeEv/
	TPHBfqFH+S8NQqsLQ/cPFV3H81PNsMo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-p59r5BM9PBumS_Al7VGz0w-1; Wed, 17 Apr 2024 21:40:13 -0400
X-MC-Unique: p59r5BM9PBumS_Al7VGz0w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e2ae0153e2so4970315ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 18:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713404412; x=1714009212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVgKAS9nz/LG4ge1C9xAdcQzyy8X8VEwsLz7Mq7LgFw=;
        b=BpQKlertSmbLOn3tW9wrtlMNXa0d0X8w2+Bp729Qizxwu2OTOoeSceZIPG5a2ZqArb
         vfgEWJ0PQZTIOfoW5rHf2f+jheef5aH2g6laG8rWVoTHqGfP0OrnKCPsvK8z0vgxdMex
         UwM3sN5v5Ir4YOjChLvnr3NfjYewPdUPCB9wVUIwaYmoIKZ3CqaPp6BmqszC+UhY6PBC
         4hy797FxOYoX9hnYtyHHNMJ5JcdqOluqxi+THldPyNkkJ8kWdYEwszU+PmEuLVm5K7C/
         e55DOX/1KDWQM1Q4l9G9z4IBleJC1sVFhAvruIe+srg504HP08ZOSo3qB9cIvt/HcgzM
         +FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIh9HaLvr5txMTJ2bj8Sm3esordnU13IqR4ePg+iX9d7jpmRJH3dX3q/9lPOQ9krpkgHMdPbJ8GT4npusvi5bEQ6zDHuVQwsS0Cx9nhA==
X-Gm-Message-State: AOJu0YyxWIydtQ/Nk9dYYMDIrebyFT7cMS1kf9iCnto2FhA+skf0zEKM
	sx8fAoSJJXvli8/zbe2sc+0bG1FO33+dI0kCcy5VyEyGtSjkMSScBsCpX2x/LbpLeeoJlxjN3XD
	pRLfgLw31fpWWjZTrzgEKr5t1+ICNudnXhlRIkRSKwCrk4rGvIQqO1yS2Ecb0mxA=
X-Received: by 2002:a17:903:228b:b0:1e4:55d8:dfae with SMTP id b11-20020a170903228b00b001e455d8dfaemr1685039plh.4.1713404412279;
        Wed, 17 Apr 2024 18:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6VvtdAGo5TIQeytuXP1dbMJEhF6NhbLbnVJumMJQ8ijnoQzNd5M6jQzcmCzrBaveFaQNpmw==
X-Received: by 2002:a17:903:228b:b0:1e4:55d8:dfae with SMTP id b11-20020a170903228b00b001e455d8dfaemr1685010plh.4.1713404411924;
        Wed, 17 Apr 2024 18:40:11 -0700 (PDT)
Received: from [10.72.116.40] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902b21400b001e3e081dea1sm314514plr.0.2024.04.17.18.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 18:40:11 -0700 (PDT)
Message-ID: <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
Date: Thu, 18 Apr 2024 09:40:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-5-ryncsn@gmail.com>
 <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>
 <ZiB3rp6m4oWCdszj@casper.infradead.org>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ZiB3rp6m4oWCdszj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/18/24 09:30, Matthew Wilcox wrote:
> On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
>> Thanks for you patch and will it be doable to switch to folio_index()
>> instead ?
> No.  Just use folio->index.  You only need folio_index() if the folio
> might belong to the swapcache instead of a file.
>
Hmm, Okay.

Thanks

- Xiubo


