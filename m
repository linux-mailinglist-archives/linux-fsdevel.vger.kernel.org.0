Return-Path: <linux-fsdevel+bounces-35399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5919D49BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93738282456
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382D1CEAA2;
	Thu, 21 Nov 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foWLhjSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A631CEAAC;
	Thu, 21 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180504; cv=none; b=SFd3MQ3HDGxIExXK8szJDtROP8d95XfhRoFphTnyTm0VIB//AHbGr54ZRK+6VE5CBDcwGC/lFpMdwa+wSHQIegtsknrjdw4NhkmZc8LY6wVkkDIu/i5xESQUFpEXvfFFC24jG3nxfdltX2Qm800YKFzCjX+HW0chcQK/y67b0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180504; c=relaxed/simple;
	bh=Uf0hWkHxoYiN8riGMbGntzjOtzPqvs2h2lMGB0HeONY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qofhVKcFIeRNNEtcRubsM9zK0PxPPN74hLnGaDJsY3M9JK6+NMzfD1YwE9q12SxoueyXgJ1U56MH+t4cdKxpT3sqId1G4sa+sF5LHTYB5ems4yeOSxazjvC3IFkHC8qhcdOmwL7nN8PfAj+Q0f6+DnjMxOdf35SXSeOrOj9xOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foWLhjSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A41C4CED0;
	Thu, 21 Nov 2024 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732180503;
	bh=Uf0hWkHxoYiN8riGMbGntzjOtzPqvs2h2lMGB0HeONY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foWLhjSczE7CDgEqUlZ+g26zxC+rtnOjzye+ImrsXs0W3dXcBoJlqCi4vnXVd44BD
	 jSFh7mPfAoZXfTk/mRNxeWrVhRJl9wYqmf6qTX/E53klyvUIvdraLqDNsrESzJ0eQ9
	 sZQ6fnJ3aYafoy/Sx8koStFVKdxjdnZpvlLhd1ybDJOqjfLA/oVmY3chzAlOoZJuWf
	 RuubicXY+6J3hUbkIPHZt5rXUI/ixtONh4nbRzfWfeaW2P8ll6G3AS8dri1MrBtrGF
	 DLqq6qUKqOmlOiY9UtJXErsXU2F2mKXoZ/0pNpWN6aVuWxL5+MN77UKd1e/jqOCIrc
	 PsyUOcsVLDF2g==
Date: Thu, 21 Nov 2024 10:14:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "repnop@google.com" <repnop@google.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Message-ID: <20241121-unfertig-hypothek-a665360efcf0@brauner>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115111914.qhrwe4mek6quthko@quack3>

> I'm personally not *so* hung up about a pointer in struct inode but I can
> see why Christian is and I agree adding a pointer there isn't a win for
> everybody.

Maybe I'm annoying here but I feel that I have to be. Because it's
trivial to grow structs it's rather cumbersome work to get them to
shrink. I just looked at struct task_struct again and it has four bpf
related structures/pointers in there. Ok, struct task_struct is
everyone's favorite struct to bloat so whatever.

For the VFS the structures we maintain longterm that need to be so
generic as to be usable by so many different filesystems have a tendency
to grow over time.

With some we are very strict, i.e., nobody would dare to grow struct
dentry and that's mostly because we have people that really care about
this and have an eye on that and ofc also because it's costly.

But for some structures we simply have no one caring about them that
much. So what happens is that with the ever growing list of features we
bloat them over time. There need to be some reasonable boundaries on
what we accept or not and the criteria I have been using is how
generically useful to filesystems or our infrastructre this is (roughly)
and this is rather very special-case so I'm weary of wasting 8 bytes in
struct inode that we fought rather hard to get back: Jeff's timespec
conversion and my i_state conversion.

I'm not saying it's out of the question but I want to exhaust all other
options and I'm not yet sure we have.

> Longer term, I think it may be beneficial to come up with a way to attach
> private info to the inode in a way that doesn't cost us one pointer per
> funcionality that may possibly attach info to the inode. We already have

Agreed.

