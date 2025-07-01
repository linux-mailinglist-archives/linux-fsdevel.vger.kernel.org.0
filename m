Return-Path: <linux-fsdevel+bounces-53411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E0AEEE10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF26F3AA249
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F78239E60;
	Tue,  1 Jul 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcfXPUUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3433EC;
	Tue,  1 Jul 2025 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349528; cv=none; b=Y2nO5cDT8QZfTLFMdjLn7lyFrKBuBBxG38H+0ulK5ultCyN17kgztwcfy797e10CcM7D4PSDxG8EkQlux9Xv6rycQyRQ/FEQQpuumznqYIhVEssfGSsLizqHSnMK2jJxfU/q83zF56EIev2KWK5CJJcYHlWJuYjG9F+UUf/6J+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349528; c=relaxed/simple;
	bh=QOJ0JIb6v2SPa7HAN+qXGvpFDF/Ud7L7nUse4cj3hCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgC6SEBuE47XXSrJvx7FOwX6u2tEfd/RsRcqX2N604RuAsytV2Xw6Qar9/dJSmWWAYu75ot/Yyaz4hzyiYsoN2Bk5F3/AXeP9l9L2/e+AfXN4/HE00pGvUadmuCriNRVgalLg/ygbTltjtzDwbukFDdRe0whGi0/1GiSdwvOrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcfXPUUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C6C4CEEB;
	Tue,  1 Jul 2025 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751349527;
	bh=QOJ0JIb6v2SPa7HAN+qXGvpFDF/Ud7L7nUse4cj3hCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcfXPUUlgpvRX/6V+vcyHJTJsfA+jKEufnfLIEceO0O5MAPLsa2crG66y+cvknXwJ
	 1cqmeD2+/u8+qtioAs5+i5DkCUdRQwbhGhjjrhJGk1lLESx8JfM8CpZCsc6WHwg9pV
	 BemCL6TXb0JlOLZ0kXfPTDbkBQ174NW4tUbwN/NXja8H33FIFREI1DJ1MVDW85GygS
	 qqv6+a8iZF2JnjZohsdsWrYgyXiC5rFOz6VxQdGLxvSG0VDxiLPGLxaTvJ5ghFpBfK
	 gvlMfX51ZxMO49BfNRClshqpiCiTqaGYhGWMdGx3vNyF0pajGJoZjsv9F9j4wKC401
	 K1HKkbbiwDGFw==
Date: Mon, 30 Jun 2025 22:58:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Allison Karlitskaya <lis@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250701055847.GF9987@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
 <20250611115629.GL784455@mit.edu>
 <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>

On Fri, Jun 20, 2025 at 10:58:38AM +0200, Allison Karlitskaya wrote:
> hi Ted,
> 
> Sorry I didn't see this earlier.  I've been travelling.
> 
> On Wed, 11 Jun 2025 at 21:25, Theodore Ts'o <tytso@mit.edu> wrote:
> > This may break the github actions for composefs-rs[1], but I'm going
> > to assume that they can figure out a way to transition to Fuse3
> > (hopefully by just using a newer version of Ubuntu, but I suppose it's
> > possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> > in any case, I don't think it makes sense to hold back fuse2fs
> > development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> > necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> > they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> > sound fair to you?
> 
> To be honest, with a composefs-rs hat on, I don't care at all about
> fuse support for ext2/3/4 (although I think it's cool that it exists).
> We also use fuse in composefs-rs for unrelated reasons, but even there
> we use the fuser rust crate which has a "pure rust" direct syscall

Aha, I just stumbled upon that crate.  There are ... too many things on
crates.io that claim to be fuse libraries/wrappers/etc.

It's tempting to go write fuse4fs as a iomap-only Rust server, but I
never quite got the hang of configuring cargo to link against a locally
built .so in the same source tree (i.e. when I was trying to link
xfs_healer against libhandle that ships as part of xfsprogs).  I'm not
even sure I want to explore exposing libext2fs in a Rust-safe way.

> layer that no longer depends on libfuse.  Our use of e2fsprogs is
> strictly related to building testing images in CI, and for that we
> only use mkfs.ext4.  There's also no specific reason that we're using
> old Ubuntu.  I probably just copy-pasted it from another project
> without paying too much attention.
> 
> Thanks for asking, though!

I'm glad to hear that e2fsprogs can drop fuse2 support! :)

--D

> lis
> 
> 

