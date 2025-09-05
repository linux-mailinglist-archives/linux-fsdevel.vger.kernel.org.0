Return-Path: <linux-fsdevel+bounces-60372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3CB463CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 21:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A3AA07AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBB28137A;
	Fri,  5 Sep 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWeO66el"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10D13D539;
	Fri,  5 Sep 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101230; cv=none; b=GV181OynmGA2bL4EEgpkVmQivyOzHvcTtvD0mUYVIqetncFp2lyQitsSfvKcQ4GSMT2dy8/cyiPKZqnc3VaksB1aowv7GkYAYeWEyhPeUK1O5HEl1GZ5pRRUKb3/jwMK6Uu9i2hHF5LH4Du2vCzpInZm5olU4OLGkEi0CAhhvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101230; c=relaxed/simple;
	bh=xhsqW2ycceW1sdKQYARagIhFItw+4GqIkCDwVnVlC2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwMHn3O3f/puiFutF4rt48Uuddt5dZoxIKnwD/JLQLeRh7qtfJqp9R4D9cUmr9lPY7kmpQ62o6Df2P8vHdaiTDRlxJUGqbzcA7z9Iy0elfrSrSYhxc5l631Vg4aeEhPb45uxRsYby+AaN8Wjw1DkAiZkX88ntlIVHlnh/IIYe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWeO66el; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so966281f8f.0;
        Fri, 05 Sep 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757101227; x=1757706027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5Leh3iWdpj35vfwfF+dKvMn8gUxkJHhmSd0V0QRap4=;
        b=jWeO66eluDRNnu6Tusz3v6NCIxCyW7Cf9jk3C//ckCpHLnUeepaXJ48Yv62P37aD9j
         ZFhRm53ikZjUgvPoSqJRf4DtMIvdlHXie6ZgSrhcBwKpuTurEnXF7OMZEZVlAGfPpqDW
         L5fJTQf1RlDBtQ12s55nVn7VsFU4VIYbJXkOXIv81DpHIiieuSBuCshWpAKcb5gYHHtY
         Wxenj+CRgCfjY+p7ABh5/O6dAXxv2xnDUU/DOtJ0vTHgAImlL1DcwAJW8hesuJ1iZWKI
         mUAnjQSx3XDRmksajewZP2C5d8n/RSDKatZ6C/sSPz81VQPGclFztD2+0NpGPDijAFqP
         GltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101227; x=1757706027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Leh3iWdpj35vfwfF+dKvMn8gUxkJHhmSd0V0QRap4=;
        b=c+7wlU7PYx3h0kSmZiBMVOYo8C/xnVxF1gbT4Qai95o6k9TWBMt3iEpyMWxeStyDm4
         NL9Y34z/mhguV+bJRTsN/o1zZtLsBP2Stz5zUIl7/LI8D1cKxaslCIJGbv1zqy4xMrz0
         39ZRKGWhhvDfWuvtoad23BIFMG1mU3KpknZE1NYWh5+oDGGl0lA91VoLTlkd0FNco0OV
         TWNKyj9YH22wdZcQ5ZVa/5AIeOBj7FjvK6xbLR/1UJM0HBPrM+IHacv56+iR1vjr9zV+
         Qt1zFRN1Nwjo53pYGaXJ5q/W8Jc+JEP+EgUamtEFyKTX5dBiaoN+oDNTvR8MBbxDWj20
         ILuA==
X-Forwarded-Encrypted: i=1; AJvYcCVFrmM6qfumVwoubFYZHhtuBuwfr5NUzc2Osw3ekRWxZETzgJpVAKhlXHISwuiKfZxqZgCTer1SX3U=@vger.kernel.org, AJvYcCXjA13G3RR1K1lScaAQfaLuIb/NF98z8dIoXujVYNt0mJTOGmagbcnrfyk9O/3cod3nVWTi+VvoZtB+RZzXaQ==@vger.kernel.org, AJvYcCXtYS9fOthzW3l2gn3rJZlQE2coYfbj/Uyx+DIvRYq+8BRfNfy8tboA0gt60+CCAp0aDiKn0Qmyaa19vKSX@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwTsxVjPmSb8nLk4gfzwaa0TCPs4xgCT6A32Av4oscxoVDJHV
	5Vwb3wzp3l4vtBLrA2Bh/rGhgvYJEfCnqDHjBlJ++iGvHrDlBq1vYIgx
X-Gm-Gg: ASbGncsaGFP8ZJBYt/tnid4dePi3pUMTSSS+4vsd1orJlvlQ5O0P+3CYVTarZTYMf9j
	/JveJkcSDH0iydGEgMd6I1XFheM6QIQVO0nzMqXQEgTRnvfKd72A65SimXVsKjgZBqvE1aJzanA
	KKHXl72zJtC3tBmGzyxP88rIvP5U2t8BxgEo+N5GagrteKLpFsuohteKWU7ft+OzaEV1rw4/GZJ
	5PGIJFRIi9XJKKZ5cL1+Hkbo113ONnFNtnvQ2XKjxs04NyxbbVesoWgpPZ8fQbKEooTfdbeteiJ
	+Im1qk8me19MbIj6zJK8avcy5V7R6VzjnJrvkDWNMlU5w8KjsFfv32Yxp6NfBi16fTxwn3kVms9
	cyBv291VijkgOKibj0w66rmDWAj4H+rrR0lrjMnwL3EcYFWzbeR/Kxu/PSdiAmAp2b57N9aLMhq
	aH+R08ROHeui56MxGWQO9jIR/xqnks
X-Google-Smtp-Source: AGHT+IGkCUtoIJmK/cXGI+fG8KbeWQpaLfWU2RtQVWVmzNIv533orfL59bVmV7MDCa5V1l6DsQsCcQ==
X-Received: by 2002:a05:6000:2012:b0:3d1:8d1e:8e9 with SMTP id ffacd0b85a97d-3d1dfcfb918mr17778240f8f.32.1757101227334;
        Fri, 05 Sep 2025 12:40:27 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm378087845e9.5.2025.09.05.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:40:26 -0700 (PDT)
Message-ID: <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
Date: Fri, 5 Sep 2025 20:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com, Aishwarya.TCV@arm.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
 <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
 <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 19:02, Mark Brown wrote:
> On Fri, Sep 05, 2025 at 01:55:53PM -0400, Zi Yan wrote:
>> On 5 Sep 2025, at 13:43, Mark Brown wrote:
> 
>>> but the header there is getting ignored AFAICT.  Probably the problem is
>>> fairly obvious and I'm just being slow - I'm not quite 100% at the
>>> minute.
> 
>> prctl_thp_disable.c uses “#include <sys/mman.h>” but asm-generic/mman-common.h
>> is included in asm/mman.h. And sys/mman.h gets MADV_COLLAPSE from
>> bits/mman-linux.h. Maybe that is why?
> 
> Ah, of course - if glibc is reproducing the kernel definitions rather
> than including the kernel headers to get them then that'd do it.
> Probably the test needs to locally define the new MADV_COLLAPSE for
> glibc compatibility, IME trying to directly include the kernel headers
> when glibc doesn't normally use them tends to blow up on you sooner or
> later.
> 
> I knew it'd be something simple, thanks.

Hi Mark,

Thanks for raising this. I think doing 

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 89ed0d7db1c16..0afcdbad94f3d 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <sys/prctl.h>
 #include <sys/wait.h>


should fix this issue?

Thanks
Usama

