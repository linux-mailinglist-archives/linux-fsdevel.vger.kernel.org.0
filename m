Return-Path: <linux-fsdevel+bounces-25029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBD948035
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2128356A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1315ECCF;
	Mon,  5 Aug 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSk2kxaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A2155749;
	Mon,  5 Aug 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878715; cv=none; b=msTONzoE7WoT0/9F3V4ZSADT9OduGClH7+hPpPnA7Y9209zcMx4Zq72OGjqO5xuDxbIjiH8ldrCRYSUPCupwWLChRRJ3sHmWMEwsC1b89f07yKYHGh6qgR0CsiEEK6iWLaQjg6Qk50O3wt1cIoxzNbdkkV726U60dQNwZpl9dN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878715; c=relaxed/simple;
	bh=6jiMp/tganddUy2GEXyAWzO93sNAySBn8h/eSzyTAFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu9eilDjc+zs3miE+KZ5seXCYJeLIXHOF3yFtEYOE/c/r6AKFO93i7NiKLzyI746IEKxMxTJTaMLlKG+5pg0L4gBJCOcPPNVLoKfH+1LIHsKM+SJBxEDzOeE56EEKZkU65+9w0D3ISxykh96vqJw2JO4GwUCpkYJl3xyzD9q2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSk2kxaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D40AC32782;
	Mon,  5 Aug 2024 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722878715;
	bh=6jiMp/tganddUy2GEXyAWzO93sNAySBn8h/eSzyTAFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSk2kxaUdjpWZLwzL8CHxlLo8WAqHccxGNixNX4AclDxjXMM577Dmai0PDa+XhXu1
	 HNvyvMpwZ83/ueUzR0Bj799BisF3MjXcDwREBb/kakHGMdGfGj5e7dujt2Dp8bRoKT
	 0jvy0niCerAtzu9NPApz/cXFGyQYR0Ot91Y7+VopNjoeF5mLWxTuddhSCMtRGTfAmK
	 Elu1hNDdq1pXoSzfl+wfuDrIJPLuikDGRRXf3cmtCTYg0Gs+1NhKpK9CobLu7nfX1E
	 WD2JOXf4CGwfHXz7/XdUnQKFdvo9HCQajMfFzrT12fb8c+gp2NLd72Iw2eDnXODDDS
	 9CVHS1bS3TMVg==
Date: Mon, 5 Aug 2024 10:25:14 -0700
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202408051018.F7BA4C0A6@keescook>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
 <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
 <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>

On Thu, Aug 01, 2024 at 05:58:06PM +0000, Brian Mak wrote:
> On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > One practical concern with this approach is that I think the ELF
> > specification says that program headers should be written in memory
> > order.  So a comment on your testing to see if gdb or rr or any of
> > the other debuggers that read core dumps cares would be appreciated.
> 
> I've already tested readelf and gdb on core dumps (truncated and whole)
> with this patch and it is able to read/use these core dumps in these
> scenarios with a proper backtrace.

Can you compare the "rr" selftest before/after the patch? They have been
the most sensitive to changes to ELF, ptrace, seccomp, etc, so I've
tried to double-check "user visible" changes with their tree. :)

> > Since your concern is about stacks, and the kernel has information about
> > stacks it might be worth using that information explicitly when sorting
> > vmas, instead of just assuming stacks will be small.
> 
> This was originally the approach that we explored, but ultimately moved
> away from. We need more than just stacks to form a proper backtrace. I
> didn't narrow down exactly what it was that we needed because the sorting
> solution seemed to be cleaner than trying to narrow down each of these
> pieces that we'd need. At the very least, we need information about shared
> libraries (.dynamic, etc.) and stacks, but my testing showed that we need a
> third piece sitting in an anonymous R/W VMA, which is the point that I
> stopped exploring this path. I was having a difficult time narrowing down
> what this last piece was.

And those VMAs weren't thread stacks?

> Please let me know your thoughts!

I echo all of Eric's comments, especially the "let's make this the
default if we can". My only bit of discomfort is with making this change
is that it falls into the "it happens to work" case, and we don't really
understand _why_ it works for you. :)

It does also feel like part of the overall problem is that systemd
doesn't have a way to know the process is crashing, and then creates the
truncation problem. (i.e. we're trying to use the kernel to work around
a visibility issue in userspace.)

All this said, if it doesn't create problems for gdb and rr, I would be
fine to give a shot.

-Kees

-- 
Kees Cook

