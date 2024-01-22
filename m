Return-Path: <linux-fsdevel+bounces-8496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2898C837754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B11C25558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5A47A4B;
	Mon, 22 Jan 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyCnRa+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDE38381;
	Mon, 22 Jan 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964599; cv=none; b=lEEunRSzIgP/v6rBcbg3TijKPY7874/AbSateu6LBiPkzrNdA72Y4p6CFgB6NvW2u2NBvZNWAKwxlIaRXfxzT0zBpvgTSymuQZu/dqNV3UOJyRargeWqfpeHJKgV1svVXi+LWwJZasfm1qRfB8uXg8K6O0YTkRnBIEW08f7ujjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964599; c=relaxed/simple;
	bh=9E0yhn+Lc/Wf7cldLrsQEIy48JDSgVb+dkMEu7awprU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c708TkQUOuYt9ze6w+wtup3yiMS4KybDfdi+P8H7Xr9rGs0fbge2sdnyLg2ENQDzuCAJs9FgP00t2wbZ2EKOvAIkhQF7PX5FLU+nFAiS7vyltq4Qsmt/HDQYTaPmzADtTLbULfE6GWM1WespF8hb0tDzEf6LZmVXmvuBo4w1/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyCnRa+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452EAC433C7;
	Mon, 22 Jan 2024 23:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705964599;
	bh=9E0yhn+Lc/Wf7cldLrsQEIy48JDSgVb+dkMEu7awprU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyCnRa+Ml6gi8FoJ0a6Wq6z/wFvdFCzrnyDATRof2LBkIs88L/Sd/33c2abS/hhdC
	 qk+zaRsnoLx0PPzhc41zxZGCgRRwjRHstBTywnHITBscZsZuZRXdhA9jJcthFcdzF3
	 i9ZZPG7Bdmoo70ro+oI5JkXJHW9oHwih+XTNk3iq1HJ4eti4sww3MBu6X83JdBWeD/
	 le7nD2jFAedef2UTYI3pmAFFucxpZmFJTo5+3UmYNBFcbjiTFmBGIIcTebhOsu61M5
	 B5poRtVF71CKafkTabLE4+V5SA1c9PMt/v3RZggGpVhGBrqc7GRxPyC98sD5fcUbZM
	 3ubMUyXmh90EA==
Date: Mon, 22 Jan 2024 15:03:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] eventfs: Have the inodes all for files and
 directories all be the same
Message-ID: <20240122230318.GC6226@frogsfrogsfrogs>
References: <20240116225531.681181743@goodmis.org>
 <20240116234014.459886712@goodmis.org>
 <20240122215930.GA6184@frogsfrogsfrogs>
 <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>

On Mon, Jan 22, 2024 at 02:02:28PM -0800, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 13:59, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> >          though I don't think
> > leaking raw kernel pointers is an awesome idea.
> 
> Yeah, I wasn't all that comfortable even with trying to hash it
> (because I think the number of source bits is small enough that even
> with a crypto hash, it's trivially brute-forceable).
> 
> See
> 
>    https://lore.kernel.org/all/20240122152748.46897388@gandalf.local.home/
> 
> for the current patch under discussion (and it contains a link _to_
> said discussion).

Ah, cool, thank you!

--D

>            Linus

