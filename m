Return-Path: <linux-fsdevel+bounces-57875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A917DB264B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B619E3BB428
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37672FB966;
	Thu, 14 Aug 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOpuGU1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F242FABFD;
	Thu, 14 Aug 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172297; cv=none; b=WF34y1QM7bdkLHNUThlNhLzevbwmKYj0uV4RS7eJZhcp0Tq7ihA3ZkdVv7A1F/DnSbs9oWTp/XdDI0WWASI6Lh9zme6bsBS2Mv3VxFi1FUw033ox6aIVQZZ/BI4fKc3YKVXk0OFtAFFo9+R4FCT4jkqhHZW/8xzLKgsQK/3PNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172297; c=relaxed/simple;
	bh=4tk9bwz8coDizZfq6CK2c5VjBma58QVXrU05Sen13vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGcYBPzaFqo1TpzYpcD9BRbxLrMl0+rJuXOCNDDqNkVGDRBFzQicDF/bDt74quqS6RuzLAXE03nOvKkxx+SIm92dU0CKS1qJxIKrYw/Ja+ctbJGgD8kDq0v55VEp25g9159XXMvqb/gIsxBgfLjbBl/Z90YDUFNwVwh4EjIuC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOpuGU1j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so4182175e9.1;
        Thu, 14 Aug 2025 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755172294; x=1755777094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VnTFOiEQ/KEA1BYExh4enVyNJmydSamaAd1v3h7zMU=;
        b=aOpuGU1jf+qcwwAvXD+VrAXKD9P6O8jdO0Xyi6BlALhF66zSV/QxYf4avRSshfPoG8
         LlRjGznS7W7Z6nu0rJG9UNciNhrSJa8Rj39lN1hT3X/jr2MZ7RQOjNXGsoJAu36IlewB
         Ug3V8CBDjwMOQs5hDsloV/ZlYWQzPjTzRwaeXb9amijVAOyLnBOK48ageNruL8L/pwrp
         K6dGVcKCK9dGo/N9ZVnzWBYTqGU3EvhJWfpv53K80Ik7T4QkgnmmUbUDL8KrBaNgwUgE
         RolMnDFPTPtgDFGaQAMo37sfXKjnmf5NCTntKuS2OTlPtmC9QnO9d/lJ1P2d1K3XT4qE
         VD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172294; x=1755777094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VnTFOiEQ/KEA1BYExh4enVyNJmydSamaAd1v3h7zMU=;
        b=oZiVRapC/cTrOR3LJvSKhXqeTo2orzLuctHJ/cZoYJC0FQ+6WpTHDT5lqE2V21sYvP
         uHLsIwa6ohp6egQ3Jwd8hSfz5ek+KGu2t9xTJikIkmSZlNe2jyKMMejX7LEVg3rBNcHm
         3x088xyUqCUVP3EIWB0PbwHI/K3asMMefrODzuzip/rcTdYLtWm867cq7ekt19l4hrNB
         yzUrTG+cvCw0qf6rt1q4vx5URNM19YqhfSO796FjZFqVbj5Em6RuDxNmamOFGsTJ9fes
         PXsL1gj1Kr6AN+kQ7l44ROmXpd/AEvQNs7bvGyWPqJMus1IeEyf1+wI6EgHL9TwFi6gA
         IV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVR72gMDLSLwJa2OokLeVHlQsUxqnDhvUucPU1tmxft+p+VzR1I0xluqEXcgCYyurq2fbsrunq2xiM0jCiH@vger.kernel.org, AJvYcCWAop0R5qC6KFEORbaoMrUun+1OetbA1cfMBiMOhAM30upoVNMhNPnWjNF+JkBbz7fgC08+UCoIN7bdyCdHmA==@vger.kernel.org, AJvYcCXAVLpzQKr62bTXdeIrQk1h5uLY4i2+T6NHVK/gGFoGoXqQuwoKiWUn4yU7qHnVBaB/8DPJOmyYHRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXN66GzwNGPcDOKnU/s8PHByqF/yo8P5FMq8u6JrzjzsWwoJ8D
	HbYBFKxuq2wrdcfC+qe+3l7skQy/EgePeF97WLA3EgAZlwhfIsictq4R
X-Gm-Gg: ASbGncsfFOsFd7IjWRNlSV0CN2U3IEhH2ij3QRcr4G4o4F4UqExXBSMqlATXz3SVciP
	xWMlnQajzt5q0hhivO6ozr1xh1/1dmSNNxc0gVTmK8pxogkaKylmuRYA6Lgw5QNdmIORrHv7GLi
	eqTj9Ul4OFjQSHI9cbzHtO38Ur8xk+ryq3Art84N8O/eod7vhy8AOK4a9IL/hhDmPwDnGC+D1jz
	hG4PsuIQVDh3+WjkOunYIXExGyElDEtNb7QTwAaQZU3wB01/dZeG0r08BkNoqnz4aXUwP6ivtzS
	uG+mneN/PuJql7B9RKSIU+Qp4atnXk6x6kK2MkAjMf2jZbavK27Fp+zQnZVU9HNFyFyvYgS7vgo
	wpE1DcouPnHeDU4ykaPovcvQvHTcGCveMf2CBOf0i8286G16oBritZc4Bb5fC5naEq7kb19SpyA
	WmQCWNvQ==
X-Google-Smtp-Source: AGHT+IHthldMbcpzDbaJ1GGbyBIqgCUgRr8Aa4x6eTmOxq4YHMkcIGai32HHy+wWjTZMm4tR/4WApw==
X-Received: by 2002:a05:600c:1390:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-45a1b67a215mr16749815e9.28.1755172293482;
        Thu, 14 Aug 2025 04:51:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8979])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm50579340f8f.11.2025.08.14.04.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:51:32 -0700 (PDT)
Message-ID: <4d23ba51-e8d8-41bc-8d46-a7bccb4c3c20@gmail.com>
Date: Thu, 14 Aug 2025 12:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Mark Brown <broonie@kernel.org>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <1ff24f1b-7ba2-4595-b3f6-3eb93ea5a40d@gmail.com>
 <a8b0eb8d-442e-4cfc-ab79-3c6bc6a86ff0@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <a8b0eb8d-442e-4cfc-ab79-3c6bc6a86ff0@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> 
> Why would you move things around though? Think it's fine as-is, if something on
> setup fails then all tests should fail.

If its a "test" itself and not a check, I think its better if it belongs in TEST_F and
not FIXTURE_SETUP.
But yeah this is ofcourse going to be the first test, so if it fails the entire thing
is marked as a failure and we dont proceed.

> 
> Cheers, Lorenzo


