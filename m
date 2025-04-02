Return-Path: <linux-fsdevel+bounces-45495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4AA788BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C5A7A3B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B223373F;
	Wed,  2 Apr 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GUiv27Ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D7233157;
	Wed,  2 Apr 2025 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578108; cv=none; b=tlLkgxi10/p+KssJTCvPAgOGviBBmGL5vcSixJTR1t3Xw9Krh64MUTHFGVsSIHlAtMRXKIrn4pPuvmgYszn5Sa14nIVoVKx0x3g/t5BhAqe+R3lsRzQY9Qap58BLz6vtlvI6G25dUD95S6XBnb5lmb+SNUNIICpcQMFAV/8n8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578108; c=relaxed/simple;
	bh=Qs1W3wj42ZhRITNsZUtXty/qF1gbG3tiJDEnxquPng0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSpRD3aVWA8nGVAqVYMj3JphvOKIY9Re262u7LkbuVnzq9FmiEb/bsxXvCpCphw2/tsXapnvKPzzaZHTVgSBpP9fCdmnPU7SxcKTqi8idX5DzSijxRtS/4gHuoqj1QrSeV9j0QBngzNpardO57+rCST1SRtDkJI4jwq1m47HBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GUiv27Ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB926C4CEE9;
	Wed,  2 Apr 2025 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743578108;
	bh=Qs1W3wj42ZhRITNsZUtXty/qF1gbG3tiJDEnxquPng0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUiv27Ea5q5fcI+NyU9hk5k3l/ukrFv1Sb8AYrdsKC41zQ49/cU9MVnA4BqrPSiYf
	 hm1b0A6nZKLYUHzsBcv0Oj0OWdkqEIJX1JHoNdpG3RTE9ct2KDGQ5PTSbGzVNrzxkb
	 WaWXRLD0lItyD1iogBzQKEwN7Y2EElLbiQbz7Z6Y=
Date: Wed, 2 Apr 2025 08:13:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com,
	ematsumiya@suse.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	smfrench@gmail.com, zhangchangzhong@huawei.com, cve@kernel.org,
	sfrench@samba.org
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
Message-ID: <2025040200-unchanged-roaming-52b3@gregkh>
References: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
 <20250402020807.28583-1-kuniyu@amazon.com>
 <36dc113c-383e-4b8a-88c1-6a070e712086@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dc113c-383e-4b8a-88c1-6a070e712086@huawei.com>

On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
> Yes, it seems the previous description might not have been entirely clear.
> I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
> does not actually address any real issues. It also fails to resolve the null pointer
> dereference problem within lockdep. On top of that, it has caused a series of
> subsequent leakage issues.

If this cve does not actually fix anything, then we can easily reject
it, please just let us know if that needs to happen here.

thanks,

greg k-h

