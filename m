Return-Path: <linux-fsdevel+bounces-28008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37498965FE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A3F28475F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50318C35A;
	Fri, 30 Aug 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1vVcUTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E3190671;
	Fri, 30 Aug 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015694; cv=none; b=EfJPRXQAHQ6otj2KNCrMoHG1GBaZgsiqzn/nrI0xolxoninTggGo8pKHvktoROC7wGsbAzJLiLkRz8ZhM4uplUyHyt+eElVHQP5FYzoUy87iePylUn2oebMplPkLLZUjdOejbD3xt5CYmNWbfYgk9m2YmBJ7DeeqXK1/Jfjd3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015694; c=relaxed/simple;
	bh=yaJeRuRQQyP3DjjG5GehxvL4FJ/rh3ymGrsYnYVWGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKhp2Yg8S3/khR/vktAgI6byVhANYQKjbPYm/h4b247IylKP6oEOdXsjI8tRPSoUsaODSaiEVGwIbTTRpPbXOp9HDtP0m8SNU3lENJm8RHFzh7v+geK2yrY6QWIYEM9GQsTII2XgbIhwIqydKppmxysyb2CUKCWbkJvNrA2h37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1vVcUTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08586C4CEC2;
	Fri, 30 Aug 2024 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015694;
	bh=yaJeRuRQQyP3DjjG5GehxvL4FJ/rh3ymGrsYnYVWGWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1vVcUTPNlaGZHDGvi2Nt85L2PWpInQ4x7SCqtbYI8QXiJIiGSB0NTqfd86BDtpRK
	 ytCRgtIjNZQz4SjhimshFoVSoS+xP1I6aH1wmFX7WUpL78vaE4dEdr5viiGYgjYXTz
	 XOwM6VfshXyman8p+I9Y5yecMdCGl4yIhkIZC+BhP6F0wPw6TjSLnFaKh/Ox/WFDkh
	 FE4HIfgWGVZxEeSrro0sY/JDmpWO8xNttg5H8Sd3OGyJFLW+bYu0U0AkSqipbtxOPp
	 qhuGoaxk+WYdRbog0Fa/YAqXBybSjTJoNPhw7r1FW+8Nhw1EfOO1xnwHPVIn2/09so
	 azX6KHQq0x6LQ==
Date: Fri, 30 Aug 2024 13:01:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Message-ID: <20240830-formel-abklopfen-fa1249f5904d@brauner>
References: <20240829130640.1397970-1-mhocko@kernel.org>
 <20240829191746.tsrojxj3kntt4jhp@quack3>
 <4dfed593-5b0c-4565-a6dd-108f1b1fe961@suse.de>
 <ZtGTEOEgf4XuUu7F@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtGTEOEgf4XuUu7F@tiehlicka>

On Fri, Aug 30, 2024 at 11:38:24AM GMT, Michal Hocko wrote:
> On Fri 30-08-24 08:11:00, Hannes Reinecke wrote:
> > On 8/29/24 21:17, Jan Kara wrote:
> > > On Thu 29-08-24 15:06:40, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > There is only one called of alloc_page_buffers and it doesn't require
> > > > __GFP_NOFAIL so drop this allocation mode.
> > > > 
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Looks good. Feel free to add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > 
> > > Although even better fix would be to convert the last remaining caller of
> > > alloc_page_buffers() to folio_alloc_buffers()... But that may be more
> > > difficult.
> > > 
> > Already done by Pankajs large-block patchset, currently staged in vfs.git.
> 
> Which branch should I be looking at?

Hi Michal, Hannes should be referring to:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.blocksize

