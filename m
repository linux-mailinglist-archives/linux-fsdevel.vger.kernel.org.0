Return-Path: <linux-fsdevel+bounces-26957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BE95D4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E32F2847F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AB18BBB6;
	Fri, 23 Aug 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AP6ZkFLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82485191477;
	Fri, 23 Aug 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436149; cv=none; b=JsSbVGwnOi0EjQZyGK8MghG033f8AOLrhk6JkhDwSMDJNXOAeePGGm49wa7Zs8WrsrhOWWFyyO71xysO8oYwXtDHK7w/IGEuL2IV9t4mNJsXKU/UChyS6CEjUXpd4Qg2ddWKy/+xi3KG2F7a2ofCBlzrW69ZchyKtWnegDUBWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436149; c=relaxed/simple;
	bh=6iE6EpMVFQTnomSfD6spVViCNx0E+yjK/1fwwMWESyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH8d1aeBk4INjKrIOQIVons/mtEp0hKSwSerr2OTZm9EcFUOpPAZG1GFwnByUMrRMD4itGYEMKds0Ffh8W5LVyr3BuajX3ebg60MTKwRGxQtcS8mosa3yLkeYdwhY97H/HLcWYoUHoC+4RiI9Wv5TcmC//Igo6PZfY9jahpGzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AP6ZkFLP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=clCmG8G9dBvwhH0tbo2GwrYwc3bQaYwK9UUpCfBe/8c=; b=AP6ZkFLP9gj6Pi7g0IhDwnymUc
	WJFMX2oLma17PmeKhgOMFJYTb/e0iNL3UaOKSfnnV7gqc9VYuZoy2BOILRvztPYbDbMHO0X9OoN0S
	hnoYeOhRBcfNTGXNhEcI2fFjPadZn8TamTbWylctmT/vjC/ETNZ+kM+LzkeGPgAnTvebxpvh6IUKz
	i/bamH0/6LpQ56JlciAdnBs2YlWQnK/0BvwYeHFAQwHrZrT4zSCSTgxJ1JxTnJXyQjTNDL7kePGdA
	Na+dmL94M57QHWylan6JIRPoX9/5Hl7EiRsZF5dLnPqI3JGGbw6zwRkTrM54IDJAnSiFquLY3Yn2O
	sB+DpH0Q==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1shYc8-00491P-BK; Fri, 23 Aug 2024 20:02:20 +0200
Message-ID: <ebc06acd-f729-dcbf-b8b3-faf0b6cab9d2@igalia.com>
Date: Fri, 23 Aug 2024 15:02:13 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Jan Kara <jack@suse.cz>
References: <20240823142840.63234-1-gpiccoli@igalia.com>
 <35febff2-e7cc-4b57-9ba5-798271fe0e3b@acm.org>
 <20240823170559.GZ6082@frogsfrogsfrogs>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240823170559.GZ6082@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2024 14:05, Darrick J. Wong wrote:
> On Fri, Aug 23, 2024 at 09:11:22AM -0700, Bart Van Assche wrote:
>> On 8/23/24 7:26 AM, Guilherme G. Piccoli wrote:
>>> +	bdev_allow_write_mounted=
>>> +			Format: <bool>
>>> +			Control the ability of directly writing to mounted block
>>> +			devices' page cache, i.e., allow / disallow writes that
>>> +			bypasses the FS. This was implemented as a means to
>>> +			prevent fuzzers from crashing the kernel by overwriting
>>> +			the metadata underneath a mounted FS without its awareness.
>>> +			This also prevents destructive formatting of mounted
>>> +			filesystems by naive storage tooling that don't use
>>> +			O_EXCL. Default is Y and can be changed through the
>>> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
>>> +
>>
>> Does this flag also affect direct I/O? If so, does this mean that the
>> reference to the page cache should be left out?
> 
> I think it does affect directio, since the validation is done at open
> time via bdev_may_open, right?
> 

Indeed, good point! It does affect direct I/O, I've just tested in
6.11-rc3 using dd (with and w/o oflags=direct), same result.

I'll resend, dropping the mention to page cache - thanks!

Guilherme

