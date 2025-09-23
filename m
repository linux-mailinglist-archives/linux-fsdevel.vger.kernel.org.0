Return-Path: <linux-fsdevel+bounces-62492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC9B95768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F632E5046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04593321290;
	Tue, 23 Sep 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izh3cJmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617903203AE
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624039; cv=none; b=AcmeuuCaP4gnEkp+dF3HuxONxUG5/auvxo0Iqd7dVAzVjS9hLS/qbd2zQKmBOitpnH1CbYOqJPp4szEV/MaYKLO6PhV1LzK9cyeYsp2oz0uTkAjWseAd+IIpZPp94q63Da4fAh1aiv/9KuyAo/xu/81PVI1eKAMEDbZfPLvsWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624039; c=relaxed/simple;
	bh=YciENpSgtY5gJgfdOHzXcxY3Do8jl0sLg7P3MzBNjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxoI7gtyjQG8icjbBibYI4BEcfxdx8YLH+y1TP2NiI3Yito0FHFadNbOSFa1urO9pBdeaBc4H8EN+2aSWNI8IkPwTmmy0nlK1wURjNHR93UqUp2FCQ+o2KRazcixuFqKCLjWXMJmB7Q/YQ7j03d/iRf3gBDM4e7KAZsCO622Ejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izh3cJmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC5C116B1;
	Tue, 23 Sep 2025 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758624039;
	bh=YciENpSgtY5gJgfdOHzXcxY3Do8jl0sLg7P3MzBNjzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izh3cJmOqlwDy2XWzL3XPBPA7UAhBEcAnAzln+TIbfh7ItbtAB8bJzdLMwvnxr88H
	 uPFYQwSNZIQFyd8ICmVv93jut3oIeshNN9++A6lu18DaB01N3zT2zMDhLmr6n1Llsy
	 Qzg5JQ/wK8iHoIEsPzgiSxuWym2Tv/TG+bnuJRR7B8fFK2/0KbXzRaACbY9rpRZPQ5
	 Cy8tV6MHuIWEoJ5B5ezAB6huOLKw8lDSX4yJavr1T9Uqgoq1lG3+1eELjATqQjT9oI
	 WffFTdYpV8vvTumSk53ScKM9pcZ7YfkuICGLLv523dfQEesxPAlSaVss3LFcaej6pT
	 nIdvhvm4rlPMQ==
Date: Tue, 23 Sep 2025 12:40:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] VFS: rename kern_path_locked() and related
 functions.
Message-ID: <20250923-spatzen-lasten-1e29f69b2b15@brauner>
References: <20250922043121.193821-1-neilb@ownmail.net>
 <20250922043121.193821-6-neilb@ownmail.net>
 <20250922052100.GQ39973@ZenIV>
 <175852620438.1696783.572936124747972315@noble.neil.brown.name>
 <20250922133219.GR39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922133219.GR39973@ZenIV>

On Mon, Sep 22, 2025 at 02:32:19PM +0100, Al Viro wrote:
> On Mon, Sep 22, 2025 at 05:30:04PM +1000, NeilBrown wrote:
> > +-  kern_path_locked -> start_removing_path
> > +-  kern_path_create -> start_creating_path
> > +-  user_path_create -> start_creating_user_path
> > +-  user_path_locked_at -> start_removing_user_path_at
> > +-  done_path_create -> end_creating_path
> > 
> > 
> > Are you saying that it also needs to mention that start_removing_path()
> > now calls mnt_want_write()?  Or that end_removing_path() should be
> > called to clean up?  Or both?
> > I agree that the latter is sensible, I'm not certain that the former is
> > needed, though I guess it doesn't hurt.
> 
> My apologies - I'd managed to miss the relevant part of patch, actually ;-/
> 
> Al, seriously embarrassed.

I think reviewing with the expectation to never miss anything is a
losing strategy. ;)

