Return-Path: <linux-fsdevel+bounces-70807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EACA6EC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBE72300E813
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA532C933;
	Fri,  5 Dec 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llXzxDkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81B31D370;
	Fri,  5 Dec 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927110; cv=none; b=r2B8pzoO94sr/oPyP7k3Odailv8ku4ALpj5yJ2jdbcunhlUu6TOU4mzXE5xCFe1X3zw7kKb0YWxX4o26bEa6Ng4tbBi2DFCF+SaMImMcc1pHLOLjeE4k/ApDaKl0c7forpLrKqQw5i1InCn7HTF/UG8vpNuzkoZN4hec87G8tH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927110; c=relaxed/simple;
	bh=edWxLHE4wqFTkX5SVat4EE0OOOkHnRp5MjNkMy6JzJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs6IuqXqIwTmetpEwxkzqeupcw2x7UVVU6qbqoHSz/IdBLgF+Nlm1yTTbT2BxpiMsxvQgPhk8joux2mVlr2ctRBTqrvLNeUuljBlRohQyYGNA3k+/UkdHYicDbnyRrS7FB4YiBUO0QYY9x/ECdFVgi3+f4b4XZwaNffXnfUv/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llXzxDkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1421C4CEF1;
	Fri,  5 Dec 2025 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764927108;
	bh=edWxLHE4wqFTkX5SVat4EE0OOOkHnRp5MjNkMy6JzJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llXzxDkcM81FVcmgdHLxngwu+EmTIVgRlnXtjLAR/Plk6dGL+7XF43IncwvJODyZW
	 yDTpzZ5p9aCuyRiVkhGaMVGzo2Z6ExjCYkjKMHcqi7kl80LhajLizwe6pEgeutSW0A
	 Udx99gP7Ju2KgEflzT+zi0X/FtKnYhIeoa5hCbw2fwTDAoBscqH0wcfyfEe+M7AOwL
	 oGWAqFLp2U/w9Hyr309etIppYOwwNIPDr/flI8ndj6rDklqKGH/7rnX06aiu2B0YxB
	 8bdV13PZHwHgdG56f9Bc1zwcQrtvHT9ERPxyWEFyxFccrd68Kehw7AuJXDMQvw04ww
	 qSAn2pvrH/KnQ==
Date: Fri, 5 Dec 2025 10:31:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Message-ID: <20251205-drucken-stutzen-bc27967b943b@brauner>
References: <cover.1764259052.git.bcodding@hammerspace.com>
 <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
 <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
 <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>

On Thu, Dec 04, 2025 at 12:36:31PM -0500, Benjamin Coddington wrote:
> On 4 Dec 2025, at 12:33, Chuck Lever wrote:
> 
> > On 12/4/25 10:05 AM, Benjamin Coddington wrote:
> >> Hi Chuck, Christian, Al,
> >>
> >> Comments have died down.  I have some review on this one, and quite a lot of
> >> testing in-house.  What else can I do to get this into linux-next on this
> >> cycle?
> > The merge window is open right now, so any new work like this will be
> > targeted for the next kernel, not v6.19-rc.
> 
> Yes indeed, too late for v6.19.

I've taken it into vfs-6.20.atomic_open and rebased this onto current
master and will do a final rebase after -rc1. Let me know if I messed
something up. Thanks for pinging.

