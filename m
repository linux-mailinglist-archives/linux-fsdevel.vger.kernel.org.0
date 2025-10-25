Return-Path: <linux-fsdevel+bounces-65620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745F4C08BC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 08:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E0A1B25C3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8472D374F;
	Sat, 25 Oct 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RICL+Pd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DF1F4C92;
	Sat, 25 Oct 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761372192; cv=none; b=X61jRvYGR+cuU4Y1s1WFfc3hCQfxGgD9WPF7Sfa5fNe55FXxQWqdtnOr8AgpT6B4oQUPOhUYJEhb8178lgz6kU+DFYGNa0Cscjdqk/XonhmaqAxAqmnSkdVexuSKlMa3KDs63yTClhI5oaV7oYwyi9rEWHYKgZHgNYdJ5BgS+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761372192; c=relaxed/simple;
	bh=joX0o5Lrl2JShvoKBqYfj933xypiwMqz1lDALZeTrzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN8cBe6tTR4cIH4IJtQ/AfgtowhN7I1SqR/uM06+7XgKn2GptkGFnVaDbpmbI9T3PoRForQsAenK6dKsks5jtwGbngkiJrFYIkrfrptZ/kb5kUSOXIDVfJa+3XLXXPWS2SdEtQzVDkkwjiL4qOpq8Ilqh5uW5l4SHZ196yyMvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RICL+Pd+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fekQSLGB0ovepYdE7QuWcHq2DxkkaAo5JrQRK380pb0=;
	b=RICL+Pd+rFCdO6Xzthl6j3sTcyl4hhQ5xP6OHzyg2XumJXV0riBtcvMF3bsIAU
	LLJW4cBd2mwL+3AwcaDwgahUg5JvMMI6vzpJRYGDMvJUmIX/TQH+gH/kGhvy17jB
	XX044oRqHmB0hytlaUdNmylkEfYHeWZ+cL/6WT4+zSHUg=
Received: from [192.168.3.55] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXAt4MaPxoKdVhBQ--.2431S2;
	Sat, 25 Oct 2025 14:02:52 +0800 (CST)
Message-ID: <788d8763-0c2c-458a-9b0b-a5634e50c029@163.com>
Date: Sat, 25 Oct 2025 14:02:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251025024934.1350492-1-luogf2025@163.com>
 <20251025033601.GJ2441659@ZenIV>
From: GuangFei Luo <luogf2025@163.com>
In-Reply-To: <20251025033601.GJ2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXAt4MaPxoKdVhBQ--.2431S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1fGrW5ZrykAF1fXFyftFb_yoW8ZryDpF
	Wrtw4DCrs7JwsxKry8Zr18u3yFyan5A3W5AFyYqr90y3ZIvFyIqF1IvFWUZas8Gw4Fgr9F
	vF4rGryDua4YgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uca9-UUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/1tbizQTxmWj8V0TUEAAAsi



On 10/25/2025 11:36 AM, Al Viro wrote:
> On Sat, Oct 25, 2025 at 10:49:34AM +0800, GuangFei Luo wrote:
>
>> @@ -4427,6 +4427,7 @@ SYSCALL_DEFINE5(move_mount,
>>   {
>>   	struct path to_path __free(path_put) = {};
>>   	struct path from_path __free(path_put) = {};
>> +	struct path path __free(path_put) = {};
>>   	struct filename *to_name __free(putname) = NULL;
>>   	struct filename *from_name __free(putname) = NULL;
>>   	unsigned int lflags, uflags;
>> @@ -4472,6 +4473,14 @@ SYSCALL_DEFINE5(move_mount,
>>   			return ret;
>>   	}
>>   
>> +	ret = user_path_at(AT_FDCWD, to_pathname, LOOKUP_FOLLOW, &path);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Refuse the same filesystem on the same mount point */
>> +	if (path.mnt->mnt_sb == to_path.mnt->mnt_sb && path_mounted(&path))
>> +		return -EBUSY;
> Races galore:
> 	* who said that string pointed to by to_pathname will remain
> the same bothe for user_path_at() and getname_maybe_null()?
> 	* assuming it is not changed, who said that it will resolve
> to the same location the second time around?
> 	* not a race but... the fact that to_dfd does not affect anything
> in that check looks odd, doesn't it?  And if you try to pass it instead
> of AT_FDCWD... who said that descriptor will correspond to the same
> opened file for both?
>
> Besides... assuming that nothing's changing under you, your test is basically
> "we are not moving anything on top of existing mountpoint" - both path and
> to_path come from resolving to_pathname, after all.  It doesn't depend upon
> the thing you are asked to move over there - the check is done before you
> even look at from_pathname.
>
> What's more, you are breaking the case of mount --move, which had never had
> that constraint of plain mount.  Same for mount --bind, for that matter.
>
> I agree that it's a regression in mount(8) conversion to new API, but this
> is not a fix.
Thanks for the review. Perhaps fixing this in |move_mount| isn't the 
best approach, and I don’t have a good solution yet.


