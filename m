Return-Path: <linux-fsdevel+bounces-26394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF27958E2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A1B28491F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B314AD38;
	Tue, 20 Aug 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RMzGxeZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2081494A8;
	Tue, 20 Aug 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179395; cv=none; b=BBsBHWwQdg9/CAx89qGFOtEJrrZdKK3Qsm4LTqapL7rTaiIgyD0QTVg0QvV81fP6kxeD6+UvbBae+Uqu36nRBZS81ysr8RSe8lNVhZB1zhT9FZQNaeyIQ7goWl0Mzo02hET+MafHcaljS6wVOUmxuZ4Pv9eOWq89FTauUBNrBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179395; c=relaxed/simple;
	bh=LlewooNDq7KfLk5TjBHLrzvFtZnS4ZIA/enB98S8lMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN8cKflCJ0jemdhdQYLFvXx8aP5uZ1XPnCbI9H7g/A51DJtnfxGdDthhPOE6zOUjCYv5cfr4PHFE8zThMItEMinHk5Vupp4OC+CETqZFRvvZITiQ6sRB0Ka2GkGIvgr83m3TvYD7edlZ/5oa4iwk17G+HdbGJhi9fgS/s3mb/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RMzGxeZD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oe9q/2PST+rNEnrpwAFN5Ef5y6CtfM31QjRM1LKMFK0=; b=RMzGxeZDp526A1pZGk28lYb/hh
	o2xpfiSvGWlT4zuLcvP6aCcaJvVQGnu8VDBEkZFTpJppoDKtqaOY9pBTCjEUsLrrPYYF2eazilj87
	SktT11x6OFUs/V2yCT++wQtjGwoHJIq8Q1CyE45WerqXXKQs5ykctDW3+RCEsGabEk0ixyP10deAK
	w1zliqxiN3mTX73t4vjMZiY2BI8mTYEjwFYU/fijnHpdsW2A3Pf7Z3Hv0ASCwy89EWC0o0XbYTmY4
	JAV2WLaPHX5XA8rYhDIfSTrc9UnITYKJ6ue77Y6jZE3xXXO4lZSYyvRA2tRESszfD0Hv6zgjK9BWp
	VGbGohEA==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sgTor-002jTJ-4i; Tue, 20 Aug 2024 20:43:00 +0200
Message-ID: <170545d7-3fa5-f52a-1250-dfe0a0fff93c@igalia.com>
Date: Tue, 20 Aug 2024 15:42:53 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20240819225626.2000752-2-gpiccoli@igalia.com>
 <20240820162359.GI6043@frogsfrogsfrogs>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240820162359.GI6043@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/08/2024 13:23, Darrick J. Wong wrote:
> [...]
>> +	bdev_allow_write_mounted=
>> +			Format: <bool>
>> +			Control the ability of directly writing to mounted block
>> +			devices' page cache, i.e., allow / disallow writes that
>> +			bypasses the FS. This was implemented as a means to
>> +			prevent fuzzers to crash the kernel by breaking the
>> +			filesystem without its awareness, through direct block
>> +			device writes. Default is Y and can be changed through
>> +			the Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> 
> Can we mention that this also solves the problem of naïve storage
> management tools (aka the ones that don't use O_EXCL) writing over a
> mounted filesystem and trashing it?
> 
> --D


Sure! At least from my side, fine with that.
How about the following string ?

+ Control the ability of directly writing to mounted block
+ devices' page cache, i.e., allow / disallow writes that
+ bypasses the FS. This was implemented as a means to
+ prevent fuzzers to crash the kernel by breaking the
+ filesystem without its awareness, through direct block
+ device writes. Also prevents issues from direct writes
+ of silly storage tooling (that doesn't use O_EXCL). The
+ default is Y and can be changed through the Kconfig
+ option CONFIG_BLK_DEV_WRITE_MOUNTED.


But feel free to improve / change it. I'll wait more feedback and
resubmit with a refined text.
Cheers,


Guilherme

