Return-Path: <linux-fsdevel+bounces-34774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B39C88F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B2B28432D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589C1F943D;
	Thu, 14 Nov 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+O/eNO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C11F7799;
	Thu, 14 Nov 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583842; cv=none; b=GaCzNHboNtlCqJMRvLBo5AfdgfHk35B3NyNKuRYruSPK2+y7zbs0GTt5DsfPgOpFM8eQgNuh/zuwIMnzhrVksBtJPtkEbXeKbBGcD9J4upI6Bc/RXojNOAQg+uxNacZxOSKfZiCMpz/FkuRTywp+HJReL5kigfVvsgCo9Tr8bHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583842; c=relaxed/simple;
	bh=iqeIosW/+OdmLNwEXpkqClV+jE79GdwuLFVVB6EIz8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCw2ITtyus5+lNBOgChjUacCAmnKxU6/vaWUFXTTDPT78/Zekr5Q74bPUsgWJ45MU893bnFLoZq3h+lmGqJhYvEocp0fWR5GCbLk0UVh7YUH6I22Qi1rvy/zXbhAu2xsWzXGEf1YDMli9H+XqQWOaPglsTZlzZJolIRxCHnJJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+O/eNO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8862C4CECD;
	Thu, 14 Nov 2024 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583842;
	bh=iqeIosW/+OdmLNwEXpkqClV+jE79GdwuLFVVB6EIz8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+O/eNO+NVD9d69OOPwH7eYdR1FTN/UmqP0bZw6PZCzoJkjNDo7lCF9VBhZmclynS
	 Ubd/pgVgyG+oCmCbr8M9UeO9bpxZksT7cuQRV43jDXdWXC/uJGjkqzU6FTqTdHS6sX
	 DYXlorUTPnuN8rwLbqC7onS3/1ALDBwZCr8j+GLeEr39G8PHs6Q5UBE8zlKTrBY9+N
	 qkL2U+vw+YgHOjHvz+kgcBdyHKPKzc2wId7WPL2mDzQ8T87Mrrp7TM2WtxEyyeplZI
	 CO7zem2MN4iltUq8J1x97+3eiTNuOPurJGj//r8D2n7HjyI9Q3ELH5v7Kh3oX6S8LM
	 0pNgSGnN97low==
Date: Thu, 14 Nov 2024 12:30:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: pass an explicit reference of creators creds to
 callers
Message-ID: <20241114-gezielt-frost-5130e991c0b2@brauner>
References: <20241114100536.628162-1-amir73il@gmail.com>
 <20241114-lockvogel-fenster-0d967fbf6408@brauner>
 <CAOQ4uxjj0KNFzL5bxwyZ6XvCM0EnzR3pY3isRZd7JEOeDQcUPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjj0KNFzL5bxwyZ6XvCM0EnzR3pY3isRZd7JEOeDQcUPQ@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:03:16PM +0100, Amir Goldstein wrote:
> On Thu, Nov 14, 2024 at 11:12 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 11:05:36AM +0100, Amir Goldstein wrote:
> > > ovl_setup_cred_for_create() decrements one refcount of new creds and
> > > ovl_revert_creds() in callers decrements the last refcount.
> > >
> > > In preparation to revert_creds_light() back to caller creds, pass an
> > > explicit reference of the creators creds to the callers and drop the
> > > refcount explicitly in the callers after ovl_revert_creds().
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Miklos, Christian,
> > >
> > > I was chasing a suspect memleak in revert_creds_light() patches.
> > > This fix is unrelated to memleak but I think it is needed for
> > > correctness anyway.
> > >
> > > This applies in the middle of the series after adding the
> > > ovl_revert_creds() helper.
> >
> > I'm going to try and reproduce the kmemleak with your ovl_creds branch
> > as is and then retry with the series applied as is plus one small fix
> > you correctly pointed out.
> 
> Don't bother. The fix that Vinicius sent me was correct.
> I still want to use this patch, so would appreciate a review.

Ah, thanks for letting me know!

