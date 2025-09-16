Return-Path: <linux-fsdevel+bounces-61770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38988B59AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B827B23DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9E343207;
	Tue, 16 Sep 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM0JpYJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FC335BAC;
	Tue, 16 Sep 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034183; cv=none; b=ZFINSokjorFqL/9zu2/E2JLAVcwcmz/Mnww2LV+RdjZJgTZl93g30dALdfpOtfAzpj6mvLfrwSnRzswaNq9nq5sReHAoIJQSiBMlD2pIESHAKEfTlr7Z8AxezDmsLWmuQVTKCb/U9h19QALujEjLRZrbE8YfkefBFqu3pBXlfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034183; c=relaxed/simple;
	bh=xy4v1XFGir9SIE4RzoKupq/OMA0K0aETY2gPRJJTouE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgeZ9iQmlb1w+yIPMKXDOziAxR+hY3yjnRlwVNeKIc+c1vPwm5TvLPOMm5+pYLTSpQL5KwJcla8ZlsBBiWqj/029NqAyeiCzn4SzrTkejBpWWinYIlWSEYQd2gnFmAhs7wuXeNDqd91eOH3dpuZ90nm12VPYgddtpmEDykf7VZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM0JpYJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2823EC4CEEB;
	Tue, 16 Sep 2025 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034183;
	bh=xy4v1XFGir9SIE4RzoKupq/OMA0K0aETY2gPRJJTouE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM0JpYJ/ufWjW83qHEnYIFRF36FomptIhhtwJ6zTfJhTKsY42a4GwBJ1THyu7tScG
	 hovX23+QFGo/eX1tdubfW/si6LzsdMKq8nZEfwQwC3auK/A4c5DhBg5buLp+9OdDb5
	 XuzlOdhHg0ujhPbHzVdF0eNEmun7uC7amRqjyjeteaS+Q03lTTbmzGfbJziZdIwMxg
	 BO1WHLSPjM8vTis3RtYecwKQ18MC7aLxQ/Mpqmp7zxWReaoHLwHXqeYeTGqCVOdBDx
	 wttLezAQCW3y70xWSTONmuOxRKnmzt8Qk3MSXvSpd4QmYeQpitbWCTcW7F6sgzVXC3
	 /BAz7F4JTZ5yQ==
Date: Tue, 16 Sep 2025 07:49:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 1/2] iomap: trace iomap_zero_iter zeroing activities
Message-ID: <20250916144942.GE8096@frogsfrogsfrogs>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
 <175798150439.382342.16301331727277357575.stgit@frogsfrogsfrogs>
 <aMlq4DhX_mzoNz8q@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlq4DhX_mzoNz8q@infradead.org>

On Tue, Sep 16, 2025 at 06:49:20AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 15, 2025 at 05:26:24PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Trace which bytes actually get zeroed.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you send this out separately so that we can get it queued up ASAP?

Will do.  Thanks for the review.

--D

