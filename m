Return-Path: <linux-fsdevel+bounces-20608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351E8D5F52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E208AB22458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A115099D;
	Fri, 31 May 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RVKM9Yn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961B18EB1;
	Fri, 31 May 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150385; cv=none; b=mkbNrgGBa1YpT7zwviCpjml9bQEAMGT0tHP01GHVY7CcRKSUGc62o98VQvrnyCupztUY8YrvNZCpisUUoGSMw1XR+BmNieaK/EeCymhLSiHV7INSesjQTwj6wXDVRFsSmuDEMcfryaDj1MXO2sU6l8fm/YXFqwO0/99daILjFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150385; c=relaxed/simple;
	bh=uCrhf4ZOEnBO4VCk1/sMCeJBzWOouCqL5FtZQg3xdRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4Br/xb8c8MCGkotDcWSPad6woVPEYdOYTAgYEjoCdC/xwx/nugL2k2pJlKdNNO4we7DktnLpURojQ5gH3BDIn7j2SVqBQ4XNYx9ANMvwiYlTryclyT0WfyqkjEWCTKzAU5uimYF0E8CdNzgY+L6rbSZmp4nxLESNqbbeiHWB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RVKM9Yn/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717150381;
	bh=uCrhf4ZOEnBO4VCk1/sMCeJBzWOouCqL5FtZQg3xdRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RVKM9Yn/XzYfONe6xRHXS1zvr3ge+TieARHvTR+IRkgYIn9RHNB57tjTkw4xFAwEs
	 7G2B+xWvTq1ZG+U9GftFQ8VEMnwae/1mBtn5iJdHr65foVxthb/csRTFhvCNY2VsPo
	 x9x/pjAt3WodU6aIUHdphxfi1e7nazCVu7rEO1s3WJcSuNHSXv720Hg2Qu03Arky4X
	 m+Vi9gKPDfPTaCSzUl6hIiqDnPWA0ZmLIvvQPDnKdkjehO/xKGn8aG83kCuJCBNG25
	 Rocv4lj3do+i2luupO72TcteaCjCrdDio3Xg6eekfoFhu2JHTAKcPZhJlCAJz1J7/j
	 HvotI5iWHoW7w==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 693D837821C1;
	Fri, 31 May 2024 10:13:00 +0000 (UTC)
Message-ID: <c6d7ddfe-9e16-4836-b285-d43dd16853fe@collabora.com>
Date: Fri, 31 May 2024 13:12:59 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/7] libfs: Introduce case-insensitive string
 comparison helper
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu,
 krisman@suse.de, brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
 <20240529082634.141286-4-eugen.hristev@collabora.com>
 <20240531044851.GE6505@sol.localdomain>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240531044851.GE6505@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 07:48, Eric Biggers wrote:
> On Wed, May 29, 2024 at 11:26:30AM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
>> +	/*
>> +	 * Attempt a case-sensitive match first. It is cheaper and
>> +	 * should cover most lookups, including all the sane
>> +	 * applications that expect a case-sensitive filesystem.
>> +	 */
>> +
>> +	if (dirent.len == (folded_name->name ? folded_name->len : name->len) &&
>> +	    !memcmp(name->name, dirent.name, dirent.len))
>> +		goto out;
> 
> Shouldn't it be just 'name->len' instead of
> '(folded_name->name ? folded_name->len : name->len)'?

Okay, I will change it. I am also waiting for other reviews to prepare the next
version.

Thanks for looking at this.

Eugen
> 
> - Eric
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


