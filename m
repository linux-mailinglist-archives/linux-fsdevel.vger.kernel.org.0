Return-Path: <linux-fsdevel+bounces-21086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FA8FDE48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59C61C2410E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA43AC36;
	Thu,  6 Jun 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuVObQkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CA2564;
	Thu,  6 Jun 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652786; cv=none; b=FeON1dVoEpopLc09mcDXr8kd3MfybEtIp1UZkMPWznFbFqooPL5mR+w+LhDXP1I1tDGCt74130KfPQsSfqxrP45JOxo5wGA2c7wTTEwbsg36AeBdhc1HjEd2h3ICz6do9Th7HbEMcsBX4f5p/nj4oZ2e9i3Txnlk+JKKH+q6gGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652786; c=relaxed/simple;
	bh=oasRQEowEDEvTcuNGQIUUnbDSjk2QLAdYm53uQmTzeg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=QFv5avcjBi2wenkm3CgKjpl5PuOCHvPRBbEFDxiHFdGL4C6eJ2ho+RQKjV1QM9QXeIawqaqPoDjlAZJ+J2aecS673y6CD0nJjsKJyJ/rb/y0Oh2YmXrlWbAjsbSWiT19dUsbUsdsxIlvzTlnQ9dPC8u8yO6wPQkJIU7pJRm3jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuVObQkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26179C4AF0F;
	Thu,  6 Jun 2024 05:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717652785;
	bh=oasRQEowEDEvTcuNGQIUUnbDSjk2QLAdYm53uQmTzeg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=TuVObQkKFUYUfNEWP5lb1pHRVQVrSJug+a5WQPZwLzW+wRlbOLBzOP8t8f14smZLa
	 2l3/bZqUn8Cm3swwT4chu7n98wrPdYTs3Y2bR/4ATgcmDZasrzy1ZetX3O92spiHpw
	 JJG024TSkuBeyFKRzIXCECF6cF+kpO9CXFHr1pf2km4MnZiPJkai3dmBbIUsTuiCC1
	 G9qbY3IsL6HV8wayvjxlh+cjffE4fml0QZKXi0cCjf++NBOWzDYwgRdhk0cP/WiZQt
	 f9CnreLxOL9P62vcjMfxTjLyBgZebMK4lUv2a9fjSWKLb4ammyrrxE8biY1CI4qm5i
	 RW0ASqPQMfbAQ==
References: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] iomap: keep on increasing i_size in iomap_write_end()
Date: Thu, 06 Jun 2024 11:15:33 +0530
In-reply-to: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
Message-ID: <87tti61v4g.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 03, 2024 at 07:22:22 PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Commit '943bc0882ceb ("iomap: don't increase i_size if it's not a write
> operation")' breaks xfs with realtime device on generic/561, the problem
> is when unaligned truncate down a xfs realtime inode with rtextsize > 1
> fs block, xfs only zero out the EOF block but doesn't zero out the tail
> blocks that aligned to rtextsize, so if we don't increase i_size in
> iomap_write_end(), it could expose stale data after we do an append
> write beyond the aligned EOF block.
>
> xfs should zero out the tail blocks when truncate down, but before we
> finish that, let's fix the issue by just revert the changes in
> iomap_write_end().

I didn't notice any regressions with this patch applied. Hence,

Tested-by: Chandan Babu R <chandanbabu@kernel.org>

-- 
Chandan

