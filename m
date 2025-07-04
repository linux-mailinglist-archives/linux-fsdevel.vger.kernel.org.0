Return-Path: <linux-fsdevel+bounces-53976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B347AF9A7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4409F1CC17EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBB2DEA62;
	Fri,  4 Jul 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPZ9YQdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8182288EE
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653352; cv=none; b=big8H0br97GZn5qkapS70z19D9sp9MYLqR1he4oLM8E/lzGiKHRErIxH7GsdMEjDHPG/CKQRuy/nDF6YjebtA+A1FiYLqzAv13l8s8mP2/zK2DkGVEP2PV3phfiC4eiwFW2fIPuHJEvJ+hMfh3xhkK3azx0twZQDMzZAYWxFqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653352; c=relaxed/simple;
	bh=y7Hbl1pAqGjQzF/82eshc8yF2u6xa68k61bwAB5tTzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhZzI6EEVgI2dbbXu/uCKptaZ4o3KRrnwRYPF9q+e5YrN88wnhW9g/P9M//39Ezzg8iVKP+48U60lH32rTBCxZ1M2kRY96iSDgvdwTVnXUYcG/j4+Wx/Z1HQQMCI1r1hyXYc9DTPmSvkR2yAKwf/nI2MelB3rn8204xJAyVv0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPZ9YQdJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao5yV0OWlWrLaBBV5SLduZ6Vw0gfsxB0sugrEeYXGWQ=;
	b=JPZ9YQdJqLIRS7c7QW497UVPE5oGN8Ly4yq8GsSbCNajIOJQXhFoj0SHUqN4tauaP1rM29
	Nv8+tKbFtTmbWPQdoI0lq7YOC8OTjpUfwBLEbAmoYje7Ggw3oix4fiZLYu/g4xnak2isca
	xbJ9pGIoGXyvs05IBuhG2PNomtFRB5E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-gGuL6XmvOFmJxh2ozpr_RQ-1; Fri, 04 Jul 2025 14:22:28 -0400
X-MC-Unique: gGuL6XmvOFmJxh2ozpr_RQ-1
X-Mimecast-MFC-AGG-ID: gGuL6XmvOFmJxh2ozpr_RQ_1751653348
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd75e60875so22059466d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 11:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653348; x=1752258148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao5yV0OWlWrLaBBV5SLduZ6Vw0gfsxB0sugrEeYXGWQ=;
        b=NomWbEusJHwxOANFVTBXqFJiNUiVtHpe5lPlY1D4pt1Z4H41k2oaQV4G2LhsLNc83O
         l9biLam9ou4xzhN6IQ5YBWyIuMzR1qovhI+QuMd9EmmgpczmG5PztrxpbIHnl2Qa+ytr
         zqyqIMJsrRjo+pVB0RBtnT+Tlj2lmViJKMdibki65OX7IC89uhdqt0SfZVhe3mICxPS3
         xkY9v5SX4Ur+aA+iMbrhp9LZ+HusskBsHU8sfl+iP2VdYIQ+/Iq3aIwI27zpBYHC09nq
         hUILasRhYA5OlPPvQwzi/nbW9W+0ST4rGstpEMMYFn3vWcJY/VmAQGxkHIDlEpZiOHkS
         zDSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Mvgq5BCh+LuZElT94ub8YPosuRlXWSFIYN8k+xD84FwcAn1QkU/Nzvs/ta/SuxWTG6OhIk3xu9Qx1xXZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/i6jCsnlynsn1sLQ+IxfsRAjyKzl741o2v3h7fsMiOI7J9m68
	SXgG/ELYz9IdawYzuUQtu61p5I1tgsu2Upp/YfZU+q6P/kPB81FSR9nKOR1K5po2Ji4KSEbV6E0
	/X3TJb7rVFM6H2LZmKmZZnSJj3bfxYekK0W1d1Ta1ilTFuFkHQCDm4ikZXCMYLNKTtOI=
X-Gm-Gg: ASbGncuQSrKuiMd9exfSpMLA9yQ4abfmLERgaLPFqCuPZMJf+olg4eY+MmnHD03iMJ5
	KYjBIrzheGR5WDJ7TlSOBSY85GdNVSSvPheZA0DlfR650y/gt+0zD8NSzUuhUE21yjMNmXfn/6V
	XHV1SdJ65dmXH5xC5fdXA4h6p10nV+TSm9/42iiQ7IcbvIEEN9EhmSGiN6u/CIT0A68VQRxE7lD
	k4iWlcatyA8u5w35X6Zs1EBpBw1vPfoYrCCVEaOgjbVnwKJpsYjck1jcNRbI1JrwHCMkhwM9RVV
	SGPtqPVE4Org53GBO70/wInK
X-Received: by 2002:a05:6214:e4b:b0:702:c15f:3291 with SMTP id 6a1803df08f44-702c6d7a145mr47721606d6.22.1751653348117;
        Fri, 04 Jul 2025 11:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOOAnVJ2nhxq4q+rgZ9MWxRastPRZ+F+UsTkduj/PWXspmSODVR5v/cT1qpEPk5qddOrytUA==
X-Received: by 2002:a05:6214:e4b:b0:702:c15f:3291 with SMTP id 6a1803df08f44-702c6d7a145mr47717576d6.22.1751653342959;
        Fri, 04 Jul 2025 11:22:22 -0700 (PDT)
Received: from [192.168.2.110] ([69.156.206.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cd2c1esm16472856d6.50.2025.07.04.11.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 11:22:22 -0700 (PDT)
Message-ID: <34be0c05-a805-4173-b8bd-8245b5eb0df8@redhat.com>
Date: Fri, 4 Jul 2025 14:22:11 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
To: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Michal Hocko <mhocko@suse.com>, david@redhat.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com> <aEaOzpQElnG2I3Tz@tiehlicka>
 <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
 <87a56h48ow.fsf@gmail.com> <4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
 <06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
 <20250609171758.afc946b81451e1ad5a8ce027@linux-foundation.org>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250609171758.afc946b81451e1ad5a8ce027@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-09 20:17, Andrew Morton wrote:
> On Mon, 9 Jun 2025 10:56:46 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 6/9/25 10:52 AM, Vlastimil Babka wrote:
>>> On 6/9/25 10:31 AM, Ritesh Harjani (IBM) wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> On 2025/6/9 15:35, Michal Hocko wrote:
>>>>>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
>>>>>>>
>>>>>>> Any reason why we dropped the Fixes tag? I see there were a series of
>>>>>>> discussion on v1 and it got concluded that the fix was correct, then why
>>>>>>> drop the fixes tag?
>>>>>>
>>>>>> This seems more like an improvement than a bug fix.
>>>>>
>>>>> Yes. I don't have a strong opinion on this, but we (Alibaba) will
>>>>> backport it manually,
>>>>>
>>>>> because some of user-space monitoring tools depend
>>>>> on these statistics.
>>>>
>>>> That sounds like a regression then, isn't it?
>>>
>>> Hm if counters were accurate before f1a7941243c1 and not afterwards, and
>>> this is making them accurate again, and some userspace depends on it,
>>> then Fixes: and stable is probably warranted then. If this was just a
>>> perf improvement, then not. But AFAIU f1a7941243c1 was the perf
>>> improvement...
>>
>> Dang, should have re-read the commit log of f1a7941243c1 first. It seems
>> like the error margin due to batching existed also before f1a7941243c1.
>>
>> " This patch converts the rss_stats into percpu_counter to convert the
>> error  margin from (nr_threads * 64) to approximately (nr_cpus ^ 2)."
>>
>> so if on some systems this means worse margin than before, the above
>> "if" chain of thought might still hold.
> 
> f1a7941243c1 seems like a good enough place to tell -stable
> maintainers where to insert the patch (why does this sound rude).
> 
> The patch is simple enough.  I'll add fixes:f1a7941243c1 and cc:stable
> and, as the problem has been there for years, I'll leave the patch in
> mm-unstable so it will eventually get into LTS, in a well tested state.

Andrew, are you considering submitting this patch for 6.16? I think
we should, it does look like a regression for larger systems built
with 64k base page size.

On comparing a very simple app which just allocates & touches some
memory against v6.1 (which doesn't have f1a7941243c1) and latest
Linus tree (4c06e63b9203) I can see that on latest Linus tree the
values for VmRSS, RssAnon and RssFile from /proc/self/status are
all zeroes while they do report values on v6.1 and a Linus tree
with this patch.

My test setup is a arm64 VM with 80 CPUs running a kernel with 64k
pagesize. The kernel only reports the RSS values starting at 10MB
(which makes sense since the Per-CPU counters will cache up to two
times the number of CPUs and the kernel accounts pages). The situation
will be worse on larger systems, of course.


