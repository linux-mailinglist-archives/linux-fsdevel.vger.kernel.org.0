Return-Path: <linux-fsdevel+bounces-30093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E2986158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD3C28B42A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0441B533E;
	Wed, 25 Sep 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="gg0Rp0ay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2CdQj5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49A18F2C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273253; cv=none; b=fDR+6PfWZJKxeKl0IYQcN/Z6n2weOOy4MzgHI1pfZ7ds9ymZ9w4NcfiimAtDrBwIRVbC7vPpzrAKqpxRG7+pu/ljyeYnk1+GywLvJcRYCEjzaijyMrzMcb0MuC0d7DsyS+yuKQx16rm5K4FrY7GOK9vMihGnh0T53Yz3ukwgOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273253; c=relaxed/simple;
	bh=rEEDIh85bHbdcByqr+PFC5FgCn4FhWJT1QrtqcCegTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptPKMvwH9UKi/epOBZIAuuy9kX9npL7XieHkEn+g/I7nWM9sjQMDfkZ8o5v9M1y6YMQVZtNGCu351RVMQ7HiS+6S3hh223CN7TPZbuQTj7t7CbqoXiPXOlQNOCoAc4j1rihop8zGng1sW0Hh88FFv7N4Wlb8WQ88JE+c8fKk/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=gg0Rp0ay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2CdQj5d; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C5C51380342;
	Wed, 25 Sep 2024 10:07:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 25 Sep 2024 10:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727273250;
	 x=1727359650; bh=m1VPGu6rSVC9jkIGICq3PexQNYs8+fLWppQ7H8AlL90=; b=
	gg0Rp0ayg69aMZ2bKzqlau3I/LiD8ROl3XBlQeLl2Naibr3RQ0RIQPtdSxdcwUsx
	7u+ZN0BfPpTeatF+3D2VTls38uLzXKecowi8VeBPsM757u4PYsLQAEbgQvgXQmR1
	YhAPOep4Vrv55WjaUmSWux5nuyKFJQN7uRWM67VesjjZwbN8ymLur7iphUpQL8u7
	gdOO3TGFDI1LmxhlnbtRNefV6QHudKVtGN8Kivz5VqX/ZykviRX0e4TZZ2N4HHI8
	ez25MCZT4t6UsXfZkFM0eHpEY58xkzOBgM8BYfcUn4Y/+Kk0mfn3AEDNLbun8lbw
	QTdM1rT+dik1f7aMIoWsBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727273250; x=
	1727359650; bh=m1VPGu6rSVC9jkIGICq3PexQNYs8+fLWppQ7H8AlL90=; b=k
	2CdQj5dr5i7vIfWB6E1qyH3EH9GJCdkfRMAqX8oHSr1KvzuC5obt66Hgpq35xQJW
	D10Kpz21Tu/8rD4t8vQJTUuqBpNn3tVSGPEyb+jT24rNFeGM8UMN2T0cLyYpLyFs
	NSjuaI5q1hQFavSeoGp+6PSwE8GW8wXwetcR9Vkj2fGFzmpsAD3OXvTTSgrST2X+
	yM+2it9arxF2Ob5mzPVJ+tVic6K6SZCxU6pfIv5TmVK2PpG2URYfI8p5U7zo+VyG
	c5hHR7RJWfm0uE16c0FpFbsQsHY4DXTTBbpK/aHASuFyN83JtW58EhHLsC5SydhQ
	XI3G0c3qBxYIfiEcoe9FA==
X-ME-Sender: <xms:IRn0Zle6YNCiHW-GiRRauLuGtyxIrajwCou5RvZeBmJuWk4HFVDaKg>
    <xme:IRn0ZjOdwyLFVcmKqOSYVEHrtNqPS25toeRPn-9XWW8QH77kb6EmpsusBtwp0alOZ
    C0YH9Q0Qzf5uYHO>
X-ME-Received: <xmr:IRn0ZugY6qj6EmeNevWtx7yITN4D81RBz9sljBd3UNiKccHCbq0Tt6XQtnSo9YGRcuJX5kXjUficCGl6nLQcQhnbesJSAiNk1qRSbO2L_9Cd42Vf4Xmn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhgruhhrrgdrphhrohhmsggvrhhgvghrsegtvghrnhdrtghhpdhrtghpthhtohepfhhush
    gvqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IRn0Zu920KjvNhm9bpaJHfFTRcrchYvuWl1n-gCzlmsevc0D4bY0rw>
    <xmx:IRn0ZhsiNU6kr3evYY-goMlRbd9ZujtWIOX-2er_T0QtltWbYHyRMg>
    <xmx:IRn0ZtFjDmVs6Nh-lJMVGne3sl4dFkucPHc4YwsbM_lj-bG-g5EWXQ>
    <xmx:IRn0ZoPXF6rXnnZN1iMcGzZcxR2vHdG0_pMYoF0Rydw8nTWwTh7Unw>
    <xmx:Ihn0ZrKzzZN6h9POEyu4-X5CLCj3WlPMjulOkJ5n0nBvL6F6q_oihswY>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 10:07:28 -0400 (EDT)
Message-ID: <a48f642d-a129-4a55-8338-d446725dc868@fastmail.fm>
Date: Wed, 25 Sep 2024 16:07:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Miklos Szeredi <miklos@szeredi.hu>,
 Laura Promberger <laura.promberger@cern.ch>
Cc: "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
 linux-fsdevel@vger.kernel.org
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
 <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 9/25/24 14:20, Miklos Szeredi wrote:
> On Thu, 15 Aug 2024 at 16:45, Laura Promberger <laura.promberger@cern.ch> wrote:
> 
>> - But for corrupted symlinks `fuse_change_attributes()` exits before `fuse_change_attributes_common()` is called and as such the length stays the old one.
> 
> The reason is that the attr_version check fails.  The trace logs show
> a zero attr_version value, which suggests that the check can not fail.
> But we know that fuse_dentry_revalidate() supplies a non-zero
> attr_version to fuse_change_attributes() and if there's a racing
> fuse_reverse_inval_inode() which updates the fuse_inode's
> attr_version, then it would result in fuse_change_attributes() exiting
> before updating the cached attributes, which is what you observe.


I'm a bit confused by this, especially due to "fuse_reverse_inval_inode()",
isn't this about FUSE_NOTIFY_INVAL_ENTRY and the additional flag
FUSE_EXPIRE_ONLY? I.e. the used code path is fuse_reverse_inval_entry()?
And that path doesn't change the attr_version? Which I'm also confused 
about.


> 
> This is probably okay, as the cached attributes remain invalid and the
> next call to fuse_change_attributes() will likely update the inode
> with the correct values.
> 
> The reason this causes problems is that cached symlinks will be
> returned through page_get_link(), which truncates the symlink to
> inode->i_size.  This is correct for filesystems that don't mutate
> symlinks, but for cvmfs it causes problems.
> 
> My proposed solution would be to just remove this truncation.  This
> can cause a regression in a filesystem that relies on supplying a
> symlink larger than the file size, but this is unlikely.   If that
> happens we'd need to make this behavior conditional.

I wonder if we can just repeat operations if we detect changes in the
middle. Hard started to work on a patch, but got distracted and I 
first would like to create a passthrough reproducer.


Thanks,
Bernd

