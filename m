Return-Path: <linux-fsdevel+bounces-41284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B1A2D60C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 13:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E0D3A9A8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF2246346;
	Sat,  8 Feb 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnk4DnjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE9246326;
	Sat,  8 Feb 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739017536; cv=none; b=EUmSc8jrSGDvAA/gmVeNt2tBo/LUB9oMnpwWCNhZ1hC8ZLt9ePzF0urHDFyARGsrae6UC7sDlN8Q5Dk9ZYmBMb6jjucKBa8h/t8HaDB1SESTa4h5gAwf3OmWev4FdtjzyzkZO5Ngtocn0DEfweNjel86Q5IBlCR/EsUPGDs1hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739017536; c=relaxed/simple;
	bh=AadnZ0j7VcIZfdYKH0NEkcDMx/JDq/nGC7nAGgB0Tzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m92oJ8c3qjKlwFodSMp924PK4RldhBE82CrdpF1SInTHcPguvq2xObYJSPkjowsDEmSNvfdWs1hklTQpHHKNPCpjj9ytmAD9dym6cYtImU7gSp66rk/LVrMvm40iSwCdgHbVtQpIOeyXTQZxsCFlhuWAtTcN/8TuCKi8bTUtAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnk4DnjM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5450622b325so296325e87.1;
        Sat, 08 Feb 2025 04:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739017533; x=1739622333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf7UCe2+gJ/ZwuZ0utuOhvytI5Khd0c+ZEq76ketdUc=;
        b=Cnk4DnjMWPjrh84owDDjMi44/X6PXi7+Bm9y6XKP4gXangjCi0Ewt6JyDhtWwqR/9X
         BTFBwZpsfnmTes/iWNH1ojdRF8rq5ZbjPiWl/k3TXnyOd1QO+QCiD92d7RKuKZoPRv0d
         YR9FI/ieIv8lNUoNfWoeUy2HsdQzkH/fPEi6sLNmumXaiS1gb0KP/x+bhK/GE3XCl9oR
         WxnznFbgiT/Cib1B5ajqUrQSeDw4rNyNTseqI/2hggOcco+YBMUDTOdiET1Fg5LQryrv
         KGu8rTMAdu5KmhBoD23ReU0IXgQ/TiACQ0CmuVShPhOw21C5G3bZ6W9Qvtk63NxbIxVA
         0uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739017533; x=1739622333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf7UCe2+gJ/ZwuZ0utuOhvytI5Khd0c+ZEq76ketdUc=;
        b=cXvcU9ct4ZSmFt6HJfbuZSuSyiW0exc2mH/gJPRGiHx609eI9+EmAMwX7C+7uaPZNg
         CKVteZxgFnVD83qXBJs2hNG+6Qo5+maqxKhTfaAR8lWnjDGk0mlkM5pz41wlUBQXPlqb
         UGmaBXtN3XN7rgpLIGIQzfWjjb4bsd0yCADzPyCpRw0XI6yBY0BBKNc2L2VfarGfyG8x
         ZWQ2qBfRfptfPGDLxxRPHZ5qx1Q1+JMOelImdfiBgu7TUnGsSR5V1mxYJKkYQ9QwPqhM
         1i9CJ0EmMSV38grCf2nQHWvgy8qTR67zykcQNFopOb9KFona+n/gZxa1zkAdVxX5C6fC
         IaXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rQ+i7rv14oWqLDzX39JMqIKK3IYo1/DsuBm/Za/DAyjCbVjCTXTx14Xmfom3lh/2AhOEsmf3i0MGlXGf@vger.kernel.org, AJvYcCXhaASxh/iQ6OazskDMFpbZS3j74+4coqdrR80WIyfAv+p2HXu1DUiU7ufiZnIIyMPy+Twio5qXk4urGYI3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn0Ye2J34OGaGEG1F9RkdVWa4LTkMqVvPckRg2tXb8SrILmY1
	eJeKbUzAd66haxyNGZKr5XsxeKT37L8ib6+QaqE8BTfoqBPG4S3y
X-Gm-Gg: ASbGnct9IASYy6AexFNWmnXP7oSF3YuZGf8xMYSfBKXgQ/tJqU0Vi3xOMIcabGLMJVT
	yhInqzJCN00GF64bQ5/jE/qifJ7qEsSNefzBODyMp6O75oFf+vhmsZ6MN7yyh34VFCsh+J61uJy
	ka8HBbdqYq4SrjxWb7QhRDMzfJY9JVYeMvdaTxb62ViPde98kOOl14B39SZRtwQXujIA0sj2CLp
	ujSTmuL+LuhyTowdW6L4OJZnxX2fVSsTBwE45xGsEthS2IV2MkMFC4whFyrMOIvUttIve+aqK6+
	QwEYg+stRVSm2D512X/MQjjSuGQvv72f6ozTPdtj
X-Google-Smtp-Source: AGHT+IEKSXFs+VKuDDwV+S1yCbrtaX4ioZyasHRW6SDx+XrDhvhm7KyK69cSIttc8f/uOAOsSAabZQ==
X-Received: by 2002:a05:6512:3988:b0:545:58e:e543 with SMTP id 2adb3069b0e04-545058ef015mr489528e87.21.1739017532610;
        Sat, 08 Feb 2025 04:25:32 -0800 (PST)
Received: from [10.147.2.13] ([85.206.91.33])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54410554276sm705168e87.67.2025.02.08.04.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 04:25:32 -0800 (PST)
Message-ID: <b39f702c-f1f9-424a-b2d3-38ae8d5e72e7@gmail.com>
Date: Sat, 8 Feb 2025 14:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, Christian Heusel
 <christian@heusel.eu>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
 <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
 <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
 <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
 <CAJnrk1atv4N-BDWnwmESvczJhkayXyQqnLEypkmuJNKBa6gq8A@mail.gmail.com>
 <b828162e-716a-4ccd-95bb-d51e31cea538@bsbernd.com>
Content-Language: en-US, lt
From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Autocrypt: addr=grawity@gmail.com; keydata=
 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
 aETxZy4lQ+jpsbG/q9fvS/sAZA==
In-Reply-To: <b828162e-716a-4ccd-95bb-d51e31cea538@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-08 2:02, Bernd Schubert wrote:
> 
> 
> On 2/7/25 19:40, Joanne Koong wrote:
>> On Fri, Feb 7, 2025 at 3:16 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>
>>>
>>>
>>> On 2/7/25 11:55, Vlastimil Babka wrote:
>>>> On 2/7/25 11:43, Miklos Szeredi wrote:
>>>>> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>
>>>>>> Could be a use-after free of the page, which sets PG_lru again. The list
>>>>>> corruptions in __rmqueue_pcplist also suggest some page manipulation after
>>>>>> free. The -1 refcount suggests somebody was using the page while it was
>>>>>> freed due to refcount dropping to 0 and then did a put_page()?
>>>>>
>>>>> Can you suggest any debug options that could help pinpoint the offender?
>>>>
>>>> CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch the
>>>> underflow (modulo a tiny race window where it wouldn't). Worth trying.
>>>
>>> I typically run all of my tests with these options enabled
>>>
>>> https://github.com/bsbernd/tiny-qemu-virtio-kernel-config
>>>
>>>
>>> If Christian or Mantas could tell me what I need to install and run, I
>>> could probably quickly give it a try.
>>>
>>
>> Copying/pasting from [1], these are the repro steps that's listed:
>>
>> 1) Install Bottles: flatpak install flathub com.usebottles.bottles
>> 2) Open Bottles and create a bottle
>> 3) In a terminal open the kernel log using dmesg/journalctl in follow mode
>> 4) Once the bottle has been initialized, open it, select "Run
>> Executable" and point it at any Windows executable
>> Note that at that same moment a BUG: Bad page state in process fuse
>> mainloop error message will appear and the system will become
>> unresponsive (keyboard and mouse might still work but you'll be unable
>> to actually do anything, open or close any application, or even reboot
>> or shutdown; you are able to ping the device and initiate an SSH
>> connection but all it does is just display the banner)
>>
> 
> Thanks Joanne! Hmm, I found "wmplayer" in a c drive, but there doesn't
> happen much
> 
>     5241 pts/0    Ss     0:00 -bash
>     5317 pts/1    S+     0:00 /home/bernd/.var/app/com.usebottles.bottles/data/bottles/runners/soda-9.0-1/bin/wi
>     5319 ?        Ss     0:01 /home/bernd/.var/app/com.usebottles.bottles/data/bottles/runners/soda-9.0-1/bin/wi
>     5321 pts/1    S+     0:01 C:\windows\system32\wineboot.exe --init
>     5345 ?        Ssl    0:01 C:\windows\system32\services.exe
>     5348 ?        Ssl    0:00 C:\windows\system32\winedevice.exe
>     5359 ?        Ssl    0:01 C:\windows\system32\winedevice.exe
>     5360 ?        I      0:00 [kworker/u130:0-rpciod]
> 
> It runs it, but no system issue. I had also tried "Obfuscate", but didn't
> manage to feed it a file - it runs in the sandbox and no access to
> my $HOME.

That is the point -- the bug is triggered by using Flatpak's FUSE-based 
"sandboxed file access" mechanism. The sandboxed app is supposed to ask 
'xdg-desktop-portal' to give it some file, which then lets you select a 
file and exposes it through its FUSE mount inside the sandbox (which is 
also visible at /run/user/1000/doc outside the sandbox).

So the specific app probably doesn't matter, as long as it *is* in fact 
sandboxed without direct access to your $HOME, and as long as you have 
xdg-desktop-portal installed.

I had suggested "Obfuscate" both because it was what originally led to 
the crash in my case, and because it's a fairly basic app where opening 
a file happens to be step 1 of its usual workflow so it's quick to test. 
Other similar ones might be:
https://flathub.org/apps/com.belmoussaoui.ashpd.demo ("File chooser")

The actual FUSE code is at:
https://github.com/flatpak/xdg-desktop-portal/blob/main/document-portal/document-portal-fuse.c#L2041

I guess any other filesystem that relies on libfuse's direct splice 
support would also be able to repro? I don't know if there are any.

