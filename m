Return-Path: <linux-fsdevel+bounces-11995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CE85A215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694C71C226A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816AB2C691;
	Mon, 19 Feb 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ha+AEffn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXGIMddO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA52C686
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342626; cv=none; b=a5HVdCjXegZpkb5Mv8Iq6wpmHOdsIJm9XtYO7lbQrNFfzevvKfiSwcd1nvA8B3CxL34Iztewv3NPxbs9ASZR379fFo6672TEZNVcZaHS2vADb0lYiFBBqzxMILulFcs8AiziGpXunyMTeNx7OQ7zEgRF4cZh/JjeMokAKbxlvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342626; c=relaxed/simple;
	bh=mnWK9zzZPm7Hf6XyEfhQCxTu5PmsGMAiJUQ6D38LLT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDwDkKNk3qMiI79GqxG9ZY0wP4pUzH5347LKU4IRVp/VPkTvR4vgJid+J2rii9mJxlDOv4rN3IbSqShMluU6TtoA2VBrOveKwuAaagtET3hB0LqyeZvxc1AreqzrGD14VmT+RRpsgwAknPV5Km0D7uopD9oTV7kymKCId7VFzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ha+AEffn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXGIMddO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 49D8F13800CF;
	Mon, 19 Feb 2024 06:37:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Feb 2024 06:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708342624;
	 x=1708429024; bh=h7/g6Ji+UAPinsgg9xwdg+W1bG/Esg+zqoguuBJySPk=; b=
	ha+AEffnX3nHtoFk7kDbtkVzLFvHDtmqgaQTm5OnWVOwkHNEyyEQhdtC1HUamg35
	qUjUdkDW4LcCHfZgFtaaoK7vHagLd7UFdoEWyLculWhFXGF2wAKZmNQfvmtmtQYF
	IF7jd7GDUV2ghdmyg6YrSGSgddEssIbHAPLRs9Xd/sO6k3CwNzZxegdXvG6cwnhg
	sChbWw7oJfoGMNcFBa8eP5YPKLayvIFynOzKZdvL0svEl3aqBmK5AbxcgIaAyX97
	8A09FdB/b3edsZz4c8bYkVjirfRG5b6b6hnS8HQ5xOnN8aWJmxoB/venBgz8Ms5r
	diZk5ZaGT36Dkcx5itor+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708342624; x=
	1708429024; bh=h7/g6Ji+UAPinsgg9xwdg+W1bG/Esg+zqoguuBJySPk=; b=n
	XGIMddOBmbJOHAXwODXIPlDp51YZNkeU9wOvg6a3xQJz8NbP8NPaqj0fmm18/u1y
	Iz4R6GNUSRYTXh5dSc2DsJo6j5pCwrvKWz2HaiktJumjPppDDm3QhJPTmZdzayea
	wBvYVH5f8RCxKxPeZtk+DMdpuHvfTzJ/ncUPLJ1W/XQjGFlzgZaM8dGvmSoz2FcH
	HoUxIZv22FkfkRYM0EaEJVanvKI/IjJkm8ar/XVqZxeg0aPGXQEcMt46KUQcb2um
	BjwTd7D0v1EPQIK17gryyvsBq4EdbcKZEZSkrLBsC2zOHcQrsYiUcvy6FsuvA9tl
	bhxRj2Jqq8gHuG2FB/bLA==
X-ME-Sender: <xms:Xz3TZWTKQ167p1T2devZmIMbLeGXhJTVii2DbhbwxiLp0hq5woWCAw>
    <xme:Xz3TZbwg2Z6-Gs-EBJwmo1DI3A1rYnIsQo3VFg5JFzjaNzx77RJHpHuTACsYkX5hS
    kipbHLkLGmxzQFf>
X-ME-Received: <xmr:Xz3TZT0wjOJ3w3uroUA85tZo5h4PA3wmLuy_WX7bLHQRQ48rXE_Q27twECAX4TcwE8ptL6igjyuHkMUBuGsd7IiRDwtcq0mA2fLlJuCijNfFaTPkTNrS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtke
    ertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfe
    dvudevudevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:Xz3TZSDEJgwH6mxA1iGYz3fkQT5PLBmVV7G9E2okr0uWA7KPknO-jQ>
    <xmx:Xz3TZfgFespkKhiTTn690KSAjrOzOxJyI7UOrVeQhOZ7yTnDu7ur0g>
    <xmx:Xz3TZer21-jMfKCQJfflsj77gP2Mlvtzs53BcfPNsKXzM0hhC2l8cA>
    <xmx:YD3TZQWiS5EDg3cHNAvqHg7PAYdffy_yEY-0qvEcJ3ssvLp-YJQcYg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 06:37:02 -0500 (EST)
Message-ID: <46e6e9df-1240-411d-9640-51d36d7e2da3@fastmail.fm>
Date: Mon, 19 Feb 2024 12:37:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
Content-Language: en-US, de-DE, fr
To: Yuan Yao <yuanyaogoog@chromium.org>
Cc: bschubert@ddn.com, brauner@kernel.org, dsingh@ddn.com,
 hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 viro@zeniv.linux.org.uk
References: <20231023183035.11035-3-bschubert@ddn.com>
 <20240123084030.873139-1-yuanyaogoog@chromium.org>
 <20240123084030.873139-2-yuanyaogoog@chromium.org>
 <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
 <CAOJyEHYK7Agbyz3xM3_hXptyYVmcPWCaD5TdaszcyJDhJcGzKQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOJyEHYK7Agbyz3xM3_hXptyYVmcPWCaD5TdaszcyJDhJcGzKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/9/24 08:46, Yuan Yao wrote:
> Hi Bernd,
> 
> Thank you for taking a look at this patch! I appreciate it a lot for
> adding this patch to the next version. However, I just found that
> there’s a bug with my patch. The *BUG_ON(!d_unhashed(dentry));* in
> d_splice_alias() function will be triggered when doing the parallel
> lookup on a non-exist file.
> 
>> struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
>> {
>>    if (IS_ERR(inode))
>>        return ERR_CAST(inode);
>>
>>    BUG_ON(!d_unhashed(dentry));
> 
> This bug can be easily reproduced by adding 3 seconds sleep in fuse
> server’s atomic_open handler, and execute the following commands in
> fuse filesystem:
> cat non-exist-file &
> cat non-exist-file &
> 
> I think this bug can be addressed by following two approaches:
> 
> 1. adding check for d_in_lookup(entry)
> -----------------------------------------------------------------------
>        if (outentry.entry_valid) {
> +            if (d_in_lookup(entry)) {
>                 inode = NULL;
>                 d_splice_alias(inode, entry);
>                fuse_change_entry_timeout(entry, &outentry);
> +          }
>             goto free_and_no_open;
>         }
> 
> 2. adding d_drop(entry)
> -----------------------------------------------------------------------
>         if (outentry.entry_valid) {
>              inode = NULL;
> +           d_drop(entry)
>              d_splice_alias(inode, entry);
>              fuse_change_entry_timeout(entry, &outentry);
>             goto free_and_no_open;
>         }
> 
> But I'm not so sure which one is preferable, or maybe the handling
> should be elsewhere?
> 

Sorry for my terribly late reply, will look into it in the evening.


Thanks,
Bernd

