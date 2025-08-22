Return-Path: <linux-fsdevel+bounces-58791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B045B317DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B6C1C849A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055032FB621;
	Fri, 22 Aug 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Hc1lna26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTw4yilO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9C78F58;
	Fri, 22 Aug 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865916; cv=none; b=FbTY+eeaGXb/8XoI6YIWDIWh4TRzHZOYCLGobPk3Djl18xZPtlkyop5Y/3WYzvMXSJiQCsw3E7U9ZqiUkKHFQVSlq7Ne1nWt5rPsp5fCKXsnwKxSYLJFNm6Z9OsXlE+R5Bsk+uTCw7C7EzLSU+Pxck3uc61IEKr5DadQijtDWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865916; c=relaxed/simple;
	bh=8O6P+KnBSM9tsYHgrhKmCq6XLjltsmW23yXffgDZ92o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axaXiqhrnhqww3kkiAo6ino1pSYfQNnwxjyHU3NgEpTThV6QHjN58xVYl/6d14/MPL3lwStneNX7CfGHmT3+YSn9b5YuVpojWElgC9AIy5HuqZLq+2GMs3ZmVCNxzhSt6XPWD752KucBEp2AQMOSPa7wpi8/2oErkjfJf7FbF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Hc1lna26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTw4yilO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9B1A7A015A;
	Fri, 22 Aug 2025 08:31:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 08:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755865911;
	 x=1755952311; bh=8O6P+KnBSM9tsYHgrhKmCq6XLjltsmW23yXffgDZ92o=; b=
	Hc1lna26W7MspI/ZK5z8IVAEKJAVFrEijbanjkPSqVDR+1mUcN89BoX+KCbhazXc
	qrY2DebY/+/w+xkG8dXT5q49uOeML46/ayDyqcxP1GA5Fahx9RJ331zHXOrVrnO1
	sB/FWh2VfPPsm+k25/SwABpObfJBx31lp84hs6DeLvjdjteF5xmiV70LhVjCLW8q
	KyAJulfMz+LnDdIwf9T3mlrSRT1zy/1TL1uFVztxwPKexyamgLWlhA3OeNR3hgTb
	WSkMiryuTNhnzPLYYuLOiFmLkKmcfamOnHz8ryagSZlu3GxDYtgu5Z/Gki+i2bkO
	ovrvY+BijTMu2X3Xq5Xu8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865911; x=
	1755952311; bh=8O6P+KnBSM9tsYHgrhKmCq6XLjltsmW23yXffgDZ92o=; b=a
	Tw4yilOCRgZCQ/v4Ug6sDG18jXn6JbswyMxNwBHk9tNEQAP911IGkNK6gN7Kna8P
	lehILgZJ20um5J9TFS6mw4MtHykTZKKJXCseKh32Lia9hpWiW13jabIEq0S/aryM
	BPufGU6s63n7ABKM7cE6RCs/67scctccHxq8Drslc3AQcRJaL04aU7jKDwqRhX1k
	aQF8y5G3fDbeiSseAW3semwv0S3q9ZG5cLndT+C5kNRO1VDqHnDo848wyuW16+A7
	5i0r6ULyWYTXRD4iqVz1105KmRAgqgxWX4qRkVfo+o/RhUrN/Kq+g1G7OUjuu1YH
	bQXBTHXySa3k/de/uckag==
X-ME-Sender: <xms:N2OoaC-oovpkVSvMlCDyNj93nJI5U_c0iOe2gtM4-JGGXGsEs-VC4w>
    <xme:N2OoaLIwc_ANE70TFQKJ0LfDWYPS4I0ZNImR5vCpGiy0oLTrUYxyv0tKbR2BTWV7d
    QUtHeEUoZ9R>
X-ME-Received: <xmr:N2OoaIcX0QKopzcaweyFEClteRdUM42WCU1SgKGe0mHaUeAgiKNO5hACpHWAPW-pTfCmuR1zbwgdwu7NQV3m6OBBVMUib-tO2vmuJ83uh-ZLCgEY_jjuX-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepud
    ffudegkeefgfevtdeffeetkeetudelkefgffetfefgvefgleettdevkeevffetnecuffho
    mhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghfihhnrghskh
    grrhesiihohhhomhgrihhlrdgtohhmpdhrtghpthhtoheprghuthhofhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrdgt
    ohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:N2OoaK8dFDddwEt1milTa2OlsmtN5SagXC2RXMXUTPgCj0NB3GEEPQ>
    <xmx:N2OoaFr8vzTEotGoenKwCQHuVxUzfYgp3M7LtCRj4D9sVnJIjnlv8g>
    <xmx:N2OoaPDEd6_qf50B5Si4Oeku9KogsOi2ER27E0c--rzdEJ5iVq-JzQ>
    <xmx:N2OoaHx-_PxhtFdpcnF6ByKItKlxct7OKvlGnWQ_Qiagu6-oxw85lA>
    <xmx:N2OoaMi0Onp1WBCvm8VJZciK4ZiSwR8sprBPWMY5M3vq1o0GMhxD8TaS>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:31:49 -0400 (EDT)
Message-ID: <f83491c4-e535-4ee2-a2a8-935ccebec292@themaw.net>
Date: Fri, 22 Aug 2025 20:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Serious error in autofs docs, which has design implications
To: Askar Safin <safinaskar@zohomail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, cyphar <cyphar@cyphar.com>,
 viro <viro@zeniv.linux.org.uk>
References: <198cb9ecb3f.11d0829dd84663.7100887892816504587@zohomail.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <198cb9ecb3f.11d0829dd84663.7100887892816504587@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/8/25 15:53, Askar Safin wrote:
> Hi, Ian Kent and other autofs people.
>
> autofs.rst says:
>> mounting onto a directory is considered to be "beyond a `stat`"
> in https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/filesystems/autofs.rst#L109
>
> This is not true. Mounting does not trigger automounts.

I don't understand that statement either, it's been many years

since this was done and I can't remember the exact details. I

didn't write this Neil Brown did and I have spoken with Neil

many times over the years and although I'm quite sure we talked

about this document at the time it was so long I don't actually

remember what was said.


It's quite likely that what I said at the time was misunderstood

but the discussion following this is reasonably clear and describes

the uses of the callback. The need to not race with an ongoing

expire of an automounted mount is important and the transit through

a non-empty directory in the case the automount map in use specifies

a tree of mounts is important too (no this is not kernel only

automounting such as is used by the likes of NFS it's functionality

implemented by automount(8) based the mount map constructs it uses).

So much of this is needed by the autofs file system during path

traversal which is used by automount (not general file systems).


>
> mount syscall (
> https://elixir.bootlin.com/linux/v6.17-rc2/source/fs/namespace.c#L4321
> ) calls "do_mount" (
> https://elixir.bootlin.com/linux/v6.17-rc2/source/fs/namespace.c#L4124
> ), which calls "user_path_at" without LOOKUP_AUTOMOUNT.
> This means automounts are not followed.
> I didn't test this, but I'm pretty sure about this by reading code.

Explain what you mean please.


>
> But what is worse, autofs.rst then proceeds to use this as an argument in
> favor of introducing DCACHE_MANAGE_TRANSIT!

I don't think that's the way you should be looking at this.


At the time this was implemented into the VFS there were several things

that autofs needed to do for automount(8) and David Howells chose to do

it this way at the time after discussing what was needed with me.


>
> I. e. it seems that introducing DCACHE_MANAGE_TRANSIT rests on
> wrong premise.

I don't think so myself.


But it may be possible to do it differently if there are reasons to

do so.


IIRC Al doesn't much like this either but even so I would need a clear

description and discussion of how the cases I need are covered before

changing this to some other method.


>
> Thus, it seems (from reading autofs.rst) that DCACHE_MANAGE_TRANSIT and all accociated logic
> can be removed from kernel.

Again I don't think that's the case at all, certainly automount(8) will

see various breakage without changes to it and probably the autofs file

system.


IIRC (and I likely don't) I would probably need to re-introduce

->d_revalidate() to autofs and make sure that the VFS locking is

consistent (which it wasn't at the when this was originally done

and what was needed didn't seem to fit sensibly into ->d_revalidate()

either) wrt. autofs's needs.


So why do you need to change this?


Ian


