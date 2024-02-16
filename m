Return-Path: <linux-fsdevel+bounces-11847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E1857C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF641C21C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE978B46;
	Fri, 16 Feb 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxI1BODy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AE7868B;
	Fri, 16 Feb 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085332; cv=none; b=gxdq8YoqFz9AzoU9t7mnrHUzssYDRfcItWZCJLMPGXrYAKpONWa9W/PgleGrIMJsXhO/H4DFYtKVT+d1Gdi2fPA5rCG2JODMT4KhrQaHokzRRVoaWBi+JalT00X891N7LIpk67X+FjEr5uluvwyIo4RSiV4CuvnwNcnoFMpuG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085332; c=relaxed/simple;
	bh=qHbNI6yjXVOhnzBKZKp8fMbmEhmZPZ09P4nge02k6Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih0J5S8Mf995lkiIKb6IS6vBQ+duLud1iiS7wFamq69Ou/i39d2b3D7wMyARLkA+la/0CEoU/Owa0p+ZGi/KyXwBXpJdu2v8XRVy8OzcyVM8KjR4Aq+u0B0HaXqdZ2aFwWFFgDCwq7gvK17irqPOfeKm1x4hFvSSDrjfP2nEW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxI1BODy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729D9C433C7;
	Fri, 16 Feb 2024 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708085332;
	bh=qHbNI6yjXVOhnzBKZKp8fMbmEhmZPZ09P4nge02k6Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxI1BODy2yDyI6e5+XT6VS8r7iZTCMgzBVMu2qqochReSXck1H8Dknd1lZBnu94vC
	 eAL9wZCds9Fe8MonS9U1Z+LHhG6ckD7LwUQGCzOZO+/XjAQEgqTxZnKLMRyuJFhY5R
	 XGnW4MSJRGJ42wgpxv43vGS5b2bZ9oqYEE3eM8QmAjd1rxnk2tA6lzzYGbNvXAKSAu
	 JiW6IN4jNwCV8qZ/CP1sdAs6IrDm4AsNOFF5nIJt9pnplYwIS+LR0WCquNRUI0d+U0
	 FM5pkYYAplhVpsLloKQ5Gp9hR1tTgrOazacb59+IWigI1es+m8VoH8YIboXwN5zBNV
	 GuueJLIgbeo4A==
Date: Fri, 16 Feb 2024 13:08:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Avi Kivity <avi@scylladb.com>, 
	Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fs/aio: Make io_cancel() generate completions
 again
Message-ID: <20240216-wolle-lektor-105fecc77d6b@brauner>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-3-bvanassche@acm.org>
 <20240216071325.GA10830@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216071325.GA10830@lst.de>

On Fri, Feb 16, 2024 at 08:13:25AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 15, 2024 at 12:47:39PM -0800, Bart Van Assche wrote:
> > The following patch accidentally removed the code for delivering
> > completions for cancelled reads and writes to user space: "[PATCH 04/33]
> > aio: remove retry-based AIO"
> > (https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)
> 
> Umm, that was more than 10 years ago.  What code do you have that
> is this old, and only noticed that it needs the completions now?
> 
> I'd much prefer your older patch to simply always fail the cancelations.

Hm, if no one noticed for that long then I agree that we should probably
try and get rid of this.

