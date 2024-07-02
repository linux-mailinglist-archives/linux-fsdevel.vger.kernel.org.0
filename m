Return-Path: <linux-fsdevel+bounces-22928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7323923CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3581F25F71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6415CD7C;
	Tue,  2 Jul 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FCktr51S";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="jtKEKH4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362C15B152;
	Tue,  2 Jul 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920494; cv=none; b=rkO0UGYNFll2XyBbkJb0XzxYlbyHMece4gV7zJQktIa+3JGOGAQuWLPBmwmkmhf7gFM/MdFt4+F51aI41XdG8utqzw56a/7vV9km1LcO4ED9XuZ5pGHEKCJdd8hNoUItmCdQtOOgJ48Yn9W5Rz4g2w/qCsvAChutveCaYEKUGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920494; c=relaxed/simple;
	bh=XpF7Ovdn2GPQkALgInOtej7RrXCY+KCbZ7EXlTpeWSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oeplTcifxmQf5CZbX4qUkSqrYnZ+CNd38sGY2QG0QST+ycSbk34wveBoRj95c/2/RnlDGNg+5/SUOziYB5waIT+b5kWJ9l/Up6D7bkeCTJzNSJWcL8dWV1fudyfyHM2hX7zKW7n7T9WvUDMfFZcJne92g7G0VG/t0X0kT59cdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FCktr51S; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=jtKEKH4I; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5FE612168;
	Tue,  2 Jul 2024 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719919998;
	bh=FvoWozv7kiGX5kCPeJTR6YhhTOGEpNfWM7pqi1LrdKY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FCktr51SmR4olYGJ2vxwHBcO9KwMO0dynZxEPPwC4TICQrPHkOTp9uyX/e436o/H/
	 FS2BngZMp2ilR77GMkvhC2JtJ6kQlVOIGHVHrWfXSgGoHIdgcYDa38fchFG+dQ8g07
	 CqN5nDgoL4/xrvtjf0DuYH7fkz27aIbNT12VHg8I=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7B7D61D09;
	Tue,  2 Jul 2024 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719920484;
	bh=FvoWozv7kiGX5kCPeJTR6YhhTOGEpNfWM7pqi1LrdKY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jtKEKH4IolMCs3UOtawejZ+BFvpJonwAYywkAZ7FfIcy8hEMni8YtmybQMmQJw+3R
	 0J5ZrJmE8FhZdY6sQkIgk1/kPSNbFldTIwcnyu2GHj7p7BDlndTthxu6d0zUdCqagF
	 VYCZh3Yusvofwdnt/JUZTXc+kyipk3+5IiVT3wiQ=
Received: from [192.168.211.37] (192.168.211.37) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 Jul 2024 14:41:23 +0300
Message-ID: <b41e693f-940b-42a8-8154-1721c7ff13e1@paragon-software.com>
Date: Tue, 2 Jul 2024 14:41:23 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: Fix memory corruption when page_size changes
To: Linux regressions mailing list <regressions@lists.linux.dev>
CC: popcorn mix <popcornmix@gmail.com>, <ntfs3@lists.linux.dev>, Linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240614155437.2063380-1-popcornmix@gmail.com>
 <CAEi1pCSQePMo4X_RvMfYmpxYwmuamhd8=1OXgNCU-N2BBdTXPg@mail.gmail.com>
 <a60fc742-0ad4-498d-b90f-793b9578b843@leemhuis.info>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <a60fc742-0ad4-498d-b90f-793b9578b843@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


On 01.07.2024 15:53, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing a few lists]
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Konstantin, what's the status of this regression report or the patch Dom
> Cobley propsed to fix the issue? From here it looks like it fall through
> the cracks, but I might be missing something.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 14.06.24 18:24, popcorn mix wrote:
>> On Fri, Jun 14, 2024 at 4:55 PM Dom Cobley <popcornmix@gmail.com> wrote:
>>> The kernel panic can be observed when connecting an
>>> ntfs formatted drive that has previously been connected
>>> to a Windows machine to a Raspberry Pi 5, which by defauilt
>>> uses a 16K kernel pagesize.
>> Here are links to some bug reports about the issue:
>> https://github.com/raspberrypi/linux/issues/6036
>> https://forum.libreelec.tv/thread/28620-libreelec-12-0-rpi5-and-ntfs-hdd-problem/?postID=192713#post192713
>> https://forums.raspberrypi.com/viewtopic.php?p=2203090#p2203090
>> https://forums.raspberrypi.com/viewtopic.php?t=367545
>>
>> The common points are it occurs on the (default) 16K pagesize kernel,
>> but switching to 4K pagesize kernel
>> avoids the issue.
>>
>> Issue wasn't present in previous RPiOS LTS kernel (6.1), but is
>> present in current LTS kernel (6.6).
>> Revering to 6.1 kernel avoids the issue.
>>
>> I've confirmed that reverting the commit:
>> 865e7a7700d9 ("fs/ntfs3: Reduce stack usage")
>>
>> avoids the issue.
>>
>> This patch avoids the issue for me, and I'd like confirmation it is correct.
Hello everyone,

I recently accepted this patch with the same fix:
https://lore.kernel.org/ntfs3/20240529064053.2741996-2-chenhuacai@loongson.cn/.

Unfortunately, I don't have an RPi with a pagesize=16K at hand, so I 
can't practically test it.

Regards, Konstantin

