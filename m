Return-Path: <linux-fsdevel+bounces-20157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B98CF00F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7E9281B30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6085942;
	Sat, 25 May 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mHu9h5b3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAeJcGYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFF85297
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653784; cv=none; b=D9mvPEX2OwTHfpFiZRifMzb94mVZkB5RffiiGmyJ53kdd5LKpKz5Ri8SBBs3EXNNd7x0yFnfsooyESSoqr9Y2R/pWMtNgZkajwDkRTxxBVTFbgCB9QrwE7ubrLhrHOTcS0UQ5PuyP5wcR5wAi8Pa4knRd0pSSB4OttnknMb82a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653784; c=relaxed/simple;
	bh=DmIhXaOQYDQI5uTth1MAR3L9gq+Q0dJmO8lVk0MMN8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5H+AbiGp84U0s6L1RB7ovIrImKj6XocK5v5ND5gEtVjVD6ZH6/EuMIOzMj96UJw7gVil0hsXcbTmP6Sn0Mg8xiQL+SKjhcE94rqYxEB3AWjtTHdI9zCNi4s5EK1BK357WtEe9a6pH29SRPGwCT1rgE/wdc+Gcwk7JQlUqesMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mHu9h5b3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAeJcGYh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0264C13800D1;
	Sat, 25 May 2024 12:16:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 25 May 2024 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1716653780;
	 x=1716740180; bh=vo5cESYwtJO3692S7y2PJx/93ELiW5zdblFNPAgtTNM=; b=
	mHu9h5b3/z4GqM1LqKLshch5ob/XVeGvliatfei9kwEAFLAIcmpF4N/cqMqUDyW7
	onrQVAdn931/bxV6cIKF9j4zeMK+FbxKn7Q5fUnKwLL2K90tY8OJwMcbZLr/rXGf
	KpGiH2iTo/zXiJdiown5314JCr6mIpCuiFq1bkUx2qw5+YjSX3R5N7w67KHRTwPu
	TuyPF/j+G/P8AHi8F9tvbRbK08xfwscOB268IzjHkf8+j1JuUaSRSdnJFWph5Jxq
	RHWltWrBrvjQjVjsP+LjJy2Fv2VBlri56W/vlOB97fJI7Mi2zXrefHagkogBKeEo
	svwqcRDsoEjFnhK22aZ9Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716653780; x=
	1716740180; bh=vo5cESYwtJO3692S7y2PJx/93ELiW5zdblFNPAgtTNM=; b=J
	AeJcGYhFUjr2kUTyz/dqMj4rjYkGeK9OByeRbc7O+kHG/30Am+LZ5hxq5R+2hmUD
	YG+aTIWj2D7+IOMnm0NjKYK71EzbRSuKEY9DTfLq9Zn8iIpxUqX+Co/HEkHXNj8A
	jyhEhPMAeHX7yo0//f+oyf3ukUeTZ5yiuTWgK2hOTd3/xwJaaQPvDl/hxmggdCh1
	DXtZilzXAlz7V/pxthCYLZ71xgXon0frYw/+CUbgI6AOJn2r8EV5zdb1MhpQLl6v
	oSSs3rfGN1Ws8PhgLxVR51HB5BUFCGy5nYZKWK4wdHcuZoubRU7ToUBMGjpAkyNs
	HzmIb0u77FbBIkF2EYsLw==
X-ME-Sender: <xms:1A5SZsuO_tI7HKkwdURP4inKZ5YFfIJQrGHr9ErHE2rXaaW35kueyQ>
    <xme:1A5SZpdKx38dQaOZ1ERlnLoof8p4pNqrXlRMyQHHw4i668FojyC5HzlQ-N6MBDyC_
    rgPWY60w39LRNih>
X-ME-Received: <xmr:1A5SZnzEciFzTiV53MBPaU7-saeFgmiP40VIQrB62y_IKvNSEv91PPYCgjAUhM5nGk9jtatwG_n_nZ8zrBEoFcRL-oeVVYhwLbsOQ5NdQXtqEkKONAgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejtddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:1A5SZvN8mEk_G7vf6hp8sXSfNvairT72XvtOcZGxF0yw2QOZ3MkefA>
    <xmx:1A5SZs9Jd3xorHGquOCaiL6CDaLSp8JGWhZQP4weKUzKXLSvyPzsjA>
    <xmx:1A5SZnUD1TgmDr3Vd2PN75ubrFjPdh7hJI16fVhErgb3A-xo-2P24Q>
    <xmx:1A5SZlcoR6yBnBhAW6-Q5-jMNLFmptkfDvceQZ6JbdEvSsFE_gToQA>
    <xmx:1A5SZraCLLGo2eomrzi0XQdvh-Iun96fI78wofOVAQIMRcvruNdNZRSq>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 May 2024 12:16:20 -0400 (EDT)
Message-ID: <42b358bd-b7c9-48fa-bfcf-5f71b14a92fb@fastmail.fm>
Date: Sat, 25 May 2024 18:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse passthrough related circular locking dependency
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <e67b7351-1739-437c-bea4-bb9373463339@fastmail.fm>
 <CAOQ4uxiObdGjKoNx2o2kXzbBKPc9EKRa6K7cQ0ny0P4LN_UuWw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOQ4uxiObdGjKoNx2o2kXzbBKPc9EKRa6K7cQ0ny0P4LN_UuWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/25/24 17:40, Amir Goldstein wrote:
> On Thu, May 23, 2024 at 12:59 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Amir, Miklos,
>>
>> I'm preparing fuse-over-io-uring RFC2 and running xfstests on
>> 6.9. First run is without io-uring (patches applied, though) and
>> generic/095 reports a circular lock dependency.
>>
>> (I probably should disable passthrough in my uring patches
>> or add an iteration without it).
>>
>> iter_file_splice_write
>>     pipe_lock(pipe)                    --> pipe first
>>     ...
>>     call_write_iter / fuse_file_write_iter
>>     fuse_file_write_iter
>>         fuse_direct_write_iter
>>            fuse_dio_lock
>>               inode_lock_shared        --> then inode lock
>>
>>
>> and
>>
>> do_splice
>>    fuse_passthrough_splice_write       --> inode lock first
>>        backing_file_splice_write
>>            iter_file_splice_write
>>                pipe_lock(pipe);        --> then pipe lock
>>
>>
> 
> Not sure, but this looks like the reason that ovl_splice_write() was added
> (see comment above it).
> 
> I think that fuse_passthrough_splice_write() and
> fuse_passthrough_write_iter() are probably deadlock safe against each other,
> so I guess we could teach lockdep that passthrough inodes are a different class
> than non-passthrough inodes, but I think that is not easy to change
> mid inode lifetime.
> 
> Also, I think that mixed passthrough/dio mode may be breaking this
> order for a given
> inode - I cannot wrap my head around it. Will need Miklos here.
> 
> Question:
> mmap+dio does not make sense so we let passthrough overrule dio for
> mmap in mixed mode.
> Does splice+dio make sense? or can we also force passthrough splice
> when inode has a backing file?
> 
> Another thing that we will need to do is annotate different lockdep class
> for nested fuse passthrough as we did in ovl_lockdep_annotate_inode_mutex_key().
> Lots of fun...

I'm just in the middle of other code - I don't want to get distracted
too much right now, will look at it in more detail later.
My test had totally locked up up - lock annotation is not enough here.
From the traces and from the test this is mixed dio/page cache IO - I
think that is the same test that had found issues with mmap and
FOPEN_DIRECT_IO in winter.


Thanks,
Bernd

