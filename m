Return-Path: <linux-fsdevel+bounces-44843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974FEA6D10E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99697A622B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20611991DB;
	Sun, 23 Mar 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGYObbt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B83B1A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762190; cv=none; b=Cl0sBBvqFP0Am9605Py/Shi+7hwJz0W16o85RdawoYhdseHTLz4QWhtGeW3SZxGChzhHeC6LYLFBEfwBudN8n1qrnhvDctNW1gl9m8Ptha7a/ia/+GZ7NrIjU75FcN4UuI7NRyroa1OiNDcrO8TCb1nr/v+0VzyoKNdrW5rDhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762190; c=relaxed/simple;
	bh=oFgSnUTYfYFx1rgFexHJ2OQhkx6E1nggXcYzj5QK6QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz67/B/quCSpj5x4scKtLWrTv5JtnAdDxQcuq6Eb+//JR1UUbJypk5BRB6WWVMWkEbaKTFtqucU7t7RuyCE9MbhGVPoPs9ZCe9BVI5EBHAslcVNkzPoXpt7DbUan0hKZ5RXIcg4PA7qwFxbGU2vLZMYXBypnso31ee0u7KOhz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGYObbt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D606C4CEE2;
	Sun, 23 Mar 2025 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762189;
	bh=oFgSnUTYfYFx1rgFexHJ2OQhkx6E1nggXcYzj5QK6QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGYObbt1y0ntmk9D6AoMPiEB8XbNbGrSory5GNjkJpXNO5QGpPT3Jgb0KwghgwUq1
	 akAPfN/lAnJfiLz7DqZXSthGx+1tP231GUTqgihqKlOh6iAS/toyN4vVJzQmUXz97A
	 ELDTAYaYu05BxqR+japmslKdI5JWvzooVwpnLxEicnPD8wTmXuDFJUuiEIs9Ll/tD6
	 HCmnfXZHaBPXKYWmQgrNm6nKPLFUEI77Qq8tPXNsjGXGQr/mH3H8srhLli8NpcVroG
	 QtVN8084T814cpvyFpM6E5mZJsYHPPb8iE3sI5qUIGAlXC9hfrJ4OuIuBwMpBPI/xS
	 M+qSYDZC2M+/w==
Date: Sun, 23 Mar 2025 21:36:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: selftests/pidfd: (Was: [PATCH] pidfs: cleanup the usage of
 do_notify_pidfd())
Message-ID: <20250323-mixen-neidvoll-4f8f8fe7cc94@brauner>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250323171955.GA834@redhat.com>
 <20250323174518.GB834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250323174518.GB834@redhat.com>

On Sun, Mar 23, 2025 at 06:45:18PM +0100, Oleg Nesterov wrote:
> Christian,
> 
> I had to spend some (a lot;) time to understand why pidfd_info_test
> (and more) fails with my patch under qemu on my machine ;) Until I
> applied the patch below.
> 
> I think it is a bad idea to do the things like
> 
> 	#ifndef __NR_clone3
> 	#define __NR_clone3 -1
> 	#endif
> 
> because this can hide a problem. My working laptop runs Fedora-23 which
> doesn't have __NR_clone3/etc in /usr/include/. So "make" happily succeeds,
> but everything fails and it is not clear why.

Yeah, I agree. You want to send your small patch as a quick fix?

