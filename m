Return-Path: <linux-fsdevel+bounces-25145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C033E949672
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EB11C21CA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF9481A3;
	Tue,  6 Aug 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="tBAcR+Wg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drwdgXhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FF22331
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964286; cv=none; b=RdzTESSaWhwbDLPtOx5GsRzrB+9LMUz1ZAhwVW8qUdIDy7eCsRv+dOQ4WkfCbjkr/m7xg4mMV3EEtCdDtOMNFm/wAVXPI6OlDEV3V1rtRjL1mjd73gH5AaXZKkiJ4G2LJYjL8pA2/1x969/kPoXtJgwTinefk4SnYYYIvMkW2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964286; c=relaxed/simple;
	bh=HZQb4Ra4fZL5Fv7NnPvoAXkodT2JwCG4SJgEjIgpm/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5z3gldFyRc1MQcBOc8d43BP5FdW1J20KH9kSNhgtr6ypx/EA5GO3zZ6avGUvy6cZmYeSotz89rzvWRSdhvj1FwMkf++QjvOKHjUGuv1sNderRlBNlRSzbqtUm17URxHH/E2nkW4Wsle0lY2IEPUD978S76io/mFDCOyM/JD2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=tBAcR+Wg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drwdgXhj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 36EF0114AB22;
	Tue,  6 Aug 2024 13:11:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722964283;
	 x=1723050683; bh=ina3UfqMkBKENBvx+REx/5aIkefG9mY3I/Qg9oqrEXA=; b=
	tBAcR+Wg14lPXN7E2V52de+toh4O8qog+qYd7kJhmmLN1vamq7iWnVi5zjvTAQ+v
	4jevuW5gop1WFYFs9w1/fPWmDB2/NegyoT9jcjxhM5ZO/LFnhdt/QvDAbtgu3ctt
	dwNyMt69CckiJw3sGdim0s3KUYR6xroBMRYSjk3Ff/uiMfm7h01qkyGXKZR6QZMm
	s3tBcdEHci1TgRUzEtDGGyw3M2jhUbtsikk5nKXgbYNHGZozbC1rwoJ7mebJtnOH
	aluRMePkKLCsuS2cec04Ipk0Qq3/d4QsnsD7Zm3k9YtspmSw5zJJdAn1WsKVTD49
	67WnTsj+2SeywW4CgQ8tFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722964283; x=
	1723050683; bh=ina3UfqMkBKENBvx+REx/5aIkefG9mY3I/Qg9oqrEXA=; b=d
	rwdgXhjduOtGJbpnqfmVotgiVVCFOzuZuEstT9/OtYty9zBQAQjWzbae94Q1vBKc
	HaVLDKFapALAfHmPRg6Ge1UbQB+85QTSiWfGEBuAKY9sg0UQpIZf6s6zbT5hEEFV
	AEUYZ3DjkH+lEofgEwvve6rUFREN4CvMuYJyJjASMO9AfiIuRbg/eb57VijiB/0s
	oiBEJMpEHHnsWYT1vsNwM090UepzWMcoU5sc+Lg97IYSA2ONRZTEbs+Ye0j6blIk
	65HuYdYJT5xo3xa0Vzb+zZEgvwdkavj14JlLXOHGgpuhBiIB7W8CwdU9zQQbqgoO
	TnXTpUWW0xwlSbwS2y74g==
X-ME-Sender: <xms:OlmyZl089ke7NvrH2r4vB8GWlnt_DsgOB3XnTn70mAUe1Q7w-X2xAg>
    <xme:OlmyZsFdxXGxKhgd5QK2WJlZk0GzDQTdZDIxE1XcOZABb6yLnEvnGNrr_Uw6gyl8J
    4eNMQk0uSc4XXua>
X-ME-Received: <xmr:OlmyZl6pkIbGIFKlPbKLXaZiRoQoLA5QNO88yMiBxloZkKslkq5zlfnKR-a3cMzbGWtZ3R_FysJ2z9lF_C4-HFxCG0I9hK6R8p48WoTMGEFnLt84qRVS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:OlmyZi39TS-wEh7DlIC6k9NOowq3SI5_8l3TiE9zE-Xz9PGAn9g4Jg>
    <xmx:OlmyZoH-at2TjnDso28Odrj2IzLCJ0NhhWgZCUw3RMRvQ975PmQwOQ>
    <xmx:OlmyZj_fCGUbO5hvYHjUgDolnTAs3wA9IcSoBfvvEO2BQKAmEqnEQQ>
    <xmx:OlmyZlk5C-DndzMeEnltLrnDs-HkfdoIxlRsDWrk-EqhcuTo03dShw>
    <xmx:O1myZt5yjxdDN121j-84jYJc83CvE7gaGKwYfTRzJERMPXEvENZmcalJ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 13:11:21 -0400 (EDT)
Message-ID: <d3b42254-3cd0-41f9-8cc1-fd528c150da2@fastmail.fm>
Date: Tue, 6 Aug 2024 19:11:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>, Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
 <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
 <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
 <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
 <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
 <CAJnrk1ZMYj3uheexfb3gG+pH6P_QBrmW-NPDeedWHGXhCo7u_g@mail.gmail.com>
 <CALOAHbA3MRp7X=A52HEZq6A-c2Qi=zZS8dinALGcgsisJ6Ck2g@mail.gmail.com>
 <CAJnrk1ZRBuEtL65m2e1rwU9wJn3FTLCiJctv_T-fKAQaAbwLFQ@mail.gmail.com>
 <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/24 18:23, Joanne Koong wrote:

>>
>> This is very interesting. These logs (and the ones above with the
>> lxcfs server running concurrently) are showing that the read request
>> was freed but not through the do_fuse_request_end path. It's weird
>> that fuse_simple_request reached fuse_put_request without
>> do_fuse_request_end having been called (which is the only place where
>> FR_FINISHED gets set and wakes up the wait events in
>> request_wait_answer).
>>
>> I'll take a deeper look tomorrow and try to make more sense of it.
> 
> Finally realized what's happening!
> When we kill the cat program, if the request hasn't been sent out to
> userspace yet when the fatal signal interrupts the
> wait_event_interruptible and wait_event_killable in
> request_wait_answer(), this will clean up the request manually (not
> through the fuse_request_end() path), which doesn't delete the timer.
> 
> I'll fix this for v3.
> 
> Thank you for surfacing this and it would be much appreciated if you
> could test out v3 when it's submitted to make sure.

It is still just a suggestion, but if the timer would have its own ref,
any oversight of another fuse_put_request wouldn't be fatal.


Thanks,
Bernd

