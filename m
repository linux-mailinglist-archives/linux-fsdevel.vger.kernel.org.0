Return-Path: <linux-fsdevel+bounces-23026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452B925F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56E0292B95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4251741F4;
	Wed,  3 Jul 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="PNEMt4tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjFnFVwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376217164D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007996; cv=none; b=LMn3LaAWleKpsZDyPqNh6SsAc0IkoFCvpRZRLTL24LU7eNE8JGIKDFZaY9cIsNoYa0yMwUjwpb98GNYKMnEaRQhr6u1BEEicW3SJEn0nVCwYRZOL8vCyzl4585JB2PCuoaGI5v72aJG41uOHJ/Amf7Yn8dMDwaloQFmI93UnlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007996; c=relaxed/simple;
	bh=smqpaaIk61uoXjUgjoo6Fg1b0sk89PQm2b/c/OzM/s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcrNWV82VNa/WsnCdk7UbmEzx2YzYYIJFj6k5pJd1uZqvjvNbRrC08bVZYbv5erVvq5gppRTvWVx5Y7IwBaeHL4n8O4RIyDw0iKu7Tg0XiSIrG92aV8qH1tuC2mub+7Uo7/0uu8RTc3O22JX5w7j+FhkX6xKH6pPxYNE/5EtjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=PNEMt4tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjFnFVwq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id CC5091380634;
	Wed,  3 Jul 2024 07:59:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jul 2024 07:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720007993;
	 x=1720094393; bh=smqpaaIk61uoXjUgjoo6Fg1b0sk89PQm2b/c/OzM/s4=; b=
	PNEMt4ttePt7Xod4+polDp4DpBeNmiWTNIPkfPQdMdXzRdjIqBsMMdzXL+WDTzmA
	2dLepfz4JV8hhZlvbZiD4Uth7bzTpXp/XqCu4/eWQ5x7UQ/Fq2cCXhS+6R4wXf9X
	LdVOScK48v62IZqXtk2cLbrgGf4n7p7q3YrSSM1i256xXO30YQVkEZEqueKn22Pc
	KbgpLCreTkmILFoDFuP+NtknNf6rOIQhmFuE4iqoHwy9oiPZdHSUvSx9XBG1OkCh
	4obXGJ/MStLqnoElKIgeTWlo5iy9627sN7lRJnKkYumNnQZ3jsRPBk6KO0FlreGP
	csl8OoRxwa67rWx/TK4ETg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720007993; x=
	1720094393; bh=smqpaaIk61uoXjUgjoo6Fg1b0sk89PQm2b/c/OzM/s4=; b=b
	jFnFVwqUkTHQDYIVQj6psRnHjrjDYKwT4HRKjBnXynMpGL56WGtxB4u9LzPcGew3
	bG5yl2J90Zd4TxEpST7vI6zJRPWBqAALHIejVNtxpJOg9EtaE+BONH0QnFjMhPgr
	+gqsfeCfI1qf5huXhek5fHGXE0LEMskJLHfIXRMCoe0JkbhbHUFeJfLS2jw5pjD4
	rDbGTjrzqV/c+fZjwqknW1Za+D22qzZHUaamp3OufKWyfO7Lu+jBrh3MJbWK8MmU
	X0eSwvOy9segvlfVn9lJuQ/yUBJvpvClpLTLKm3KNVnHqs2pRamlp6vzlwTMfrwW
	c4JilkfOKE8/rQfUQROGQ==
X-ME-Sender: <xms:OD2FZo60VmQXA0QhNEhV-zeO7x2mVldvIfZ68rlFWa0T_GVRGaqlzQ>
    <xme:OD2FZp6QAH76CjXQ2iQbOi4ZuyhisEQmsDmsqs9izn6Je-EwGXAnpM3fpiST0VvsR
    PhPzfpk3R5Q0eS5>
X-ME-Received: <xmr:OD2FZnffM3Ua1Nd4_e9Er8EwIduqovgDwcPfdvNnVe5aeHyFgv4VGlUHdMVsaR9Myn6-htJ97OV9oh82y0pTbG--HnW_mWbri7Oeb9L3H24a8Ey7fXnX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgf
    dvledtudfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:OT2FZtJ7cvpU__hTIn-mEz9b2Fu8jPgyT0f468lXypLpUxyn5sBEBw>
    <xmx:OT2FZsIo2ftVZ0VOtnGnYT5JR3f2ydNX2quKGrUOhx3XIaQlSOZvTg>
    <xmx:OT2FZuxC06XkSBte9X08wB5s3QHAN3OEqgJ2JBrneB_ai8w2q9ucvg>
    <xmx:OT2FZgIYQTXRMW41Q9P_5g0w6x7Q9C0CfmxmyqcQpM6h5d3gHvxpfQ>
    <xmx:OT2FZg2akLwrHVgq5uJV1BqJI8XnMwBz26t7UOAfMjfdJskeaMsjk3Zy>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 07:59:52 -0400 (EDT)
Message-ID: <ec0bd816-fd12-4008-9ded-eb9b1dca672d@fastmail.fm>
Date: Wed, 3 Jul 2024 13:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
References: <20240702163108.616342-1-bschubert@ddn.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: fr
In-Reply-To: <20240702163108.616342-1-bschubert@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/24 18:31, Bernd Schubert wrote:
> Read/writes IOs should be page aligned as fuse server
> might need to copy data to another buffer otherwise in
> order to fulfill network or device storage requirements.

Sorry subject line and and the description above wrongly mention reads -
this change is about writes only and also only required for writes.



Thanks,
Bernd

