Return-Path: <linux-fsdevel+bounces-51714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F467ADA9D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218AE18871E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3811202961;
	Mon, 16 Jun 2025 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bMTh2iGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE518E025;
	Mon, 16 Jun 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060101; cv=none; b=AS9NAZq9TlGYjvPZSMsX2jST+rN2KTFjXjhGf5kUFyQLPCz1x5aIwHzKmotXhnDohyfbFA4IUWj1pWsPPDvvGaEs2V5OycgcbGWRsTEp9tC9rhenWnl04lJXgg8g9VCUFZ1/KBfttEeN9gqAkTMCnPk6JsT8i54Ai9tYkiG321A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060101; c=relaxed/simple;
	bh=+iIPmuYIR6F5LD+a0iF6PdJq5ltgbL412UY54MPIgwU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WCHTV0YOhCLN6m3fgCdS5C4yycleIz5DsmVNmL9oMmvR/8bpoW2BLWBjNptNrhQoUjU8KSLLVhunFk1QY8wqXya4azZnKdSz0/LUEyw3rFC2xCVlC4a6vF+EDSCjGlutZEDvxdXG/Av8z0RbPqFPWCeux0GwR8iz2QG5GhVXOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bMTh2iGj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=+iIPmuYIR6F5LD+a0iF6PdJq5ltgbL412UY54MPIgwU=;
	b=bMTh2iGjANzqA0fkenXxijxFfsuq5hBLU1dpaT+kTeuFL1+ulIVofkiZUY3EnO
	Y007zeOvFFxQ12wHOTN3I0/TazA3bjwADonDaQbZ3FwyLeU22khDK25PhTgm+I/y
	0wg1wc21PXlETkky1e01YoGqrfubed6W+NVfVsyTiMVL4=
Received: from [10.42.12.6] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXLrMxzE9okqQRIw--.24480S2;
	Mon, 16 Jun 2025 15:48:01 +0800 (CST)
Message-ID: <41095783-1f43-488b-880b-c0c1245d4640@163.com>
Date: Mon, 16 Jun 2025 15:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: Reduce some calculations in
 iomap_adjust_read_range()
From: Chi Zhiling <chizhiling@163.com>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250616054722.142310-1-chizhiling@163.com>
Content-Language: en-US
In-Reply-To: <20250616054722.142310-1-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXLrMxzE9okqQRIw--.24480S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RNL05UUUUU
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgA9unWhPxTW0uwAAsk

On 2025/6/16 13:47, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>

I just noticed this patch has an issue, please ignore it.


