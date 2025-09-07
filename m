Return-Path: <linux-fsdevel+bounces-60465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E4B48111
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B52D7AE32F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 22:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7472264B0;
	Sun,  7 Sep 2025 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aju54ZaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E31C863B
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284889; cv=none; b=Pl4fzDgac50ZqtkqETAhcgYODRYq5OBuB3U7WF8CEb0f9eEoBMLV+uhuQ64ps1C8jDDj5Fu49ggEksPvhJG71fdVIaYIcnZgeQ6rjZlwfTtcrsNIhzm5rrC+2mEV97nrTlKQEDLmqxFwCGwKISVhTQoK3h2jFiiB3Sps94nQKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284889; c=relaxed/simple;
	bh=n/drI+cMGG5bVmm44g/BahrwI+Nm6w8YZD3H3dpNylQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAxGp4iS/7rZva1ArYGIFKY24XnBFKm4lFAVmHMg6iYpJ3YaK8rGabJ+d64OcBnJjHy+Vh9MouX5fo979JOXWUA6Up0c9Cp3/9FKRLlt0T1MwoVklQtoOt1R6moP6EQWOUdBdGAsgHlHNEhTdwYt3tXDzbbsaSEOjSp62yh9wTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aju54ZaQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so780181f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Sep 2025 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757284886; x=1757889686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hVFLpSueAmA1ouTf41WNMAKcdmyhZBwcWTTBzR0VaHU=;
        b=Aju54ZaQIBL+sURemAu/1oP+QBv7otcdKyEh3UqDDXh2ugbLLsqt5sOmL/sUCLbyq9
         zOC+nua85/AF+sChOERMapDXQ1RUjVj1b2nN4gCa3V5VxwFPax3JN5d5iUxAdY0JaCYq
         JnOLpRhQRSoD/kpoxaXBqVQUUOzxgy+lFZAJdD/djeQKZdP1qOPWxrgOdddEwedJygaM
         L2lCMB1wc1SNJaBblG3oRj2HUo0jBuFnVAm6BfZbI0ebtXWo+3yT/8l8AhmX2fcSEQoq
         QSfhMsMGikz/DsY0c3bdQuz1tTo1RoBk35o91OI1mz1kM8KlR/7DB+BiZOx2DWcLpoOi
         mJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284886; x=1757889686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVFLpSueAmA1ouTf41WNMAKcdmyhZBwcWTTBzR0VaHU=;
        b=EmDZIiXTuL7DKhr0KmmptiWfVKTwqGY/Su4pWbc0yg4SJuLu+sfxvgMRONIAg2EVp7
         Mtdo+KqSBUjrTSiAVakqbENwZyB/0H4bsV4ylfaA0LVIJdlaCNAl5AqKUldewTBgxzCt
         g1ytZBBRtUDlqRYjnxRhh79gz+TAGQtYugo+8BwzFqYooSRzwahB1A+0GNRrG2u/jmzY
         Pwq3MwUZGfvVFOfHIl0bA6m2ZEuX1crbEkmduYMMbTd2PS79wwdDHZmZKfl021T/r4Qp
         z7ZOEpVBfPxj8IurMZern62dKoCg1RUcun81BxBTcmfQ7te+qFmxNWkEKS+g4Y4/PNzX
         L9LA==
X-Forwarded-Encrypted: i=1; AJvYcCUE9fusnQmjj5lHMDMjlEdfGEtIjUctS0ZRzUg4xofNbUQ9Q+JRxl+i3EuDvoquecTFXISYoF7f5LOI/QIg@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYtOcLvMStnkYjRwUI62ODXzwTi8Fzlh56QphgaeAVEraixlv
	LnQtAffe7j6PuAXL1sgDtuW2kkeBQPkdbdhxu7nd74FsQHJ23sN9FtwMUAZ3naju8THozLeWINH
	LupZQ
X-Gm-Gg: ASbGncuPJFD9vJttXpxfY1KMjRnrrE1wZUk6cAQMi7ZjROG7IcN7xMThTehyaRda/co
	ZfbODs3VJ3JAOHKEvtQ8OpJohge4e4ZYCbquXrGtMittuv204zc2AdInYTQwBEmmoltjoYE2WQR
	tNsy5eUvJiATG22Sq0VdYunHfXLM/U+e9yLZZtUZfcq14A2BSoDeEMp5Quaqw8bNNMxeraTNr70
	aDYSCBojCfCIXJ1FK4Yi+KBUF/AGLRL7TX7cYgeuaNLgkRhLxj83B7ciuXeW5ZnSYewiPD6kjBw
	KAojCY5HtdYz7nsxr0b/xP90I9ijMX90VyKk8heVcoO5B7H195sqjp1eKIwQCqoqKPVvEyNotJ7
	2OQB+6xNJuMieazc6VqXfpDE/lh0ARvkoRi9+PqUAZmF/9NdC2toRcyoCQtgQeA==
X-Google-Smtp-Source: AGHT+IEOYfTqBSNVTYIQ9V/rlEDtEfAdMgW8uO9tKr+yaEnvOkmsOpyDzVo2RX0gxi1NXzpCePC35Q==
X-Received: by 2002:a05:6000:2285:b0:3e7:4334:2afe with SMTP id ffacd0b85a97d-3e743342e6cmr2920789f8f.5.1757284885808;
        Sun, 07 Sep 2025 15:41:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b790sm125165205ad.67.2025.09.07.15.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:41:25 -0700 (PDT)
Message-ID: <7981ee42-fc55-4125-a662-60fb18b454c8@suse.com>
Date: Mon, 8 Sep 2025 08:11:19 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression, btrfs mount failure when multiple rescue mount
 options used
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: brauner@kernel.org, dsterba@suse.com, terrelln@fb.com,
 Linux Devel <linux-fsdevel@vger.kernel.org>
References: <e2179aaa-871f-4478-b72c-45f1410dff87@app.fastmail.com>
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
In-Reply-To: <e2179aaa-871f-4478-b72c-45f1410dff87@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/7 09:31, Chris Murphy 写道:
> kernel with mount failures:
> 6.17.0-0.rc4.36.fc43.x86_64
> 6.16.4-200.fc42.x86_64
> 6.15.11-200.fc42.x86_64
> 
> 
> # mount -o ro,rescue=usebackuproot,nologreplay,ibadroots /dev/loop0 /mnt
> mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'nologreplay'.
>         dmesg(1) may have more information after failed mount system call.
> # mount -o ro,rescue=usebackuproot /dev/loop0 /mnt
> # umount /mnt
> # mount -o ro,rescue=usebackuproot,ibadroots /dev/loop0 /mnt
> # mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'ibadroots'.
>         dmesg(1) may have more information after failed mount system call.
> # mount -o ro,rescue=ibadroots /dev/loop0 /mnt
> #
> 
> There are no kernel messages for the failures.
> 
> Looks like single rescue options work, but multiple rescue options separated by comma fail.

It looks like there is no longer combined "rescue=" since 6.8, where we 
switched to the new fsconfig mount method.

And even before that, the separator for "rescue=" command group is ':', 
not ',' as that conflicts with the default separator.

There is no support for using ',' inside "rescue=" from the very beginning.

Thanks,
Qu

> 
> Any rescue option after the first comma, results in an fsconfig complaint.  Since it looks like fsconfig migration fallout, I'll cc some additional folks, and fs-devel.
> 
> ---
> 
> I get different results with kernel 6.14.11-300.fc42.x86_64 but I think some of the bugs are fixed in later kernels hence the different behavior. And in any case it's EOL so I won't test any further back than this kernel.
> 
> # mount -o ro,rescue=usebackuproot,nologreplay,ibadroots /dev/loop0 /mnt
> mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'ibadroots'.
>         dmesg(1) may have more information after failed mount system call.
> 
> Notice the complaint is about ibadroots, not nologreplay. And there is a kernel message this time.
> 
> Sep 06 19:44:38 fnuc.local kernel: BTRFS warning: 'nologreplay' is deprecated, use 'rescue=nologreplay' instead
> 
> 
> But there's more. All of these commands result in mount succeeded, but kernel messages don't indicate they were used.
> 
> # mount -o ro,rescue=ibadroots /dev/loop0 /mnt
> # umount /mnt
> # mount -o ro,rescue=usebackuproot /dev/loop0 /mnt
> # umount /mnt
> # mount -o ro,rescue=nologreplay /dev/loop0 /mnt
> 
> This one has yet another different  outcome, I don't know why.
> 
> # mount -o ro,rescue=idatacsum /dev/loop0 /mnt
> mount: /mnt: fsconfig system call failed: btrfs: Bad value for 'rescue'.
>         dmesg(1) may have more information after failed mount system call.
> 
> 
> 
> --
> Chris Murphy
> 


