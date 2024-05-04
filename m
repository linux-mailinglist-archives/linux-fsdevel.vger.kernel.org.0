Return-Path: <linux-fsdevel+bounces-18732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED868BBCC0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05FB1C2083B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B154CE13;
	Sat,  4 May 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8oKj1vu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31123EA76;
	Sat,  4 May 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836843; cv=none; b=TTZ+IJncnL0/7nUEDL+kWmtR2hTO1LxBE7N7/jv+T03DF6NBRvuR8h45QaRRMTd8aVvxXUs00zzJFzsmx6DZPBQacmvGhRDR96O3Rh0tRGMGIJx252wWOC3+XqoWd3DElnQFfi+YDUDTC3lnMOrLUG09oKf/XnqxVaxE4BhN+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836843; c=relaxed/simple;
	bh=Tw298gqXSpUNqvTJkAVfkw6zpwke5iNqzYaHmcCtz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK9Xc8t9TmdOeemweaxdiH+wOmgVU+jn4+AP1IyglZbjezGU5e1Dhn92KInAcZ4KVMDanxDhHYCOwjq1euBj9xhbgd0nd5Fy1xtYnBPh0/YX1I54QuMpo6h4xKvxr/gGEWjtwbGzboHc/NzSGCL0zTcugiOQzlpdxouD/vuNraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8oKj1vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CF9C072AA;
	Sat,  4 May 2024 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714836842;
	bh=Tw298gqXSpUNqvTJkAVfkw6zpwke5iNqzYaHmcCtz/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8oKj1vuOdQlfRTomxMl8NGsRXqYO/Yop4wH6qOJ+VYQXhJj8oDV2Yd/oada14QOe
	 Z0Bj4Rw/XlpEWO5oUJ4quoahtgdmSP3HgFBsAmdcfpqkzXvVUkp9wBmt/vJvzfFmeB
	 MkbKMSmopKmujPR8NjtEqq5cFrhvzJClELB3a0PM=
Date: Sat, 4 May 2024 17:33:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
Message-ID: <2024050424-drift-evil-27de@gregkh>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504-rasch-gekrochen-3d577084beda@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504-rasch-gekrochen-3d577084beda@brauner>

On Sat, May 04, 2024 at 01:24:23PM +0200, Christian Brauner wrote:
> On Fri, May 03, 2024 at 05:30:01PM -0700, Andrii Nakryiko wrote:
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> > applications to query VMA information more efficiently than through textual
> > processing of /proc/<pid>/maps contents. See patch #2 for the context,
> > justification, and nuances of the API design.
> > 
> > Patch #1 is a refactoring to keep VMA name logic determination in one place.
> > Patch #2 is the meat of kernel-side API.
> > Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> > Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/maps to
> > optionally use this new ioctl()-based API, if supported.
> > Patch #5 implements a simple C tool to demonstrate intended efficient use (for
> > both textual and binary interfaces) and allows benchmarking them. Patch itself
> > also has performance numbers of a test based on one of the medium-sized
> > internal applications taken from production.
> 
> I don't have anything against adding a binary interface for this. But
> it's somewhat odd to do ioctls based on /proc files. I wonder if there
> isn't a more suitable place for this. prctl()? New vmstat() system call
> using a pidfd/pid as reference? ioctl() on fs/pidfs.c?

See my objection to the ioctl api in the patch review itself.

Also, as this is a new user/kernel api, it needs loads of documentation
(there was none), and probably also cc: linux-api, right?

thanks,

greg k-h

