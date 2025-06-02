Return-Path: <linux-fsdevel+bounces-50299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705FACAB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BEB18955C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F011CEAA3;
	Mon,  2 Jun 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nca/dKql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A01AF4D5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748855076; cv=none; b=YOUZ7viNCiMq22dl3++yq50CUtgq5Kmqg3gtGN8a5kIdhVFpUdHWhwZz3SRocSMk1XwhcmetfygWiVQ/lDT/uymaKme3m7aLTJqaNi9PB+UCPWeDOud04QTAUFZ8YUBH11wLJJdz6TiUlqVoSFyeL2w26kCayi6FZ1Sa32rmGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748855076; c=relaxed/simple;
	bh=HVl4qNpIkApLYC+fQzXewrB1RMqnNuR5Oe/jbzrHuw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf0pRkzMXqWP7gI/go2XDg+X7Lf74Yn76To0OsHQOV4yGUgUvKNyXUlI41LD951S3eEon1vuiF8vh2H0afztkRmBPrXXht4LgWPnS65AJDzBY//vEPqMOwwAKZs9hg4AqOwOEDik8l+Y7thqaJY8z5eprxlBHzfm9csfQPxiv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nca/dKql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B313BC4CEEB;
	Mon,  2 Jun 2025 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748855076;
	bh=HVl4qNpIkApLYC+fQzXewrB1RMqnNuR5Oe/jbzrHuw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nca/dKqlKu7BpweLWb61RzJI8Y5wYawoivp6usjLggBVT5DM4YpV+fX1XMG6SH3/3
	 /fTiYn964Al9mAycRtbydmvfZboTKQfR9GHOrAy/nToNTPO3b3u+/647v5mRlrIjDi
	 QipUDjE5KVtnbyHYMCnoX9Ko4S31OjTGIxMC38QJnPmVqjm2LSoTDd5mVwAyGXa+2r
	 WgJL82SaBnk34F/lPtq1GW7PfGAtbUlAHK/kgRlD1X3A6O1yT4zWPzfSpeOICIF9Qq
	 nauy6w0ssGDivEzHosQY/FJ81+oND9hXB0ZnUJheDqB3QxjUF4e+azt0wE4rfiUsdF
	 BbA7N7TSYM4Hw==
Date: Mon, 2 Jun 2025 11:04:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250602-ortsnamen-umwegen-2f2780a769c6@brauner>
References: <20250525083209.GS2023217@ZenIV>
 <20250529015637.GA8286@frogsfrogsfrogs>
 <20250531011050.GB8286@frogsfrogsfrogs>
 <0315c56c-5fe1-460d-8b34-a356e42ccae5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0315c56c-5fe1-460d-8b34-a356e42ccae5@kernel.dk>

> >> https://lore.kernel.org/linux-fsdevel/20250416180837.GN25675@frogsfrogsfrogs/
> > 
> > After a full QA run, 6.15 final passes fstests with flying colors.  So I
> > guess we now know the culprit.  Will test the new RWF_DONTCACHE fixes
> > whenever they appear in upstream.
> 
> Please do! Unfortunately I never saw your original report as I wasn't
> CC'ed on it, which I can't really fault anyone for as there was no
> reason to suspect it so far.

I've just sent the pull request with the fixes a minute ago.
Thanks for testing!

