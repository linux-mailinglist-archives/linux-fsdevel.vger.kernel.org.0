Return-Path: <linux-fsdevel+bounces-55977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5AAB1131C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B277D3BB193
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48F2EF290;
	Thu, 24 Jul 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uh0PrygV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42912EE97B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392431; cv=none; b=FxIHkIXz9JgwSjTUvofon9Si0gggKjTYkWyf/fjSQoAxUBv+POoUhEgbrGJXdEmbam0if7JmCNdi1rhz8+nARCBiQ9FHVXwnkMuxVgs5jmqW1luxzfCpZqmkJSyMqBnCmpEUFgi1eDsfrjnmZdm1GA0CaUHdX6ZPJICxlTqfh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392431; c=relaxed/simple;
	bh=9yo7PAzDWZnWGDhWTQcvkkaMcI5yuLUZBspBv87afKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6w1nmBKqwAz6WkiyV29zayUO3KIMZY9b+/b9P2ZQawf04+JvEoMLxHa63PjckHk32IhU+u4o4IXXHXP7gPuzH4xfZEsn1i1anUQYBFRT6o9D9fgGqxZ6lw78wY12KrXFlO4Ky/W3u2jNlejvqYnJ55SzUXtRX9iAG6gS1qLJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uh0PrygV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so20606096d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753392429; x=1753997229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BrQZvefTT8J72h8dUnTdsjaXor2WmZQIMIJXwY4LKOg=;
        b=Uh0PrygVY/mCdTHTcdOUZsaALA/JD4sqRsUhiX0x4u3R38kw44E0b+x+cAZvc/tHud
         40VHZypReravUhnHEGSNk5QrQ/7sSct4InVKwI/MZSGI9sDjCzPnZlUXBbiHSA6SoG6j
         IUP1nF4vqHzKaSuMTaUtJ4FpdWHd0JCcj9vcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392429; x=1753997229;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrQZvefTT8J72h8dUnTdsjaXor2WmZQIMIJXwY4LKOg=;
        b=uKHV6Rtq26BjT1eLH14VC8YC2uhgAUtoe+iHTyLSITKRY56xPrqYo4Kl1z7gAMNOE8
         g28V4qo8lpB2UgZJrv1k/QrLXy0if5T9sdSBU57N9HVxyHfm8iwJNceMGwIQ3anZGQg2
         JUDvzuCxYbPgQoOt78sNm9YuwgoeQIelfuIrhnRlLQMmWJNXY39PvMmG/xsfAjNpHHmt
         ph1THJy5wG4LdanbpE90jFMF0Gsa2w1C4AUC40D85bEx0AvpTekJ2FSHVsUAbYAIrCFV
         9vuy691LlEdyhRbvwyTzYXB7YSHrOcJIlkuFu5LSY3amOyoqXHbG52AK07MRqWAKsD8R
         aB3w==
X-Forwarded-Encrypted: i=1; AJvYcCUUBFdUXlj6btXE8btAKFPK7fJOzMVC4RYfZaYj4Qw5cuYNjMzIUhFPHpoLE9v2w7JMWOZBddXK9UjLF0iQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrZBJnWd9DnGG2xsdqfR3et+TxpxYYjcDkvXSgcEIM+BhojC6
	VGM2jTMNPGJT61BXXmlR/Tv/ygurbRsBtC2PUpwM/rd36fCxPk5Jg20v0Z9qh95y3A==
X-Gm-Gg: ASbGnctiihix68/8ZgOrDWXZEQXohPooSLYB0oVTBsz1A+G+YDjNMkzHG6iRpMN87Fp
	R9w6SvLa0BACLeH1AJrRizFzOB+CxJVJxg4HJQsCeqC4689Ol2FMkZmypK8CEgExm9OmOeOv2EF
	sXvFe5i9wzZgqqIE4OIj5SHCfzAE3/G6vQ+Gk9mc6NpRvGi1pyE/WvjlyhT0/ihdl6IjhPi1kS4
	HqjL9f5Fbm9JENgzc+4kgBkuVkbayDX8UYEamfeTK8RwggiTfEpHRdkrb0jB7q7pl2XcyD1PIzG
	HRZkvx3azbjb2RUrlAgzfV4JNToLhPnTCyE6SlnEbLzXun8AqftVIUekBpuG6Ut+8GGU2E+aJUP
	Lonpj8Fu2wMki5M665qXCN7RAoxUddVBbBBEAcfbTK3mHheDWdzXE4fgvqri99w==
X-Google-Smtp-Source: AGHT+IH/5Hg4SYzXScd2JZ5u442inXbwL+/GXKWv2N03daX9+cThsM2yzxMXOEyM0Xu49jU1K7FUEw==
X-Received: by 2002:a05:6214:c22:b0:706:ea6d:e161 with SMTP id 6a1803df08f44-707007167e0mr108054966d6.32.1753392428572;
        Thu, 24 Jul 2025 14:27:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fc9d5e3sm18704486d6.53.2025.07.24.14.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:27:07 -0700 (PDT)
Message-ID: <f084e692-7fd5-417c-8e49-860c2ce47d33@broadcom.com>
Date: Thu, 24 Jul 2025 14:27:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] MAINTAINERS: Include GDB scripts under MEMORY
 MANAGEMENT entry
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
 <20250625231053.1134589-9-florian.fainelli@broadcom.com>
 <04116d0f-2815-4583-853e-e4295fb3d014@redhat.com>
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
In-Reply-To: <04116d0f-2815-4583-853e-e4295fb3d014@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/25 10:10, David Hildenbrand wrote:
> On 26.06.25 01:10, Florian Fainelli wrote:
>> Include the GDB scripts file under scripts/gdb/linux/ that deal with
>> memory mamagenement code under the MEMORY MANAGEMENT subsystem since
>> they parses internal data structures that depend upon that subsystem.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   MAINTAINERS | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cad5d613cab0..52b37196d024 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15812,6 +15812,10 @@ F:    include/linux/mmu_notifier.h
>>   F:    include/linux/pagewalk.h
>>   F:    include/trace/events/ksm.h
>>   F:    mm/
>> +F:    scripts/gdb/linux/mm.py
>> +F:    scripts/gdb/linux/page_owner.py
>> +F:    scripts/gdb/linux/pgtable.py
>> +F:    scripts/gdb/linux/slab.py
> 
> Probably they should go to the corresponding sub-sections. At least 
> slab.py?
> 

Sounds good, thanks!

-- 
Florian

