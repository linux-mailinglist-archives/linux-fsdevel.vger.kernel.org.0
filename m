Return-Path: <linux-fsdevel+bounces-17035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D18A6945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 13:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8CB1F217CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959E128805;
	Tue, 16 Apr 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdfLqDfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710F763F1;
	Tue, 16 Apr 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265345; cv=none; b=cOmxgg08H2J6NRQZcuvoWW03invD8O0FsYqF3ZVq4H325LjHCFiSnnBVxl5lTBdL1aXVPZxsCuXTjE+0UOPT5GqTORDTBnA2FAxq2xv24YJbKPdsil/Ue39kwMc0XwijoAo0yHvZ9Y4WOWKDB2DrqdHvzQjnLROursnFvf4c6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265345; c=relaxed/simple;
	bh=bkDgWr7XyI1pfPFJlziFtGVw4ovew4FuLAiRHzSxUPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QRaEVIsIHuiuR9Jg+TOW/3YijLOge9nRiOTgw05INiISq0+2wJ7NmckPhSWRrCoLL8+UByESwLKRTz0T/BIwZMCZ3+VvS+E49zruJQ5U3W+wFvvhyasngIgMrQQJ8n3JHdh8GwELnutGX00NHwx9QhWDA+WtE9WcLDGVS6se0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdfLqDfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3845CC113CE;
	Tue, 16 Apr 2024 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713265344;
	bh=bkDgWr7XyI1pfPFJlziFtGVw4ovew4FuLAiRHzSxUPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WdfLqDfI1HZOvcHPxnKxS8UR3ya06gFVkKMTxtYXUfQLGiVD+iYLjLjfs+Cc4Ayu6
	 JkbkQ5r/TOID5m3ht8wZdsRgOfD02I/a2tciX+BhNltGkMqmJETnXK59mqiV7BLYs5
	 0Hnfkwn0ir7rFqPFWZSm4bZEEfaPlxpzGe1r8biQHxpShDstBCWBz6GXbMT4ImHssM
	 fpsAlJsTYaHvI8McL1S07XGqFsa+EKugasztU7N6UjIjUk4kO6gD3dTa0hGjh70ZwO
	 gOJChqN8/gmcu5OGH5mxvMY1TsYYbkYrad78+Rkgy74O7lAxpmpZXrelRy2NdFuTPZ
	 aLfhw0hmzfZhA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>,
 Mike Rapoport <rppt@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anders Roxell <anders.roxell@linaro.org>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
Date: Tue, 16 Apr 2024 13:02:20 +0200
Message-ID: <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> [Adding Mike who's knowledgeable in this area]

>> > Further, it seems like riscv32 indeed inserts a page like that to the
>> > buddy allocator, when the memblock is free'd:
>> >=20
>> >   | [<c024961c>] __free_one_page+0x2a4/0x3ea
>> >   | [<c024a448>] __free_pages_ok+0x158/0x3cc
>> >   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
>> >   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
>> >   | [<c0c17676>] memblock_free_all+0x1ee/0x278
>> >   | [<c0c050b0>] mem_init+0x10/0xa4
>> >   | [<c0c1447c>] mm_core_init+0x11a/0x2da
>> >   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
>> >=20
>> > Here, a page with VA 0xfffff000 is a added to the freelist. We were ju=
st
>> > lucky (unlucky?) that page was used for the page cache.
>>=20
>> I just educated myself about memory mapping last night, so the below
>> may be complete nonsense. Take it with a grain of salt.
>>=20
>> In riscv's setup_bootmem(), we have this line:
>> 	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
>>=20
>> I think this is the root cause: max_low_pfn indicates the last page
>> to be mapped. Problem is: nothing prevents PFN_DOWN(phys_ram_end) from
>> getting mapped to the last page (0xfffff000). If max_low_pfn is mapped
>> to the last page, we get the reported problem.
>>=20
>> There seems to be some code to make sure the last page is not used
>> (the call to memblock_set_current_limit() right above this line). It is
>> unclear to me why this still lets the problem slip through.
>>=20
>> The fix is simple: never let max_low_pfn gets mapped to the last page.
>> The below patch fixes the problem for me. But I am not entirely sure if
>> this is the correct fix, further investigation needed.
>>=20
>> Best regards,
>> Nam
>>=20
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index fa34cf55037b..17cab0a52726 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -251,7 +251,8 @@ static void __init setup_bootmem(void)
>>  	}
>>=20=20
>>  	min_low_pfn =3D PFN_UP(phys_ram_base);
>> -	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
>> +	max_low_pfn =3D PFN_DOWN(memblock_get_current_limit());
>> +	max_pfn =3D PFN_DOWN(phys_ram_end);
>>  	high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
>>=20=20
>>  	dma32_phys_limit =3D min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_=
pfn));

Yeah, AFAIU memblock_set_current_limit() only limits the allocation from
memblock. The "forbidden" page (PA 0xc03ff000 VA 0xfffff000) will still
be allowed in the zone.

I think your patch requires memblock_set_current_limit() is
unconditionally called, which currently is not done.

The hack I tried was (which seems to work):

--
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..3a1f25d41794 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -245,8 +245,10 @@ static void __init setup_bootmem(void)
         */
        if (!IS_ENABLED(CONFIG_64BIT)) {
                max_mapped_addr =3D __pa(~(ulong)0);
-               if (max_mapped_addr =3D=3D (phys_ram_end - 1))
+               if (max_mapped_addr =3D=3D (phys_ram_end - 1)) {
                        memblock_set_current_limit(max_mapped_addr - 4096);
+                       phys_ram_end -=3D 4096;
+               }
        }
=20
        min_low_pfn =3D PFN_UP(phys_ram_base);
--

I'd really like to see an actual MM person (Mike or Alex?) have some
input here, and not simply my pasta-on-wall approach. ;-)


Bj=C3=B6rn

