Return-Path: <linux-fsdevel+bounces-9059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32983DA80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF11C2033F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB31B805;
	Fri, 26 Jan 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="j/67QaIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96D1B599;
	Fri, 26 Jan 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274292; cv=none; b=psccPu/0FrfVhwgKcR+Ov6oXAiu5f9pINLdKJIiqqnOgDYbXVyv81OPNlo1YzBLKfx3/tK+n6pNEEiTRxK0CztS/eQtPGD4RETcXpHQm7pnKo/e7ahank34ywSjoJviA5mlDJq8LGKy5pk4hUYJciWcB00Z+ENy4yi4dBsyEw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274292; c=relaxed/simple;
	bh=gCq4g1b3O8Oeg4N8ujXRTfw/tL+4gbF4FTm8029MUrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kBhtQlsJnzDEZ8oQE0WjvOyBsw3cttjh1jMs1WJYOx3dBAgtt17vsggQq7gFwcNRow9HBPYpUIx5h1gEEA+jc0taagfA3FKjHJIuhEu8CPEA2gtKyGEerXAnlD84GRyZN1gHYvxqP57tRfD9y1Lx4ghrtfbzkFbTfoWZCpug6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=j/67QaIG; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C7CAC1DA1;
	Fri, 26 Jan 2024 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706273447;
	bh=9EfuMGzeWNG4VV/qzBMKHVckt4mYsHngjUttdA846ZA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j/67QaIGKRoxhLEOdLCQfd7Q7ZvtuN+BJhpzpy7NVZFbr27ajjfS2OIviyErZWDEU
	 G+99jEC7OP9wVCjSO9Q4SbjRXkDayos1TOgk4DZjwvHe8UrKQ5fKFkrD2NvOnG990Y
	 cm/c0w8vIflwmAiosbQIhfTXfpkTYOFqRgg0NvqA=
Received: from [192.168.211.144] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Jan 2024 15:57:36 +0300
Message-ID: <97660d80-fbea-4eb8-83af-78f59a6302c7@paragon-software.com>
Date: Fri, 26 Jan 2024 15:57:35 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regressions] ntfs3: empty file on update without forced cache
 drop
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
CC: <ntfs3@lists.linux.dev>, Kari Argillander
	<kari.argillander@stargateuniverse.net>, Linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Anton
 Altaparmakov <anton@tuxera.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
References: <138ed123-0f84-4d7a-8a17-67fe2418cf29@leemhuis.info>
 <24aa7a8b-40ed-449b-a722-df4abf65f114@leemhuis.info>
 <d5f4c2d7-0a98-4ff8-9848-a34133199450@leemhuis.info>
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <d5f4c2d7-0a98-4ff8-9848-a34133199450@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 21.01.2024 12:14, Thorsten Leemhuis wrote:
> On 05.12.23 13:49, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [adding a bunch of people and two lists to the recipients, as Konstantin
>> apparently hasn't sent any mail to any lists archived on lore for ~six
>> weeks; maybe someone knows what's up or is willing to help out]
> [CCing Linus now as well]
>
> JFYI for the VFS maintainers and everyone else who might care:
>
> Konstantin afaics still did not look into below regression. Neither did
> anyone else afaics.
>
> But Konstantin is still around, as he recently showed up to post a patch
> for review:
> https://lore.kernel.org/all/667a5bc4-8cb5-47ce-a7f1-749479b25bec@paragon-software.com/
>
> I replied to it in the hope of catch his attention and make him look at
> this regression, but that did not work out.
>
> So it seems we sadly are kinda stuck here. :-/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
>> On 27.11.23 07:18, Thorsten Leemhuis wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>
>>> Konstantin, I noticed a regression report in bugzilla.kernel.org.
>>> Apparently it's cause by a change of yours.
>>>
>>> As many (most?) kernel developers don't keep an eye on bugzilla, I
>>> decided to forward it by mail. Note, you have to use bugzilla to reach
>>> the reporter, as I sadly[1] can not CCed them in mails like this.
>>>
>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218180 :
>> Konstantin, are you still around? Would be great if you could look into
>> this regression, as this sounds somewhat worrying.
>>
>>>> The problem I am facing is the following:
>>>> 1. I mount an NTFS partition via NTFS3
>>>> 2. I create a file
>>>> 3. I write to the file
>>>> 4. The file is empty
>>>> 5. I remount the partition
>>>> 6. The file has the changes I made before the remount
>>>>
>>>> I can avoid the remount by doing:
>>>> sudo sysctl vm.drop_caches=3
>>> See the ticket for more details. It according to the report happens
>>> still happens with 6.7-rc2, but not with 6.1.y. The reporter bisected
>>> the problem to ad26a9c84510af ("fs/ntfs3: Fixing wrong logic in
>>> attr_set_size and ntfs_fallocate") [v6.2-rc1].
>>>
>>> Side note: while briefly checking lore for existing problems caused by
>>> that change I noticed two syzbot reports about it that apparently nobody
>>> looked into:
>>>
>>> https://lore.kernel.org/all/000000000000bdf37505f1a7fc09@google.com/
>>> https://lore.kernel.org/all/00000000000062174006016bc386@google.com/
>>> [...]
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
Hello Thorsten,

I apologize for the horrible delay in responding to the bug. I was able 
to reproduce it in a scenario involving a compressed file. The patch 
will be ready within the next few days (the response in Bugzilla will 
also follow).

Best regards,
Konstantin

