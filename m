Return-Path: <linux-fsdevel+bounces-55978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D1B11323
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1324AC104F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30D2EF288;
	Thu, 24 Jul 2025 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SM+lRFo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12D2EE980
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392451; cv=none; b=IciYs6uPgucWJgOONY1ypZDy+05pzSGuiiqfcEMAnLGh8H2fCV7lgXhrRKZ00ytt8Wzva9Vbq+in20NPAAM4TmBhhbOXixebX+1CqIb9bBRzrOeQy9hUA046R/t2RAg98/D1eBfTfC4zT7KnxfKtwBRGoXB8otx5Gf0G9sNXmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392451; c=relaxed/simple;
	bh=wNCd3EJBV8JmYYmxRVMwzijvsmCmObXzyS6voU1YqDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrEKXQzOObiFzKWcTmRSJ/wo8VqlspS3Pg/LYhvk1aM6DMejFkIzBDrmONulcu1SsSXp1FVLGveITu4Loy8KTHKrCfYhcn5PvWxGZLmZaJSb8iZiwt7vF1MdlCOCKkic3O41AgnzaCRO9eTT8sYWNUDYKfvzyDuvFGToFlncd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SM+lRFo7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e346ab52e9so178240885a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753392448; x=1753997248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eb7LwTrwfKZRGwsWl7FQwuOc+LHKc/Q1TZHaaM57R8o=;
        b=SM+lRFo7N1mbFZfA3hHMXOBmBgQhT2Q5Jqm4GiZ7DzeSol+W2X6WyFPGADIx7r+aB5
         1rultwrb5EaOiP11okmK8Ot0hzKrfh3mc5nMW6clw8Lgp4HIRPP4dJSuHhXR2pbUxF+v
         084CeppGGsxQpw9hKcs62wSthkFAkMFGLwKjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392448; x=1753997248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb7LwTrwfKZRGwsWl7FQwuOc+LHKc/Q1TZHaaM57R8o=;
        b=tS2tNbMLJmddOg6z2T0+j2Frpb26qmkeRLjKL/B01JWfqYt6pG8Xa3gPRwKHIhNxtH
         vsyR8XoV9ptX9OqkzB2g0sASyxG43KxufUB4THvzkM0QjLpk4EEsb0mHgrdIOurfhj7G
         wQIFoPSFTzfPxKbS6Y3ip4QhvbhsOp8SFlrEKbMI+XC/c/ABIzilyuUTTF7afQEEsBlS
         ldcDiBHhklyjdOQFnWD7W7ckbij3jRfL2MI6M6nTkWGeFJn0vn7FtdFaUjrI89oOVEhc
         3G6BSBxr2lR8MRIRDh+m141WK81qdzQgVhwewvj95Bk3bgaO1L+3NlsMrQvH8T5UWQR8
         tXig==
X-Forwarded-Encrypted: i=1; AJvYcCUqRozlpp3u/US7vU4yNeOfWFjkWKRU6s2A8kCIYFA1xYXqzFeSwuIae2f77My+EEzHMYG4M9KSmF7zF28W@vger.kernel.org
X-Gm-Message-State: AOJu0Yypp1RXXfyVR6FpvLOEIsRAPiIz+H4bGVHKqvaEQ5m5U69tM/RJ
	sGzyMFBxBDA4Xz0sKdDhIO0o1LCnOxku2pejamW4AIqNtdImo+Mg7vLEi1TcKGhA5A==
X-Gm-Gg: ASbGncuxwQY09PQUMCmrgExN5wKhukn4HML3zSyMntqzDxYfBbDkFNYm9goS6kJdXWL
	8jLOPUtRo6vVgalCKQxNYFA9aHqXJwnGDJQnQT4uoXuZP1VOFehR+3O2+Qj5S/nN/oMIvzN4cbZ
	aOZJuGR4Rj1wR2HZO9yIfyoisKKSHEXJpXD17XXDBKCrIZd+MuLZERMapVmhF8OOoIs9rqfaeBt
	wwHIUNJq9wkreZ1BDnNsT+rcddHp+0cXu7OtXR/bC5CYQ5I02tV2DNYs/6OGenWPw3J1UfKbNqq
	8ntuYfeDyWat603+tnWz/MtPu0sXAH2Sx09lzgc5bK2uEKSx8ajztF391V2mQLYZMI/TsLXDyf/
	fa75qoCtNABWPctkpfCRHLcGfSjbmYQH8w9hB6GF8hkUuJmkpPzQ3bFfiSUZZfzEiUj8RE2tm
X-Google-Smtp-Source: AGHT+IFXe1AUozr/VBWe0gYnK+qQoY2TYFea6yXJGINXUcVKLGT6eNnGYGkrp3ZYYhKBw7J09w5K5w==
X-Received: by 2002:a05:6214:500d:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-7070051b347mr106591216d6.14.1753392447547;
        Thu, 24 Jul 2025 14:27:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070faec0b9sm18388806d6.5.2025.07.24.14.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:27:26 -0700 (PDT)
Message-ID: <136af381-5c31-49dd-98fe-1703a2cd57df@broadcom.com>
Date: Thu, 24 Jul 2025 14:27:20 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] MAINTAINERS: Include dmesg.py under PRINTK entry
To: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
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
 <20250625231053.1134589-13-florian.fainelli@broadcom.com>
 <84v7oic2qx.fsf@jogness.linutronix.de>
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
In-Reply-To: <84v7oic2qx.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 01:43, John Ogness wrote:
> On 2025-06-25, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
>> Include the GDB scripts file under scripts/gdb/linux/dmesg.py under the
>> PRINTK subsystem since it parses internal data structures that depend
>> upon that subsystem.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 224825ddea83..0931440c890b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19982,6 +19982,7 @@ S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>>   F:	include/linux/printk.h
>>   F:	kernel/printk/
>> +F:	scripts/gdb/linux/dmesg.py
> 
> Note that Documentation/admin-guide/kdump/gdbmacros.txt also contains a
> similar macro (dmesg). If something needs fixing in
> scripts/gdb/linux/dmesg.py, it usually needs fixing in
> Documentation/admin-guide/kdump/gdbmacros.txt as well.
> 
> So perhaps while at it, we can also add here:
> 
> F:	Documentation/admin-guide/kdump/gdbmacros.txt

Thanks, v2 coming up.
-- 
Florian

