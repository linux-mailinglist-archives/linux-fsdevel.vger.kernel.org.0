Return-Path: <linux-fsdevel+bounces-33302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D69B6F9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFED1F22006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452541D0E0D;
	Wed, 30 Oct 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k5YZxKoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601131BD9E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730325396; cv=none; b=SwRXITQdbD+HfaBzfN6A7njQxNVN1bO4vG0lGrLYOUgBD0rf0mP7ZCoJyj6BY3xTk96T7mUNWtEgDjsaxRgL0W9f//QIq1lV5Ol0D0uVsCk3MInSkI/uShxqswEk15O3kQ/umynPQes3zZaGNTaYTiMj2wfOoATZ+7HIc27b7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730325396; c=relaxed/simple;
	bh=tR4/EotUivc/7jiagpx680zYfAgzMwXc0OjSM7VvPQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i52sdq75ouYdPfIO0SjnLVLTBzGzufM2N4sklKexU7GgTo93G3emE6F6bdR8l3xx/K4bJO0MTlVEl+HLyw+HIDuoZx6A7n5RapXR5FnQLfB5MYudPhScClFVTig1oEaNTJhT6rthHD5OKYrXing3WvmELGJksZvYDre5KwY4lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k5YZxKoV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Oct 2024 14:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730325390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VUlfA7tM1TVV6uo3if3+lGHhFVUrXdrLThYsxW6fYg=;
	b=k5YZxKoVHwq3/JXsudymmK6M5Z46e94WXOQ+cqfAhNFbUl7vl97TSqgjoHzApfq29wHm5c
	yT3kz4bNAaL2Z9OO/Ea2AjLw0ZtQD9OoKefL2vZApowcK/nvwUKs4IKnI8rVvytIYnUAAR
	D2k9MIOpAsExKAvG8mKGj2v2+XUkjgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
References: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
 <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 30, 2024 at 10:35:47AM GMT, Joanne Koong wrote:
> On Wed, Oct 30, 2024 at 10:27 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> > Hmm, if tmp pages can be compacted, isn't that a problem for splice?
> > I.e. I don't understand what the difference between tmp page and
> > write-back page for migration.
> >
> 
> That's a great question! I have no idea how compaction works for pages
> being used in splice. Shakeel, do you know the answer to this?
> 

Sorry for the late response. I still have to go through other unanswered
questions but let me answer this one quickly. From the way the tmp pages
are allocated, it does not seem like they are movable and thus are not
target for migration/compaction.

The page with the writeback bit set is actually just a user memory page
cache which is moveable but due to, at the moment, under writeback it
temporarily becomes unmovable to not cause corruption.

Shakeel

