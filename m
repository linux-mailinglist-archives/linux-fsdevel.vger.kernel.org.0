Return-Path: <linux-fsdevel+bounces-67116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CBEC358EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E8C4E515D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477C3126CE;
	Wed,  5 Nov 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ3Br3s1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4F191493
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344347; cv=none; b=i1Ca/L30wtECFFp9P7Maj8aAbNtIvQ8Xb273pjM7CgK3BRhZgVE9lBoC//cxhQ2JGYttmHjDbThS6Bgk9gE1bqhTiQZxYb5+vCjry5s8u49KmYP/SdK9RZUw8INuDfQLmqGN8MnbfdbriOL0DRWuwMvOXC92KGq6TPaMeypcpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344347; c=relaxed/simple;
	bh=F4z1+mLSXVITMNorvLol2nmEFJ96OyW7FAzqkgVqMjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oigYKT9Vi8QjkvYbELd6Jjxayd7ajw37L0YVitnb3ydLK0y7VeQm0Ckuo1SImSkPkyX1dbiJQsDm//3GS1R2fryIc4O5hnrE4kttjGZ4ieUnpsSUD0z8WR8Up9buonLl58tC2nmjzR2vI5KtgCP9YJY3r7XnMmZ1BHAppiRw1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ3Br3s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC797C4CEF8;
	Wed,  5 Nov 2025 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762344346;
	bh=F4z1+mLSXVITMNorvLol2nmEFJ96OyW7FAzqkgVqMjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ3Br3s1xPwRjBOaDX1WZKetz0OTGp9y+N20NTEnFFM8o/e68zgXpYvhM+LIqwvfy
	 LScYQxrmgc7yYIN+sef2Bm3sXqyagG3Xq/io07xpaljNG8Sz8jCRpSfX91FMagRDk0
	 9ctZF9Q1frYqB3vGe+g7SZkoB/8QdPqr2zbEsGw8vlHKf8lVAgMtEL5bslsMuEIXti
	 4xH4ru1XeG0Cc3jzyOKksToSKRgLLc7i89UBmQlZgYh9MoIpu+FWL2WUEgAw2y9/+p
	 JRLH0FWow4WBAKuKVlgmVa8RYYeiZYxH1gRNPz/HdcXseEWbFbLZjsvz1wPoxc7NwU
	 /CWyL4GcSgg6Q==
Date: Wed, 5 Nov 2025 13:05:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Snaipe <me@snai.pe>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
Message-ID: <20251105-rotwild-wartung-e0c391fe559a@brauner>
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>

On Sat, Nov 01, 2025 at 12:01:38AM +0100, Snaipe wrote:
> Hi folks,
> 
> (Disclaimer: I'm not a kernel developer)
> 
> I'm currently playing around with the new mount API, on Linux 6.17.6.
> One of the things I'm trying to do is to write a program that unshares
> its mount namespace and receives a directory file descriptor via an
> unix socket from another program that exists in a different mount
> namespace. The intent is to have a program that has access to data on
> a filesystem that is not normally accessible to other unprivileged
> programs, and have that program give access to select directories by
> opening them with O_PATH and sending the fds over a unix socket.
> 
> One snag I'm currently hitting is that once I call open_tree(fd, "",
> OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE), the syscall returns
> EINVAL; I've bpftraced it back to __do_loopback's may_copy_tree check
> and it looks like it's impossible to do on dentries whose mount
> namespace is different that the current task's mount namespace.
> 
> I'm trying to understand the reasons this was put in place, and what
> it would take to enable the kind of use-case that I have. Would there
> be a security risk to relax this condition with some kind of open_tree
> flag?

In principle it's doable just like I made statmount() and listmount()
allow you to operate across mount namespaces.

If we do this I don't think we need a new flag as in your new example.
We just need open_tree() to support being called on foreign mounts
provided the caller is privileged over the target mount namespace and it
needs a consistent permission model and loads of tests. So no flags
needed imho.

I can start looking into this next week or you can give it your own
shot.

