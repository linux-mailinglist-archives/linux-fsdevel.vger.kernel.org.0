Return-Path: <linux-fsdevel+bounces-28101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E81967046
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 10:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FDE283FAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02243170A15;
	Sat, 31 Aug 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfB9N89e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB113C90A;
	Sat, 31 Aug 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091412; cv=none; b=EjA43maqwSx+leERXU+bjuhKEqWiegXO8YA5DCG8bc4DUg2KRh+TuI3rJKvRLduw5y2aClDR6yBjwyr19oDkZz/GVKDD3BE1P4RN49TeANo+XlUSQKBcwWv3Ie57SUuleGMTCVnal/ylzt9naYtaPn7UWMcizFBN1ldXwIkAm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091412; c=relaxed/simple;
	bh=UUnJg2+37TJ1rix+7yKtkbYPhz3Ebu2K/okE4c6fqnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG44Omi8IYjv6H0tu5terbg9D1BThEEVtUzhlG6fCkn3/ExcYnbUswuyRAnSOvbjUEoUElfuhkOIVftFxYQQHxIKq4M9B/PoK+NOgnmVLv0LTfCI9JLEwD4O1b8aNfvNmYkB8PiYOUvYdWeOst2PTD6z1YRUAInoYYjoUILhJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfB9N89e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0096C4CEC0;
	Sat, 31 Aug 2024 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725091411;
	bh=UUnJg2+37TJ1rix+7yKtkbYPhz3Ebu2K/okE4c6fqnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfB9N89eeS9otX2McEmYF6Zw+OgaRxckUayhw9kSXJ+ILkpYAtb2rS/4DZFlgcD6q
	 wUnIAMhPw+uxzBdR5TyQ99e5WrYoJzw8wXjOVA0aTnIBYmDj4MuY1IBpsjHVkXUL/d
	 VJPU+wdMYEpX9grNb/yu2xrw3e1gZZ/li+Pa3DW1iHC0NwxIj0KECoIdyIYcpDGUYR
	 X9C3IEAzp0BbfjI3maWn9ddETGIw3M3reCpR3JZtgwB1Dy5ojFA7IPk6UoYg9LSHrn
	 qvLTsf3iIGSnKl0X+SF4iUWp5I2ibwE2FmVClIuBAyd4vAFwV+DFGQve9A5QzNfu0V
	 vi+eapXaWf3Xg==
Date: Fri, 30 Aug 2024 22:03:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	yi.zhang@huaweicloud.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Message-ID: <ZtLOUuoxnobhYgrm@slm.duckdns.org>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
 <ZtIfgc1CcG9XOu0-@slm.duckdns.org>
 <9cae20f9-aa6a-77da-8978-b4cfb7b0cb73@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cae20f9-aa6a-77da-8978-b4cfb7b0cb73@huaweicloud.com>

Hello,

On Sat, Aug 31, 2024 at 02:11:08PM +0800, Yu Kuai wrote:
...
> > I think the right way to do it is marking the bio with REQ_META and
> > implement forced charging in blk-throtl similar to blk-iocost.
> 
> This is the exact thing I did in the code I attached in the other
> thread, do you take a look?
> 
> https://lore.kernel.org/all/97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com/

Sorry about missing it but yeah that *looks* like the right direction to be
headed. Would you mind testing it and turning it into a proper patch?

Thanks.

-- 
tejun

