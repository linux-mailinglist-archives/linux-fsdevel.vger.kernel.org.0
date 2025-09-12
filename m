Return-Path: <linux-fsdevel+bounces-61111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C84B5548E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209D93ACDFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C23168EA;
	Fri, 12 Sep 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNZPWMLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F51D54E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694011; cv=none; b=q2Kys/JaAfgR4DeXMCRyO7GB9+6/vGhErafU7/iAQMwiXIWnn7QktWnzdonmOohz8yXLqDpzzOYWZvRSx/18DF/8HxYicbDiOJJEzlz1IRY79ebIV6a10TkbY6WUJBE14ORuk97E6jOWiB//hc81KJPqJP4kgY+zIU/ClZk7tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694011; c=relaxed/simple;
	bh=rWCsnDotSdcackT6JYr/D0ZJ19goSgbavWWHWw6kxWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSKVIGHvBJBqonjSPNSHMGmxA2k1fko5HbnEK+LQ/zgrBkIL94ngV5gLco7m7GPWpg0GHVT+5mIigiquCY5MOnkQmvOcEGL36dkQHbfOlpY9kf8BlADrEIZkibmjrZ4lIJO3CUESZ61nHLhAMut8YN9Naw+iKG7FFNtmvRmUiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNZPWMLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAEEC4CEF1;
	Fri, 12 Sep 2025 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757694010;
	bh=rWCsnDotSdcackT6JYr/D0ZJ19goSgbavWWHWw6kxWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNZPWMLu7ah0tpbXcl8bG8zJgyAoAHuJQcm3K/g79fO4WO5NEdOTAJFG32LWGVJjH
	 5hNOZtPaPRteyaMQv2FdHxx/inLDgUWkb+Pu9SjbDOjPrnbwshU3jSa01fK17A0PqT
	 +TGUzQ0+cLX1b4JAZnHDlUAbynrc3++06XREJoscUCTz2M6b9bfFvrO8JNk+j0LH/q
	 gKGBFjxx2l+TrgE0nlP8wkUn+EJG0ejAanlyr25JasQjn96ZDAdwPRtqcAmIuAMFFT
	 fODVFVuhKGnqGRVIdjI1hBrfhj29loiduhDj+KPfOw8RAcQ9DGhcAbABKU5zFXTvan
	 HDtsZgY73NCFg==
Date: Fri, 12 Sep 2025 06:20:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMRIOa2_3wiLEy8K@slm.duckdns.org>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250912103840.4844-5-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912103840.4844-5-jack@suse.cz>

Also, a nit:

> -static void inode_switch_wbs_work_fn(struct work_struct *work)
> +static void process_inode_switch_wbs_work(struct bdi_writeback *new_wb,
> +					  struct inode_switch_wbs_context *isw)

Maybe just process_inode_switch_wbs()? It's a bit odd to remove "fn" without
the "work" part as those two together was saying it was a function for a
work_struct.

Thanks.

-- 
tejun

