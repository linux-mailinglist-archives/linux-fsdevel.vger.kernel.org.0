Return-Path: <linux-fsdevel+bounces-36582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DC9E6239
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807BF1695CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0311DDF5;
	Fri,  6 Dec 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdOoa8zC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606C2BCFF;
	Fri,  6 Dec 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445061; cv=none; b=qbDPy6W2EhZ2vgH+MKefvbspH4lkmBudw9cFESsgTzOmoJj8i3JEorwSqU/bAMRfIhjpmM1fl6NiX5FBfh1nRKiZLVEIo3uoNgJh88lagX2GK8Q13/zJFECthubY9kDYurkvGn2/IT+qHefLEmcH70m7yaF62r1JJZ3a34ftwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445061; c=relaxed/simple;
	bh=T5XsiHaeA6gX7H3TG0AwK/Z1GuvCOEYpveaCBKvj2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOy31GmLy3HHSL1EAj6jjzjrLfmbW2e+am3Bh1hxh1Qpwfly8asVIQQj3YRCiTjjhoRifnCiooP1+elf2eYOrCfwEYTC/y7ziqe3Vxv/sE1IqUF8TfmWaC0fytnFPahDzmcaTwJY5ucfqKK7akrv+h6fsYpk9IeuScHT7JSIx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdOoa8zC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa549f2fa32so292117866b.0;
        Thu, 05 Dec 2024 16:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733445058; x=1734049858; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuJ7vWjq9N4bf180yHzi7XHCXBBIt3hkByBmhQQJFDA=;
        b=LdOoa8zCdgGwG0vyIsjaUvxeGi+ZMoIH2ZFUCx7CEMu53mMfV5tIXiWYXYZqDdDyj+
         iPpc0WLh2TRf8tRDib92PlfuoPD6xqfQeIFAJwlXqd03XWglsMBkX6tGhgHUg4o1Im8m
         HsdtS485U52WkTQAOXW08O6tVTkRGWKentlg1mqhgBDfsCv43fMd0n8O6vuGzr6Y9tEO
         5mCMZw+5lQyT09nHEDpMyISeHno72yc/MMYeoSCiJr9zps2I4H4/mc7qnLA+BTZ8OEZT
         ZDMomtTH5F6uQgA/4uokpA+mjaTEi7tFem4ZblhctmcPVdmMztevQY+a5Wh7CwvzBbDy
         qhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445058; x=1734049858;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuJ7vWjq9N4bf180yHzi7XHCXBBIt3hkByBmhQQJFDA=;
        b=QsUeC7wtrwozZTJV0nn02uQWpLasYFVbgeC8qXgsL44pYnDJwnNQaZ5QVByVvXVxN9
         NVqt8yasx/yHnpcGkqWtHaoSey/tw8rncjHP4dp7o2PQ/qzqD93FRVDIn22eFEbFiKJL
         pTlDGytDVfJyzQpGVFMcwBw3PzIRbJbuojGqH8ur7xIotaJA0q4e46HntaCS1Cdq5RQj
         AEIznMAe8lUrChIg8/wKoZ/IQ/QsJ/fWqQgk8o2Cf6UKPwcScZ7lKciQThyuhIIGY8Gs
         iuvadlCJM3QjSywPMk0jCmPLzuJ/uKfs6QpnTw01ehjOQlRySELZGq077YTpZJC5Ti6M
         mAXw==
X-Forwarded-Encrypted: i=1; AJvYcCVYNUbw5fxBvou199nefXmhZpKHsj0/Q4UorJ0pU55eB8zjhsLSB4gjriKCq9HQbJKg8uNwQTf3xfBAqst1@vger.kernel.org, AJvYcCVmBafAIwIg9QGZwU/zPuygLRHOmduumiNO+P2IZAKPVFMFBek0qo2kTYEY+aGZuEhanmXi7z6U3QKiUR2w@vger.kernel.org
X-Gm-Message-State: AOJu0YyUsrxQr/0yBGi14OTC9kabpK/nFd55x4rDVivsU+GEYivw476m
	cIgLsjydX2drJZKP0EyBV+ZgJ1lXlC74ZkFd4S/OLZhi7K8k3RZU
X-Gm-Gg: ASbGncvkIAEDmdwcSiCbVw102kDXeEK8XyFTQo9BfoNMnUC4t6/+PtCvfpBB2X8cRk5
	aUXbVnkQN8zTVMeyL3FNS35Gvktn3Vvv4Ck+lXE31YzVgfLtmu03DjvBzSn3bBKyxKAvPUxU7wk
	TZoC2+9vwZt5tfwNJzE0ikhSpH02W9TUWniveWIawgjOsC39+lwZr8RveA2A+LhuZqz48F0heDc
	pZuYh86s6twRYzg65KTjp5CyR3DM3QPB6Ja65bj6aIbppadbH+c/Q==
X-Google-Smtp-Source: AGHT+IGdYCzXiyn+212FHw2lMBug+v2LYRIEy3va52yhzA+1vwvzueHuUr0mlkyKkF4A+lap/DWwIw==
X-Received: by 2002:a17:906:3155:b0:a99:6791:5449 with SMTP id a640c23a62f3a-aa63a264d25mr68373866b.52.1733445057370;
        Thu, 05 Dec 2024 16:30:57 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5f3sm160564766b.120.2024.12.05.16.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2024 16:30:56 -0800 (PST)
Date: Fri, 6 Dec 2024 00:30:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vma: make more mmap logic userland testable
Message-ID: <20241206003054.cj767w67kydv3rms@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241204235632.e44hokoy7izmrdtx@master>
 <68dd91e4-b9c3-413c-b284-f43636e7ffba@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dd91e4-b9c3-413c-b284-f43636e7ffba@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Dec 05, 2024 at 07:03:08AM +0000, Lorenzo Stoakes wrote:
>On Wed, Dec 04, 2024 at 11:56:32PM +0000, Wei Yang wrote:
>> On Tue, Dec 03, 2024 at 06:05:07PM +0000, Lorenzo Stoakes wrote:
>> >This series carries on the work the work started in previous series and
>>                         ^^^      ^^^
>>
>> Duplicated?
>
>Thanks yes, but trivial enough that I'm not sure it's worth a
>correction. Will fix if need to respin.
>
>>
>> >continued in commit 52956b0d7fb9 ("mm: isolate mmap internal logic to
>> >mm/vma.c"), moving the remainder of memory mapping implementation details
>> >logic into mm/vma.c allowing the bulk of the mapping logic to be unit
>> >tested.
>> >
>> >It is highly useful to do so, as this means we can both fundamentally test
>> >this core logic, and introduce regression tests to ensure any issues
>> >previously resolved do not recur.
>> >
>> >Vitally, this includes the do_brk_flags() function, meaning we have both
>> >core means of userland mapping memory now testable.
>> >
>> >Performance testing was performed after this change given the brk() system
>> >call's sensitivity to change, and no performance regression was observed.
>>
>> May I ask what performance test is done?
>
>mmtests brk1, brk2 (will-it-scale)

The one from here ?

https://github.com/gormanm/mmtests

>
>You'd not really expect an impact based on relocation of this code, but
>with brk it's always worth checking...
>

Yes, I am trying to know usually what perform test we would use.

>>
>>
>> --
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me

