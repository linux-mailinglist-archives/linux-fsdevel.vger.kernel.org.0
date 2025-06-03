Return-Path: <linux-fsdevel+bounces-50422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60897ACC04B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1101172E20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72721B9C9;
	Tue,  3 Jun 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD3lF8ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D914A1E;
	Tue,  3 Jun 2025 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932715; cv=none; b=H0Tk//N6fXEjFlx4XBpuF72t/NvfzrpW+IByB0Sg8qAYte5Oxlaz/dMjVQyiWCa+oFXLpE+xvIipf1NfENrgr/YPzVT/sD7AIoB0d3td00nsc9WuqSBp7WuQYxuD/Mddn7MMjcisQf0tlwAPML98FfTTowgOi7uHA6hhP22StqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932715; c=relaxed/simple;
	bh=vELbicKQti/njJbXFpgzvQuo6tUiyIyokgi26yVHlgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaDquS/B7gedfCI+kKaM6r0805/DG9ajfVnauNS6gMSd9z5gISIbm6/NedvyQJKJ7seZtpXQM5DB7919opuDAx94v3PMtK+5OkfNBUk4K4tRYgRGgJml7DdS0DiJiDCwf06FU9K75KDt/F/iZnqITtZu3flDSgmY6c4bf+xaL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD3lF8ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED31EC4CEEF;
	Tue,  3 Jun 2025 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748932715;
	bh=vELbicKQti/njJbXFpgzvQuo6tUiyIyokgi26yVHlgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZD3lF8obNluXo9gAt6837c9auyvM603SqNth7BfUUFMpwu4MHNqNGJzWFrJWv+zXK
	 J1rA0qGMH+zIlZQD2AcToZ4gSIXUJ19rv3G3R0JTPa+CK/3Os2KgWpjUF8+GecjkqJ
	 jknjBLAwAGFK76wD6RvPLsGppbeVV/30P1oOJFDx8xR1YcuT+SMXB2s1ObltR8vsdj
	 iv8YNpcU1Hl33XCDKjHHaNH1F3YgDS1FrOWXZMMpKhyoP+nrzlwLHSOFK3VI1TNOiq
	 eGI9tl0ZpjRz57/ItzDAfmwhzoGm5PiQwcfgaA4BbzzFoZKWjnXvK5Hy7ZrvhwzVW2
	 3N7T0aUhqDqYA==
Message-ID: <26d6d164-5acd-4f85-a7ac-d01f44fb5a87@kernel.org>
Date: Tue, 3 Jun 2025 15:36:57 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org,
 linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
 <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
 <aD58p4OpY0QhKl3i@infradead.org>
 <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
 <CALOAHbA_ttJmOejYJ+rrRdzKav_BPtwxuKwCSAf2dwLZJ1UyZQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CALOAHbA_ttJmOejYJ+rrRdzKav_BPtwxuKwCSAf2dwLZJ1UyZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/25 2:54 PM, Yafang Shao wrote:
> On Tue, Jun 3, 2025 at 1:17 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 2025/06/03 13:40, Christoph Hellwig wrote:
>>> On Tue, Jun 03, 2025 at 11:50:58AM +0800, Yafang Shao wrote:
>>>>
>>>> The drive in question is a Western Digital HGST Ultrastar
>>>> HUH721212ALE600 12TB HDD.
>>>> The price information is unavailable to me;-)
>>>
>>> Unless you are doing something funky like setting a crazy CDL policy
>>> it should not randomly fail writes.  Can you post the dmesg including
>>> the sense data that the SCSI code should print in this case?
> 
> Below is an error occurred today,
> 
> [Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
> originator(PL), code(0x08), sub_code(0x0000)

This is PL_LOGINFO_CODE_SATA_NCQ_FAIL_ALL_CMDS_AFTR_ERR, so you got an NCQ
error which blows up the device queue, as usual with SATA.

> [Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1669 FAILED Result:
> hostbyte=DID_SOFT_ERROR driverbyte=DRIVER_OK cmd_age=2s

Hmmm... DID_SOFT_ERROR... Normally, this is an immediate retry as this normally
is used to indicate that a command is a collateral abort due to an NCQ error,
and per ATA spec, that command should be retried. However, the *BAD* thing
about Broadcom HBAs using this is that it increments the command retry counter,
so if a command ends up being retried more than 5 times due to other commands
failing, the command runs out of retries and is failed like this. The command
retry counter should *not* be incremented for NCQ collateral aborts. I tried to
fix this, but it is impossible as we actually do not know if this is a
collateral abort or something else. The HBA events used to handle completion do
not allow differentiation. Waiting on Broadcom to do something about this (the
mpi3mr HBA driver has the same nasty issue).

> [Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 Sense Key :
> Medium Error [current] [descriptor]
> [Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 Add. Sense:
> Unrecovered read error
> [Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 CDB: Read(16)
> 88 00 00 00 00 05 6b 21 0b e8 00 00 00 08 00 00
> [Tue Jun  3 10:02:44 2025] critical medium error, dev sdd, sector
> 23272164328 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2

Here is the culprit causing the collateral aborts. This is a read command
trying to read a dead sector. It fails and causes all the other
"DID_SOFT_ERROR" failures above due to its retries and repeated failures (it
blows up the command queue every time, causing the same commands to be subject
to the collateral abort retries and running out of retries).

> [Tue Jun  3 10:02:49 2025] sdd: writeback error on inode 10741741427,
> offset 54525952, sector 11086521712

So you get also writes being failed, likely due to the same reason (running out
of retries).

> It is SAS HBA.

Yes, a Broadcom HAB. As explained, these have an issue with handling retries of
collateral aborts in the presence of NCQ errors. In your case, the NCQ errors
are due to attempt to read bad sectors, which normally should only result in
EIO errors sent back to the user if the reads are for file data. If the reads
are for FS metadata, the FS likely would go read-only.

But the driver using DID_SOFT_ERROR for retrying commands that where not in
error but aborted due to an NCQ error causes failures because of the invalid
handling of the command retry count. libata does things correctly:

/**
 *      ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
 *      @qc: Command to retry
 *
 *      Indicate to the mid and upper layers that an ATA command
 *      should be retried.  To be used from EH.
 *
 *      SCSI midlayer limits the number of retries to scmd->allowed.
 *      scmd->allowed is incremented for commands which get retried
 *      due to unrelated failures (qc->err_mask is zero).
 */
void ata_eh_qc_retry(struct ata_queued_cmd *qc)
{
        struct scsi_cmnd *scmd = qc->scsicmd;
        if (!qc->err_mask)
                scmd->allowed++;
        __ata_eh_qc_complete(qc);
}

However, for a SAS connected ATA drive, this is not the code used. It is either
the HBA FW handling the retries (transparently to the host), or the HBA uses
the host to resend commands to the drive (which is what mpt3sas does). We
really need to fix that mess as it causes hard-to-debug IO failures that are
really hard to understand unless you know what to look for.

I have yet to come up with a good solution though.

> It is worth noting that this disk has recorded 46560 power-on hours
> (approximately 5.3 years) of operational lifetime.
> 


-- 
Damien Le Moal
Western Digital Research

