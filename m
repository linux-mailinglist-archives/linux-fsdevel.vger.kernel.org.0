Return-Path: <linux-fsdevel+bounces-20521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED08B8D4C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184541C21F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F017C9FF;
	Thu, 30 May 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ANu7/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEB17C9E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073873; cv=none; b=hQ4gTLQdmbo16Ls9AfLuOkfeO+HtbSEJxVEEVAo/5Iek6ok8XdpPhDowsxo+xTjinuMFBfds/HbHuaJwOvU3Q5TAb/tFmNtFwSI0bWrNd6iANFmZ3KkKIhJFqWmvoKuLW9nRh5Aa54/8Brktot2Yc/hpsW14pMa79aGhz3EGPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073873; c=relaxed/simple;
	bh=y4LnIMwTKQkiRQvQMzlPe8AFdOE12U8Oe/cRqUTdApo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9QjxEO/t+6UrPFRK+GmNOG2I6xekp1nDnfwlDc+pq/fbJScB+2w7SqJMwwAf4FbK2qcwIWcqoXwLWnOudpfuRAy9+FrYkX99B8sqipJS/4nKgYh9YCfEV0w+rhl+NT7AstlkZGo5ruA/BkN+vh8d5D1C4X/+O8UPebQtgeYlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8ANu7/d; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d1d3c7f7c6so421761b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717073871; x=1717678671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vq0zHl2BOaGAawQMyRpMgWGnmO5PQZnGKgfeJvWwkc=;
        b=g8ANu7/dD99KnUT4HNEZRTHgxorUT+vTx6cl8DaXIfbY+uUmBXS4MhlN1a0ZlhtT5o
         tfftM8Txl7Vm7FfxV0XMhpWDQ9H/hvYOKWUQI+wa0EjSnEl7khwtbjjp+VDvKVBzCwSR
         R4KBAvrpeQUWs5ON8H/BdJTMaU74w62sGHmmx9DjWRusMG+eRshWfVsZmLGQT9Ci7wWG
         OpMmt3inlhXKJmclDFnXOwPREkqxhgrrx3GGJneSZRf7A/9Bn8xSrkZgrDpD+tF0XmW9
         juJWZ2QvTpUFEQYE7mu3owF5O56KlZ7QwVbB0s+/8Kh6t0bfTjtc3QtMg2AnwwoEZNz0
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717073871; x=1717678671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vq0zHl2BOaGAawQMyRpMgWGnmO5PQZnGKgfeJvWwkc=;
        b=iFUrlqdLqIlm2xEXz0JPo4Fds8Hnr5+/OuRtVxN7MF6EQVhdBnPDXStWhBdJlc7uRD
         Qfx6kDaHS0eyl+WfAu9iEGD1thTRY+EF+O061H/4FD7TMZR1zEqyKyY2rUuKwPmnX4x3
         O7cpcjxqZIH8hulyD4ujDrO2KG5biWnVh/S8RXr2cH0l3hvsc6D5nKQESh731sHnQmFe
         LfjoGhh5tzBMh7roaW1UqIvNF3M9bvq1ex8mf3NFK9isfYD/xYxvRRuU41crQ/fa42id
         0M5+D9riIgoLqmfeoBzR2OTCrGRzytWrKhhhEAYEGtd0LDO1spu3YgM8uihZ9GZQ0gXs
         mKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/8ZViOyIbbtR/px7C5bAbd9HBTqvs5IT8PIyUAaJJWpb0EVVTrJz7zRzFl8PrATF8jEhDnf8uuu6Q3WPVTyplFwRVQU6ZPvUzcHSBw==
X-Gm-Message-State: AOJu0YwP2B+K23rTfX7N4/mERcTXW8+1pd+n3gLTDTKEXGzUL9fKMGdc
	Dyd536UFyMh0aDeTEx8rI0MlRK5V1bTc14MwD0VQpBCCjbysDGAKCZhkpUXfx7lbjq6WgMBWf3b
	RkKWAebulR2fPGyfdEd6FqNNns5k=
X-Google-Smtp-Source: AGHT+IEc9EqAtbWuWYKXj4kERlYEsNljzEAK+U/pWxBs4JGZ/mpMH8QFggnqQbOfvnr4e9RCkpEXiZFaXF3fBEcWQAI=
X-Received: by 2002:aca:d0f:0:b0:3c8:2ce9:da35 with SMTP id
 5614622812f47-3d1dcc9c1c8mr2370247b6e.6.1717073870885; Thu, 30 May 2024
 05:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
In-Reply-To: <20240530-atheismus-festland-c11c1d3b7671@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 May 2024 15:57:39 +0300
Message-ID: <CAOQ4uxhQTUW7NuGGDWf=NCPe5mxofkYAj0Av5Kga7q3eOW-p5w@mail.gmail.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, May 29, 2024 at 04:41:32PM -0400, Josef Bacik wrote:
> > NOTE:
> > This is compile tested only.  It's also based on an out of tree feature=
 branch
> > from Amir that I'm extending to add page fault content events to allow =
us to
> > have on-demand binary loading at exec time.  If you need more context p=
lease let
> > me know, I'll push my current branch somewhere and wire up how I plan t=
o use
> > this patch so you can see it in better context, but hopefully I've desc=
ribed
> > what I'm trying to accomplish enough that this leads to useful discussi=
on.
> >
> >
> > Currently we have ->i_writecount to control write access to an inode.
> > Callers may deny write access by calling deny_write_access(), which wil=
l
> > cause ->i_writecount to go negative, and allow_write_access() to push i=
t
> > back up to 0.
> >
> > This is used in a few ways, the biggest user being exec.  Historically
> > we've blocked write access to files that are opened for executing.
> > fsverity is the other notable user.
> >
> > With the upcoming fanotify feature that allows for on-demand population
> > of files, this blanket policy of denying writes to files opened for
> > executing creates a problem.  We have to issue events right before
> > denying access, and the entire file must be populated before we can
> > continue with the exec.
> >
> > This creates a problem for users who have large binaries they want to
> > populate on demand.  Inside of Meta we often have multi-gigabyte
> > binaries, even on the order of tens of gigabytes.  Pre-loading these
> > large files is costly, especially when large portions of the binary may
> > never be read (think debuginfo).
> >
> > In order to facilitate on-demand loading of binaries we need to have a
> > way to punch a hole in this exec related write denial.
>
> Hm. I suggest we try to tackle this in a completely different way. Maybe
> I mentioned it during LSFMM but instead of doing this dance we should
> try and remove the deny_write_access() mechanisms for exec completely.
>
> Back in 2021 we removed the remaining VM_DENYWRITE bits but left in
> deny_write_access() for exec. Back then I had thought that this was a
> bit risky for not too much gain. But looking at this code here I think
> we now have an even stronger reason to try and get rid of this
> restriction. And I've since changed my mind. See my notes on the
> _completely untested_ RFC patch I appended.
>

This looks much simpler :)

Obviously, a proper patch would need to also turn get_write_access()
to void and clean up the error handling code of its callers.

> Ofc depends on whether Linus still agrees that removing this might be
> something we could try.
>

Crossing my fingers that this will be acceptable.

Thanks,
Amir.

