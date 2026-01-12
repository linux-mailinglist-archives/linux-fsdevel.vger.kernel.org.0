Return-Path: <linux-fsdevel+bounces-73306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31344D14C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFAC3031964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5273876CA;
	Mon, 12 Jan 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xnruUDms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E43876BB;
	Mon, 12 Jan 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243200; cv=none; b=p3PsdXbIpsMmVYNuMJU51coiDWWRaB285qP2Vdn18TgQOrwQXzUT/1C2rPPyx7pFMSkAArYNF65cC7SJwshvZE4wLpHROa4nIVsZMp6NIVHgV2jhU6ZfTOILfOSc11DPBFXHOmon25MuoxE99f3koPBuBkNi1EIFhDbWtZrbLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243200; c=relaxed/simple;
	bh=JOhw6HFoKITN/j6NwG55v9ms5aDBY8eE9gr0mfjICKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NkgeZY7yRUW10wkvoEzSrfG2I9n+7iMJJzA5IM9XU0ILc9HxNJDRBbgDal/ye2hiHV267lAkQOMsU1xD+DhSAZcyMh7SNP8m2Bx1iSGGYKnCFwnFTHE1zYwCCnjPOl1tlac8OrHS/snnI17iaXgFrk+EeTQ6YFOFggTTZGGqa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xnruUDms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE55C116D0;
	Mon, 12 Jan 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768243199;
	bh=JOhw6HFoKITN/j6NwG55v9ms5aDBY8eE9gr0mfjICKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xnruUDmsvDq5GQlzCBDjgydSUCt+iXko8wee+x6839xRPU8vdy1Zqy/mvQO6U49A4
	 pv7+iizt+W6JC1JHov8zUnNPfOfQa63V83aPYEg5b4+oXVgYNJSr6eGACWf6z86s3t
	 Vo3krBJSm5bk29A87bpBZFDMPUHV3Pvuxf8dk8HY=
Date: Mon, 12 Jan 2026 10:39:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
Message-Id: <20260112103959.e5e956cd0d8b6f904e21827a@linux-foundation.org>
In-Reply-To: <87cy3ed7c9.fsf@mail.parknet.co.jp>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
	<87secph8yi.fsf@mail.parknet.co.jp>
	<87ms2idcph.fsf@mail.parknet.co.jp>
	<CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
	<20260112095230.167359094e9c48577b387e18@linux-foundation.org>
	<87cy3ed7c9.fsf@mail.parknet.co.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 03:16:54 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:
> >
> >> Hi OGAWA,
> >> 
> >> Sorry, I thought the further merge request would be done by the maintainers.
> >> 
> >> What should I do then?
> >
> > That's OK - I have now taken a copy of the patch mainly to keep track
> > of it.  It won't get lost.
> >
> > I thought Christian was handling fat patches now, but perhaps that's a
> > miscommunication?
> 
> Hm, I was thinking Andrew is still handling the fat specific patch, and
> Christian is only handling patches when vfs related.
> 
> Let me know if I need to do something.

OK, thanks, seems I misremembered.

