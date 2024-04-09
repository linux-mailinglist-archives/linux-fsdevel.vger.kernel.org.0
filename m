Return-Path: <linux-fsdevel+bounces-16505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997189E66E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE951F21ADD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569F1591F6;
	Tue,  9 Apr 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbfR4JrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF5158DCB;
	Tue,  9 Apr 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706645; cv=none; b=VoXt3B1msrLjNa5U4ycNtdb3rTNDh1zMK+k08ORca0atRU1uAyoAmEpLNFV+akheF5pv6UpRaFaTv7DcvnYj1YOn60tb9vWsTNGLUcHpuaSpA3KIzpBIrgQI+eNou0rxHOoZCINYuaGGyWzbk81z63jVjK5BOCu9og4aUkCN47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706645; c=relaxed/simple;
	bh=kIrvOTkhKhlzHL5+y3Z29QwL0SjY19i/TuT814LkkRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8J6Oq/tfYHYvVHWUFeuZ02ffhZQ76xUQOiTNBv8mmcr6yPVkX9o8wJh9aYtA5L/KXl3oX0LRzmlPXa2iLCpvIwH+3y9MFnyGpjPntazVtWdvKGWcT8E3jW6X9VDyAQSFcNQk44qIwnm29bZx+ZuNZ7//dm2mQhXbHWBmrcUegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbfR4JrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD2C433C7;
	Tue,  9 Apr 2024 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706644;
	bh=kIrvOTkhKhlzHL5+y3Z29QwL0SjY19i/TuT814LkkRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DbfR4JrKwzpNGR5uYsl3FzHepTKAXJ1nX7+MQT26VRs75sDGe87lef0nbXW2Dhc+7
	 Srg4V13/L1sm1pn35iSDKN7vmBExijl94SUT7hTPfJsZDuNKEInbJz0C7ltWkO/FLY
	 3BhVMZ6kUJmVcokEIaNq33vZrYsh6tJ9qMm1ats3ynmQRoOyno8oHhLrwd9gXaC6oY
	 uA7AyPHjxVRcS9AEW+8J1OO6ywUNIiJmxyfZBRVn085YZT/8/r7Dpws1EUloRRicjk
	 71EsDyWlHww0QqvhKRiXnMj0SW658SLBnoKlu4eTQy48CfoD2oiBJvcrhszyL3lB83
	 G32Blf1JykuiQ==
Message-ID: <a82cfa8c-1dbf-42aa-a60a-b70a5510ed73@kernel.org>
Date: Wed, 10 Apr 2024 08:50:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402101715.226284-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240402101715.226284-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 19:17, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(zgroup->g_nr_zones)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied to for-6.9-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research


