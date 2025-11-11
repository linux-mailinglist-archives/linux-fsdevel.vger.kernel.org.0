Return-Path: <linux-fsdevel+bounces-67861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45BC4C696
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0F034F5381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA372E6127;
	Tue, 11 Nov 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="cqChozWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ttTB93KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA434D39F;
	Tue, 11 Nov 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849538; cv=none; b=MQ/QkONeAZHSn+F3BpSBRXcf7tegwbra25mv5ZubtoG2ujXI7+RzLrlPbmsaCoE2RdFkTvO1ShqlrD/jvkZdVf+h/wTOih1ympJSMgtm5lm4h7GcK+wZqvbIlzuFWU/1sSqITxu7iz25YjZqUYLrC8ABNQXfLIBWJq1NhSPyjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849538; c=relaxed/simple;
	bh=5eMAE6CFiVek50M/mKTSUsxSKOVLCCBxb48Ff6yt/jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwhqj0xG639uo3uNbZxLKz6CBrkbTJW+mmxwWoGNjZANxEvTn2kgLN+VAFArwwpdf6IQzSkmYpuR5SO5ATLI0HuQvXijCGW9Ah6PZM8TD9p3OuL+JI2HxImX6aYYskf0nQ+vTwd1KfygfxmUy/ZfSba9aJJ9HdFrLKddHmwyfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=cqChozWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ttTB93KD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A83941D0011B;
	Tue, 11 Nov 2025 03:25:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 11 Nov 2025 03:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762849534;
	 x=1762935934; bh=l0CyVOrIIDerJtiqzpcuJ4aRtoPzZBuAKsadBTgU3lY=; b=
	cqChozWHQz4YQ4GAsADWCl6mgvRpr4kDdxzIDR4QzHIkhRSMZ7IXmsd4cnO7Fb9X
	lyG1bE64KlAPeRf52+BFTaA2UBfWBHLtKzcSyLHegvumd2eUg1GVDRZ5nZIjOP3X
	vIg7+a0g6W2yGYMJoQf75ppfS2tkMn6PzbBgqn5KUqmkprCNg8WBx7ra058ilzi9
	UR4fOcjHPbLJ6z0G46A5VsBXOelxqxE1Y8SfnxGw/AXlcLGVCfv0xMnRKV5N3G7k
	I+IKGNmZTFsRVS2kX5VSJq0YJ7Zx9wpZX83TjjVKXvx6GSXOumrfz9Se06Zle8Yj
	5Tsx4u5jaR5wIp6K/ngWOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762849534; x=
	1762935934; bh=l0CyVOrIIDerJtiqzpcuJ4aRtoPzZBuAKsadBTgU3lY=; b=t
	tTB93KDhHGCiA+aRdUfw6nZ/gIt8HfEYg1NWAIFd7e2BjoRAo2JLTDmYGS4zwM8B
	P+O6/daZpmW0rRI9cVEGL+JSZ1+hrMlWDxa+Ed0MB375+OLKP5WOmWP0z65zV8t1
	ooXjYzMTh94YfHC4nO7VPlK6dhxzh6OY1feFS+TANJODCbF5dO24u4hs3yThb6bu
	YRhuIESZ1rp8lk1wscb3lyhR+31DyW0ekrHAPi8mxc5yeY298tiGDWSqMmMkfGb6
	NqeY+ZrHAViOtijscrE9dkgjkcBmU600ExXirwkmzcu9nxwidbQSBR2DhQv/jp0y
	vVrlt8fpJtJ+0sHqikytw==
X-ME-Sender: <xms:_vISaUtcsznWYqcI6DYwb3TfybqjoGQyZ-XPZ4qUJhZemU7R3VLgCA>
    <xme:_vISaawdW7l0pT4YYjZtANInwwJyqK0ozWeGAVwUtb-Pd5Ci2tAB3fVfEz3ok9pdI
    hH8vcqBZPn0YXlTjyJNF1CFzHdYL3q6-cCZotoFof4CPBw>
X-ME-Received: <xmr:_vISaXD5ebHbxe3gK2Z2CV2lr9gyVl0yWaEUncWIljFIfHu4qRQYWGMTdyxjLN1ix47izkgKiB5GA42zw1JzVqb3aDpNUkz9mA89waxxfZxTiMrVzG4xCM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_vISaYfzecnlaDhpCPpS3J6hVZHdH08l83SGZ8P1vcq3TTdo-1KNLA>
    <xmx:_vISaRlxNPpSl0JAVONhQsubMO055r3ML4aP78KuAa2QQdpcPnnBzA>
    <xmx:_vISafGhypXovJyTdteDft53P2W2DujrzIZyMK-CvHkld1lCdU4qMg>
    <xmx:_vISaZ5VNQgqaKePtOMqsjI_lAExHEYmGVLniIXgDV9UheA6xIwT3A>
    <xmx:_vISaQ7davWr2zTAcsW4El_ii1Msvl36FptnOx1eNOMC6qfBawKRGwof>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 03:25:32 -0500 (EST)
Message-ID: <d8040d10-3e2a-44d9-9df2-f275dc050fcd@themaw.net>
Date: Tue, 11 Nov 2025 16:25:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net> <20251111065951.GQ2441659@ZenIV>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251111065951.GQ2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 14:59, Al Viro wrote:
> On Tue, Nov 11, 2025 at 02:04:39PM +0800, Ian Kent wrote:
>
>> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
>> index f5c16ffba013..0a29761f39c0 100644
>> --- a/fs/autofs/inode.c
>> +++ b/fs/autofs/inode.c
>> @@ -251,6 +251,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
>>   	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
>>   	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
>>   	sbi->pipefd = -1;
>> +	sbi->owner = current->nsproxy->mnt_ns;
>>   
>>   	set_autofs_type_indirect(&sbi->type);
>>   	mutex_init(&sbi->wq_mutex);
>> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
>> index 174c7205fee4..8cce86158f20 100644
>> --- a/fs/autofs/root.c
>> +++ b/fs/autofs/root.c
>> @@ -341,6 +341,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
>>   	if (autofs_oz_mode(sbi))
>>   		return NULL;
>>   
>> +	/* Refuse to trigger mount if current namespace is not the owner
>> +	 * and the mount is propagation private.
>> +	 */
>> +	if (sbi->owner != current->nsproxy->mnt_ns) {
>> +		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
>> +			return ERR_PTR(-EPERM);
>> +	}
>> +
> Huh?  What's to guarantee that superblock won't outlive the namespace?

Not 30 minutes after I posted these I was thinking about the case the daemon

(that mounted this) going away, very loosely similar I think. Setting the

mounting process's namespace when it mounts it is straight forward but what

can I do if the process crashes ...


I did think that if the namespace is saved away by the process that mounts

it that the mount namespace would be valid at least until it umounts it but

yes there are a few things that can go wrong ...


Any ideas how I can identify this case?

Ian


