Return-Path: <linux-fsdevel+bounces-56752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEBFB1B3D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0743D3B07F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E51271453;
	Tue,  5 Aug 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLqWAxpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A2238177
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398535; cv=none; b=bnTElUu43dG7ywn9lVhZc7GYAnwjIGFESj/AAwDwfs8AzG0p6C14xdYu1eY78sSBOBmQn6erXmf7cKuVsKmiWVMTcN+DXXCBHwX8NGHS7G4NnPiMLkjTz5bym2J9EIMAQFsfL3FpEW8zVHBJ1rF5wjVZmx1KmWAOty89sOyYaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398535; c=relaxed/simple;
	bh=HOB22G3loRJWaKMt8mwgyEJ+zx+KC090srXh72+31xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imkNSByOBxR2iX2+xrI4vlXklNCoe/X9DJZhCb51PjkLQdeyHfHIcnAs8F9hJCqrxR4NZ3lsyCfWj3IfvunIQfVHXrYj6Dih+ErrO9XfUHNiqBBPcoum22uJnMs7xnzEJKOyAwpkXCJElVJZINx25q5jqsaoWF2MTFo+g8U5TxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLqWAxpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754398532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mXQVWi/b7AMP+vy5HeVixIeMAJNnKqw2TByOJlo+1Us=;
	b=gLqWAxpmQqCzd/dSWzef/PnSJIzfnHjn8Y6z2TccJRWouJ89oLxRJWP1OCFx8rCwNO7KfS
	g5CE9Th47pr0UDeoqSLR3RSRQOQIgNCZ9voiFlvQKXUtUalgp3QXF8q/3+ncHIZddHIXDD
	vKSkhO8eri1w8oMnYVBNgG850IFKO20=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-f7MNPCAeMJ6W4r-AMBlu8w-1; Tue, 05 Aug 2025 08:55:31 -0400
X-MC-Unique: f7MNPCAeMJ6W4r-AMBlu8w-1
X-Mimecast-MFC-AGG-ID: f7MNPCAeMJ6W4r-AMBlu8w_1754398530
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b788d00e26so2788962f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 05:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398530; x=1755003330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXQVWi/b7AMP+vy5HeVixIeMAJNnKqw2TByOJlo+1Us=;
        b=j7ka3iCzAlD5iAti6jtIUWcdd8+5l6X92edOD8y5cDJg75nVFtxFxpJsfqjltAW78X
         vjF5iB/A4QuLKGvDL0w70CuC3L8aYf3UC1dPa7BEAYmmffOcES7SuUDKSAPZvou38b3b
         SGVS1+QPmVEzpXQwgnn1ORx6Dlxqq0VnjoZuD4g6ZlD8ByOAhagZkGHOFEKihkwMRxCf
         FwjwdYpag0/zIVJvqnPvuOuXh69ika0GGO/NkZvMg1krItCgUJg1sdtPLv8MVHFFqOhl
         ti0piEOfEnKz+nQRrQbEqV2FImaGQEvhNSTraZ2vKrNYooovn/ZdwUpUp1+TCYwx1vdR
         pstg==
X-Gm-Message-State: AOJu0YwLXBiFP6LDQrVy5mSE11V2gwrj5sBBDBWbjspuj12AOEgi/EML
	1RubfxyHgVSTHq5kv74uGIs5U/kP+YMpg/ffQXcbXmbETmPfRzFykSVaKhJeLbI0A70AHmzxxe1
	Axvfmk7D771T/rCvaPN06HAvcow+lABwNRJn7DbvMjgmdqDrnhXIl+HEmDjS7Fd/jmyo=
X-Gm-Gg: ASbGncs0W7+Pw0p9GP3bNkHaKrx8PANSZ9kLQWWaQ7MW1wnJxFBCz5mgGLfcndjl1Uk
	J4Al64rC5OMsZhqJsS2KHBc6eTWVXLeR7QCnbmeZ73BPeyaH3zNbocemBdmJ3T4Pm4lN55hlTrM
	9UPwky2FOnL6G2OMlHATGzkqibKO+XdetYBSPJp5JRlHThLr1xIWZXFPK7jxBhM/0eETd2vklEi
	XiaTJV3xPLmHbO419TA8wsMg1Sv3ivNIkMVEzZisgYl28YofbTdsSqGR8W29WWsqwZHVRzlTJcP
	7Zul5hoUBjcPlqCI4lVz1zDMV268tsRIeHrMwzctQEUx+Irsl/4gqnjfjHCcHLfo/jsctts=
X-Received: by 2002:a05:6000:2287:b0:3b8:d2d1:5c11 with SMTP id ffacd0b85a97d-3b8d94d3549mr10242836f8f.51.1754398530410;
        Tue, 05 Aug 2025 05:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoW0VEHeHdM6KbOLWiBmAjo9TG0Lqe1CZviyoNOwGriAOTp++1O5KXtJScToSn/9LRd7ABaA==
X-Received: by 2002:a05:6000:2287:b0:3b8:d2d1:5c11 with SMTP id ffacd0b85a97d-3b8d94d3549mr10242807f8f.51.1754398529950;
        Tue, 05 Aug 2025 05:55:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm19065920f8f.47.2025.08.05.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:55:29 -0700 (PDT)
Message-ID: <e608f766-8750-4781-bd23-8fa95b6d683a@redhat.com>
Date: Tue, 5 Aug 2025 14:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
 <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 14:46, Usama Arif wrote:
> 
> 
> On 05/08/2025 13:39, David Hildenbrand wrote:
>>> +FIXTURE_SETUP(prctl_thp_disable_completely)
>>> +{
>>> +    if (!thp_available())
>>> +        SKIP(return, "Transparent Hugepages not available\n");
>>> +
>>> +    self->pmdsize = read_pmd_pagesize();
>>> +    if (!self->pmdsize)
>>> +        SKIP(return, "Unable to read PMD size\n");
>>> +
>>> +    thp_save_settings();
>>> +    thp_read_settings(&self->settings);
>>> +    self->settings.thp_enabled = variant->thp_policy;
>>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
>>
>> Oh, one more thing: should we set all other sizes also to THP_INHERIT or (for simplicity) THP_NEVER?
>>
> 
> hmm do we need to? I am hoping that we should always get the PMD size THP no matter what the policy
> for others is in the scenario we have?

Assuming 64K is set to "always", couldn't it mislead us in the 
"madvise"/"never" test cases in some scenarios?

-- 
Cheers,

David / dhildenb


