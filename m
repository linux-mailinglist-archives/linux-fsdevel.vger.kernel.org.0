Return-Path: <linux-fsdevel+bounces-26238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D2956619
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F18B223D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF715B551;
	Mon, 19 Aug 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg7woUIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33B947A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057703; cv=none; b=cmZzhGFeUj5wEPwjt88oLMlLglF8QSRI/04+4yDVfqyZhqdASFWKOCmhKSBjmoksb/tJQXenVwoln2TVKJaWd/Vv3RqezA04KiNNQgJCUSwHZ/R5Z/KXeHgEr0UwTbCq6QakRLpMtbSlVx0bdmg3AefLENqdRU8C7xiZveg6iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057703; c=relaxed/simple;
	bh=TZmDvR8f2F/zfiua/CjbiGmZFyx8UsbN2fEHYeU8qoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+zckgxrTTtAs12Fvyf9SugL4F2ZGuo2lr0lLNit/W8P05N9z/6zUqHdcONn3ErxExn7fzJuof9Ysdo5cs396cjOIdJx90ywEo4bPbZEUCRlM5OW200ns6j5A8EkLS9jCRGkTQailZVdNJA9EC/DQmgM7KldRkrPkRSC5Wi/j2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg7woUIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17035C32782;
	Mon, 19 Aug 2024 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724057702;
	bh=TZmDvR8f2F/zfiua/CjbiGmZFyx8UsbN2fEHYeU8qoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cg7woUIiwfoKRP88yjXgnBcawfySfAhJaV8xSFw34FY1E2ZkO7B0t1ZNCh3R/3cnS
	 h9+rHsehEXZ1IOe/eAItEe3MA/nMLDgspy8Y9XAvpr8k4ACpbIGn9H+o5Liif8mBwj
	 hGHWrMGiVlqoRafoINow3wo8mMib1/ZM+RQrIunEICHxIf3HaSi86/L1FWibzs+zbJ
	 i0hy1xwGRr3gKedtSm6i/M/oqNTXQvlTQF3Mh/HWVSanGzXCvlAEw6lwQp9NdP5Gh0
	 8XdREOWcdXq0aYutUaeIPr/27Gog1MdA4K7XeuvsVoLN/4GQECV1oy8nfZHGSKtfHs
	 5Cli86gEZ06uw==
Date: Mon, 19 Aug 2024 10:54:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fs: Allow statmount() in foreign mount namespace
Message-ID: <20240819-episoden-erstplatzierten-6b838e8715c8@brauner>
References: <e7d78aa3-a6fc-4bf8-bec2-2a672759b392@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7d78aa3-a6fc-4bf8-bec2-2a672759b392@stanley.mountain>

On Sat, Aug 17, 2024 at 08:43:41PM GMT, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> Commit 71aacb4c8c3d ("fs: Allow statmount() in foreign mount

Hey Dan,

Thanks for the report.

> Should copy_mnt_id_req() ensure that kreq->mnt_ns_id is non-zero the same as
> ->mnt_id?

No, mnt_ns_id can legitimately be zero.

> 
>   5329          if (ret)
>   5330                  return ret;
>   5331  
>   5332          ns = grab_requested_mnt_ns(&kreq);
>   5333          if (!ns)
>   5334                  return -ENOENT;
> 
> The grab_requested_mnt_ns() function returns a mix of error pointers and NULL.

I'm not sure how you got that idea. If no mnt_ns_id is specified then
current's mnt_ns will be returned which is always valid. And if
mnt_ns_id is specified it'll return a valid mnt_ns or NULL.

