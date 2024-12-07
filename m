Return-Path: <linux-fsdevel+bounces-36691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25669E7F7A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AAF281FFF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6421428F1;
	Sat,  7 Dec 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFvsItv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9B136331;
	Sat,  7 Dec 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733566203; cv=none; b=CHCx9KU2RYfmkvoBg2kngF2NLwNk/NynayNw5TZpJSyRzjyvd7uZQACMwXZig3kjUaQ/yo6gJZrjmAs/6HYcSamD0UPfTTz9odupSz3E3gU0sNu2Zt0jknVlV+uhudJmj8ilzq4lT5S12La1y00mXfoLIBQi9rnKQXVBe5PNcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733566203; c=relaxed/simple;
	bh=p2edH10DS2izFB/jzZz2W+zP4whcYevquQhC4IC/v/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4EdbMf0PmzfkiFEk+zaKTD9wBDyVGhfzhXJERVqMeddndV5xtEowpB9eSH22A14fraiIZ3SS0kBK1tIDvldpAQkggQOI1Uw1AGT7xtxMU0SPxdJJUOO3gsTr/SUHeCfcvMJBUE+Nl/wFdHld+J5CmR+u9fNowL3Uf6Z9MjvnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFvsItv3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725dc290c00so38150b3a.0;
        Sat, 07 Dec 2024 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733566201; x=1734171001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BHlvc2h6RbQcsZ4MoZvKFrwrzmCNN8+Ik8anzK5kag=;
        b=eFvsItv3h+jzoerK6lx0qGiH3yGQpmRfJQUH1YdkcysdEp8UMn/olIrIuz7lW7K4z1
         PqHcVFgo17wpFJ5sTQu2sXqjsvozs5CQKvJZAickDvxh46X57wVIfjQq5R/hQ9oNdt7K
         Nm7Vl5UNrJkvgCdj/AtSaGQzjsOtrdDbf1y/exxQF344dwKXR4THTIRx44d2GIO5/rBi
         FE5pJZkQEy3N/SKjE1/CWJNCZN/meAK349JbEEXJQLxaRJJR94eW5mikJ/8ARosyvH7A
         PbQQNekME90pHo/xLVnEDwmSDRAJlycCUqxCoz3fZul2rKZ+RPgACqa6MMRwlgmYWArl
         4iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733566201; x=1734171001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BHlvc2h6RbQcsZ4MoZvKFrwrzmCNN8+Ik8anzK5kag=;
        b=f5inPlWpZBKd5Gy5Qp0LKmdvTuBaeHhroApE0+u3hk1pC3vZgIlqF13/pHtIOd1Wqy
         I6G9lTVwT1Wk7ucLo3wJat6z943noqJhHCdgVpID3nL5esQnSLi/C2kw964slA8UTaHk
         JG6pM4+q3kSIqD9oznOMRyzhF5SYmhFLAFG05ayCPt/pxRkICpTW4sk1ovf4h6KygW9F
         dJSBKdVNV0WB7dEEl3nSxleOyPU5f0rPciaOZ5/uq9r98v3RVrmWNYePcU/nH4teEL/C
         GBpC585RFJ+H3kdVXb35T2aRdq1RY+myowPRTojF7PlmohWpCh5Gdt4Dn54Gq4ty/D5C
         Mz7w==
X-Forwarded-Encrypted: i=1; AJvYcCUk5MAQYZIwTLzArN+acRmhVHjc5WymHA+nCUAc8f9+tTAv1gaRC8qsvx8DCPzNImvn752SbsWC5tg/V8Qv@vger.kernel.org, AJvYcCVIbPyJa5y44QP01IXoYGp3aIeJV/Q/vp/UT4qlU4x5rmv++wYbtz/c8oK9041yBOmSIj8j0WRfCbN6qm4l@vger.kernel.org
X-Gm-Message-State: AOJu0YwDscnCfj0/ZGbVFmTC5+Jl5ov0Bx3/Vhhj4s482KChJX6iPEo0
	NLMdIecQ8xh9Tqqw9pWPUaYhujpDKlAvx+LNlwtN50JAlgb9rTi7
X-Gm-Gg: ASbGncsu0HKkbB2NmeJUObJJBzfI+MB+Iru25468tNQ8ecG7bEbWE39y96NBA1r69IJ
	/7iCTAc5yWJTHZ7ZJrfbVEjIACw8rzbbaXmcvnXc2PoJMMceoDrCzovt8yRUA87DX7hrjoEJip/
	qjK7kGqyzUZYXSaaxLeX4KdgaYiRIt8JvlZwRC3YTdApOok+LBG7sstdUtmWfZD0uGPrH9XJFb/
	O7GqRtXQhAJ3mwaHiiRNs8OKu5GF1G7ZG5ZuwD82/FhfxSiTUINJ+3yJ51/a4S9C6xmEN5ZrXFj
	EjXkLpbaUt4zklyD
X-Google-Smtp-Source: AGHT+IEwKHhlxGzah4NtZ1B9CRa8dut1jgF5vSw0cszYeuNUODXBUIVq9msGMlK35IELUgHoTm1KAw==
X-Received: by 2002:a05:6a21:168d:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1e186c1dd91mr8250378637.12.1733566201479;
        Sat, 07 Dec 2024 02:10:01 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ef5b6sm4218484b3a.71.2024.12.07.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 02:10:01 -0800 (PST)
Message-ID: <9cc62b69-7cfb-477b-bec1-3bbcc49a310e@gmail.com>
Date: Sat, 7 Dec 2024 19:09:59 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
To: David Howells <dhowells@redhat.com>
Cc: zilin@seu.edu.cn, jianhao.xu@seu.edu.cn, jlayton@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, mjguzik@gmail.com
References: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com>
 <20241207021952.2978530-1-zilin@seu.edu.cn>
 <2011011.1733558696@warthog.procyon.org.uk>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2011011.1733558696@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On Sat, 07 Dec 2024 08:04:56 +0000, David Howells wrote:
> Akira Yokosawa <akiyks@gmail.com> wrote:
> 
>> Are you sure removing the smp_rmb() is realy the right thing to do?
> 
> The wait_on_bit*() class functions, e.g.:
> 
> 	wait_on_bit(unsigned long *word, int bit, unsigned mode)
> 	{
> 		might_sleep();
> 		if (!test_bit_acquire(bit, word))
> 			return 0;
> 		return out_of_line_wait_on_bit(word, bit,
> 					       bit_wait,
> 					       mode);
> 	}
> 
> now unconditionally includes an appropriate barrier on the test_bit(), so the
> smp_rmb() should be unnecessary, though netfslib should probably be using
> clear_and_wake_up_bit().
> 

Thank you for clarifying.

> Probably we need to update the doc to reflect this.

Agreed.

I see that wait_on_bit()'s kernel-doc comment mentions implicit ACQUIRE
semantics on success, and that of wake_up_bit() mentions the need of care
for memory ordering before calling it.

Unfortunately, neither of those comments is included into kernel
documentation build (Sphinx) at the moment.

I'm going to prepare a patch for including them somewhere under the
core-api doc.

WRT memory-barriers.txt, I'm not sure I can update it properly.

David, may I ask you doing that part?

Thanks, Akira


