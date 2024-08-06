Return-Path: <linux-fsdevel+bounces-25123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700239494DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B1BB21223
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688C1F937;
	Tue,  6 Aug 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="RIGwf2Fy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDJ86dt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382A182C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959029; cv=none; b=S3+0hFg3mBM2IFN9Rp6HbLFwGApXIPn62FlcQ56XPePXnK0J0g4XwhAGbZOkFi7oFqqk+Y8sol0KyhoR3mwhWpcbSL9FpW2YFJw+HZBz/1WKsaHMhv8icOrYJolXlankrchptLihM+0opuUeH6igbKOHDZCQTL2z6EjyZQrGaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959029; c=relaxed/simple;
	bh=A913mzl4HDXoDDZLuIjA5DUTf0Na/nmPaS7aofdXvAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX3jLUiEJHyBs2iWkN43sJqIlJrhUyOzIIHwLYq1knBtYKIITmUNkIdEeikrrcnWCHyGn4samXijMv0PUham6mkbYqCWU+x7D5iJNo26qmaNdlvszEIvPqJ2IRL2sS56gNoz/kRxBsjGN469n+X0oSEGCeYSEp1lrbzNRAWOOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=RIGwf2Fy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDJ86dt2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D425F1146E8D;
	Tue,  6 Aug 2024 11:43:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722959026;
	 x=1723045426; bh=kY2wqgjOQc9d1GoR5kn8qQM4Y8UjUkBbzh7Ru4RCDRQ=; b=
	RIGwf2FyPS1D86NLtHO+0MklOqK/VJARyrV48SZuA9ldsJk/xAVS9O3sJmbR8Fsx
	juKDDYBpXWv38ndy9WqTRpPBPIJBC4My4mWNdDl8HAZkvLq2NKxoC1dJ09iFxZHE
	i6tlUeY69UEejg6YzIItIhDm60VUfZoEmLNlDSkU9EfitA53IoLef1otulBSPt2X
	QwifTDSuHkgh5qK76Ykt33Gcx/vMdrgkWlYXM3IqhjsqejrvoEErv3OmI80lf/vv
	pPRMhMF2VOh83B5nckEKN96mMJbIjmse4O1RD17NJSZ0jqSeBT6dRK2EFsjCMYai
	fcsLvciUDGJhhEVf+4jPbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722959026; x=
	1723045426; bh=kY2wqgjOQc9d1GoR5kn8qQM4Y8UjUkBbzh7Ru4RCDRQ=; b=q
	DJ86dt2R4/W42bSMN9qgCXlW9hdC4xjM+0HvpFHxiQ76dZaYXgoXOyM8QuvzLLKL
	5A9AV+MulGlq3tOMqQIW/XiyxC5pjy9Wfqbo+41DV8hiaY8mFfeW4eb3vRnqdYsw
	2n3fdPuhWt6juVzy+/F/OFJAorw8cW0chJeC8PYlMdtHgCAAMm3uC3AmutPi9030
	nMSEImOpEqcOTM5M+aT9syVSjB0gZp1U+c8X0FYBYQ6EG8JuSiUtETlAoTFEolfZ
	birU7La6XsxfXbEIBWsxCxmv5P6mk2RH0tsxTMaLbwBxVzp1ZnoSFObFsDHjUaTL
	0vwxV12BEnPvdAG/l0lNQ==
X-ME-Sender: <xms:skSyZkBZ9St_V-ZTdG6V70K7ptwqeFfNY-gLVDsdZ_gIjMQ6CcDwiw>
    <xme:skSyZmicnDS-h8qzwvpc_TlCcoJKqvBFjxBJiJ5NbiBhSruvtxklgz4FHYGFiItyu
    CduVnBUk_qRr5vP>
X-ME-Received: <xmr:skSyZnlgdHIyTZwh_eEnwRyD9i1yx_pV3vBsKij0jAUKYYakBWfDRvggMw0BrjYS3YJ9hRfgIcQQXzDvjotXHjKt4f4XuBrwATofk4h4loeM7dl97gEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:skSyZqw1qWyZT3_LjXnJs4QJddvdslNRGzZeGjhkFZfOOZdnXduTLQ>
    <xmx:skSyZpQmGCnmzteIDCmpFiKgxFLfZ4Y3qrfp0wbjdxGdjDwAk6RwtA>
    <xmx:skSyZlYBSJstMpwjDxubYflA0zMWPo1XdC1eA3FFYrHawV-a0kAyGg>
    <xmx:skSyZiRnwRAK2krC_LOK-Upsfy7_-nDj9g_It3n8JikiVBzHbAmYcA>
    <xmx:skSyZoGOazDMMYZUVWDToQWhioUrXTF9EH-S-AQ_4HcnuuZDR-0QBW9t>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 11:43:45 -0400 (EDT)
Message-ID: <1dd58650-0704-4974-a0d7-765aaaca53fc@fastmail.fm>
Date: Tue, 6 Aug 2024 17:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
 <CAJnrk1Yf68HbGUuDv6zwfqkarMBsaHi1DJPdA0Fg5EyXvWbtFA@mail.gmail.com>
 <fc1ed986-fcd6-4a52-aed3-f3f61f2513a7@fastmail.fm>
 <CAJnrk1YVC58PiU6_gJno7i439uHUkcLDzKY4mXmupybeDO7LWQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1YVC58PiU6_gJno7i439uHUkcLDzKY4mXmupybeDO7LWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/24 00:10, Joanne Koong wrote:
> On Mon, Aug 5, 2024 at 6:26 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>>> @@ -1280,6 +1389,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>>>>                  if (args->opcode == FUSE_SETXATTR)
>>>>                          req->out.h.error = -E2BIG;
>>>>                  fuse_request_end(req);
>>>> +               fuse_put_request(req);
>>>>                  goto restart;
>>>
>>> While rereading through fuse_dev_do_read, I just realized we also need
>>> to handle the race condition for the error edge cases (here and in the
>>> "goto out_end;"), since the timeout handler could have finished
>>> executing by the time we hit the error edge case. We need to
>>> test_and_set_bit(FR_FINISHING) so that either the timeout_handler or
>>> dev_do_read cleans up the request, but not both. I'll fix this for v3.
>>
>> I know it would change semantics a bit, but wouldn't it be much easier /
>> less racy if fuse_dev_do_read() would delete the timer when it takes a
>> request from fiq->pending and add it back in (with new timeouts) before
>> it returns the request?
>>
> 
> Ooo I really like this idea! I'm worried though that this might allow
> potential scenarios where the fuse_dev_do_read gets descheduled after
> disarming the timer and a non-trivial amount of time elapses before it
> gets scheduled back (eg on a system where the CPU is starved), in
> which case the fuse req_timeout value will be (somewhat of) a lie. If
> you and others think this is likely fine though, then I'll incorporate
> this into v3 which will make this logic a lot simpler :)
> 

In my opinion we only need to worry about fuse server getting stuck. I
think we would have a grave issue if fuse_dev_do_read() gets descheduled
for a long time - the timer might not run either in that case. Main
issue I see with removing/re-adding the timer - it might double the
timeout in worst case. In my personal opinion acceptable as it reduces
code complexity.


Thanks
Bernd

