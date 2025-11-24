Return-Path: <linux-fsdevel+bounces-69614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE4C7EB89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 01:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A472344E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AFA86334;
	Mon, 24 Nov 2025 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qatSm75X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BF38DD8;
	Mon, 24 Nov 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763945056; cv=none; b=n3T9zpgltxAM7YjAEEVzLD/YqLHpUrAxjevAzCdxSLCcbBDiGqCd73975OC7U/I0qrICuVMN3d7O6XtqRgIaNyma+r5Tnw0licnvgqKNL0nzM691LDE/iNVTzSWHu7PVALNjW6QONZBelrVIGUB6gj++On9j+WslxFToMxPghOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763945056; c=relaxed/simple;
	bh=F1jtxFmXqezT3lBxnvIzHZ3jxljgpcwImean9FI7r10=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SwrkJfSPiDLo3W3OEMCGVClTPpSMdRlXRRdpnmjop1OcBw/W/y8HimhHNUt2PLebzGtXpTmdaXu1VcSnUidNJfnXsTE+kadrSm3rFyOqPJtgbPt0kSju4dD549wMDAd1HZ0nof4BeVmeBLoHpFY+PKDnkTiXCARl2uCVObHeV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qatSm75X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8C5C113D0;
	Mon, 24 Nov 2025 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763945056;
	bh=F1jtxFmXqezT3lBxnvIzHZ3jxljgpcwImean9FI7r10=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qatSm75XE5O3EZEwVbcjZCD/AqEE3/VnKprTk8lj0Vlv6l5aK2KFVg2Hm6esoF7MY
	 uucMb0schX6I6WVNDNVxs81dhJnLPnoe+yC99RRZubsCTnKDX92sZCa5h2jgzBqlqU
	 T3qs7OYtLV+nRg154qlCZ1MgaNNqm3/r1LqXUBxnT4uubL/Rqzf5H2mybhwnAOwMoC
	 NY//mqEZyc6L0/XxGMQpVxrEE3fJBHr8tgLMBD8BMEKDpBeuzbupC9+ncj0E9IVmEx
	 7mcRkC1fPstneR/yx5wtQy7ZzP4craYLMlP0NdQihkKWm63gZauVtgcRBlSQYMf/IG
	 ZMO7hLf6aJ/mw==
Message-ID: <b8b27003-2366-41c9-871f-6e04ea74c309@kernel.org>
Date: Mon, 24 Nov 2025 08:44:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com,
 Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: Re: [PATCH] erofs: correct FSDAX detection
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
 <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/2025 7:57 PM, Gao Xiang wrote:
> The detection of the primary device is skipped incorrectly
> if the multiple or flattened feature is enabled.
> 
> It also fixes the FSDAX misdetection for non-block extra blobs.
> 
> Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
> Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

