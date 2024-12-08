Return-Path: <linux-fsdevel+bounces-36711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993A9E879B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 21:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F73164690
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586D13A865;
	Sun,  8 Dec 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="nMoH7+6/";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="dEFU9NNE";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="zrv5BGiK";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="kF6a/S8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6437081D
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688169; cv=none; b=OMm5z98yjzdJVcEKTEAZ8I/K2SZKSzZoIzWOJ8Kw5yuKFAx9iatVi7VqHunfDa33sD3DwmrWMEMDM/5wqsQWcv/N14BhvXyPAdrsdAtv1qEsom+/18v663IOQCn9kYWe9EW/yX08FGS/ZXRcR04F5EoU8nsahjYPK7ITClRKX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688169; c=relaxed/simple;
	bh=m2VqCZqc3Dj65shyqCQ+p6IenMEupbhblCcaTGIpM04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucxQ45OGLrvM7wq4nmntT5ujKSGzvKvanq5uVWnO2ieYF/qLTLZ4IODsJLSdgahaeDYrd+TsHZg1T81tOA5HV5ZHSPwEgSUoqIYAiH9wjzlB5+Dsb0BWG2jQO1wPvzJVJ6jnSa2JiPWG71Y/vyYb+6+l7krvkHexY6KlnyQ4acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=nMoH7+6/; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=dEFU9NNE; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=zrv5BGiK; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=kF6a/S8u; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:808e:8168:83e7:b10])
	by mail.tnxip.de (Postfix) with ESMTPS id 79799208CC;
	Sun,  8 Dec 2024 21:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733688158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKcATS5eL0v9NqV11yKQ3Ui01Vh2bun9jcT+tLUCsPI=;
	b=nMoH7+6/jSpNkUid9BOnFIwA8ooYm/6w2t1L5tX/oUMQ4DscXq3w7F9R96bD/tiyFCK1wi
	HYShRl/gPj52ZHm0YANlNDHoKhHUxi2de+qnSupWhzOj4qfjEQQAuMhVjRX9PtSnw+Delk
	meumepGksHCRc8ke+sVJckQEJHaJV8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733688158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKcATS5eL0v9NqV11yKQ3Ui01Vh2bun9jcT+tLUCsPI=;
	b=dEFU9NNExgGsZWVIQRwMRg2ql36UTOncWaO0i61t6eH1hgAxVgKWKJMVsxXrjSvmX2bTRc
	571zP3y1nmB+X9Bg==
Received: from [IPV6:2a04:4540:8c05:f700:b769:775:6562:48b8] (highlander.local [IPv6:2a04:4540:8c05:f700:b769:775:6562:48b8])
	by gw.tnxip.de (Postfix) with ESMTPSA id 0AE66700A55F5;
	Sun, 08 Dec 2024 21:02:38 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733688158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKcATS5eL0v9NqV11yKQ3Ui01Vh2bun9jcT+tLUCsPI=;
	b=zrv5BGiKFO74F72MGb3PNEFsiR0YIvuAWeF3c6BZvsh4T4RW/FKw7H5HgkcupGWeIfuSfs
	6nHK0YjbQIJHHjAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733688158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKcATS5eL0v9NqV11yKQ3Ui01Vh2bun9jcT+tLUCsPI=;
	b=kF6a/S8u9kUasnmUU2ENpGRJSMn5bsTbGKe8ovugnYRzsFqlQJRounL8oZfe1ty/9JQW/K
	DBh/u1gpB1oYc7JSpA7q43Wj3L7pLtEsC1FPHhcjdUdRtTAKBXjU74p3eZb9B/k/kpMSdr
	LqI+4/j2wacq1RLjhkEGMIQqHTM/WP8=
Message-ID: <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
Date: Sun, 8 Dec 2024 21:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <Z1T09X8l3H5Wnxbv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/12/2024 02:23, Matthew Wilcox wrote:
> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>> me.     
> That's a merge commit ... does the problem reproduce if you run
> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
> between those two.
>
> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
> of an interaction to debug ;-(

I spent half a day compiling kernels, but bisect was non-conclusive.
There are some steps where the failure mode changes slightly, so this is
hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
the nfsd-6.13 merge ...

d1dfb5f52ffc also shows the issue. I will try to narrow down from there.

/Malte


