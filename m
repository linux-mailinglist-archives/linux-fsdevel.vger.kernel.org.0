Return-Path: <linux-fsdevel+bounces-33913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44249C09A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76A21C23756
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF521315B;
	Thu,  7 Nov 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMk3WUax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F049212D31
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992037; cv=none; b=I+h4GSQ0wLNV6nYbYPyyMttAf0wROJqZu/QYB/ge1eGn8An8Fg7XtJq75peRyJWJ6gx9/rLSJcrEx5kdchFWc0FI39Y8pHtJ4kHBGYEuM/Brv0RV08HqVw/HwZFVEkxDwoU5/H1HqwVJY+VfnHYMelxzKzysf8ihqLXS7/Ku8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992037; c=relaxed/simple;
	bh=mMgQMIAdR1U6/trMnkruUieVLKWT+EzgS20G8XFGvaQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MVzWNqYHnOaUsK1udFew0GHeGWd2pYnoLPwo6384/t5V/Zmy03BfbMzusts3SunPEKXpn62PQ/jY5kIVHgKlgtPiq2XVSyyQk6MR5TUbXtnccoHl/Rj6XgtXrNqm/1liuRm70ns/fYOJhPTwiM0Kwp9XLuAY8MJb+Dvq6EHwar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMk3WUax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730992033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=rUULYW5HA71CcadhjfBnhDAiPuL8EUk2+KSGHV8WYRg=;
	b=LMk3WUaxfMLvz/2ibG/Agfk7PdFt8Uutm6O5q9pgDGoC6DpLgssnhGNzYI8mRnZNPTeoNN
	OuB2eYRdnSvDsMSZmUqIbeL67IAPFb36ROpaAlgi3jdA6lY4ut7HKW09Db0MMgiYRw8nCy
	IQmfUlEJr5SLsOduJYIOzH8FdsY32TI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-m4X_UOE8PQiwRNBAzLtmgg-1; Thu, 07 Nov 2024 10:07:12 -0500
X-MC-Unique: m4X_UOE8PQiwRNBAzLtmgg-1
X-Mimecast-MFC-AGG-ID: m4X_UOE8PQiwRNBAzLtmgg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43164f21063so6765255e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 07:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992031; x=1731596831;
        h=content-transfer-encoding:cc:to:organization:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUULYW5HA71CcadhjfBnhDAiPuL8EUk2+KSGHV8WYRg=;
        b=R30eRxxLznl4u5YMvbFErV90Frx+/ywTKI3jQMVmUF63tNg9jGgx2pFyAMzs5WfCjE
         Dpzz+3ItH02do1PMip1MNawHnfvW1i2HyToRVa9w5jBTg4VzgeM9/62r3J8Jts+IgM5X
         LiwVWPMEwx+vhdyL6AksV/qat1hyZ0tdGWcgLKO3IURRMQhB1vkpuLvwFNHaRBppbTdT
         ebNQTnWgwlDUCQAeH3WlX6b2Blm4orRZCUCRbXTRiQEfcSYaH0mbFycRs1y7u+ei27kA
         S3pild6+xS3ugrhtSeNWi/RC+kIlweQlTIeLq3XQAuOw4corKxALvGTdRjSQsX9AHkRN
         Gveg==
X-Gm-Message-State: AOJu0Yxdg6YP6I8PAKk+6lvU1mWNXVmGA1zz3FVPfsBy220w2mua7r2l
	t3VMhy/6sBvXzbqfKaJ2LgE/WjK+XaD4QyHE89qpnZ3NWcYczNrR2fg8MtDc/p3hHQdeh1vEFc+
	pOcZbZaK2ENiSyYv1CJNR26siq0yobtIFR966+H6/Dlx6w29wGVBlMXweACb1DT6SMc3TvtLzq0
	GUPEoGaqZ2+ZTNz3A3ul/+9y4vzBRW3mo9IwEMzs2lr7cN1A==
X-Received: by 2002:a05:600c:1e04:b0:431:59b2:f0d1 with SMTP id 5b1f17b1804b1-432b5f93d40mr3188535e9.4.1730992030916;
        Thu, 07 Nov 2024 07:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQqcExJcKyVOnKxX3c1cjDHIL/l3Y7gyY3Yl4uEcZqFA46iJzi71uSxtUbXoHCkBs4VoKj4w==
X-Received: by 2002:a05:600c:1e04:b0:431:59b2:f0d1 with SMTP id 5b1f17b1804b1-432b5f93d40mr3187785e9.4.1730992030226;
        Thu, 07 Nov 2024 07:07:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9? (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de. [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c0d33sm27963635e9.27.2024.11.07.07.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 07:07:09 -0800 (PST)
Message-ID: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>
Date: Thu, 7 Nov 2024 16:07:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Subject: [ISSUE] split_folio() and dirty IOMAP folios
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
To: linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 kvm@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm debugging an interesting problem: split_folio() will fail on dirty 
folios on XFS, and I am not sure who will trigger the writeback in a 
timely manner so code relying on the split to work at some point (in 
sane setups where page pinning is not applicable) can make progress.

https://issues.redhat.com/browse/RHEL-58218


s390x PV ("Protected Virtualization" / "Secure virtualization") does not 
support large folios. So when we want to convert an individual 4k page 
to "secure" and we hit a large folio, we have to split it.

In gmap_make_secure(), we call split_folio() if we hit a large folio, 
and essentially retry forever (after dropping the folio reference).


Starting a "protected VM" (similar to encrypted VMs) will not make 
progress when trying to load the initial encrypted VM state into memory 
("unpack").


I assume other split_folio() users might similarly be affected: 
split_folio() will frequently just fail without any obvious way to "fix 
that up" to make progress.


Looking into the details, it seems to be an IOMAP limitation: 
split_folio() will keep failing in filemap_release_folio() because 
iomap_release_folio() fails on dirty folios. I would have expected 
background writeback to "fix that", but it's either not happening or 
because it's just happening too slowly.

I can see that migration code manually triggers writeback, using 
folio_clear_dirty_for_io() and mapping->a_ops->writepages) when it 
stumbles over a dirty folio.

Should we do the same in split_folio() directly? Or offer callers 
(gmap_make_secure()) a way to trigger this conditionally, similarly to 
how we have ways for waiting for a folio that is under writeback to finish?

... or is there a feasible way forward to make iomap_release_folio() not 
bail out on dirty folios?

The comment there says:

"If the folio is dirty, we refuse to release our metadata because it may 
be partially dirty.  Once we track per-block dirty state, we can release 
the metadata if every block is dirty."

-- 
Cheers,

David / dhildenb


