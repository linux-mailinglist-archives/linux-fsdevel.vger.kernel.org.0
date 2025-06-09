Return-Path: <linux-fsdevel+bounces-50995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE95AD19D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747711887244
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666191E5701;
	Mon,  9 Jun 2025 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg+36JnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68581881E;
	Mon,  9 Jun 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457973; cv=none; b=pONmohWy0Au2VbVVC3FciwXEtbNFWwAgPJSV3KekxLgk443JwjZK+iHR6T1sQO6wCMMYmxnax8dM50VPKA5gzSmhyiabqCs/dmueSuyMArpByPpN38JrQhrvtf6TEHyS13Mt7oDfcnvlCnR5dzsNWc6ynOln3nBrwS7Rl6YDsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457973; c=relaxed/simple;
	bh=P9S9F1SGnmKUUFQ0IRiNJpckQiZOkArH66z7nM/LnRk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Umcqq7MSEGvQke9hTbful884/xJmlYbdx2CL/9ilMDHZq26bU73D+YuWeUM1lcQ3DzoUMcGwZn614wrxy5YWgzOY48MzttAo2EHOYyhcYYpMQpPwO4MIui2ux8+RZ812NE7t5Y/Aen0wFP+5GZ16XQYnwB2vTtOPYIZnHSNY/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg+36JnZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2f11866376so2569304a12.3;
        Mon, 09 Jun 2025 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749457970; x=1750062770; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJhRuEPgl8IUTnHZOTdmxme0PwZqVTJX6cZfIyFLqhk=;
        b=jg+36JnZyzD8WOIFIjp7PO9JOUQDynhT2VLeMJ1+QeG9VtWLIBQ9loO6WT8NIN0iKf
         tFnDDxRNVCDMwaADXt6Ae4Vt6tK9FMYjn5k0nXA8QJ10Efcw3/HJN8Gi/DYtK6i04aE8
         laQTU1kUifQEWaGziVxikNqrah+ZFRZKXPDkOTSQ8use+xs4crbw3Yy0qsuhYNVwsTAx
         t2Z9g6dFAatbDhitw1xqnY9Uq7z+bkhQZkXsW8A6ucrxLAZZa77GpO4lUSaQiVQ2+n5C
         //OaM9yufiyr5t51qnlAmshzjD7I5GCKRjk/m+HwXpT3LIOXArHZsgYl0spsRphMVSGd
         umQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749457970; x=1750062770;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJhRuEPgl8IUTnHZOTdmxme0PwZqVTJX6cZfIyFLqhk=;
        b=srTipp4RcrJSimhNMDjKGW2kPj01iY5Ds8nv0Cabab5GW8YG3mCmrwwVyH4yPsQLeb
         a2LG3ZiFLJrKIVyBBgeCgdnSYkfWaKCYGnbsIHGR0HHoXMyRa9YmUnarI2Odfo+RZMkN
         Rxac2A1sIh4SX777CK60iouZckQ7sMcNSq3mibwPqlIfyDjlOoJ0BdqL6KX5DeTERW9v
         1yrz/v/69rRwCvu8gFNR8R10wjuSZj8CKd5csdtddyHrgnJyO0l7vleNxbDFBlbirCdn
         w0W0hDFihz84+crEL+Jk3YrX8Snz5O5GfN1HrvUpr0kUFgBXt2mNGiMCydpl1ycCRVkM
         qlXw==
X-Forwarded-Encrypted: i=1; AJvYcCU34XiJwtts0mDy4xJAsZFzwAdZNReiXH++WzY3P5tF8JBM1HTZwZGXX/dRUNPXEwv7e2DuMuMqTMHheY5h@vger.kernel.org, AJvYcCUWx/Utq5KtZr44jUuSOvufBj0JDdwandwxAnh1qlWy1k8IsgsN8um/S9V/ab+Z6neKIb/Mky2uxQx2fsdt@vger.kernel.org
X-Gm-Message-State: AOJu0YwuO3EMSNkhWD7eC5/7yOUoCGffcg8tLVNmRni3CopAA+PC7JsL
	ba2hyRcy+NJuKPUs73uDM9F1xwrjjBHlgQ4JIOYHpH4VWtfqs25NgjnkjnjsOw==
X-Gm-Gg: ASbGncuDmlQNJCEMoX8Jp1VI6K1i3+1kNdmOtpMM9wEI+TfpJuYsC219w66KqFrHuGK
	dTXmRbnCdzn491qw5LK27u0lrOliv0IXkjyZ5DiXyAKuwrmnFWMCDFxFEY1cb0tGGIqnsZ9JVo6
	++7w+uGmR7dn5Tp662FhvZBM1J6i9c8XToPzS3dH4/a+7ir7hVsfrc2L5XnAeNKErx0GVYvy56o
	/duFvP2OxEpLNhQ72MMQ4Q3z3XvGpmYH3FP8UxLhKfo17PL28LygI4GzubmfVMkbA4kKPKXQQlj
	8TOSYbgP2XweIUQcVF8NYTvRsqInIUIGMIWUw4fDR60=
X-Google-Smtp-Source: AGHT+IH/jLthttFZGwChlmYVWIdc0ZdbjjsyQOWl1xOhRZ8sMoj8FC6nMVI4aXzgdM/DNifxv+HT0Q==
X-Received: by 2002:a17:90b:390e:b0:312:ec:412f with SMTP id 98e67ed59e1d1-31346b3fc52mr21701565a91.14.1749457970144;
        Mon, 09 Jun 2025 01:32:50 -0700 (PDT)
Received: from dw-tp ([171.76.83.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f17be8sm5273606a91.3.2025.06.09.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:32:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, david@redhat.com, shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for users
In-Reply-To: <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
Date: Mon, 09 Jun 2025 14:01:59 +0530
Message-ID: <87a56h48ow.fsf@gmail.com>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com> <87bjqx4h82.fsf@gmail.com> <aEaOzpQElnG2I3Tz@tiehlicka> <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2025/6/9 15:35, Michal Hocko wrote:
>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> On some large machines with a high number of CPUs running a 64K pagesize
>>>> kernel, we found that the 'RES' field is always 0 displayed by the top
>>>> command for some processes, which will cause a lot of confusion for users.
>>>>
>>>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>>>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>>>
>>>> The main reason is that the batch size of the percpu counter is quite large
>>>> on these machines, caching a significant percpu value, since converting mm's
>>>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>>>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>>>> but on some paths, performance may take precedence over statistical accuracy.
>>>> Therefore, introducing a new interface to add the percpu statistical count
>>>> and display it to users, which can remove the confusion. In addition, this
>>>> change is not expected to be on a performance-critical path, so the modification
>>>> should be acceptable.
>>>>
>>>> In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
>>>> dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
>>>> In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
>>>> contention. This patch changes task_mem() and task_statm() to get the accurate
>>>> mm counters under the 'fbc->lock', but this should not exacerbate kernel
>>>> 'mm->rss_stat' lock contention due to the percpu batch caching of the mm
>>>> counters. The following test also confirm the theoretical analysis.
>>>>
>>>> I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
>>>> machine, while simultaneously running a script that starts 32 threads to
>>>> busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
>>>> following data, I did not observe any obvious impact of this patch on the
>>>> stress-ng tests.
>>>>
>>>> w/o patch:
>>>> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
>>>> stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
>>>> stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
>>>> stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec
>>>>
>>>> w/patch:
>>>> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
>>>> stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
>>>> stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
>>>> stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec
>>>>
>>>> Tested-by Donet Tom <donettom@linux.ibm.com>
>>>> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> Acked-by: SeongJae Park <sj@kernel.org>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> Changes from v1:
>>>>   - Update the commit message to add some measurements.
>>>>   - Add acked tag from Michal. Thanks.
>>>>   - Drop the Fixes tag.
>>>
>>> Any reason why we dropped the Fixes tag? I see there were a series of
>>> discussion on v1 and it got concluded that the fix was correct, then why
>>> drop the fixes tag?
>> 
>> This seems more like an improvement than a bug fix.
>
> Yes. I don't have a strong opinion on this, but we (Alibaba) will 
> backport it manually,
>
> because some of user-space monitoring tools depend 
> on these statistics.

That sounds like a regression then, isn't it?

-ritesh

