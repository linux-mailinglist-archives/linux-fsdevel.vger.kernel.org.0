Return-Path: <linux-fsdevel+bounces-53202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD6AEBCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477701C603BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D92EA160;
	Fri, 27 Jun 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H4dCPw8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE82E9EC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040602; cv=none; b=MfNnmMXlmoKyTLuYbGn1FQuVZqqz4vcdQT6bFCU42dEN0e+8pVMfoznSGrw8IDOuNxvGm4rPaGbGBXufGbnSUnDkejI/Bfv2oXcLmjO8w0/S3hAoOakmQRBVIKCD3u0nZ8qY4wFUOsMzPMa1Vo0gT6Jo1c2AIkcXyyX7DDbXcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040602; c=relaxed/simple;
	bh=IH2+O5cU6bMl3dQgfqyetZYxS7jXnkdNLnvW+qxsQ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTHkvq7uXjr0bZWdANqDE39zKlkOSiyzoKnTuwF3hzELjXIS/xxGK1UQSezJInHOb9BhAUxPMHGVLMXFvoBcsVMZAVRvp3klySPezvkCR/X2/nP8s6SG79MQZNeNJRtznFLUe2QDle49L1aWM4hK/L8RsymEsobuJvvm1k7orhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H4dCPw8k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2840605b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751040600; x=1751645400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6tajG5R3MCsrP/w0wwPMIBf3LF9dc2Wm7Uf1cjFJKdc=;
        b=H4dCPw8kainQkV3U88q1ykgWUxcyaUhGqNx70wITre5B9Uqg0J5ACangeMO0rF8x6v
         I86lecQmRle0IXAfhBiPjb3MOiHCqYYTthU4m0LlPGixC1QoSv64F+UuBk7yeSTdgtsy
         2VaZFR3XhvRA9jigy235+wgd3/xBOuEZOA5KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040600; x=1751645400;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tajG5R3MCsrP/w0wwPMIBf3LF9dc2Wm7Uf1cjFJKdc=;
        b=N9gHy9HVak/OvzeQVtES2OWPIWRrr0mnGEtYm5Rb+a1MhbVZYANluzLow71eACmfTk
         da40PvcRvolJ6sApHhGjwwFQeO1ODFsUdIuWsh3dEL6qFfI6vbdLRGxGLqajgVFqB6F9
         u83NbwUtHpSSpBZKcO3VllDYWMTTyJ+AUBfwdFsoU1MzO3fzpZLObN7uQ77pmNJMw/R1
         bDURQOb6uB/PqAHBit69LeGkjXgRtyO7u82MlhvDMLWpg1rW3QbnEK7A2RgHkfdKn7PO
         zuU3AwP1W6O1Ab33DkJ55mJu8sWtPC+G8Rm1+bNQ6zKu5XCqEu1EYMYyRGjk+YP+Rg7j
         lbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdX5gOqzahPAvDurzgGY1lCAk+N8K/xDy8Uu/p80Kznnr/31Zzw2N+TdILaZzcVHtQlqhJgz7DmoEwU19J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EpWe78fIj5BEet5N7wtgnIpUZVpPoIjUqeL+2Ngpmq0azWn1
	VH/LaIz2u0xAWolzPCZPUtBVLDKE9ytwxvlHwebZmsFWG86mWgv9EnZDtH/1gpKBWg==
X-Gm-Gg: ASbGncu/+iybhdLo7GgY3XL5q1lSaWaHtqU9/FZIHB6m8IhEPfm1aJENcHn1plFAsvg
	nhTABXW39JgKJwnJJD+62Y9WbBwVeQoWkN4y8ht+huHYtKmgx8ozLy8jYh+Mjzka39CZIu+DY4+
	39lxI8y1D06DVgbBY6Pchu44VBV14NMzNLiriUgKAoxzq6xD2Y477tCL8SoJJkxdHKBndwqIVjb
	tvse4CP/dZZEbhUKToPw/ZnbFSHDaWMQAie48a6HLM/SHy5STvRG+WXiXjNoE+Hjnb2Hql9HXS+
	2R9Kjtb/LAsC8bIT/QYmenH4M7r2GPMAdsmrddWmr3iDu2j1Ghyz+Or0zgSe0+8LqLBOGkWHqen
	sCb9Wo7emwZpQkSOKgIKouRudpg==
X-Google-Smtp-Source: AGHT+IGphu6TPIxsadsg8AJvhSvpk9h0/WSLUUO4UG0XTFbdDPP5hlzrX20zsMC3uarGOiW78rocGg==
X-Received: by 2002:a17:902:f709:b0:235:779:edea with SMTP id d9443c01a7336-23ac465d24fmr64232725ad.38.1751040599657;
        Fri, 27 Jun 2025 09:09:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1b3esm18966805ad.35.2025.06.27.09.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:09:58 -0700 (PDT)
Message-ID: <cc36310a-c390-42f0-9c82-5b0236a9abfa@broadcom.com>
Date: Fri, 27 Jun 2025 09:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their
 relevant subsystems
To: Jan Kara <jack@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
 Christian Brauner <brauner@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
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
 <c66deb8f-774e-4981-accf-4f507943e08c@broadcom.com>
 <iup2plrwgkxlnywm3imd2ctkbqzkckn4t3ho56kq4y4ykgzvbk@cefy6hl7yu6c>
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
In-Reply-To: <iup2plrwgkxlnywm3imd2ctkbqzkckn4t3ho56kq4y4ykgzvbk@cefy6hl7yu6c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 00:55, Jan Kara wrote:
> On Thu 26-06-25 09:39:36, Florian Fainelli wrote:
>> On 6/26/25 09:17, Liam R. Howlett wrote:
>>> * Florian Fainelli <florian.fainelli@broadcom.com> [250625 19:13]:
>>>> Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
>>>> that provide OS awareness for debuggers and allows for debugging of a
>>>> variety of data structures (lists, timers, radix tree, mapletree, etc.)
>>>> as well as subsystems (clocks, devices, classes, busses, etc.).
>>>>
>>>> These scripts are typically maintained in isolation from the subsystem
>>>> that they parse the data structures and symbols of, which can lead to
>>>> people playing catch up with fixing bugs or updating the script to work
>>>> with updates made to the internal APIs/objects etc. Here are some
>>>> recents examples:
>>>>
>>>> https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
>>>> https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
>>>> https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/
>>>>
>>>> This patch series is intentionally split such that each subsystem
>>>> maintainer can decide whether to accept the extra
>>>> review/maintenance/guidance that can be offered when GDB scripts are
>>>> being updated or added.
>>>
>>> I don't see why you think it was okay to propose this in the way you
>>> have gone about it.  Looking at the mailing list, you've been around for
>>> a while.
>>
>> This should probably have been posted as RFC rather than PATCH, but as I
>> indicate in the cover letter this is broken down to allow maintainers like
>> yourself to accept/reject
>>
>>>
>>> The file you are telling me about seems to be extremely new and I needed
>>> to pull akpm/mm-new to discover where it came from.. because you never
>>> Cc'ed me on the file you are asking me to own.
>>
>> Yes, that file is very new indeed, and my bad for not copying you on it.
>>
>> I was not planning on burning an entire day worth of work to transition the
>> GDB scripts dumping the interrupt tree away from a radix tree to a maple
>> tree. All of which happens with the author of that conversion having
>> absolutely no idea that broke anything in the tree because very few people
>> know about the Python GDB scripts that Linux has. It is not pleasant to be
>> playing catch when it would have take maybe an extra couple hours for
>> someone intimately familiar with the maple tree to come up with a suitable
>> implementation replacement for mtree_load().
>>
>> So having done it felt like there is a maintenance void that needs to be
>> filled, hence this patch set.
> 
> I can see that it takes a lot of time to do a major update of a gdb
> debugging script after some refactoring like this. OTOH mandating some gdb
> scripts update is adding non-trivial amount of work to changes that are
> already hard enough to do as is. 

This really should have been posted as RFC, because I can see how 
posting this as PATCH would be seen as coercing maintainers into taking 
those GDB scripts under their umbrella.

> And the obvious question is what is the
> value? I've personally never used these gdb scripts and never felt a strong
> need for something like that. People have various debugging aids (like BPF
> scripts, gdb scripts, there's crash tool and drgn, and many more) lying
> around. 

Those are valuable tools in the tool box, but GDB scripts can work when 
your only debug tool accessible is JTAG for instance, I appreciate this 
is typically miles away from what most of the kernel community does, but 
this is quite typical and common in embedded systems. When you operate 
in that environment, having a decent amount of debugger awareness of 
what is being debugged is immensely valuable in saving time.

> I'm personally of an opinion that it is not a responsibility of
> the person doing refactoring to make life easier for them or even fixing
> them and I don't think that the fact that some debug aid is under
> scripts/gdb/ directory is making it more special. 

That is really the question that I am trying to get answered with this 
patch series. IMHO as a subsystem maintainer it is not fair to be 
completely oblivious to scripts that live in the source tree, even if 
you are not aware of those.

 > So at least as far as I'm> concerned (VFS, fsnotify and other 
filesystem related stuff) I don't plan
> on requiring updates to gdb scripts from people doing changes or otherwise
> actively maintain them.

vfs.py script is beyond trivial, the largest and most complicated IMHO 
is mapletree.py which had to be recently developed to continue to 
support parsing the interrupt descriptor tree in the kernel, I can 
maintain that one now that I know a lot more than I ever wished I knew 
about maple trees. So really the burden is not as big as it may seem but 
it's fair not to be taking on more work as a maintainer, I get that.

Thanks for your feedback!
-- 
Florian

