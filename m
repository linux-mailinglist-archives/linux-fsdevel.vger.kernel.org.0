Return-Path: <linux-fsdevel+bounces-30850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8B98ECB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194431C20CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C2149C4A;
	Thu,  3 Oct 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Y1xygjdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ht+ME9nJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B76128369
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950215; cv=none; b=GDV90S06UG9nnInabi4INDpGZFUXqnxM9CtyRrm4bwSAYhYORrSbyM0yHoul10ms1QbYV5LBihN14Cq1XF8u3Z2QXIsfNm/PqjrwoA8XuGnNA+01kbyt2HrtLQ5xpb0K9znl+qkhGf7kpbati/gM7KCWgW4HCDB3bsCf7bZiMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950215; c=relaxed/simple;
	bh=F4HpecKj4YejpDe4XG0yGVfIqKBsG4cYsvh1nkOCANU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbrEBMdol3699XspsmVfGXSMEeodNVJPe4JQc7+V7D+pa0J7O8O/ldZrx7ZFmlJBTcK/BGoILEiewiaevRlLRloVr4sT9ergXlijjlgx3WDRSmR2yB5Pdg5hM8s8Qn83V6GWsGLS1Kkukbb7ihubvS1omnUNSwXRP74bljnAsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Y1xygjdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ht+ME9nJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 70ED11380602;
	Thu,  3 Oct 2024 06:10:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 06:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727950211;
	 x=1728036611; bh=rTnRG1g2xH3IvTk2dTlLjnVeTIodw+w7GvqBFOuy4CY=; b=
	Y1xygjdy8+dFbUmgqjnuZFab4xT6nPV3/t6muiAeqaPRb8+PL1gZq0y5rSYEXZb1
	BG/8aD2PU1WNQeVMbce8tP9Jg2F4d0L4fpmcIkHJvw6UBfzXJNOWQs9nAfP3wgat
	2Q08Fe1aQBvi8xsFPyB/vJuHPXj4zJjhfkym2pegqIEbGgrpBcJf3W9aNAdP4E00
	4JHGECGP9eXxNoIXpH2wt0mPTwa1PqgUmVXzO9ULWqBFIad+ZLr3pyi6y8IP62I3
	c9+ddgJvJLRvGbould0Gx7a6Usrr2U1fFJVWolktLoxweV5EbW9QHLL1Jy9Txib9
	Aws06/JyPIs4gbDr2LDqXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727950211; x=
	1728036611; bh=rTnRG1g2xH3IvTk2dTlLjnVeTIodw+w7GvqBFOuy4CY=; b=H
	t+ME9nJpyrBs3DMiDPMc+DuYSiZRiDAPl5HKaokX/cY7kZXhbvW7PlYlO2oKJHC2
	6v4Ia89wDv0wmWL4Px3Qp8cMrlaCoA+AOHEW47f+PSDvd1H1j8mu21mgl9kIFR9U
	pS6uAGfV/c34jWB1T8xzySzunSd/9CS4qrIiaI/ZpWlT1sRw0KFK+mWiCs06gUnm
	qbEksIKkqufIQNZr6MyXtJgoSltKcp2g+dT1C53iNCHONdntRLZxEg1a/lXU9qu2
	h7Wx9WVvUOBrgKYSpQr7yf8/kRGIYvPBbIhMcCjOpwXIKPQ1Wi1ueRc1u29016f6
	pRShpCia0t42R5e1VVstg==
X-ME-Sender: <xms:g23-ZnYTq3FlkM-i-WGa-eQieJZhuyquFS4D3lkdTshTwTd5xrLoyA>
    <xme:g23-ZmZpEabBb2cmDzZb2dwpLAtgydx7mk7WgsS34eIHK8op5f-4x8lacb67sz90Z
    ERhsM1ibTbpoYaX>
X-ME-Received: <xmr:g23-Zp_cg-8dnvGqaJXx6AtaA5feco3KHK90JkwGEoWnvslC-XxCH07n6oYhewFiE89NZJa8nRu2RTQgbdOc7Swk6FEHl2pHEME5uaSufkVqYmnAKbk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:g23-Zto10_w1Ll_lXTlWgrcio4DCLBA9P4IfCnm3EvubA0yexu1duA>
    <xmx:g23-ZiqOi1WNMMxZX-roXE5YeaLbYb4_P_I7vCB4tiow3SFG8v9dFw>
    <xmx:g23-ZjTgw8kNjerEvqwouZhyMwpxiZnL5NY0uSNdlji8iK9V9JK6zA>
    <xmx:g23-Zqq_Yh7SbrUi4ePbrL3RPdPEEqCT2DbI--S9v1dC4a905fSlpw>
    <xmx:g23-ZrnZSN68RHNubJG_3RObvwpPO7phkOwUBsb5kxFb2mS8nbrSkmKB>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 06:10:10 -0400 (EDT)
Message-ID: <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm>
Date: Thu, 3 Oct 2024 12:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/24 11:50, Miklos Szeredi wrote:
> On Wed, 2 Oct 2024 at 23:54, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Miklos,
>>
>> in the discussion we had you asked to avoid an entry tag/index,
>> in the mean time I don't think we can.
>> In fuse_uring_cmd(), i.e. the function that gets
>> 'struct io_uring_cmd *cmd' we need identify the corresponding fuse
>> data structure ('struct fuse_ring_ent'). Basically same as in
>> as in do_write(), which calls request_find() and does a list search.
>> With a large queue size that would be an issue (and even for smaller
>> queue sizes not beautiful, imho).
> 
> I don't really understand the problem.
> 
> Is efficiency the issue?  I agree, that that would need to be
> addressed.  But that's not a interface question, it's an
> implementation question, and there are plenty of potential solutions
> for that (hash table, rbtree, etc.)
> 
>> I'm now rewriting code to create an index in
>> FUSE_URING_REQ_FETCH and return that later on with the request
>> to userspace. That needs to do realloc the array as we do know the
>> exact queue size anymore.
> 
> It should not be an array because dynamic arrays are complex and
> inefficient.   Rbtree sounds right, but I haven't thought much about
> it.

What I mean is that you wanted to get rid of the 'tag' - using any kind of
search means we still need it. I.e. we cannot just take last list head
or tail and use that.
The array is only dynamic at initialization time. And why spending O(logN)
to search instead of O(1)?
And I know that it is an implementation detail, I just would like to avoid
many rebasing rounds on these details.


Thanks,
Bernd



