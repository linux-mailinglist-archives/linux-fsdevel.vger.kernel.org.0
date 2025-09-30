Return-Path: <linux-fsdevel+bounces-63113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD9BACA0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55831925F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390B7D07D;
	Tue, 30 Sep 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfhCP6Tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB61DD9AD;
	Tue, 30 Sep 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230234; cv=none; b=gMk7HKCfuULbwfSIsNhesGe3PL/xcGKkQ4YJKeo3qO6GFEEbxyu1rhu+RGhWKDpHk4Ecfo4yTVlVsY4A2hbo1cV8dzc8eDjCM3jLa9NQc6rEzo2LlQCnsIwaBZMSvYlpMUG1ZG4IsKsY1DTmmvxGK8lCC6GWR5It+vlt4JhiEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230234; c=relaxed/simple;
	bh=ZGQBfrOsIbWOK3cA0NcinOuD17JZE3z7XJZBM1kqshc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIa88YhavnoVjvSzVwPjRVraPcIqLmF3d45XtbKvsqwvvqXgnRYRluAWTXCkwEL6+FgN1wl/r3QWDAnEL7raDhYoKZJf9aLE9CiToOHVFlyoi+YSNOAzw+zWxb+QsaoI8Koy5NqsDmCyjFxrDu01+O6tWLIW5aN9giDxXh9L/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfhCP6Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F6C4CEF0;
	Tue, 30 Sep 2025 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759230233;
	bh=ZGQBfrOsIbWOK3cA0NcinOuD17JZE3z7XJZBM1kqshc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RfhCP6TmkOCSmOjcEJxrf0LYOnFVQm2xn9skqyF0Tb3u94PzfN6bR3dluKH3QiS6i
	 OUYmigVSYNq+leQHPpeXbfNUBCOGgCo7X5mNmedRGL0zJ4cpGAbuMWF9lNydbrotOO
	 1ODtEFHwatf4FrZ4WVm3jNXvk3cML9BDl6fc8Yy8=
Date: Tue, 30 Sep 2025 13:03:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, stable@vger.kernel.org, jack@suse.cz,
	sashal@kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 6.6.y] loop: Avoid updating block size under exclusive
 owner
Message-ID: <2025093034-glance-limping-e739@gregkh>
References: <20250930064933.1188006-1-zhengqixing@huaweicloud.com>
 <2025093029-clavicle-landline-0a31@gregkh>
 <4656e296-5dfa-46a7-8b9b-a089425b1eac@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4656e296-5dfa-46a7-8b9b-a089425b1eac@huaweicloud.com>

On Tue, Sep 30, 2025 at 03:51:39PM +0800, Zheng Qixing wrote:
> Hi,
> 
> 
> The patch applied in the 6.6.103 release encountered issues when adapted to
> the 6.6.y branch and was reverted in 6.6.108 (commit 42a6aeb4b238, “Revert
> ‘loop: Avoid updating block size under exclusive owner’”).
> 
> 
> We have reworked the backport to address the adaptation problems. Could you
> please review and re-apply the updated patch?

Ah, I had missed that we reverted it, sorry for the noise.

Now queued up, thanks.

greg k-h

