Return-Path: <linux-fsdevel+bounces-35908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1179D9878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F328412E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987371D5140;
	Tue, 26 Nov 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE6yAvfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F6522F;
	Tue, 26 Nov 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627451; cv=none; b=fRlQI0UaNrk2bvVXtH+/s1XJFedT5HKzYSTB/9svG3D1KtajPo1B0T8SCJtHbeMxbKD9D/7/EZgEXmowSc9ArpkraKwer0U0DN9IgEiK1jegskMGRGw8I/PqxApcqtkKfP6mZhsiGaxo/AG9dNsGH0kfI4beZ9DVPATqp98Vri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627451; c=relaxed/simple;
	bh=iHYB7EKOxgthbbmnUN0jsVW2puY2PEYcKryO0GjDGFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=luw/TG56yPwIc6PEKylNysjKa/YlgO3IHmJOTxJfUN+CYz7Eqyv0XRr2wCjI/WgzswJYSlAcZ3msxjzHDGAZI3CCtuBanc1Gq8AymVSVcU9vArLNJmRSNeK065EDb2LXw2XxGvaB83WtcJLUwhyCeJ6HPUjLJCBj+ElGo61SUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE6yAvfP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da353eb2eso8747230e87.3;
        Tue, 26 Nov 2024 05:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732627447; x=1733232247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1iBvzimN1iv1fee77YElBhVaU2CCj11UuGl0oezYDc=;
        b=CE6yAvfPv24+sVn9wI1ku/V3hr+jGZTiqBEVj2uwzDB15THZdYTwASTAGiTWkLzSHJ
         y1DDs7r8Zgu6x+HLxPSTGmwNMt1QPGiJWK9YuIVfh+yRWD21cKYutpClqrhjZgBxuqCs
         jnk7SMmXhPC/5yuQS1PAwXUS0pNodr4dt7bVrJQQq0zHggFok9ZBngrawEm8aSWRX9p7
         9496pjrOt3fPpQC+z/A+3cGYkTQrUl3tfmcg+Xn66NdjMXNyzEeY9/VbPA/gzd7lVMg4
         VX8IuagqcvJQ0+a2iVPQOr8iuuB3OAT/0raP4EKvMh4XJfJeTUm8L2OaLGP2btrgxWIq
         y5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627447; x=1733232247;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1iBvzimN1iv1fee77YElBhVaU2CCj11UuGl0oezYDc=;
        b=RnAIssaX5voxFpytEzM25zbYq986CDXXG1GEbzBD+TRPhcTlAEVRnByH+kqtSdRO3k
         dWl6XICN+HncMAyJsNXh53C8Ejp52E3nMWjLZsDGug1z5RUqeZ6Io3rpZYNhJxVr3OP1
         zG1MjWXzODJnAEK64HzqAYIgxc/8soJRPbnfRLy9JK70iWzJ0ALIGGyTyAxtyFMH/AGF
         Qptv8znKsmqa79B7V0GbYpHgoQ17+Yhk93IuaSch8QqTkJBwF3E/R4/11GcFs2++WcHD
         GuE2vQ+NTI2LT8+yZVSA6Cvto5WoMJUvJ5dsnZQHs8xu+McRKO7GjtA75yntBvv9nWIw
         F8rw==
X-Forwarded-Encrypted: i=1; AJvYcCWlDujBolR9hmsk/cSgqYVxDXu6S95WHa/lnwI0COfe8p1/1zGCCjjoaDUDZUTGxShU9khtIknZaTY07vFv@vger.kernel.org, AJvYcCX4ko8auY+psoRLquVvOd3YDnqR3Yvdf1Ru+NXURArspgrFDnL5GsDjZat9VGCnxjCI3m9kE3uFb0cCh7uf@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaYSdhHLdYsZWf2w75H2LApBvrRrHtmCktAqnDAXvOV+O5Xwl
	a1+besjt3J6nMPvyRVcp0fo+4DQAOtnn0L7I9UsROhTef6BUY74M
X-Gm-Gg: ASbGncuGbV2Uvb80hxIm5of2LDgDGj7mEgGw3A7U+lcWWhR5u4UndDdctfqZQe/UsbB
	Jwd636aFLx/gtW/geGywmJJ8uxpVhvpKynl5g/9VFR4Rb7NUFLgCK/Vm3LYOyCSTHcTKqJM01YQ
	lfV7M2wHaoIeRF+8nXEMIxZEbMN5GBE+GAY2PRX42I+tihRKR+U3WRaO9g7FgGSQAxOJS3++NC2
	S7c1NXvzbH90uwW8Ry5ktYUiAYALd5I8WqoP0Hx/M+EntwqivvJvLvQwLyuALHkoIdDQQoAT/Op
	dGZixvIM
X-Google-Smtp-Source: AGHT+IEob9+z/w1hvogkiR/Kp//LkJYdHtQ9ArarJa3hPnE5n/peMRVpRUWIrYf7qSruTyw0ncGebA==
X-Received: by 2002:a05:6512:2203:b0:53d:e592:5415 with SMTP id 2adb3069b0e04-53de5926f10mr5468823e87.34.1732627446804;
        Tue, 26 Nov 2024 05:24:06 -0800 (PST)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ddb348709sm1543432e87.100.2024.11.26.05.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 05:24:06 -0800 (PST)
Message-ID: <fc8fca1c-d03e-4b11-84f4-5e7560086e42@gmail.com>
Date: Tue, 26 Nov 2024 14:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in NFS probably due to very large amounts of readahead
From: Anders Blomdell <anders.blomdell@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Philippe Troin <phil@fifi.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <6777d050-99a2-4f3c-b398-4b4271c427d5@gmail.com>
Content-Language: en-US
In-Reply-To: <6777d050-99a2-4f3c-b398-4b4271c427d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-11-26 13:49, Anders Blomdell wrote:
> 
> 
> On 2024-11-26 11:37, Jan Kara wrote:
>> On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
>>> On 2024-11-26 02:48, Philippe Troin wrote:
>>>> On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
>>>>> When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
>>>>> we got terrible performance (lots of nfs: server x.x.x.x not
>>>>> responding).
>>>>> What triggered this problem was virtual machines with NFS-mounted
>>>>> qcow2 disks
>>>>> that often triggered large readaheads that generates long streaks of
>>>>> disk I/O
>>>>> of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
>>>>> area of the
>>>>> machine.
>>>>>
>>>>> A git bisect gave the following suspect:
>>>>>
>>>>> git bisect start
>>>>
>>>> 8< snip >8
>>>>
>>>>> # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
>>>>> readahead: properly shorten readahead when falling back to
>>>>> do_page_cache_ra()
>>>>
>>>> Thank you for taking the time to bisect, this issue has been bugging
>>>> me, but it's been non-deterministic, and hence hard to bisect.
>>>>
>>>> I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
>>>> slightly different setups:
>>>>
>>>> (1) On machines mounting NFSv3 shared drives. The symptom here is a
>>>> "nfs server XXX not responding, still trying" that never recovers
>>>> (while the server remains pingable and other NFSv3 volumes from the
>>>> hanging server can be mounted).
>>>>
>>>> (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
>>>> several minutes) on random I/O. These stalls eventually recover.
>>>>
>>>> I've built a 6.11.10 kernel with
>>>> 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
>>>> normal (no more NFS hangs, no more VM stalls).
>>>>
>>> Some printk debugging, seems to indicate that the problem
>>> is that the entity 'ra->size - (index - start)' goes
>>> negative, which then gets cast to a very large unsigned
>>> 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
>>> bug is still eludes me, though.
>>
>> Thanks for the report, bisection and debugging! I think I see what's going
>> on. read_pages() can go and reduce ra->size when ->readahead() callback
>> failed to read all folios prepared for reading and apparently that's what
>> happens with NFS and what can lead to negative argument to
>> do_page_cache_ra(). Now at this point I'm of the opinion that updating
>> ra->size / ra->async_size does more harm than good (because those values
>> show *desired* readahead to happen, not exact number of pages read),
>> furthermore it is problematic because ra can be shared by multiple
>> processes and so updates are inherently racy. If we indeed need to store
>> number of read pages, we could do it through ractl which is call-site local
>> and used for communication between readahead generic functions and callers.
>> But I have to do some more history digging and code reading to understand
>> what is using this logic in read_pages().
>>
>>                                 Honza
> Good, look forward to a quick revert, and don't forget to CC GKH, so I get kernels recent  that work ASAP.
BTW, here is the output of the problematic reads from my printk modified kernel, all the good ones omitted:

nov 13:49:11 fay-02 kernel: mm/readahead.c:490 000000002cdf0a09: nr_to_read=-3 size=8 index=173952 mark=173947 start=173941 async=5 err=-17
nov 13:49:12 fay-02 kernel: mm/readahead.c:490 000000002cdf0a09: nr_to_read=-7 size=20 index=4158252 mark=4158225 start=4158225 async=20 err=-17
nov 13:49:16 fay-02 kernel: mm/readahead.c:490 0000000036189388: nr_to_read=-8 size=4 index=17978832 mark=17978820 start=17978820 async=4 err=-17
nov 13:49:19 fay-02 kernel: mm/readahead.c:490 00000000ce741f0d: nr_to_read=-5 size=8 index=3074784 mark=3074771 start=3074771 async=8 err=-17
nov 13:49:21 fay-02 kernel: mm/readahead.c:490 00000000ce741f0d: nr_to_read=-4 size=6 index=3087040 mark=3087030 start=3087030 async=6 err=-17
nov 13:49:23 fay-02 kernel: mm/readahead.c:490 0000000036189388: nr_to_read=-2 size=16 index=16118408 mark=16118405 start=16118390 async=10 err=-17
nov 13:49:24 fay-02 kernel: mm/readahead.c:490 0000000036189388: nr_to_read=-10 size=16 index=20781128 mark=20781118 start=20781102 async=16 err=-17
nov 13:49:24 fay-02 kernel: mm/readahead.c:490 0000000036189388: nr_to_read=-13 size=16 index=20679424 mark=20679411 start=20679395 async=10 err=-17
nov 13:49:25 fay-02 kernel: mm/readahead.c:490 0000000036189388: nr_to_read=-9 size=4 index=20792116 mark=20792103 start=20792103 async=4 err=-17
nov 13:50:22 fay-02 kernel: mm/readahead.c:490 000000009b8f0763: nr_to_read=-7 size=4 index=4172 mark=4167 start=4161 async=1 err=-17
nov 13:50:24 fay-02 kernel: mm/readahead.c:490 00000000295f3a99: nr_to_read=-7 size=4 index=4108 mark=4097 start=4097 async=1 err=-17
nov 13:50:24 fay-02 kernel: mm/readahead.c:490 00000000295f3a99: nr_to_read=-7 size=4 index=4428 mark=4417 start=4417 async=4 err=-17
nov 13:56:48 fay-02 kernel: mm/readahead.c:490 000000009b8f0763: nr_to_read=-10 size=18 index=85071484 mark=85071456 start=85071456 async=18 err=-17

--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -485,7 +485,21 @@ void page_cache_ra_order(struct readahead_control *ractl,
         if (!err)
                 return;
  fallback:
-       do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
+       long nr_to_read = ra->size - (index - start);
+       if (index > mark) {
+         printk("%s:%d %p: "
+                "nr_to_read=%ld "
+                "size=%d index=%ld mark=%ld start=%ld async=%d err=%d",
+                __FILE__, __LINE__,
+                ractl->mapping->host,
+                nr_to_read,
+                ra->size, index, mark, start, ra->async_size, err);
+       }
+       if (nr_to_read < 0) {
+         printk("SKIP");
+         return;
+       }
+       do_page_cache_ra(ractl, nr_to_read, ra->async_size);
  }
  
  static unsigned long ractl_max_pages(struct readahead_control *ractl,

Regards

/Anders

