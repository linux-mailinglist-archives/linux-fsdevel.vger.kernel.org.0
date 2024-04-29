Return-Path: <linux-fsdevel+bounces-18095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7738B571E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A21C20F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D66524A2;
	Mon, 29 Apr 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyQpOoh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146F44377;
	Mon, 29 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391397; cv=none; b=K6ODPhPhaqRVn0f0wUcat0+kdGSoISX6hmBJK1E8CSe1FUXRFNy0FaDao8d0WBD0gXASU0pzqW4vLrjBa9OkgBap4EurfKTFItX8LaGw9fcaroHPnaGWMGBc6mPabFXvA/4LZLOqz6MW3ULnbITeCXHC8lZmt8Xpnha5xqqrLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391397; c=relaxed/simple;
	bh=zzKgmRbRfcLYwWhF/Li/Qlh6M0W6EwxnRDSUIgMeOUs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=GzP8pnJNtH5HR+bond9Hlk+leiZqXT33IvRGSIYvBlPyPsLvh8P9eeQOLlEgGiWlT6cjTBudybmN5a6zRedfVbhz+Fw4dEqZ7/x6eaJJubfgMz+3gjGnI/gJ7a5Txbq/BZeimHFYOdbS1c3h8iC7+aQlLtKatP9lL8Ox0eCgm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyQpOoh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2D8C113CD;
	Mon, 29 Apr 2024 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714391396;
	bh=zzKgmRbRfcLYwWhF/Li/Qlh6M0W6EwxnRDSUIgMeOUs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=kyQpOoh1tdHAVJrnpbxDP4KnnEChUWEEVGNxetJ7ANoWV3qVt8thMbBVsXb3PgnI0
	 JhOQcyZwngHIO6Hj1SJPou/qzYPFOnkbLNW/Tc9NX4cT5+6kDs6eEuVcdEy8QTnuR4
	 LC+AnTxqsw4ImvSdFPSaP43adLzQfWt2JmNpTeTvjP1q0oxBjpS1zZtjFRKwRPDinP
	 2UlkMKgJH+zjL6E5XQwKuGmm4piOLBGmCjk/JNLBgObjRlsCSSxesTpSxYLWNzL/65
	 XmaN+msetv17A+Zbb6sJHMqMW3bEiBmvbRs39KyJt6nVCtxekIK8744ZsqsqWYJCRb
	 5DugAeMfIZRTw==
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <20240425-modeerscheinung-ortstarif-bf25f0e3e6f3@brauner>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-kernel@vger.kernel.org,
 djwong@kernel.org, hch@infradead.org, david@fromorbit.com, tytso@mit.edu,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/9] xfs/iomap: fix non-atomic clone
 operation and don't update size when zeroing range post eof
Date: Mon, 29 Apr 2024 17:18:52 +0530
In-reply-to: <20240425-modeerscheinung-ortstarif-bf25f0e3e6f3@brauner>
Message-ID: <87o79spevy.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 25, 2024 at 02:25:47 PM +0200, Christian Brauner wrote:
> On Wed, 20 Mar 2024 19:05:39 +0800, Zhang Yi wrote:
>> Changes since v3:
>>  - Improve some git message comments and do some minor code cleanup, no
>>    logic changes.
>> 
>> Changes since v2:
>>  - Merge the patch for dropping of xfs_convert_blocks() and the patch
>>    for modifying xfs_bmapi_convert_delalloc().
>>  - Reword the commit message of the second patch.
>> 
>> [...]
>
> @Chandan, since the bug has been determined to be in the xfs specific changes
> for this I've picked up the cleanup patches into vfs.iomap. If you need to rely
> on that branch I can keep it stable.

I am sorry about the late reply. I somehow missed this mail.

I will pick up the XFS specific patches now.

-- 
Chandan

