Return-Path: <linux-fsdevel+bounces-58705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAFB309AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D7C7AC154
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F322E2EF7;
	Thu, 21 Aug 2025 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="OjYKieCo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IclmXLe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E5393DEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816866; cv=none; b=Q4JdI2XuZOeFiVxghFIuFlKPUrm5ckEwx6UOrQWrmhIBpxRT1DMOD6gSZyeT7LjJxyPFoCg9yxRU32F8urezOJtlyd7wJzMjPzzrlt7KQVXo29B7xwr2JvSkkrJEfLrMQdXmSUJu6DDBukX19lDikNi+3pKWu0468LDQVaF4Xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816866; c=relaxed/simple;
	bh=AbkVPEUvn3PY7L+hhsA3QPK6KGp58GnLlcj633iNeRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBHgkSMmZNvhP3uoK35L6GZ7bVyCPQBv6nudCM7h8nwOzROfP5VfDE57npgkJtkTSgBNXzB84vVdrG5hEwNUYRvdHDZRx7R7ed0DWBPBNdpCKlY0bE003sm+iOBXd+VM1V2rIBJ9KbpGgUwKRdqfHZPtvLWwRbE471S2RWQcYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=OjYKieCo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IclmXLe5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E28214006AF;
	Thu, 21 Aug 2025 18:54:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 21 Aug 2025 18:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755816863;
	 x=1755903263; bh=eiXKBSCvDVD0rlZZiCgglRilQSQWe82w53UhFo17uHo=; b=
	OjYKieCoNonpa2pncKP4mCmOztFKceeOJEPmxSK4C6H1Vp2VoWZNHwSY/kwPz8iI
	1QzjOK633Wg8hRI8wzdgEbt0xFCeXEtU3G7zEJn1KzsCxadY1iUNSBwLz+s2S6Lu
	m8Z1UO8J0kpnxnINoibIoQsqrQpH5i/MGNzLSoQgaDQ4OXP/h9NRwl/kWJ6SWJBR
	aDdB7TKF0dhGhJTd7NT6y7MG/uh5h8pFefKklh0fKjT7hgFFy43zY+7Itt4IDpF8
	AoZ7fHgRxgQ9BNwbSoetpTyiSE8R6jcDHrLLNma+5NTAio0nTalC8lFLjp1hnvWf
	voh8rF3D947xGkP0MZJr2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755816863; x=
	1755903263; bh=eiXKBSCvDVD0rlZZiCgglRilQSQWe82w53UhFo17uHo=; b=I
	clmXLe5BEgFXrJlr0oAuw86+p9Jrvr4tm4uuXiH7ppARvQb4uACRdHp7kpCAkiCN
	eISyPafU63tx9oK46sHV/P8gIE4bR1lFgR3HxzS0mDVILyWHUYTrhJ40lNl0qKNx
	vaG3p6KYQSefOjZZBZjRCJVvQb/ERcDUoYtCOz+UqwALa2ZqnJjIjTRX9BNyPHGw
	mSb1xCfwhhhzNhh7AwbIDimmeRMcx27ibG2/imGjE54oGw0x70KHbM3Q/V2siije
	XaXkbUXeYlKEkShiZ4BwUwjNYCOQVPySy0W3IIh4NQRMssE4Iiz9YaF2/gHJim5p
	/ZL/n2hXavySAD3AraXNw==
X-ME-Sender: <xms:nqOnaDvxm9sUs9Crl7iEhehhJ-wBVJx1UKLYkWQogEPI1o6Qjzjvrg>
    <xme:nqOnaM4SSHGdY4O3pFjvpnG5k7se7HxmRh80KkWXCLuY2IiHPRHc18h0boMG5v5kI
    nZ_UNVj3SRiFewh>
X-ME-Received: <xmr:nqOnaHOFatrt9kRzfvb_LQA1GYNFU6fNX1kQ2Npr-fnK-lM4XLpKSFsi7nCRBkWa0VlDkkj0BmGhyXNFOAU-M0DgLCnVcC0eS96b8bIMvN2HExixUg2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprg
    druggvvhdprhgtphhtthhopehjohhhnhesghhrohhvvghsrdhnvghtpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nqOnaCvzudkyPNueFxPw3UbtDig0w0v6XvrNPPlmBiDwBN4J0Bmufw>
    <xmx:nqOnaCZKecmoBptC5nWp8njjXzNGA9nKHfUtO4cHhySJQL-2uja2hQ>
    <xmx:nqOnaMwsUx61_kEHS8V9y6s33sjVdtPcEbjjLCciAP4H8a_kxsBpWA>
    <xmx:nqOnaChfh9Yw9Q8dJKLBu-dCilLLofzIEKCMEv2S_fdYbdrl5ykQmg>
    <xmx:n6OnaPR6-rZqJQRQozi-53X9emQS4hbq7oTsW-H_FjHaH-45iU6Mnoob>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 18:54:21 -0400 (EDT)
Message-ID: <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
Date: Fri, 22 Aug 2025 00:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250821222811.GQ7981@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/22/25 00:28, Darrick J. Wong wrote:
> On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
>> On Wed, Aug 20, 2025 at 5:52 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Turn on syncfs for all fuse servers so that the ones in the know can
>>> flush cached intermediate data and logs to disk.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  fs/fuse/inode.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>>
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 463879830ecf34..b05510799f93e1 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>>>                 if (!sb_set_blocksize(sb, ctx->blksize))
>>>                         goto err;
>>>  #endif
>>> +               fc->sync_fs = 1;
>>
>> AFAICT, this enables syncfs only for fuseblk servers. Is this what you
>> intended?
> 
> I meant to say for all fuseblk servers, but TBH I can't see why you
> wouldn't want to enable it for non-fuseblk servers too?
> 
> (Maybe I was being overly cautious ;))

Just checked, the initial commit message has


<quote 2d82ab251ef0f6e7716279b04e9b5a01a86ca530>
Note that such an operation allows the file server to DoS sync(). Since a
typical FUSE file server is an untrusted piece of software running in
userspace, this is disabled by default. Only enable it with virtiofs for
now since virtiofsd is supposedly trusted by the guest kernel.
</quote>


With that we could at least enable for all privileged servers? And for
non-privileged this could be an async?


Thanks,
Bernd



