Return-Path: <linux-fsdevel+bounces-69917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCAC8BB09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAAC3A55BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF5342503;
	Wed, 26 Nov 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FhX5JOvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30499340D93
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185925; cv=none; b=QyJ6mZ+5MDkynAWcVMSyMt54VtCqJF3C320Pvrn8QaDPZO4FH66S1710rYf3RPJFbCL/JGWoHwmYkbrUXCYTJeRp4Fey/AaDVAgh2zttzzEQq0zk3XlBw7amn+Bnh3QmHSTOEMHN2rMWcYaTklCFA+2yq2eclvOIfSg4sdiIKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185925; c=relaxed/simple;
	bh=pLRVMqpcsS/jMqnT7c9XLFZqoTHeqWXahPKFE7CRmR8=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PABhgPI6FFhh8UAiE5UkNZ23mLFPZ78MLSW5QKs1d54o4AkH+BCoP7Uc/Y1YEvUmPu9lV6hCbAw2ZzyMvXMHxZUiTgGyZVtIhFC2dTNzWNL84pfMBlAiOX8Z1IgeonhlPcaXAnqjKKh67XW/EB8+XnqWB6xa1IW6dec7YbyMMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FhX5JOvE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AQJcGNA014129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764185899; bh=kczFExVBlxlD5CEONl7ENAuYgYLUiLN5v26Tr/EFCnk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=FhX5JOvENGJQSmyjIHNqxFGRoNZfvd8A9KgS5u1oYNISfxE2U+jR9wX1+KABUnfvi
	 Mx3NKAuS7HiM9IWZFdk/bZU7lYDXG4yZ4kllx2YULBRM/Y6O/+MfXvYw80Ma0yIDQT
	 w+7ZCPcHlmVBzr7Jcqq7X8cHAuWPjFnmNSYmmJmkBcwo11Px4K7+MTvQmtdYWxsEmJ
	 Y48xR4qniodiHtJSlt8Wvp80Ok69BPeZUbAOZq5IBciCOIBPUKEYHXXx+ssfrNa98z
	 qTWIrE43tyQP8AT75CJY6zbHth/BzgenlV2ibTmBMtqG64Dqotp4KfK9+277taRfuM
	 q0I0co44DPWsA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 36ED84CEF871; Wed, 26 Nov 2025 13:38:16 -0600 (CST)
Date: Wed, 26 Nov 2025 13:38:16 -0600
From: "Theodore Tso" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com, libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy
 by enhancing order-0 validation
Message-ID: <20251126193816.GB59583@mac.lan>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
 <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
 <2d7f50d1-36f0-452c-9bbe-4baaf7da34ce@huawei.com>
 <20251125214739.GA59583@mac.lan>
 <7ebbd365-702c-4491-86c6-23c6242ba80d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ebbd365-702c-4491-86c6-23c6242ba80d@huawei.com>
1;95;0cTo: Sun Yongjian <sunyongjian1@huawei.com>

On Wed, Nov 26, 2025 at 05:12:49PM +0800, Sun Yongjian wrote:
> Thank you for the reminder. Yes, I've already sent the revised version with
> the suggested changes, you might have missed this email 🙂
> 
> https://lore.kernel.org/all/20251106060614.631382-1-sunyongjian@huaweicloud.com/

Thanks for the pointer!  Somehow the e-mails in question aren't in my
inbox for some reason.  But I see them in lore so I'm not sure what happened.

Thanks,

						- Ted

