Return-Path: <linux-fsdevel+bounces-22663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F791AED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0351F2282C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24C19AA69;
	Thu, 27 Jun 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjE087sO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362C14C5AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512088; cv=none; b=FLMLEp0McpJG09wX46hGp5WRMpLYbeIUngAkoVnAVX1odEEtnBGqLHyx62iP6YWL5Wb2ASI4D7At1WJMp9deVX0fA2LbCd+7k6g8VMFtN4PsEpBciXhSHznLIJEO2PC72sbKKzgfjygMRmSZfNx7ntzIMceP1ja1e3XmgGNeQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512088; c=relaxed/simple;
	bh=2cK5AxOV9l+UMy4wzDeUFqdeQNcGCtOHicEYrQngggg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgoR83cthGGTuH8qH9mP/Dx++LdLW1zbtcH0e/3E7TpuUrqqCdR1OiUpl0TwD6pNKr/J1kyyOHu2Mf3i71wu+16OUg7P2AK3WcIFirAEONKsUSAIVDWTvrPpl864c+hXVLJ1gnFsAJLOEtMXBwuyy9+1sh2VHwVqUlePmSbjpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjE087sO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f3d395dcf9so6276239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719512085; x=1720116885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=HjE087sOGZTN0DJOfWF5kD74/RlY+ZWkCZTQdzqHwACHVT+XeJ3v/wzclu6TgfWMJR
         ckOJTOO7FmDiilRiO5qzrn3K2fdxlDXL5IEto+jQiZxO0UT0ZMXpqjTF9QuRiplIsdRy
         5S9NaPOquoVvKRUQs+LbXGcA4uc6fv6j+JwpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512085; x=1720116885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=tiWBGutxtDfJbZrGNWFIlkETRZlecDJxWb8IylmrS7BfW3s9m9l38I5dY9Ebupkr0V
         Dw2HaYN7pMqfu3C/F8aRNPqr652VNg6Tbz01+gcJ/M7ObRRN39d9j2+1Xk87MRjqEpDE
         n1wttb1cORNaItHhLOKXtF2/EansiPON6x8FieoKWxNzoz6dblygCW5NYHBAXk3vcHzz
         1PdSzQkNUzGa7w5cok01SqIgQ6npEaqvLPhUhdchbyVTovQAJgdaNCTBXKx1P9alX5mj
         Yo5z6IQ5Y+1HZ7UhEb/Ij1sYFb7qpQ2huXCFDGhJo/fXaSdeNgXjG1X7CJeeZGphHODB
         hqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWRbs2kLJsjg6eIwx18ayKLI/jipz3Ho1qcuMbBFg+5GgTwI2lpdWMHwdwfKIrjNgZac2blE54DR9vTj8lcYJNs4ZTEdxCS126SNiQIdA==
X-Gm-Message-State: AOJu0YzDDBl/JerDmH/C/BzHWimlU7fDS1LSdocu3d07ciYdCjNndYHj
	BBaWQ1TShUEA0QShVDDKHxtQ65/UBx0dFNr310OkQx5JXRq+0GgrP32RIP9CYVk=
X-Google-Smtp-Source: AGHT+IFUG5O1SrOnPJRNTLD5kODnctBl78frxmuDBYLRyoOk4cGdplKcVn3bQ6BYVahLxGENnJxatg==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1350449739f.0.1719512085576;
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9d654sm2994739f.13.2024.06.27.11.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Message-ID: <af55d4ae-fefb-4235-a175-83e947ec4c25@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:14:43 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] selftests: Centralize -D_GNU_SOURCE= to CFLAGS in
 lib.mk
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com,
 seanjc@google.com, kernel-team@android.com, linux-mm@kvack.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625223454.1586259-1-edliaw@google.com>
 <20240625223454.1586259-2-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625223454.1586259-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 16:34, Edward Liaw wrote:
> Centralize the _GNU_SOURCE definition to CFLAGS in lib.mk.  Remove
> redundant defines from Makefiles that import lib.mk.  Convert any usage
> of "#define _GNU_SOURCE 1" to "#define _GNU_SOURCE".
> 
> This uses the form "-D_GNU_SOURCE=", which is equivalent to
> "#define _GNU_SOURCE".
> 
> Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
> "#define _GNU_SOURCE 1", which is less commonly seen in source code and
> would require many changes in selftests to avoid redefinition warnings.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/exec/Makefile             | 1 -
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   tools/testing/selftests/intel_pstate/Makefile     | 2 +-
>   tools/testing/selftests/iommu/Makefile            | 2 --
>   tools/testing/selftests/kvm/Makefile              | 2 +-
>   tools/testing/selftests/lib.mk                    | 3 +++
>   tools/testing/selftests/mm/thuge-gen.c            | 2 +-
>   tools/testing/selftests/net/Makefile              | 2 +-
>   tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>   tools/testing/selftests/proc/Makefile             | 1 -
>   tools/testing/selftests/resctrl/Makefile          | 2 +-
>   tools/testing/selftests/ring-buffer/Makefile      | 1 -
>   tools/testing/selftests/riscv/mm/Makefile         | 2 +-
>   tools/testing/selftests/sgx/Makefile              | 2 +-
>   tools/testing/selftests/tmpfs/Makefile            | 1 -
>   15 files changed, 12 insertions(+), 15 deletions(-)
> 

Andrew,

I am seeing merge conflicts with mm and exec tests. Might be
better to have you take this through your tree?

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


