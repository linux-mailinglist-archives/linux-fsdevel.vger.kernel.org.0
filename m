Return-Path: <linux-fsdevel+bounces-17444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E998ADB29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 02:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B61B237F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3AE29AB;
	Tue, 23 Apr 2024 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XetfoTC2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689B802
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832353; cv=none; b=H377dkFBOd+E0PeJ0QIDBtvn+hdn8qoyvKrmZIRMBfodKjPjOv8G0CpP15yicdWjWNEsdktsoI1y/qfRDkZrycvwIxy6B1xYXijZtWS0M3GDw8iU+twMIGX1aKqmwUj7TeLVlcPjKX0aKCcC4gA+pdTJyw2mjV3bhEMCZq+GZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832353; c=relaxed/simple;
	bh=itx3ppvDXT8VS6nX8kv0qHKwC99CrFUC/qNlwzxzXlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwl8ujVJl/GSXw49WhR0vjwsxWeCjnRb0VnmYhDEcNk7RlJrkNtPBKSzZOy0Hk0OZhdmiHY4AYbolxUeOS83EqMO4vHHgrcMbx3afbYKsnyovdobSUHxhCVgFIAEVSTE86mTHlAN16wCoBJIyA0a3euNAENyxn7TBm6Sw/9r+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XetfoTC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713832350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCmzYdZTWhVBI3ziUJNs2kwLaL5ADy/aO28Jy0SKLfQ=;
	b=XetfoTC20wybfc9UtETB55zJSVJAHcvwjqdMgHOsvoDaF733k8qocemNvJv/msS+ctU5QR
	FbXfi3qGHqbn2TW7tLc1atA7BxLmqGboxZov0nmA1sR301o6Y8CePTinEwR7U8MQYPJyFB
	6tNUup9TpfmzaC0eS8dClyWKUn89x4A=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-BxPJWGTvOGCNnsF2uOcXug-1; Mon, 22 Apr 2024 20:32:28 -0400
X-MC-Unique: BxPJWGTvOGCNnsF2uOcXug-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so8216480b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 17:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832348; x=1714437148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCmzYdZTWhVBI3ziUJNs2kwLaL5ADy/aO28Jy0SKLfQ=;
        b=I7G4959SFSbYs8C2Da/rSNIsoZG/+SVzBTYWMBJHEm+8g06oljhVWdkhsR6Y+xQtRF
         +rTcL6CDEOBOe0cHb+c8AI0SsQ0JD2pP1rzG2W8AAZi8Ju7024JdlVLZKLTfz1vsNIgT
         hQxUoyLHGGlp/AETKut+0w/Fx0uQ1x2sjvdFHc36nOmnuW7Hz2WLU6lYwk5/YRiS71Oq
         Ywc9uAx9W06O1B+Y8tr2G4Nk33l7DwdwvngzRdc2qPOiHo0kOV5+U9hNXzt7Jqv7cVWk
         ICPHO1BLfuzEiiMsjOLBJ+nsZmI7YRw/b6XBh0cpbxSgXYd0fQHhOYaIOZbE233jYVn3
         zOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCC5Y6PJ834DG5l1IBYBHFXQ2k3s0KIyARKy+m4hELsGXwpr7iEib+zMg+ktwuZnOiz4mMVncEP4kshIF1i4kqIQogQxeCqV9F9wgDyA==
X-Gm-Message-State: AOJu0YzVD3ozAwaFf2TxQbxbLIVcJtBgts3TEOxgt5lN231X6tjMWTux
	MXt6o41b9WYv96yQVAXysB3Y3fDZKkJ6vnAOGhQa6aFc80aqN44pz8zAydVfCjAbwT8jsRq9/Eq
	sin/cItlQ/gcEeZq8WgTMV7rOBHdXSRdQnhQaZULgSn0EinZMosWiNUMO8Zjf7Lk=
X-Received: by 2002:a05:6a20:9186:b0:1a9:40a1:a4e9 with SMTP id v6-20020a056a20918600b001a940a1a4e9mr17459134pzd.3.1713832347993;
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPFwlEkwtEe4z6JKUzvuIirWRzKBneJXlYzK+sGhH29LKwk/1srLPP9PxHQTHpNiXcEPgqhA==
X-Received: by 2002:a05:6a20:9186:b0:1a9:40a1:a4e9 with SMTP id v6-20020a056a20918600b001a940a1a4e9mr17459104pzd.3.1713832347621;
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
Received: from [10.72.116.3] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ge3-20020a056a00838300b006ecfc3a5f2dsm8414894pfb.46.2024.04.22.17.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 17:32:27 -0700 (PDT)
Message-ID: <ef670902-edf0-43a3-9409-e0719514ba68@redhat.com>
Date: Tue, 23 Apr 2024 08:32:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
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
 <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
 <CAMgjq7AKwxBkw+tP0GhmLh8aRqXA81i1QOgoqyJ2LP5xqeeJWA@mail.gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAMgjq7AKwxBkw+tP0GhmLh8aRqXA81i1QOgoqyJ2LP5xqeeJWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/22/24 23:34, Kairui Song wrote:
> On Thu, Apr 18, 2024 at 9:40 AM Xiubo Li <xiubli@redhat.com> wrote:
>> On 4/18/24 09:30, Matthew Wilcox wrote:
>>> On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
>>>> Thanks for you patch and will it be doable to switch to folio_index()
>>>> instead ?
>>> No.  Just use folio->index.  You only need folio_index() if the folio
>>> might belong to the swapcache instead of a file.
>>>
>> Hmm, Okay.
>>
>> Thanks
>>
>> - Xiubo
>>
> Hi Xiubo
>
> Thanks for the comment,
>
> As Matthew mentioned there is no need to use folio_index unless you
> are access swapcache. And I found that ceph is not using folios
> internally yet, needs a lot of conversions. So I think I'll just keep
> using page->index here, later conversions may change it to
> folio->index.
>
Sounds good to me and thanks for explaining.

Cheers

- Xiubo


