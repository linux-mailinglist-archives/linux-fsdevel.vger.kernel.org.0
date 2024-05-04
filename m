Return-Path: <linux-fsdevel+bounces-18726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4578BBAAB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603F9282814
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90091C6BD;
	Sat,  4 May 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3RJ+eD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448554689;
	Sat,  4 May 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821869; cv=none; b=DlM4AAeUxlJi5Tuu2OAnNYNmLs/VWCuft4ssb3FntCeZmrn+l84ivgzoUaYEjEKsGt0gx9NyzADWt3dgQ7BgFv5p1tQbRXq9dwCcHIvGBfaYxdV74o0YWBjGTydL+j5bNDvJ7tiwdl2nRe2qaZ3CUn4Bw5rusIADLbxRTTV4mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821869; c=relaxed/simple;
	bh=ZFUN6ZfJJFj019cT3H3F5ftQBbB/jbGfSG3vzZ2bHDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy+NQcM7o0CNKsHgvXIsjZlUBHZc7wddur1iYYk3dBj2+05oGoXCY2r/TPC7WCuDYYcVSwmbTieBEByDHklGNaj3CrLmc5jBTNCU1QwegR6qILdwQK1JRRNgsoL2jK63JNIz/DjcuOhQa4VPCrBzV5GEjVo7oyNvO4SejWrt26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3RJ+eD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A9C072AA;
	Sat,  4 May 2024 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714821868;
	bh=ZFUN6ZfJJFj019cT3H3F5ftQBbB/jbGfSG3vzZ2bHDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3RJ+eD3P4krbidA4Ux+D5n2CGZ52JX4U90QOuKkNuirMUx4ftzcL9Zq24mhdBYEk
	 ic3BoOiWj/dNwNV89puB3YidkIcSOC7UcAU9JGdkmdzgU7pUYfZEzh8PX0cgRUw4lj
	 0o0Zw1EDkU0R4rYRwSe9Cad/EHVH6N0WhkKnN1HUVRyaCcZinvkHrvemcLzdsn4nvm
	 2fQythfK+JGXpeCwVuW6wNxQ04MsxSNmJQgPRhIkokdjTqhUBHHVqtoclNUI5Ax9Y5
	 B2T9wcrvandZRpNJnooCKA0KPITePq8Ae89YJI67TVPOWU1j5QOKn5GCL6cabvx0CL
	 m0FQi7LDFyd1A==
Date: Sat, 4 May 2024 13:24:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
Message-ID: <20240504-rasch-gekrochen-3d577084beda@brauner>
References: <20240504003006.3303334-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>

On Fri, May 03, 2024 at 05:30:01PM -0700, Andrii Nakryiko wrote:
> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> applications to query VMA information more efficiently than through textual
> processing of /proc/<pid>/maps contents. See patch #2 for the context,
> justification, and nuances of the API design.
> 
> Patch #1 is a refactoring to keep VMA name logic determination in one place.
> Patch #2 is the meat of kernel-side API.
> Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/maps to
> optionally use this new ioctl()-based API, if supported.
> Patch #5 implements a simple C tool to demonstrate intended efficient use (for
> both textual and binary interfaces) and allows benchmarking them. Patch itself
> also has performance numbers of a test based on one of the medium-sized
> internal applications taken from production.

I don't have anything against adding a binary interface for this. But
it's somewhat odd to do ioctls based on /proc files. I wonder if there
isn't a more suitable place for this. prctl()? New vmstat() system call
using a pidfd/pid as reference? ioctl() on fs/pidfs.c?

