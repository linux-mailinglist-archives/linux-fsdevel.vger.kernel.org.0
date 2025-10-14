Return-Path: <linux-fsdevel+bounces-64154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9CBDADCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990214E43C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1E305064;
	Tue, 14 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="R+m9gWEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFD35948;
	Tue, 14 Oct 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464543; cv=none; b=et3TB2BOSzO3sx12714/cSp+rsq2tBhqPIlseH8sCak1q8DL6p2gPTWQpDjbivZ4wezLOMqf5qA3Wahu/Pi2T6soucAwqvHU7Gfat9jhznxCrf60O3EFIkY8Pl/aXKGgpoY0/1C72SvTimVZjVTXQtBUByDGDwxK6v5Hh+GammI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464543; c=relaxed/simple;
	bh=w9lq0KnLFNIDgiTvkM+Pij2QV2uCURRntZPgdwRl5m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmTPtsB49Io42D5C5FXMpqkMhEVzz+W3mHgK1SQt5ee9dCoOq+jWk/+0Y7emuFPSjhgckWeNrTTT63d7xSMQM3Xb7bYycTyUerKaa2j2yOOB5uEaA6BLtfzET0NSSyB9UFgmURNBsh/qbz+3RpztEd2SclwaQQmYmd5FMPc6mIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=R+m9gWEi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kcF99RvVevWpvf4WCT72mVaNQKgwyrkDXLpeNGpD5kg=; b=R+m9gWEi0Nn8rAb7yWe0PaRTtB
	f85QE2WLXthtqq3Uc3G5W/qapMCt2p7vcUchJErTP+6vl4n8H6HTDGZbJ7dnfKa8WKaPO+VdOW/l8
	X5e5KeMZApYehjQ0prU4DGiQAMn9nx1wB8OtxgopSt7FCSKUdQjYCkuSK3hIwRGCBLeQASlqwZrVU
	OyGXU+x/EeB99BYOlM8Oc3x8r9RdZF5kEJzJ/eOnMzf/HKt5W8XeWhK+yCBcsIuRCq9qm77Mpk3qv
	uW9ZvkhRRjSw1r+lGSmcYa2GIPada5x8yCJtlu+dYMNvq9gH+b4NwUBeIhPVT14xZw2JoRaxhF+cR
	Yer7sIHg==;
Received: from [168.121.99.42] (helo=[192.168.1.10])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8jF7-009XUi-QB; Tue, 14 Oct 2025 19:55:26 +0200
Message-ID: <2c0ebf78-d98a-4013-a54a-c528e06f7e9f@igalia.com>
Date: Tue, 14 Oct 2025 14:55:20 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
 <fe7201ac-e066-4ac5-8fa1-8c470195248b@suse.com>
 <20251014174032.GC13776@suse.cz>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251014174032.GC13776@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 14:40, David Sterba wrote:
> On Tue, Oct 14, 2025 at 03:43:54PM +1030, Qu Wenruo wrote:
>> 在 2025/10/14 15:09, Christoph Hellwig 写道:
>>> On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
>>>> Some filesystem have non-persistent UUIDs, that can change between
>>>> mounting, even if the filesystem is not modified. To prevent
>>>> false-positives when mounting overlayfs with index enabled, use the fsid
>>>> reported from statfs that is persistent across mounts.
>>> Please fix btrfs to not change uuids, as that completely defeats the
>>> point of uuids.
>>>
>> That is the temp-fsid feature from Anand, introduced by commit
>> a5b8a5f9f835 ("btrfs: support cloned-device mount capability").
>>
>> I'm not 100% sure if it's really that important to support mounting
>> cloned devices in the first place, as LVM will reject activating any LVs
>> if there is even conflicting VGs names, not to mention conflicting UUIDs.
>>
>> If temp-fsid is causing problems with overlayfs, I'm happy to remove it,
>> as this really looks like a niche that no one is asking.
> What do you mean no one asking?  This was specifically asked for by
> Steam to do A/B root partition mounts for recovery. It is a niche use
> case but it has its users.
That's right, I've come across the issue reported here while working 
with SteamOS partitions, so it's being used. The original thread for 
this feature has more information about the use case: 
https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/ 


