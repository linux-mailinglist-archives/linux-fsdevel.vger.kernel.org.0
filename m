Return-Path: <linux-fsdevel+bounces-37807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05E9F7E55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92974188CC72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86C225770;
	Thu, 19 Dec 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/hdT8kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97443D3B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623246; cv=none; b=FALVRk4EC/edoHvCiiDyYchXWe2Um1ONy7JDnjAAkgvqq5TgZjiOVBot72RFcSG6Dahhqs86yixT87Lh1zERxwcjeuD3izvx3QqpKXogxY0G7S72RQ+EVs1rzb8Ws5PYk3f406+EbQJreYyAN9Ap4mYRpRMYgAQj4QYNuelbVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623246; c=relaxed/simple;
	bh=HGc/O0fLayT9IHQNDaTZ2//uvweeJOFzUaov7laqUE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwdB1PnADeg6XZkiwKAd5OFDFnSPjwqjw2AFniycU4IMRlLuWJHAJmSsH3NwqG02I7h/YhabA1q9baAYoztdSOYLM8ivgD1hMB6vAOxBtzT5A0G0iSzxuyTD/5HsWbN7vKV3VzNYjbraJPrut6bddFfsK9pzC4Miv39PFJCpg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/hdT8kt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734623243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LtJ9h9zUfVww3DKEtUkUv7Bzjw8SnqlhuK1sCMv4jYk=;
	b=e/hdT8ktzVpii/f9fGi6emmEz4weHip+bAo0dnwyxCYyl97aKsGKggkfeJi1tQjuHvf3OM
	IJhqgOM7ZFtfGqXYV4nfrnrV6lWHzwwGyWsbBcF/Po5weHNjkYj2WFygYtupYHGmkAJf7r
	klKGKrp0XnTVfYZpQny8Q3Vv4Qzx2gg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-QUxgMHBVOfOBRSbi1a7xEg-1; Thu, 19 Dec 2024 10:47:22 -0500
X-MC-Unique: QUxgMHBVOfOBRSbi1a7xEg-1
X-Mimecast-MFC-AGG-ID: QUxgMHBVOfOBRSbi1a7xEg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-386333ea577so452041f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 07:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623241; x=1735228041;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtJ9h9zUfVww3DKEtUkUv7Bzjw8SnqlhuK1sCMv4jYk=;
        b=CM5Eq0Np7eINT3VweRLRHKmJ8nhquymKkfbCMyph9wY+gwPDNgi6avzayF8wjZha7j
         jlz8ggtAupLIPRoUDIUjVfVJgCt7a3ZkueOnQlL4QjLnhFcqFo0oofoQ/Jq9Qc8sv72o
         aCH3VK0tAkEIddqj6ttmcW+aBCivM3DbnuHOs9GIK8kkgqKexVPqGTdCdg/fprCoOPPk
         fudiJg632pnzrUfKBWrJY4bseKI5RJMe1PlUOdynsNHFNjBDD4Y1nypADUz/3GTzuK+I
         F+Rs/VnAJmUwLN2BCRC2IWriK5qww+3qheCcWVjkRxOYVCKuQm/T0yHi8f9bIelHu8z2
         ganA==
X-Forwarded-Encrypted: i=1; AJvYcCW4WgB0m0KFeyKrl+4VdxIrrFVIW403PeR1dAKhLj1K8YBagqQu2fbSZo5WrZ07FAceEA9hMqjmcJdQ/sF8@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAFHYP/9sbFOV8IvEeDq9ZtTZ0c/p2t+Pm83E/51QU0ApRpGv
	JUKEl8oYa6mCzIupkwES3mKWYgodBYS2VWN5EHLQ/qnn4DSpbUZBxeTYzlnm5CUhCg4M4iAB5EQ
	0iF0Z2sKQv/x2OJRiIM3b9dIr0nODHy3v3ZqI4K3pS8G/3NVXmYCRddI7l8ZTv/Y=
X-Gm-Gg: ASbGncu0Cr/3t21ItBiasuUPhiF7mCZDRCnOFi6K631KOOoPcCfZxGiySSB2ZeR+cf2
	9DNklNjsikxcigQOLFIofOj9/iP2QSiOKcUu3KRHkYi9sxEJqHkhmK7IOaShSmDNtOE8RAcKXlE
	FPYX9BrYXCm1CsfNZKd97HWs2/q3qmdb58PDLfc1A2JUAnzH0ZRe05O5ffuAK1Hem4ruRgWDKTY
	rOs0JaNaGD5luJcMAFUG10gk14unTFlWL8Cw7ooi9BK1vlCkhgfCwZksE5m+BymB9bc0gbUan5y
	OCQ+kzkWGJSnDj6IkysLhqro3LjNrCXH7heiuuC2klWXXkafsLfCVdi87rwgwDG8IgJ+uIZVY8Y
	XkQ7X6g==
X-Received: by 2002:a05:6000:1fae:b0:388:e3e6:69cb with SMTP id ffacd0b85a97d-38a19b1e71amr3674752f8f.37.1734623240699;
        Thu, 19 Dec 2024 07:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdGsLbb6Y+kzc2T48yRITUSDrN92p1wgS7UeSo9ZOtJhznpONh6av8dQ2S9nLr0DHAtDEx/Q==
X-Received: by 2002:a05:6000:1fae:b0:388:e3e6:69cb with SMTP id ffacd0b85a97d-38a19b1e71amr3674725f8f.37.1734623240290;
        Thu, 19 Dec 2024 07:47:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb17sm1791950f8f.97.2024.12.19.07.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:47:19 -0800 (PST)
Message-ID: <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
Date: Thu, 19 Dec 2024 16:47:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 16:43, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>> On 23.11.24 00:23, Joanne Koong wrote:
>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>> writeback may take an indeterminate amount of time to complete, and
>>> waits may get stuck.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> ---
>>>    mm/migrate.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index df91248755e4..fe73284e5246 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>    		 */
>>>    		switch (mode) {
>>>    		case MIGRATE_SYNC:
>>> -			break;
>>> +			if (!src->mapping ||
>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>> +				break;
>>> +			fallthrough;
>>>    		default:
>>>    			rc = -EBUSY;
>>>    			goto out;
>>
>> Ehm, doesn't this mean that any fuse user can essentially completely block
>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>
>> That sounds very bad.
> 
> The page under writeback are already unmovable while they are under
> writeback. This patch is only making potentially unrelated tasks to
> synchronously wait on writeback completion for such pages which in worst
> case can be indefinite. This actually is solving an isolation issue on a
> multi-tenant machine.
> 
Are you sure, because I read in the cover letter:

"In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse: 
support writable mmap"))), a temp page is allocated for every dirty
page to be written back, the contents of the dirty page are copied over 
to the temp page, and the temp page gets handed to the server to write 
back. This is done so that writeback may be immediately cleared on the 
dirty page,"

Which to me means that they are immediately movable again?

-- 
Cheers,

David / dhildenb


