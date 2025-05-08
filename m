Return-Path: <linux-fsdevel+bounces-48448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7DAAF3C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E53A9DBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200251EE03D;
	Thu,  8 May 2025 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3jeWaYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B014B1E45
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686099; cv=none; b=lYJcGdaPIhv3IrQRswPyq+TKOG8JDWDOA+/TYBShsc8evvJvKo/TVoPxyEAapkIH5WEauC+Qj95oKp2qKYuHQATn0kYrVNZ50cvvFbG91/ydQiIB4XOHz3JSrEkeS5tN5bq6LtpXElylc8LC8sqjH0ugTUpfpZuYggKLo8TmwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686099; c=relaxed/simple;
	bh=iRUqwdtVluzi8HRIkzz+g95ssxWFsQLhfah1v85A2gU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f7rfZ9o41ujCQ/EI8YSac2YnCsupH03Rmb3Wf4V4fpkYG9UKCLQNECV6/iycWm/S6cKGlSwwwCp2jbaNijCynX3EL+XxvR83qqoIOkXqpqSUd7m4Q8NvLLFnyXA7amzfl07/EKGpix2DgiFAQyT1LRmwx81eKwFim5NLLCsBl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3jeWaYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4621C4CEEB;
	Thu,  8 May 2025 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746686099;
	bh=iRUqwdtVluzi8HRIkzz+g95ssxWFsQLhfah1v85A2gU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N3jeWaYdPn2Ex2T0rif9mSaRmPvo2z1LdpQBRDqVCadN/i3AzRTT+t7Egj7q5V9Aj
	 uT7JEjFv2rgeWY1vuxvSiGNDcG28yDTXcG3Uq7HsXuAFWFx/X/yjebYxt1ge10gPHY
	 J9kXsDjYWpn5meyuB+zC0zHZQJS/lSz3e+lekwZ69Pqzw8kY5FdbeTLJIgzhxq1M1a
	 9g3fJYQbIQ77mREBBg/hWrTJ2l1+WXufOw9fG7VsVCFy6TiDpPNKp1EsJOXUq68Rlj
	 8tSJ6BG5OzVTB36wpAOXJEuyN2LOuz0a7z4Yi0Lg5Pdj/pakt0R+RAMKrzn0MuVyQz
	 14YDPtm+f96Tw==
Message-ID: <b4ec3021-9786-4712-b66c-0ec78b852e6c@kernel.org>
Date: Thu, 8 May 2025 14:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 4/7] f2fs: Add f2fs_fs_context to record the mount
 options
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-5-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250423170926.76007-5-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 01:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> At the parsing phase of mouont in the new mount api, options
> value will be recorded with the context, and then it will be
> used in fill_super and other helpers.
> 
> Note that, this is a temporary status, we want remove the sb
> and sbi usages in handle_mount_opt. So here the f2fs_fs_context
> only records the mount options, it will be copied in sb/sbi in
> later process. (At this point in the series, mount options are
> temporarily not set during mount.)
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port, minor fixes and updates]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


