Return-Path: <linux-fsdevel+bounces-32242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C3F9A2ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A210C1C20B9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131371DF993;
	Thu, 17 Oct 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="moeKKU4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC01D95BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185652; cv=none; b=nvIjCetd6rMbnpv++urFosqyJ793TS/h2hXoreEBHNlQ+/PdaGdbNF/B7s3mOLzzVuAhVKoBz6CR++VrpXkb/ZMU+S4uJeeUL6ZaLvDxZPQ39d5Vy+czuW/UphpoPBPbU6NOI697DKosNiaRPjFqrzDe+fjWwclCn7aj9A9gjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185652; c=relaxed/simple;
	bh=++9xN/9rcsAbeXC6YK96A9CnqxtXmDwYGMylS5Kzu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq6eaPo7stuaROSsaCobt+h2NNL6oZzJde8akJcdb2VUmZjjaOec+XpRkghcurVYVjXlHaY5g5y10f5lTjfyz7hpiOJ+Xif/dxsf9blq/0AZBTVsnmKY+UHVIJs0dbGYGe2Yv7rA7MHi/GP6kRvjlpn7oiL9coWtZdeUPXB54b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=moeKKU4z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4uImpaVCmNINqFp1gz3U/eEl00Sua2kmGgIF6OMPRPI=; b=moeKKU4zqnz9jbe88qANMcIaMK
	j7eqfwNmTqRPR2kM93S2eIQ1W+aBCeCbDZDKxrt3O+DYIlAHSYhcMFjCUCkNskcouoJzvXAKLk5Y5
	xvFVGjKs7JqW9XU5j2vx/LLnWrlskV9wD1cpN3Pvhs8DIsYzadjmWUxi6CfA/wYBbkDo9Xr79Q5kx
	rreeh8G+FdeMT3/x6K64B6GHSK7ojf0H5mP0j266EaiwDdPj5I16VnaxsSssMa97fcx28GXn8WA7n
	CJ73dbSpJVilHDvlhxrjnd0+EoaizuOWEr5zXwfR6OhbYYpc0bEUbbXRMAP6UTmX+krKURn4fJiYm
	fQl+t5Rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UB5-00000004lEY-2oeW;
	Thu, 17 Oct 2024 17:20:47 +0000
Date: Thu, 17 Oct 2024 18:20:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: Dropping of reiserfs
Message-ID: <20241017172047.GK4017910@ZenIV>
References: <20241017105927.qdyztpmo5zfoy7fd@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017105927.qdyztpmo5zfoy7fd@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 17, 2024 at 12:59:27PM +0200, Jan Kara wrote:
> Hello,
> 
> Since reiserfs deprecation period is ending, it is time to prepare a patch
> to remove it from the kernel. I guess there's no point in spamming this
> list with huge removal patch but it's now sitting in my tree [1] if anybody
> wants to have a look. Unless I hear some well founded complaints I'll send
> it to Linus during the next merge window in mid-November.

	No objections, but it might be a good idea to repost with Cc to
reiserfs-devel@vger.kernel.org, to notify anyone still there.

