Return-Path: <linux-fsdevel+bounces-67341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CEFC3C2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C140F3518FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A932B994;
	Thu,  6 Nov 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/PRZQgY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DF217F2E;
	Thu,  6 Nov 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444183; cv=none; b=roQ8azeEod5j72ehNKdaN4eza1OzzI1qreKQWMLrtBiw5+jSUQbWUrpH+wt7g5qZca97jLz8NutELrZsY3zNqxhp/ZReU4f2lXh3laCp9FpAf/TDtx/pzS+AY0cAbGdkI2UDi19hNk3HQpVhp/UCOf6bglnt1xlJSShkWjDk0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444183; c=relaxed/simple;
	bh=7TC1p2s9TGnPBiDKMtq98JVXuCQ4iJCFX4nkyWMijLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTrL15XidCsLmo0glKqOVFO1FQGEhssgyP3C58bqLF2OEe+ER0W1usknrTRfhQlmNZdUCDzVKl2KS642WWDCec3G6Afu1mHamWUrCIf1nqbuhX5QKxnkqhQmM+VWLMIB/4NOwd9HzpM5pbBi8PHcs4jhB8CWIFHlbklwGfB9+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/PRZQgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4580C116C6;
	Thu,  6 Nov 2025 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762444182;
	bh=7TC1p2s9TGnPBiDKMtq98JVXuCQ4iJCFX4nkyWMijLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/PRZQgY9FbWd0mKXsz3tUU+Ns39L+9bIJDSNabFpeLlGw6EDKEU81BhKEjeG0Gug
	 3vS2Q/yG7R7KYXpLZbQxTjGpN7ovtqzhfTGGtA5EpAe3/jdpy4+eZBnbhAQ3tMuD3s
	 53qzBHcFdD1+dODt/9R7U/KCUu6l0xNqnzHJLXSNDawwfrCGZanMgjaRrsLJh37uxD
	 lyRfR/48lzuvECWjInCOf6OejnMWGGG1T4ynyvhOkndrxpsNY1O0cYyoOzXraWdVpU
	 37nOs3MAhev0oss/gBW6pqcldMuQNcNPHwDSKbgMl4DrdRBvzlXN5wtOpHi0aZpQ/P
	 Ka81nuJBhOKeA==
Date: Thu, 6 Nov 2025 07:49:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>,
	Bernd Schubert <bernd@bsbernd.com>, Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20251106154940.GF196391@frogsfrogsfrogs>
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
 <20251105224245.GP196362@frogsfrogsfrogs>
 <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
 <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>

On Thu, Nov 06, 2025 at 11:13:01AM +0100, Amir Goldstein wrote:
> [...]
> 
> > >>> fuse_entry_out was extended once and fuse_reply_entry()
> > >>> sends the size of the struct.
> > >>
> > >> Sorry, I'm confused. Where does fuse_reply_entry() send the size?
> 
> Sorry, I meant to say that the reply size is variable.
> The size is obviously determined at init time.
> 
> > >>
> > >>> However fuse_reply_create() sends it with fuse_open_out
> > >>> appended and fuse_add_direntry_plus() does not seem to write
> > >>> record size at all, so server and client will need to agree on the
> > >>> size of fuse_entry_out and this would need to be backward compat.
> > >>> If both server and client declare support for FUSE_LOOKUP_HANDLE
> > >>> it should be fine (?).
> > >>
> > >> If max_handle size becomes a value in fuse_init_out, server and
> > >> client would use it? I think appended fuse_open_out could just
> > >> follow the dynamic actual size of the handle - code that
> > >> serializes/deserializes the response has to look up the actual
> > >> handle size then. For example I wouldn't know what to put in
> > >> for any of the example/passthrough* file systems as handle size -
> > >> would need to be 128B, but the actual size will be typically
> > >> much smaller.
> > >
> > > name_to_handle_at ?
> > >
> > > I guess the problem here is that technically speaking filesystems could
> > > have variable sized handles depending on the file.  Sometimes you encode
> > > just the ino/gen of the child file, but other times you might know the
> > > parent and put that in the handle too.
> >
> > Yeah, I don't think it would be reliable for *all* file systems to use
> > name_to_handle_at on startup on some example file/directory. At least
> > not without knowing all the details of the underlying passthrough file
> > system.
> >
> 
> Maybe it's not a world-wide general solution, but it is a practical one.
> 
> My fuse_passthrough library knows how to detect xfs and ext4 and
> knows about the size of their file handles.
> https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/fuse_passthrough.cpp#L645
> 
> A server could optimize for max_handle_size if it knows it or use
> MAX_HANDLE_SZ if it doesn't.
> 
> Keep in mind that for the sake of restarting fuse servers (title of this thread)
> file handles do not need to be the actual filesystem file handles.
> Server can use its own pid as generation and then all inodes get
> auto invalidated on server restart.
> 
> Not invalidating file handles on server restart, because the file handles
> are persistent file handles is an optimization.
> 
> LOOKUP_HANDLE still needs to provide the inode+gen of the parent
> which LOOKUP currently does not.
> 
> I did not understand why Darrick's suggestion of a flag that ino+gen
> suffice is any different then max_handle_size = 12 and using the
> standard FILEID_INO64_GEN in that case?

Technically speaking, a 12-byte handle could contain anything.  Maybe
you have a u32 volumeid, inumber, and generation, whereas the flag that
I was mumbling about would specify the handle format as well.

Speaking of which: should file handles be exporting volume ids for the
filesystem (btrfs) that supports it?

--D

> Thanks,
> Amir.

