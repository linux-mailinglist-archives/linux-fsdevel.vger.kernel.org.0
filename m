Return-Path: <linux-fsdevel+bounces-16356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E060889BCAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 12:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CAB21419
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09748537EC;
	Mon,  8 Apr 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvTg4tiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F912535D0;
	Mon,  8 Apr 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570795; cv=none; b=qQTezuKBvFKA6ZUcKQcC/tYUaKoCU96Irv+vA7T+ZwOPBo3yqoZ8wfd9iwdfiWiOjzo3Iz5I0LL+NcDIRa8hpQ0rAcNeItVc8HYqf92Rs5QV/TmpDTGK7BkReXNo3j1WqhZbBxhStNHQOgHA90GGdMGB2Bb9BCzgesD7oeiHU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570795; c=relaxed/simple;
	bh=NL+2O67zl6XhExgQ+YQoeRanLB8/+6/FsvCmRaObAY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrh06lKFVsExvhc0TZEiUoAW25wdqd8QSPl1TeoJ+/1evWHD+2MiDeLU3egU5PNczwuc5C7GaERzIugmfQgZW9OQc8cg5XJALdiXE1K+At35T3NKoF8KM3OD1E6YkWIJUpJvYhee8NREr7P5MlMp+RbEE/0sWZOFPcnh7Wn2EIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvTg4tiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084EEC433F1;
	Mon,  8 Apr 2024 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712570794;
	bh=NL+2O67zl6XhExgQ+YQoeRanLB8/+6/FsvCmRaObAY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZvTg4tiYDz01cUcK7QR0h6ZMDm8BuG8Q7kvQ33O53UxQ/w3O3Q+dAN+9TSOndXBhX
	 C5deJk2WOT6CBarGvwlM1nERXPjQlIQh/etxnQ6UAlJu+2cvfNL5h2BqnJU09VL0ko
	 xUbD+LSB9PzCjUDIIEB/t15wyYrLRo06BhAV9QcN3qTR4I0ww+swtAa9avebgzc9BY
	 4PqgH62VTGWAPdVuWMyvrKI+2xT7vOFyrKK4DWTpstHZIy8kcO24zc45n5SGBPiH+9
	 +79kGSgh88Iu4qirV5jf9LEWuRf2WEjUWZ7GDdHMNES0QgzUgiU2MQApsv19wCTOHy
	 Y8cmhzU5jOoEQ==
Message-ID: <aeb7dd59-4b11-4b16-b3dd-6b481768d575@kernel.org>
Date: Mon, 8 Apr 2024 19:06:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402101715.226284-2-thorsten.blum@toblux.com>
 <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
 <9AAAD718-D1D7-416E-87A9-3CA2BA20C93B@toblux.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9AAAD718-D1D7-416E-87A9-3CA2BA20C93B@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/24 19:04, Thorsten Blum wrote:
> On 8. Apr 2024, at 03:48, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> Looking at this function definition:
>>
>> static inline const char *str_plural(size_t num)
>> {
>> return num == 1 ? "" : "s";
>> }
>>
>> It is wrong: num == 0 should not imply plural. This function needs to be fixed.
> 
> I think the function is correct because in English it's:
> 
> 0 files

Hu... I learned something today :)
OK. Will queue that the patch then !

> 1 file (every number but 1 is plural in English)
> 2 files
> ...
> 
> Best,
> Thorsten

-- 
Damien Le Moal
Western Digital Research


