Return-Path: <linux-fsdevel+bounces-12591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA866861688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2001C24CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31E82D97;
	Fri, 23 Feb 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3WUQwDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257682D8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703799; cv=none; b=DWlPIYOWBd+dmQRZ3bKmByBiHG9nnmAGMV7rOCjXH/ydjvK+itZeJWzD3Ty/nuC7X46uQBdNcrtHT/exvKJK9MX0IPE6WiRPvRUDFs49P9bE9a+4pp2n+pyDEo2fyNDXL00RmEM6LXIopqhzY0s5L8Bg+O8VWJvOij/AETBpWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703799; c=relaxed/simple;
	bh=Zb5Lre9J+T5Akg3Xh67wnaK48wnn4CduLvjzHqurzPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQmb84sXViq7m2S7706L/Ue2R6FF0Cx9EXaXH/R3LuOXZruljGRto3V366oLI0zf/W+qzaBh4J/qkpj6kTkVio3PpHHxjSLeAvLdPbyuGj3T6Wj185DSzAaqAAy9nd559g9b6YS2Jbea64vyxEFOujaXH4iyDRTWy8jfBKLL0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3WUQwDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C44C433F1;
	Fri, 23 Feb 2024 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703799;
	bh=Zb5Lre9J+T5Akg3Xh67wnaK48wnn4CduLvjzHqurzPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3WUQwDdK8+/zA4NvdQaGv+m9WA8X0H8zk5SPE3HOwDBGoSLX2zDM9A0J9+WEywS5
	 akqVKpNPk0DUb+8j7acauZFJjyyRxAp53/RkvqVINoJnABkWhylU/pYcODMcUboy62
	 9+M/WEF4gNAEdzkVi9Qn4H2lKCKcEkmiqg/EJnv9uFS4rdrmYcEUdlb1AFKq64b7Rt
	 zCZW0ftgw45uDuN3O4DeFXVI32wm57J+ZiH5Lw8Y4QIeBZYQ+/6pxfUbCHbxVWvn0j
	 hqS/SQV/ra6Hbhi03q8hJSPvSi4skE9tSLejajGRb8Sb5qfFiqWhrvgHppN8/HU97F
	 bTSlLS37WM+1Q==
Date: Fri, 23 Feb 2024 16:56:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bill O'Donnell <bodonnel@redhat.com>, 
	Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Alexander Viro <aviro@redhat.com>, 
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240223-semmel-szenarien-cbf7b7599ac0@brauner>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <ZddvIL4cmUaLvTcK@redhat.com>
 <20240222160844.GJ6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222160844.GJ6184@frogsfrogsfrogs>

> Can we /please/ document and write (more) fstests for these things?

So fstests I've written quite extensively for at least mount_setattr(2)
and they're part of fstests/src/vfs/ and some other tests for other new
api calls.

A long time ago I got tired of writing groff (or whatever it's called),
and it's tedious semantics and the involved upstreaming process. So a
while ago I just started converting my manpages into markdown and
started updating them and if people were interested in upstreaming this
as groff then they're welcome. So:

https://github.com/brauner/man-pages-md

This also includes David's manpages which I had for a while locally but
didn't convert. So I did that now.

