Return-Path: <linux-fsdevel+bounces-17442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB08AD65C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D12D1C21062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8F1C69A;
	Mon, 22 Apr 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ovU/hRCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSmuglbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D421C286;
	Mon, 22 Apr 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820286; cv=none; b=Pf9RRZfb2x8AwmC70+z/JUI+Dld65QaYg3EF7BUtKxbwYP0woQEwhwMomiCOVTKvL/uCDif4lZNDsBdgVZ5a27afDcsPAXTQXI074FzXMGu6U4I0E1M+njl+WQi1YY3P5XH1jL3dzaPXVZDueGTQuay4oHFUW5cRAVwQhzj7ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820286; c=relaxed/simple;
	bh=JremFJQlcOycUj3IWF8+0zR7mZGxiktyLy+sOHQkuRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKawCTFu3wq1wSeCeqEadX7RVdOCC1ozb0/QiOIFZZXUmTqIhyHogjtLfUEQjNTSFl1qNx/vyiNVVbT273mN66/TZcW4tejX2FjwX6pgl1fPtiKwykq+PkJdYYO5G5e+A+BN3PAHPfW6K0WVBtmeQl5PndjtK/KbPzKKJ4qBC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ovU/hRCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSmuglbr; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 83D371C0013A;
	Mon, 22 Apr 2024 17:11:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Apr 2024 17:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1713820283;
	 x=1713906683; bh=zynBXuiznSHueeqTUMZQW6b1yBwXJrIR8wvuZJWgyZw=; b=
	ovU/hRCRt6s3phg2P+miYakfvB98/CrKECAybIJZ+kVhxN/L6CkGX0kypfRue0gf
	8nEy3VQdGoYZGylYcjMSzGCPwTByIayGsk3tHAucPgcrgbQIrdoErOBJ26nsW/+h
	11+onvSh8cIhaz7Rp7VUKM8oVl7Xd1GJDbbey9BpnaHnG8p2Fw2u/eK9HbwFrjzh
	vroEfSIqGZ7Gq5UBDurRogQITbAnSiQO6oR26BQs3MiVJfExJTdevMBSjVl0SBfx
	3q/OQDdx/uqIULxZBogHmFe+Yw9x31hhPULfk4RuoqaOORMQ0fg0R7dMGS6xdRLp
	PuFMOlVx4QG2tNFSLW9IWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713820283; x=
	1713906683; bh=zynBXuiznSHueeqTUMZQW6b1yBwXJrIR8wvuZJWgyZw=; b=C
	Smuglbr/MqGuFnxmxOIvyMD4c7ZiCmP99cjG/V39e2b2j5y34AoNnqxz/6T1oj4m
	aH68Od4rauo0U+T14nRULmNbSPD9Chk0uc8KZ5FKcoPavR8Lufxtf1mSGTXROWQb
	HSMiHxjziHmu/xE7I2ukiMov1dGbZbdfywVtdoapePacS3V04LQG/qdOY7YFqkLs
	nUTgY5OcvrhgnNQhQ4fpvGWvAF70KahCCLx2u3i8vO5X+FPENw0+mhUU3NcoYImN
	0OtAqW3PE0i89yPG6kYNAekHz6pWqgR3llNXCzvpjiH/y1o9YaoQy+b2fuii4fYm
	l04d+HobPxCGVBBiQFXdw==
X-ME-Sender: <xms:edImZt2j7U1QaRy-tk7psjPR9IIzu9WUpc2nn273lZAnOSswynZPBQ>
    <xme:edImZkFvGa1OxIw3vle-1nPJyuC7MOwq6xHV5TWPs7NVfAptcwVclbjZN5ucYxm1o
    khhlzdACIIRY4DT>
X-ME-Received: <xmr:edImZt4cFXNN_Ef-y07hUsxZ8LyXZpyh_cmNpw6ajQ9MakVzs6eIE1dUrl_Wzdwnn3SbC7KRoiDKaNas916WBXxLCx0zWGO6ykuolLdh35gtWJykFWrF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeei
    veejieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:edImZq0qeF3cwb5QaydRo8o7FaRjr3ucOMy5epNirVub-saYFsTS2g>
    <xmx:edImZgFeQVyqw9CGtDuOouza7DJUlWgvB5f-FBw-yHFCd4ZSxeS68w>
    <xmx:edImZr-IHArdw9A3GupXG9tHqnnVBL-SB3IOZVyw3pQfEJsrdNa4yg>
    <xmx:edImZtlksxXrsvPQKWiMObTWAhKw-12s41RTgSI4JZuPSM6jOUsq4g>
    <xmx:e9ImZj9Jcp924CfbGk4fKPxLwVRjyNag_hPxmcyG0cgdjI2U2C_O2EQS>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 17:11:20 -0400 (EDT)
Message-ID: <dd4f9563-9a4e-4d37-8e83-89b442c39dbc@fastmail.fm>
Date: Mon, 22 Apr 2024 23:11:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
To: "Michael S. Tsirkin" <mst@redhat.com>, Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240408034514-mutt-send-email-mst@kernel.org>
 <413bd868-a16b-f024-0098-3c70f7808d3c@huaweicloud.com>
 <20240422160615-mutt-send-email-mst@kernel.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240422160615-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/24 22:06, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2024 at 09:48:08AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 4/8/2024 3:45 PM, Michael S. Tsirkin wrote:
>>> On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>>>
>>>> The patch set aims to fix the warning related to an abnormal size
>>>> parameter of kmalloc() in virtiofs. The warning occurred when attempting
>>>> to insert a 10MB sized kernel module kept in a virtiofs with cache
>>>> disabled. As analyzed in patch #1, the root cause is that the length of
>>>> the read buffer is no limited, and the read buffer is passed directly to
>>>> virtiofs through out_args[0].value. Therefore patch #1 limits the
>>>> length of the read buffer passed to virtiofs by using max_pages. However
>>>> it is not enough, because now the maximal value of max_pages is 256.
>>>> Consequently, when reading a 10MB-sized kernel module, the length of the
>>>> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
>>>> try to allocate 2MB from memory subsystem. The request for 2MB of
>>>> physically contiguous memory significantly stress the memory subsystem
>>>> and may fail indefinitely on hosts with fragmented memory. To address
>>>> this, patch #2~#5 use scattered pages in a bio_vec to replace the
>>>> kmalloc-allocated bounce buffer when the length of the bounce buffer for
>>>> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
>>>> allocation of the bounce buffer and sg array in virtiofs is that
>>>> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
>>>> Therefore the last patch uses GFP_NOFS for the allocation of both sg
>>>> array and bounce buffer when initiated by the kworker. For more details,
>>>> please check the individual patches.
>>>>
>>>> As usual, comments are always welcome.
>>>>
>>>> Change Log:
>>> Bernd should I just merge the patchset as is?
>>> It seems to fix a real problem and no one has the
>>> time to work on a better fix .... WDYT?
>>
>> Sorry for the long delay. I am just start to prepare for v3. In v3, I
>> plan to avoid the unnecessary memory copy between fuse args and bio_vec.
>> Will post it before next week.
> 
> Didn't happen before this week apparently.

Hi Michael,

sorry for my later reply, I had been totally busy for the last weeks as
well. Also I can't decide to merge it - I'm not the official fuse
maintainer...
From my point of view, patch 1 is just missing to set the actual limit
and then would be clear and easy back-portable bug fix.
Not promised, I will try it out if I find a bit time tomorrow.


Bernd

