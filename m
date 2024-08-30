Return-Path: <linux-fsdevel+bounces-28082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9E96679B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D41F255ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDE91B8E99;
	Fri, 30 Aug 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="UzaEcL7b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBIrl6TN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D967A0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037651; cv=none; b=oKG3BTs8VEf/NpOShdj2MUlod5APPhzSVZPQUQpIuf9jHIIMm1XvUZEeZ52tLMl4Kf3D8XIB20tfcQ+iko5vIl7pYWubybAjSS1LftF7KDzrBCC6y83MnV5uLEwKUWDiEL+Hr3qk4fOI2UAyYtRb+E7kFewi5qT28HT3qxSJtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037651; c=relaxed/simple;
	bh=4s8mbi4lK4juywTmP3drOR1Cf9vaETUdihluR4j5yFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BP11Od/CjRpmCRksl+xJZtz2QWbhrH8Z3ZoOXR2Jw8TMMUPgzm9+hP+zfaLrHg6uhc3k5dPoZWee2vB5SSlyJRmZ5jxc0AtDavCuzcOoTun3gV9PC3bTzgFv7FUtOnZrrBeHo1HW1Izofz5rFxTqrdU0YZKQ+QpltvfR9hEkS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=UzaEcL7b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBIrl6TN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6AE421380195;
	Fri, 30 Aug 2024 13:07:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 13:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725037648;
	 x=1725124048; bh=Rdqy319/qy8mgecu7nilvPFyGIoY+bNoGS92/jVSf10=; b=
	UzaEcL7bA0CheZ7fxD03VTdlK+Mr4xWTZGM/KUyWznjBVtoaJZyp3MqqC8QY3dro
	QY1NomOb0YC9HOZUTU/qUgNwXAgbQILwT4x2CSDy+XjR9reEkTShhClknnsMlVDI
	5uyzXTYnHZS0rzvVxOc56ZhA5wpi15V3gmfilaJHeo+DEyL2I/TptEj4nz/byKtI
	YaxQMZi5Bzs9ZqbIG2HhBxdRyIF0ShqzK2TK1rN3zVwGyZCBh65ObdJtA8pSaFOg
	B6wiFT+pBD8X/6UdYMwXaPvklGhga5zBT66ImG20BqITZqAPrXNELYeQ6Z2UtSQo
	aRUT1I7eChwClyo52PXrHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725037648; x=
	1725124048; bh=Rdqy319/qy8mgecu7nilvPFyGIoY+bNoGS92/jVSf10=; b=t
	BIrl6TNACaSQ9tVhxz/8a3Ff+PAAqSc+q93OzQXY1zsTOVmhfkB3rYHJr9tUrMYd
	7ithOBa162VxYSxCL5ji8QYqIbNRqY11SO5DECgdQCF33gfFWdEpYR2HP6cB9HKA
	t2+10Lw6EImIZksA8Vtzxw70AIQLg9I0ODSMOOjryBw4lWwiRp0xS/AQTUafqGy/
	HeGxY6N2mUvnLkr88CFeTuI+VygWJgLpScR1MUNmO7zSHK70aPsNdRookUnmWerx
	Vl0uex31DPqma9Xp+QfYAcoq13CGHh1r9hpih18YWKqSSEb3DkcLssFK71SyBfUy
	Sko2QYrPW3ee6JtIEEJsg==
X-ME-Sender: <xms:UPzRZlKB1lpMi9kxrU4cICIPZQlpUF-rHle2L-bwymqUd-Y0Ka534w>
    <xme:UPzRZhLYEgEvAMUrwewmcSg3egy5SAjtHFRKzbDxjy5O_qeAgDwdHKSmE3yBubYxz
    5iRUxaZs47VOTd3Suo>
X-ME-Received: <xmr:UPzRZtuDHidjY8ko3TIAvW9H8gNTiqjV6PJAKd4Zu53QeTgkoociO8uozp2wVYN7MW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnheptdduvdduteeugeekiedtfefgteevveeg
    kedttedvhedtieeuieevvddttdffleevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghn
    uggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhhohhnghgsohdvvdeshhhurgifvghirdgtohhm
    pdhrtghpthhtohepjhgrvghgvghukheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    hhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfvdhfshdquggv
    vhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehltgiivghrnhgvrhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UPzRZmZSPM-6A9TQHMjX8xAN7tM-srWcrQN6NKowhaWqnL1iz0l8Qg>
    <xmx:UPzRZsZ9AhXdLvBSO7vVKl-lVz4EmINY-9Y_7h9Ii8Yyma6pjwWdxg>
    <xmx:UPzRZqANflY6g0K8W1Cbw8DAJc2-T8hTrtdEjdXicYsFp1KTlh-S-g>
    <xmx:UPzRZqYeB9Yvjz_JrGZkaXQGhFm2snAukQ_ljkIzteLnjsP-LB0gww>
    <xmx:UPzRZiMZskJa2rdkhaKQciDXSU5b5ztXaBjVtQQzG2ByvagPuOIwfA-V>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 13:07:27 -0400 (EDT)
Message-ID: <5c194e3e-6dc9-41a2-b967-13fc1177b2f4@sandeen.net>
Date: Fri, 30 Aug 2024 12:07:27 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] f2fs: new mount API conversion
To: Hongbo Li <lihongbo22@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, brauner@kernel.org,
 lczerner@redhat.com, linux-fsdevel@vger.kernel.org
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
 <6c1baa6e-5f71-418f-a7fc-27c798e51498@huawei.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <6c1baa6e-5f71-418f-a7fc-27c798e51498@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just FWIW - 

I had missed this thread when I got temporarily unsubscribed from fsdevel.
I have a series that I was hacking on for this same work, at
https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/commit/?h=f2fs-mount-api
but it's very rough and almost certainly contains bugs. It may or may not
be of any help to you, but just FYI.

I'll try to help review/test your series since I tried to solve this as
well, but I never completed the work. :)

Thanks,
-Eric

On 8/27/24 6:47 AM, Hongbo Li wrote:
> Does there exist CI test for f2fs? I can only write the mount test for f2fs refer to tests/ext4/053. And I have tested this in local.
> 
> Thanks,
> Hongbo
> 
> On 2024/8/14 10:39, Hongbo Li wrote:
>> Since many filesystems have done the new mount API conversion,
>> we introduce the new mount API conversion in f2fs.
>>
>> The series can be applied on top of the current mainline tree
>> and the work is based on the patches from Lukas Czerner (has
>> done this in ext4[1]). His patch give me a lot of ideas.
>>
>> Here is a high level description of the patchset:
>>
>> 1. Prepare the f2fs mount parameters required by the new mount
>> API and use it for parsing, while still using the old API to
>> get mount options string. Split the parameter parsing and
>> validation of the parse_options helper into two separate
>> helpers.
>>
>>    f2fs: Add fs parameter specifications for mount options
>>    f2fs: move the option parser into handle_mount_opt
>>    f2fs: move option validation into a separate helper
>>
>> 2. Remove the use of sb/sbi structure of f2fs from all the
>> parsing code, because with the new mount API the parsing is
>> going to be done before we even get the super block. In this
>> part, we introduce f2fs_fs_context to hold the temporary
>> options when parsing. For the simple options check, it has
>> to be done during parsing by using f2fs_fs_context structure.
>> For the check which needs sb/sbi, we do this during super
>> block filling.
>>
>>    f2fs: Allow sbi to be NULL in f2fs_printk
>>    f2fs: Add f2fs_fs_context to record the mount options
>>    f2fs: separate the options parsing and options checking
>>
>> 3. Switch the f2fs to use the new mount API for mount and
>> remount.
>>
>>    f2fs: introduce fs_context_operation structure
>>    f2fs: switch to the new mount api
>>
>> 4. Cleanup the old unused structures and helpers.
>>
>>    f2fs: remove unused structure and functions
>>
>> There is still a potential to do some cleanups and perhaps
>> refactoring. However that can be done later after the conversion
>> to the new mount API which is the main purpose of the patchset.
>>
>> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
>>
>> Hongbo Li (9):
>>    f2fs: Add fs parameter specifications for mount options
>>    f2fs: move the option parser into handle_mount_opt
>>    f2fs: move option validation into a separate helper
>>    f2fs: Allow sbi to be NULL in f2fs_printk
>>    f2fs: Add f2fs_fs_context to record the mount options
>>    f2fs: separate the options parsing and options checking
>>    f2fs: introduce fs_context_operation structure
>>    f2fs: switch to the new mount api
>>    f2fs: remove unused structure and functions
>>
>>   fs/f2fs/super.c | 2211 ++++++++++++++++++++++++++++-------------------
>>   1 file changed, 1341 insertions(+), 870 deletions(-)
>>
> 


