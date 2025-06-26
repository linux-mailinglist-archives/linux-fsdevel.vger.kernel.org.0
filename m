Return-Path: <linux-fsdevel+bounces-53105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26301AEA3A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F9E1880874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322027F4E7;
	Thu, 26 Jun 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fn6oA183"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C814212FBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955985; cv=none; b=HBVjD/9zBs/VrSm66vVaUHc/uaujw6OGSOldOP25+/eGW+2pd2ekDSqTfPciVoB7It5XNb52xpnwWqiTD4evwxuqCtnglKhnwX/0ckm4BMrlHPIFC9Ie3AewRNONfq4G9tYhzerqdnzjKr11a0dJweYVSerwqKp3C5T4vR1uRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955985; c=relaxed/simple;
	bh=GohStccsSwcqfOZBBSgPLYUEx/+iekuLxgT7uEl7yoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aD+KhBX6yQrLDT8HFRgDeUIw3F90e8Hwot/beOoiqqhsW3n2CiwK0Izw7l2XReFBx12DkWRVp9b1FsE1ULhiKG604tzkkOTLlNlVNYlcqEp6IvgPICl1oFDWjbV3noA7uBUZI04Vo5TDhPzskHQQR3esvFAd36IaKIOsx3H5/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fn6oA183; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af6a315b491so1045282a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750955982; x=1751560782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kiB7sElStizaKuG4ZG0mE7ZHh4hndYmdW5MwoUlLuUc=;
        b=Fn6oA18352dL863hv8WUwzwyW+H+UGF0SgOmcs9gRb+IMqXdft8aob2Rv8Hsa5+H2G
         6rgK6VbxUU6xnKMT7XtocXVmqpjULEAHL4/9s/DzwIlDzjeZRqGVVXui4749CHgXXa7w
         9/dkm7JEXLeCv5bxMRxkbP2gO0xHr0umq9d30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955982; x=1751560782;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiB7sElStizaKuG4ZG0mE7ZHh4hndYmdW5MwoUlLuUc=;
        b=g7MdHtBv5nQV6jAgAK5J6hYnlmMode1MkG5qxHT197KoC2uofKFrr9SSOYF+uK2ooO
         kU9b0lFywFR3ci/Z7ooJDgmxAZGVaxks49/oLkHPl7K+PG2FbqCSEbgCnpAyWSksVe7H
         2ZjeXIFsWuWO3ubkPRdDIWzrQZqn2NKKxe0rGcc17+in6Mxh8IQ6xu3DJ9JIwMR+THd3
         I16nvl3FpqFGtniN8m6FWCs7nARhUIWH/rTYipI8rMH6qg52k3QhTCxLvsF6dtZurwM1
         8UoGwxMjCVri/i/1RyGzPMJ1Qpe90CnZzW4a0WPI9Hqu5t5tERs7yU16Hm/LlBTcJ22j
         EPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcTrIVAzhfm+J4gRnfya69TqzoRWEZtjNRzhh6m8pkKWBMIE00/t+xixCkuwaSN89Hv1O/+ImycU98ukrj@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrpJOXQIQSxBXELpBNiHShl9D1czd1BjxwWLOkVG/GoeSZ/8c
	/JaKoozkzdht86NRRXlYLG0htpKa7jVwnj9zL+WknQJEY0/thBGXKO4z1yZHvbtZew==
X-Gm-Gg: ASbGncu0CT0VRfOFkFAw16PMBpzkBHfd3km7Ho/M2ncxNNZwf2braj7voZpFCS/jaCn
	gljvI56u7ZZGM9QlxXXAmp7pygPvxYRUWXmclcqd80kQJXN/y1TemN2SmcYXwNpdndtNdqDFabI
	hnSvc/Uq21u5aG7CkNVLCN/iqJJy8mYZgh+a5O/ByoeQI+IbiGUieUYclYjGiJxEGKAvf82q/v8
	Pj0E1tN0VGo1XcDY6H/6SOZqJIt+aA9xnws6JvrSWt3JQ/XhmT0h273a9BI0GmmRO8hViTv0k4h
	pDmtjNh/NzMT2FnekgB+MS7rdfJT8avcP9OmbWwp3O1jfL2uCJr9Tn1HgfcfmYBWuxj9qKgUqYK
	mBcZ8pJJ/WNQvgL4tPoK6xaI6AOITryPvluCK
X-Google-Smtp-Source: AGHT+IHEodYyA0JwEfIYPoh2/MM1Lu2s8aF4hU27hBW/g0OK17fBGh6vDcMzM6wG4s7dCi1eZ9/MNA==
X-Received: by 2002:a17:90b:2e87:b0:314:7e4a:db08 with SMTP id 98e67ed59e1d1-315f2675fc7mr12720722a91.18.1750955982382;
        Thu, 26 Jun 2025 09:39:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13921fdsm209101a91.10.2025.06.26.09.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 09:39:41 -0700 (PDT)
Message-ID: <c66deb8f-774e-4981-accf-4f507943e08c@broadcom.com>
Date: Thu, 26 Jun 2025 09:39:36 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their
 relevant subsystems
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Etienne Buira <etienne.buira@free.fr>,
 Antonio Quartulli <antonio@mandelbit.com>, Illia Ostapyshyn
 <illia@yshyn.com>, "open list:COMMON CLK FRAMEWORK"
 <linux-clk@vger.kernel.org>,
 "open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
 "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
 "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
 <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 09:17, Liam R. Howlett wrote:
> * Florian Fainelli <florian.fainelli@broadcom.com> [250625 19:13]:
>> Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
>> that provide OS awareness for debuggers and allows for debugging of a
>> variety of data structures (lists, timers, radix tree, mapletree, etc.)
>> as well as subsystems (clocks, devices, classes, busses, etc.).
>>
>> These scripts are typically maintained in isolation from the subsystem
>> that they parse the data structures and symbols of, which can lead to
>> people playing catch up with fixing bugs or updating the script to work
>> with updates made to the internal APIs/objects etc. Here are some
>> recents examples:
>>
>> https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
>> https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
>> https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/
>>
>> This patch series is intentionally split such that each subsystem
>> maintainer can decide whether to accept the extra
>> review/maintenance/guidance that can be offered when GDB scripts are
>> being updated or added.
> 
> I don't see why you think it was okay to propose this in the way you
> have gone about it.  Looking at the mailing list, you've been around for
> a while.

This should probably have been posted as RFC rather than PATCH, but as I 
indicate in the cover letter this is broken down to allow maintainers 
like yourself to accept/reject

> 
> The file you are telling me about seems to be extremely new and I needed
> to pull akpm/mm-new to discover where it came from.. because you never
> Cc'ed me on the file you are asking me to own.

Yes, that file is very new indeed, and my bad for not copying you on it.

I was not planning on burning an entire day worth of work to transition 
the GDB scripts dumping the interrupt tree away from a radix tree to a 
maple tree. All of which happens with the author of that conversion 
having absolutely no idea that broke anything in the tree because very 
few people know about the Python GDB scripts that Linux has. It is not 
pleasant to be playing catch when it would have take maybe an extra 
couple hours for someone intimately familiar with the maple tree to come 
up with a suitable implementation replacement for mtree_load().

So having done it felt like there is a maintenance void that needs to be 
filled, hence this patch set.

> 
> I'm actually apposed to the filename you used for the script you want me
> to own.

Is there a different filename that you would prefer?

> 
> I consider myself a low-volume email maintainer and I get enough useless
> emails about apparent trivial fixes that end up causing significant
> damage if they are not dealt with.  So I take care not to sign up for
> more time erosion from meaningful forward progress on tasks I hope to
> have high impact.  I suspect you know that, but I don't know you so I
> don't want to assume.

That seems entirely sane and thanks for being explicit about it.

> 
> Is there anything else you might want to share to entice me to maintain
> this file?  Perhaps there's a documentation pointer that shows how
> useful it is and why I should use it?

It can be as simple as spawning a QEMU instance:

qemu-system-x86_64 \
         -s \
         -cpu "max" \
         -smp 4 \
         -kernel ~/dev/linux/arch/x86/boot/bzImage \
         -device pci-bridge,id=pci_bridge1,bus=pci.0,chassis_nr=1 \
         -drive 
file=debian.img,if=none,id=drive-virtio-disk0,format=qcow2 -device 
virtio-blk-pci,scsi=off,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
\
         -nographic \
         -append "root=/dev/vda1 console=ttyS0,115200 mitigations=off" \
         -net nic,model=e1000 -net tap,ifname=tap0

and in another terminal running GDB with:

gdb vmlinux -ex "target remote localhost:1234" -ex "lx-interruptlist"

to obtain a dump of /proc/interrupts which is effectively a replacement 
for iterating over every interrupt descriptor in the system.

> 
> Right now, I have no idea what that file does or how to even check if
> that file works today, so I cannot sign on to maintain it.
> 
> If you want to depend on APIs, this should probably be generated in a
> way that enables updates.  And if that's the case, then why even have a
> file at all and just generate it when needed?  Or, at least, half
> generated and finished by hand?

As it stands today that is not happening, there is zero coordination and 
people who care about GDB scripts just play catch up. But you raise a 
good point, if we are to do that, then we should be able to target 
C/Rust/Python/whatever, that seems like a bigger undertaking and I am 
not clear whether the kernel community as a whole is looking for 
transitioning over to something like this.

> 
> Maybe this is the case but scripts/gdb doesn't have any documentation in
> there, there's no Documentation/scripts or Documentation/gdb either.
> 
> Can you please include more details on the uses of these files?  Failing
> that, perhaps you could point to any documentation?

See the two commands above, those should give you a good environment to 
play with the various GDB scripts which are all prefix with "lx-".

Thanks!
-- 
Florian

