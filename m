Return-Path: <linux-fsdevel+bounces-36171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA09DEEEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 05:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B9D163A75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 04:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10913AA2F;
	Sat, 30 Nov 2024 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CYfmZo9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C376137930
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732940889; cv=none; b=owbhuY6w/e1WcNI1CVESv6RSHMdTV4BM1tiF86YCfNwn6iv7KOCuZVAanX75qYxnhIedWRiI6SDdxIUrHfGHqs6yInPdPoC0Il+fI9IRFUoxsjlNYaXgUxPVcppJ71GjCXIJpw5cxht5jHt9NNrFJb7iFVQU8MfwaJfctzmTyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732940889; c=relaxed/simple;
	bh=3fVPjAMLcPc8W9XHxCKejFdtJstDJyDr5I/dm5BmSG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=drCg0lLZry+SNblN/8ovoXF28YqjKQJDkiIjyA/oRhZ7MjIuWyDLqXEWhUpLJ6VmgcQ64ueySgBFi+I/XhFz+EWF9tLRdqN7VrhqIk8QPpWcOisvgasw2ec8TsKsIXBmNL6P9Fa4XCKi640Pv++WsjKAAyntxR1/fTx/XT/X1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CYfmZo9p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a1639637so23102195e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732940886; x=1733545686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=59D7wKw+lCrKikwTGg+Ep/tt5Aq7umJy0reSeHNByL4=;
        b=CYfmZo9pn7t2p0Du+sUkwzlE8cxodAvbflPB+PziTqhEVWAk5GSYSlGTNyNwHfy8bt
         oaRLxUR6xOOjPPjndw/TefADj5RaxYJsVIKK0QLYOAltcOW/2eGoqZgLBHyuzDSGWSP9
         dy2GV9JnZDLxsGzKmpseSKg9lH2jRTvMXljUWF+aZeqmQzzH18LAxX/FG2MoABIg2ymT
         8i4rVFrfjWgZnq/sNxlFQtxb3RgYMw2t2Yddne0W1NBR2jjE6TqsU9loZ6S6QCz5LmZ4
         6sL8GONVSLwVGa5mL/Me3Co35t18Yxm+bVi7VqaP1TM0EWcRKazWH3LREfQRh/8PmW7U
         ALbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732940886; x=1733545686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59D7wKw+lCrKikwTGg+Ep/tt5Aq7umJy0reSeHNByL4=;
        b=q/p1TMUXioaRxxHxwtGHhznhUUgqgEjM2yT+fZ9YOUo+EWJGFezFhIwDcudILH4kNi
         9AlDfV2BlHgMtNM91JCX3KZTSNiSpTO39f7rMIoTjOQGHGEO5bRq9zBgkZSQP6wKZHAR
         LKv6hCCiEya/3vNTKpPYylT4zywrTNlnZ9Nv9HDalFqTc1hTM77ofm1rG/Rcvoh5ZDNh
         Di65OrVQ7jg/S7ZtL3Mjt0CfyhdXderjQCX3oB7XO2dtYBivuGMwNfzuV1NKTbMUgmYx
         dZd04rS2/qkPJJJdcG2wGAzUD0DmP/VbH2+RNPna77GRVIyNGfnwyUwrm/eDyVma07hh
         AJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWAyBkyA3T0GDbizJM0BCHhQdgGjL5YyXC6atu2qjazH0B+239XBVX/um6RpKGFIungHyymNneBr1LmbvFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQ/nMcW8yOW6hCCW3tRkHyHnHZeNRj6t9MOXwwR67cKiMN86s
	CoXnMyzkyBnQ1xGc0aJHe04sSR0ffxlbmfqGlBjt0roHk9ZVwbiIa1r6RKqrN8A=
X-Gm-Gg: ASbGnct865Rlv3FOs6jQ6kIA+EEw6AtHjtTgtwEfa7O7ARvlQvaqpm6CKv2KPt+rBak
	bOCTpBFdxFUvwwnkGhKoRxucnTgDy12A2FqnvrX6Xhg20GRRdSvFF/q59KrlKyUGqun1j31RJ6R
	BamUFmmrM62bJEJ/Y0nh2c5d5DEQGRwgER8IL5j/Be4ecA52+HhNBCgzbXV2UutTyAMjE7c5ZhN
	9enGV3vYFKayJRnjT3JUWKQWTR7360V9bhayGHPPKWvq/9oF9TRwwR5KN1IGw3fa4XtTakWIlA1
	CQ==
X-Google-Smtp-Source: AGHT+IFIR4lZurAZoQSAFf9RPCbGkRc4iM4JBekXOV1R5tl1fM/SR9MYYfnBI8F2iWQTnPk9eayFBw==
X-Received: by 2002:a05:6000:1448:b0:382:41ad:d8f0 with SMTP id ffacd0b85a97d-385c6ec0e2emr12419437f8f.34.1732940885462;
        Fri, 29 Nov 2024 20:28:05 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215478976e3sm17340845ad.58.2024.11.29.20.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 20:28:04 -0800 (PST)
Message-ID: <15a3a0ec-78fa-4992-a98f-6b82b5a387a5@suse.com>
Date: Sat, 30 Nov 2024 14:57:59 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
References: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/30 12:21, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: MAX_LOCKDEP_KEYS too low!
> 
> BUG: MAX_LOCKDEP_KEYS too low!

Hi Syzbot guys,

Syzbot is great, but I'm wondering if it's possible to disable lockdep 
for this particular test?
Or just let it re-run the test again?

If the test doesn't crash with my fix, but only lockdep warnings on 
certain too low values, I'd call it fixed.

BTW, I'm not seeing where I can changed the MAX_LCKDEP_KEYS values in 
the kernel...

Thanks,
Qu

> turning off the locking correctness validator.
> CPU: 1 UID: 0 PID: 11728 Comm: kworker/u8:10 Not tainted 6.12.0-rc7-syzkaller-00133-g17a4e91a431b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: btrfs-cache btrfs_work_helper
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   register_lock_class+0x827/0x980 kernel/locking/lockdep.c:1328
>   __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5077
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>   process_one_work kernel/workqueue.c:3204 [inline]
>   process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> 
> Tested on:
> 
> commit:         17a4e91a btrfs: test if we need to wait the writeback ..
> git tree:       https://github.com/adam900710/linux.git writeback_fix
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c5ad30580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
> dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.


