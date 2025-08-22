Return-Path: <linux-fsdevel+bounces-58814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28931B31B24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9700A188D852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF2305E3A;
	Fri, 22 Aug 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ORLdTg4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21455303C83;
	Fri, 22 Aug 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872168; cv=none; b=lt/WKzl09ezC0082/XbDm73jTu4IWaHhV4/oDNjJh48Qf7byXmyImcYJecG3AHOUaZa+gwiicOQ/VV7tdOyJ9cqGoUWfRdVUPslicSWjzcyHUc3n6PbXyuH/4LA5HEVdSqp77FgT4Bai/ZTL76J3OVdSu52tc6zaZvVfeKCnAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872168; c=relaxed/simple;
	bh=GjRjHlx+8IVIK4VGLsw3756nQx9Hum+SOnAk0B/KELw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1r3aIAm5IoXTC7xGDOCOAl+Wj98oIOYt8oKU3INiyUJRytGuLJy2nazTDgkyC1CKQ8kuTe0iN9f2KGJTcWgEU2FG6mMa4c4bB/Thm1y2N9l7KGR8agc/FuXWeRkUBeSwWN6vKDSGjTF0X/bNzbT6D0B+JZSANEMl3uLi6T4s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ORLdTg4E; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AB1DTWmFI46rZseB1HIkiwEXCITFFpy1H7xYdXQNU9Y=; b=ORLdTg4Ecy2ssTwjsLqBptIF+9
	Qwo9YCYxp+jyfZb2iDqrSpGP+Kj5dKBUvXgzjpp2N9UPkqOdjTlVh8RjRoB1nmou9NDOZ//SxO74l
	sKP3KdKe1TCgY7BYYvi0BpP8r6KHcly6EBum6doS+DKJoJLYkA3nzcp/w++vJggdNJ5l4HLA3guXZ
	rl7r1edN9foH4gqB+eA8UmYhflQb1UlgU5exHiT9hXslW83p5V3QFPEIcZw3Mkbi4/aplBiHXFWlL
	Nk9nQWyA+wobfKLZKvkecxv75jrDOL3DpayYQ7QaYpPSo42KeH50LPPdukbv9MxDOH5bZlFwBCL1O
	WvCRvqWg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upSYi-0008E8-MV; Fri, 22 Aug 2025 16:16:00 +0200
Message-ID: <5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com>
Date: Fri, 22 Aug 2025 11:15:56 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com>
 <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
 <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com>
 <CAOQ4uxgfKcey301gZRBHf=2YfWmNg5zkj7Bh+DwVwpztMR1uOg@mail.gmail.com>
 <CAOQ4uxjf6S7xX+LiMaxoz7Rg03jU1-4A4o3FZ_Hi8z6EyEc7PQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjf6S7xX+LiMaxoz7Rg03jU1-4A4o3FZ_Hi8z6EyEc7PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/08/2025 12:03, Amir Goldstein escreveu:
> On Fri, Aug 15, 2025 at 3:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Fri, Aug 15, 2025 at 3:34 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>
>>> Hi Amir,
>>>
>>> On 8/14/25 21:06, Amir Goldstein wrote:
>>>> On Thu, Aug 14, 2025 at 7:30 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>>> Em 14/08/2025 14:22, André Almeida escreveu:
>>>>>> Hi all,
>>>>>>
>>>>>> We would like to support the usage of casefold layers with overlayfs to
>>>>>> be used with container tools. This use case requires a simple setup,
>>>>>> where every layer will have the same encoding setting (i.e. Unicode
>>>>>> version and flags), using one upper and one lower layer.
>>>>>>
>>>>> Amir,
>>>>>
>>>>> I tried to run your xfstest for casefolded ovl[1] but I can see that it
>>>>> still requires some work. I tried to fix some of the TODO's but I didn't
>>>>> managed to mkfs the base fs with casefold enabled...
>>>> When you write mkfs the base fs, I suspect that you are running
>>>> check -overlay or something.
>>>>
>>>> This is not how this test should be run.
>>>> It should run as a normal test on ext4 or any other fs  that supports casefold.
>>>>
>>>> When you run check -g casefold, the generic test generic/556 will
>>>> be run if the test fs supports casefold (e.g. ext4).
>>>>
>>>> The new added test belongs to the same group and should run
>>>> if you run check -g casefold if the test fs supports casefold (e.g. ext4).
>>>>
>>> I see, I used `check -overlay` indeed, thanks!
>>>
>>
>> Yeh that's a bit confusing I'll admit.
>> It's an overlayfs test that "does not run on overlayfs"
>> but requires extra overlayfs:
>>
>> _exclude_fs overlay
>> _require_extra_fs overlay
>>
>> Because it does the overlayfs mount itself.
>> That's the easiest way to test features (e.g. casefold) in basefs
>>
> 
> I tried to run the new test, which is able to mount an overlayfs
> with layers with disabled casefolding with kernel 6.17-rc1.
> 
> It does not even succeed in passing this simple test with
> your patches, so something is clearly off.

Apart from the other changes I had done for v6, I also had to change the 
test itself. The directories need to be empty to set the +F attribute, 
so I had to do this change:

--- a/tests/generic/999
+++ b/tests/generic/999
@@ -104,6 +104,9 @@ mount_overlay $lowerdir >>$seqres.full
  ls $merge/casefold/subdir |& _filter_scratch
  unmount_overlay

+# workdir needs to be empty to set casefold attribute
+rm -rf $workdir/*
+
  _casefold_set_attr $upperdir >>$seqres.full
  _casefold_set_attr $workdir >>$seqres.full

@@ -112,7 +115,10 @@ mount_overlay $lowerdir >>$seqres.full 2>&1 && \
         echo "Overlayfs mount with casefold enabled upperdir should 
have failed" && \
         unmount_overlay

+# lowerdir needs to be empty to set casefold attribute
+rm -rf $lowerdir/*
  _casefold_set_attr $lowerdir >>$seqres.full
+mkdir $casefolddir

  # Try to mount an overlay with casefold enabled layers.
  # On kernels older than v6.18 expect failure and skip the rest of the test

> 
>> You should also run check -overlay -g overlay/quick,
>> but that's only to verify your patches did not regress any
>> non-casefolded test.
>>
>>
> 
> My tests also indicate that there are several regressions, so your patches
> must have changed code paths that should not have been changed.
> 
> Thanks,
> Amir.


