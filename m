Return-Path: <linux-fsdevel+bounces-28898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697E9702E4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B51C21B16
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD415D5AB;
	Sat,  7 Sep 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APICZSoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259018C08;
	Sat,  7 Sep 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725722253; cv=none; b=qyJR8PFT7lB20EZ5LIXv0ICRY5EloFcp9Co2o+ByW31im3PU+cVL8JTEHrHXV0pf2Yho41kK28dnKX7SXykWgjZOXXY+ugJ0RW01HCjbib32OnSYs1cwBLjyR79vXL4RYpM8Gx0WLXvsshpfF3V/fZL7+5xvlHdhDykSLwNdFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725722253; c=relaxed/simple;
	bh=Ku4bjARC68Ga+X0eQe+xkycEzMKcH7T/GMNhH8k/Z90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOgQA/XV35lQChJCnXnqP0NOVNWi6i0qwKXWV/Sitff/6D5SRbU63esPSlq1uPCZkKvPCBqYr1KG396KAsU9T6/BWleQmlNpdfh31owOgGXp92EybWxQ7cxtXjDag1QdbetaFa26Dc8wYDI7HX8hJo0yfHUOTNEO8pQ0Exxjh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APICZSoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1951C4CEC2;
	Sat,  7 Sep 2024 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725722253;
	bh=Ku4bjARC68Ga+X0eQe+xkycEzMKcH7T/GMNhH8k/Z90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APICZSooHLLev2AZZPDi6+Eg9H0YRveEQhFsc8/oB3IZorsWUfDjYuT/J7D4OmU4D
	 JxCkXJhaPbT+7bU8ox65qe61UogWTfgX2p3Rs+0ppqxiS8tIsgjqyFQT8PaO9LYLVZ
	 //3xBAACTvm1XlrLxNQR0+R+EYqERgoXcLezsW4hXs+/Mvn0+pZsIO6obRfHdPIC6I
	 KHEgJnvcGAUsbBzPwAq5IgZNQaI/FL3QD7lAAG4SscBzn3EVtl3aQ5gES0PmVZm+MO
	 mfSX+Xnw3EXwOGTFYIPfPc7YV9340zwXvesz8zYhYBhLv00TnSZqVQ/ACKiSnVif+m
	 lPRVWeOwbV5jg==
Date: Sat, 7 Sep 2024 11:17:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Ztxui0j8-naLrbhV@kernel.org>
References: <>
 <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
 <172566449714.4433.8514131910352531236@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172566449714.4433.8514131910352531236@noble.neil.brown.name>

On Sat, Sep 07, 2024 at 09:14:57AM +1000, NeilBrown wrote:
> On Sat, 07 Sep 2024, Chuck Lever III wrote:
> > 
> > 
> > > On Sep 6, 2024, at 5:56 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > We could achieve the same effect without using symbol_request() (which
> > > hardly anyone uses) if we did a __module_get (or try_module_get) at the
> > > same place you are calling symbol_request(), and module_put() where you
> > > do symbol_put().
> > > 
> > > This would mean that once NFS LOCALIO had detected a path to the local
> > > server, it would hold the nfsd module until the nfs server were shutdown
> > > and the nfs client noticed.  So you wouldn't be able to unmount the nfsd
> > > module immediately after stopping all nfsd servers.
> > > 
> > > Maybe that doesn't matter.  I think it is important to be able to
> > > completely shut down the NFS server at any time.  I think it is
> > > important to be able to completely shutdown a network namespace at any
> > > time.  I am less concerned about being able to rmmod the nfsd module
> > > after all obvious users have been disabled.
> > > 
> > > So if others think that the improvements in code maintainability are
> > > worth the loss of being able to rmmod nfsd without (potentially) having
> > > to unmount all NFS filesystems, then I won't argue against it.  But I
> > > really would want it to be get/put of the module, not of some symbol.
> > 
> > The client and server are potentially in separate containers,
> > administered independently. An NFS mount should not pin either
> > the NFS server's running status, its ability to unexport a
> > shared file system, the ability for the NFS server's
> > administrator to rmmod nfsd.ko, the ability for the
> > administrator to rmmod a network device that is in use by the
> > NFS server, or the ability to destroy the NFS server's
> > namespace once NFSD has shut down.
> 
> While I mostly agree, I should point out that nfsd.ko is a global
> resource across all containers.  So if the client and server are
> administer separately, there is no certainty that the server
> administrator is at all related to the global moderator who controls
> when nfsd.ko might be unloaded.  So preventing the unload of nfsd.ko is
> quite a different class of problem to preventing the shutdown of the
> nfsd service or of the container that it runs in.

Right, and in practice LOCALIO doesn't prevent any expected NFS client
or server shutdown within containers.

Proper refcounting of required resources from host is needed, new
requirement for LOCALIO is that nfsd be properly refcounted until
consuming nfs client code exits.  But if LOCALIO client is connected
to a server, if/when that server shuts down it isn't blocked from
doing so simply because a LOCALIO client is active.

Rather than have general concern for LOCALIO doing something wrong,
we'd do well to make sure there is proper test coverage for required
shutdown sequences (completely indepent of LOCALIO, maybe that already
exists?).  I'm 99.99% sure LOCALIO will pass all of that testing
(informed by manual testing I have done with container shutdown, etc).

Mike

