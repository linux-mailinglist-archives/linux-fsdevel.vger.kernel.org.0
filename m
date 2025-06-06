Return-Path: <linux-fsdevel+bounces-50842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C3AD02F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3B2179537
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C59288C37;
	Fri,  6 Jun 2025 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxFegecJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76439433AC
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215755; cv=none; b=k5wpNqNTc4gG/iq18zCnZyv7rugm19b3RiI57gmbJIVRXc9T0fDN0cw16AJmYNghm9TukJ5g8nAVnjjnGXea/g0BKmGekRv74cAGyWPWL3C0WHHB/Vtmk+udgFY5dEM5ZfYlK+rb6GLSFPWn0fnhjMN+KY3sj4IV3a/8LjpcXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215755; c=relaxed/simple;
	bh=63qnBFn3IeeXRHtX0JRv2KN/seMyYa9Ut3ikUMT03o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o32hZSuyp7ZsB9lSX6kCnXve92Ty6nyShnvwzdlzFgiNBCEDi/6RvhNjYsXno85s0QIj53BAtjBij28QjZC77VM8M6pzISaTo0fu+aaBvL5wC85AaQvP+n7cXxgzs36C0NPOki/SP61m9jvORDKB0tFZyP/XyPpZFB/ER3eFKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxFegecJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749215752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s0OWnwlwuv3H3/Si1rSXJZVeVgGfMEx966EIC+C5qno=;
	b=UxFegecJR5vX0P298Y3b6kJQtbuHozBNdW9HC4gwL3+xLkAxUSXa7HscjW9m+V86IE4Ffi
	rZtg4CbWOt0auSAIDg9WIOOUwhs8lkRsnqd06KGAJ1q298sjAYYppxfEsr43M5uhPiQQOh
	n7z+Rx538wLSvH319yO/8swUa1xD2Iw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-zhSQSlw0Pzukaeddlm9oMg-1; Fri, 06 Jun 2025 09:15:51 -0400
X-MC-Unique: zhSQSlw0Pzukaeddlm9oMg-1
X-Mimecast-MFC-AGG-ID: zhSQSlw0Pzukaeddlm9oMg_1749215750
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450dada0f83so17370725e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749215750; x=1749820550;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0OWnwlwuv3H3/Si1rSXJZVeVgGfMEx966EIC+C5qno=;
        b=HCYIsCxjoZ6bHxx2PMk5repurQJeQ+D6+x9EKX5YDhRZSdr5d8npAoG+u72koDAscd
         F6SJgZp4BG26j5o9n2rbTlVJw+I/Ufb24Saq7xE/7vYY1voe6/tskCr1PZhNQt3naFLz
         JejLJRFoBKAGB47BoJX0B76XftHaqD+7R9tqjskU4ZssX8fUyLe0Xuj3Rj6YFFEkU4A+
         3U6ZQAfcOrA9EHlrup2LH/Tm/M+rk4cGApyoEVkLLJg7/yFESxKnEJIUTcMDJOj482nO
         dLPXLuDv1rCkswEqKbc7WddjTEu3bt+cNiw3nKC/5T7EkXNX2COs20bKGMw7Ihdn1i9I
         TIsA==
X-Forwarded-Encrypted: i=1; AJvYcCWrOkZDiEJIyP0/qxZOMVHsW8BMLg1spkxUUMNGceirfaZ1l/C4jbgqnDIxCJ0SXF8Q7JuRZzUFtSV6nU3J@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1Gn9RiRg3cGG7ip3I/lESk0T0CAtRFTmFsOHtuxQ+E2mobe0
	sNiaLWsal4Lz1vj2nfIzD2ij/Xwp6igQiYt0HgE1ubwsOdnZxjwk4wg9wwj1npUW0ph5sAUTTNp
	tqGc9t7l7CkG4pI7GCZSjp7ZWwxRV0jtr6Q9UxHAUtCL9i3KUaxOVdZ/sfcUw630iuyQ=
X-Gm-Gg: ASbGncuNVWrqlPZY9F0tLUjR7NVUmuKts0M6x82w97B0VdEtpvH7xOS/8UGKR5amNpc
	fBW6VaQWHTOvNoGEU83xzZwgJxlvl+k869lJ5nJ99P9N3vrKrDoTkQxOZE2EIokCJGjNttFN3Jf
	DkC99E26lj3PJOMlKEPjqhWGto3SIKSIP82kY3ibHZWeaOldhqA3r1+aiNbdQeNFRr8SJTRlKc2
	R6M0noN5kE29DzanHtiCEPBCRGnSpoLpoCcDdpHGs9nMsA9qIvWLec7eca1gYLyncr5J8thskPq
	B5ukfFK0ExQAwuw3dumgpTW214K1PnGcgrkj7MP5oBpv0sPyocZ8sQhfSe9dLb5MfyZvJUfL1tm
	8FpeMUzrOTUIkM13mu67QQfzBG1/mgR0=
X-Received: by 2002:a05:600c:a44:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-4520140470fmr30901845e9.25.1749215750186;
        Fri, 06 Jun 2025 06:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcONZMZ9mzWPMwS39oEdC+r6GbtQPJGE/G206HVbssbK1tyXGdWsRNMfKOqk0bAqRBIjoj9g==
X-Received: by 2002:a05:600c:a44:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-4520140470fmr30901485e9.25.1749215749766;
        Fri, 06 Jun 2025 06:15:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:9c00:568:7df7:e1:293d? (p200300d82f199c0005687df700e1293d.dip0.t-ipconnect.de. [2003:d8:2f19:9c00:568:7df7:e1:293d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213709670sm23732595e9.25.2025.06.06.06.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:15:49 -0700 (PDT)
Message-ID: <4108db4a-5b3f-4a8a-beb2-9ace3bd199bf@redhat.com>
Date: Fri, 6 Jun 2025 15:15:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Peter Xu <peterx@redhat.com>
Cc: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
 <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com> <aEBhqz1UgpP8d9hG@x1.local>
 <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com> <aELnNH5LTFHmtdfQ@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aELnNH5LTFHmtdfQ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.25 15:03, Peter Xu wrote:
> On Thu, Jun 05, 2025 at 11:06:38PM +0200, David Hildenbrand wrote:
>> Not sure if relevant, but consider the following:
>>
>> an app being controlled by another process using userfaultfd.
>>
>> The app itself can "escape" uffd control of the other process by simply
>> creating a userfaultfd and unregistering VMAs.
> 
> IMHO it's okay if it's intentional by the child. E.g., even after this
> patch, the child, if intentional, can also mmap() a new VMA on top of the
> uffd tracked region to stop being trapped by the parent.  The parent might
> still get a UNMAP event if registered, but it'll not be able to track the
> new VMAs mapped.

Ah, I thought there was a way yo track/intercept all new mappings as 
well, but looks like that is at least not the case through UFFD_EVENT_* 
as it seems.

-- 
Cheers,

David / dhildenb


