Return-Path: <linux-fsdevel+bounces-58852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D1B32196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F18B1BA8A1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33D31814C;
	Fri, 22 Aug 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lEnDPnG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A373D76;
	Fri, 22 Aug 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884367; cv=none; b=TXQisunZNjyU75jcOSO49tgBr4IlOfNoYKhvj5XADU2O7sGJtJ7F+P23JTM0ZTfBnGYhqnyXXQh0LDRdWH6UlcJuJuq8lD7FOz43W9lWv8afg5xmj6XHNtY06CQWuCT0eD9p8n8x7gSm5lI+1FUwGCs04Pdb6n2mV4nuWQ9nZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884367; c=relaxed/simple;
	bh=dWMRT0QE1bmEABLuxeUnZ1c6/L5TsIDzUSpqsEJPAHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swHaobhch4DU/dW3SE+4ofVueq9A+x4hOrwla5zFctcnZRbI2ojJ8yoqbdRrl+ZWBQzrAknWR2y9j7JbbqYN0vMn5Lk6G3BEioWZAtzjZwPZKMRdvLXv6jJCA1avDkL3deElY5gmImSpLIihwlqesl3kOCKtXu98w3BcAAJDT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lEnDPnG3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RwFxUebRFfqFsAgA+uxsppQf6Cb9kI/rJOWmtbFU+NQ=; b=lEnDPnG3djFiMDDg2SZeL0jBUc
	nUeLZEQ73Q6lRFbKhpgp4RboukkO21ppU6m0+DlcLshW6re/QxoysswgZFV15tWV7y3DJbiNNeq0+
	8B5Y7erc99ucDQggXVyrB7tBho5oEpc3vLwRDNiwJmI8dHfr7PQDfXwYZ3sPXXpJS1zZL0FzdxkPF
	VbqSVbqqX5tkIo2RAagsO+8TGrOus4q7QyWL9S9/eGUg1qftXpfvp5vEkuacQhbvu3ycCr4Oln8v8
	N++Np3p/bU4RhUWCVts8JBx8G4BBhvIZL6+bX21IS/Q91cS5mHO63cdAcqhs6Lz4yhUOkof91Rrew
	7Cj72+Wg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upVjT-000Cso-Bd; Fri, 22 Aug 2025 19:39:19 +0200
Message-ID: <3ed1275e-fc10-450c-8cbf-422e28a7d5a9@igalia.com>
Date: Fri, 22 Aug 2025 14:39:13 -0300
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
 <5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com>
 <CAOQ4uxiOYFf_qUZAwCZ2DO0qemUdAbOWyUD2+oqewVPGn2+0cw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxiOYFf_qUZAwCZ2DO0qemUdAbOWyUD2+oqewVPGn2+0cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 22/08/2025 14:21, Amir Goldstein escreveu:
> On Fri, Aug 22, 2025 at 4:16 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Em 17/08/2025 12:03, Amir Goldstein escreveu:
>>> On Fri, Aug 15, 2025 at 3:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>
>>>> On Fri, Aug 15, 2025 at 3:34 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>>>
>>>>> Hi Amir,
>>>>>
>>>>> On 8/14/25 21:06, Amir Goldstein wrote:
>>>>>> On Thu, Aug 14, 2025 at 7:30 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>>>>> Em 14/08/2025 14:22, André Almeida escreveu:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> We would like to support the usage of casefold layers with overlayfs to
>>>>>>>> be used with container tools. This use case requires a simple setup,
>>>>>>>> where every layer will have the same encoding setting (i.e. Unicode
>>>>>>>> version and flags), using one upper and one lower layer.
>>>>>>>>
>>>>>>> Amir,
>>>>>>>
>>>>>>> I tried to run your xfstest for casefolded ovl[1] but I can see that it
>>>>>>> still requires some work. I tried to fix some of the TODO's but I didn't
>>>>>>> managed to mkfs the base fs with casefold enabled...
>>>>>> When you write mkfs the base fs, I suspect that you are running
>>>>>> check -overlay or something.
>>>>>>
>>>>>> This is not how this test should be run.
>>>>>> It should run as a normal test on ext4 or any other fs  that supports casefold.
>>>>>>
>>>>>> When you run check -g casefold, the generic test generic/556 will
>>>>>> be run if the test fs supports casefold (e.g. ext4).
>>>>>>
>>>>>> The new added test belongs to the same group and should run
>>>>>> if you run check -g casefold if the test fs supports casefold (e.g. ext4).
>>>>>>
>>>>> I see, I used `check -overlay` indeed, thanks!
>>>>>
>>>>
>>>> Yeh that's a bit confusing I'll admit.
>>>> It's an overlayfs test that "does not run on overlayfs"
>>>> but requires extra overlayfs:
>>>>
>>>> _exclude_fs overlay
>>>> _require_extra_fs overlay
>>>>
>>>> Because it does the overlayfs mount itself.
>>>> That's the easiest way to test features (e.g. casefold) in basefs
>>>>
>>>
>>> I tried to run the new test, which is able to mount an overlayfs
>>> with layers with disabled casefolding with kernel 6.17-rc1.
>>>
>>> It does not even succeed in passing this simple test with
>>> your patches, so something is clearly off.
>>
>> Apart from the other changes I had done for v6, I also had to change the
>> test itself. The directories need to be empty to set the +F attribute,
>> so I had to do this change:
> 
> Nice, so I suppose this test is passing with v6. I will try it.
> Can you help to complete the TODO:
> 

Yes, I will handle that next week.

Thanks!

