Return-Path: <linux-fsdevel+bounces-36284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E69E0DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C74D2814CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657821DF739;
	Mon,  2 Dec 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FS3Koocm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YG6TDZSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480611DEFE5;
	Mon,  2 Dec 2024 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174244; cv=none; b=j6p8X3Oyq2SvjpmN1capXba9YGKXymDKmoNRwn4TsIxd+UT+7m9c/nKMjmty9U3EposQJhE+NBsCbEeYSBOS8fb6QaJk741zzxR2KM/RRnuATn9RRl/zqND7d9U9pEyTmprfF/RUWg2QF7Ff2NdDG4mKLBiPY8UH/1jAHwVMVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174244; c=relaxed/simple;
	bh=V8E3CAoZ+eoyH5qb5Q7b9xEpiN/FXQZ/mmLitihRQiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGZTIAwjbUc/B5FqiETIbcyKkYQk6xSJANkiMooqDt5H2TqfH1VlBj7ksi4oWAhJNBqUpCuw5oqHeWh5AbJFMojteYZFHhNYaQq8PyJwReOywwDbu8sqvEXTiUgidFzdaiAHBODsJU1Bp9h79RC2g8GuUj5Fi1sO4p/JhFwqqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=FS3Koocm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YG6TDZSN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5034113801CD;
	Mon,  2 Dec 2024 16:17:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 16:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733174241;
	 x=1733260641; bh=koGFzRxfP6P2j6KWMMaHEsaD9wq7yXqj55bBgEKSlhg=; b=
	FS3Koocm4A6dr1QP03hTwazvp2asg4xHUTLpFqWzcgYS97a5SM8BH3uBWjwa/rDL
	+uQpYB8K7nByoKWY5cahvznLbuvNUHSKBWZpKibsK6o/PaL3u4OEoZHS5sJtJYGy
	zbawQZDZpjZ/vOeMwqfh5F69Omqjgm3R0wcRWQ0NmJI2wOcBM+ZF8p3ld0LS1Adv
	wIWbxOwQ0T6ZLRGL9pwteIosavXtlqcv5GvjRHzNtrqEVrIqGGB6+CYVM30I6fP3
	3Mw8fkjOTc72I+/r/81hn4vmKgbMIVIBGJpmOuOGauJXGqlUG+KvxHhEGeq7nDk4
	BYGtItPvRz3aRuJ+7xz0xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733174241; x=
	1733260641; bh=koGFzRxfP6P2j6KWMMaHEsaD9wq7yXqj55bBgEKSlhg=; b=Y
	G6TDZSNTjZldQHX/8CHbBKeu+5Huxyjy5qnl9wl0qcsahZ/EeTGuXm1fcePBbI7F
	kl5UkUzUDWRwk4ccV/OrI4xd3rc0Egf29av9Jd26l5R8fk/HQWo3brMf9koPy6by
	5jLDaG4gfF0LQHPA4sfdRM7PgtBpjuGw1VLbh8VVgUwwcrteP3KCe/GrPtIHat9U
	TZx3qDw3GZkAbKdAaJlDZprfyv4BQi8X7tvCN85rda3dVbs+xunE/lCkzR9NHhBH
	3XsIWx57A3ebPXWuB0psEROIfcGUDu0ELiLGuhaonzGzH+nTiX/eF//2BerfwDYL
	eWtVVDUtLDjxHV13CcHUw==
X-ME-Sender: <xms:4SNOZ4j-d4qZdRaHC1GrfSAogLKhVy1YQ8gi2ILu-IUXNd6GUmvABg>
    <xme:4SNOZxCsG6FUikksopcKuF2C-jQbzl2Us9tg-PQ1uuUh9jmxbCA6V-Z5_LrzxWxab
    DJrU8qw6NeEDCL_>
X-ME-Received: <xmr:4SNOZwH7fuuBoCfqwNK3o6ZAol6JM_Hvh5CvjnjlPT0hdw3U_OE9PrOKQW46gvC7J-GPihqh5hVclHfZv_UbcdvB7XuNTGutPmaSZzKYCCVvP_mMn-pz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehnihhhrghrtghhrghithhhrghnhigrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgr
    nheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshiiisghoth
    dokeejsgekvgeivgguvdehuggstgegudejheelfhejsehshiiikhgrlhhlvghrrdgrphhp
    shhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4SNOZ5QxY-JLqdoWmCsOzLTKsIaJiHQJ5dBf-k0ujg_EuIL8tHCjyA>
    <xmx:4SNOZ1zYesvkHww5E3mf5BiU0-S2UAAK09gFPxK_GCVlZcCl-JxlUg>
    <xmx:4SNOZ35jZ7_asUgI-badqLi3BeJsv6Emtk6bzvT2_zZ9hzJf2avylw>
    <xmx:4SNOZywiLtEmoQ9kOz6qslOgKS0ErNrRQ9nIs23Bi-ap10tAziLpNA>
    <xmx:4SNOZ0xaCAkiJNoQvPeI90ChJO0mFIE4Iz9uvbX5lOovWzWINMXtwPNX>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 16:17:20 -0500 (EST)
Message-ID: <364da8c4-7559-4c6e-afc4-d1b59a297d51@fastmail.fm>
Date: Mon, 2 Dec 2024 22:17:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add a null-ptr check
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241130065118.539620-1-niharchaithanya@gmail.com>
 <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
 <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Btw, totally unrelated to the report, but related to what the C 
reproducer does, killing it sometimes results in

  12563 pts/1    Zl     0:00 [syzkaller] <defunct>


[   46.018014] mount.nfs (1163) used greatest stack depth: 23944 bytes left
[ 9929.865478] syzkaller (12313) used greatest stack depth: 23216 bytes left
[10159.658915] INFO: task syzkaller:12312 blocked for more than 120 seconds.
[10159.663075]       Not tainted 6.13.0-rc1+ #92
[10159.665618] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10159.673650] task:syzkaller       state:D stack:28944 pid:12312 tgid:12307 ppid:1      flags:0x00004006
[10159.681276] Call Trace:
[10159.683004]  <TASK>
[10159.685636]  __schedule+0x1b42/0x25b0
[10159.688521]  schedule+0xb5/0x260
[10159.690415]  __fuse_simple_request+0xc49/0x1350 [fuse]
[10159.694677]  ? wake_bit_function+0x210/0x210
[10159.697145]  fuse_do_getattr+0x2cb/0x600 [fuse]



Aborting the connection(s) 'fixes' that, but looks like it triggers
another issue. Timeouts would certainly help, but it still should
work automatically.


Thanks,
Bernd

