Return-Path: <linux-fsdevel+bounces-47234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628FBA9AD9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC846623E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A627B51E;
	Thu, 24 Apr 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="p5qk0CPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE127B4FA;
	Thu, 24 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498230; cv=none; b=NcjDoAdUOMD5RnhxQ47rlcMspjLDd6W+qm/NClnD1cVsicp/PPGQh1Wgojb8KnkVeNf298JiaHTEDkgt7yXci1/+lc9gkK9Zufn2YYa3bSvKOEjWe83Y3f9bKTs8j2gqJV659zo/4u0UFIBpja9wznQG/H5lj1n77GaqY/X9rkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498230; c=relaxed/simple;
	bh=M0gXjg0Mf9oOEmGvSXQbm2PRlU0T7fp8N9mOwhwZ6ks=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=ml0/nIM/33DxowNX4oX3CpjyjZ6Dyt6x6hK+agj4O2bg9RGKcBtZiBwk85RdWgHnkdLuUSMpoOf0fhDlOULu+ePquP8sY9e8zTRTEwZysB1yLQuAXvqqnPtNz7elfZMxYd3IG8Ksb7N1al22x0UbMYFARSEaxHHaShJwsyacp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=p5qk0CPZ; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <34ef8a415064c6a1766ba33ff99507d1@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745498226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/ErA4QgDTmHQmhuG+X33CEGt2iKdzKvGsmEP4+VIhg=;
	b=p5qk0CPZ+xJ6ALgVMBglGOC7snxn69qZpUmJxN+MTYwu8rYK46xBcHiOAz2m7WKLjK3RZ6
	FnhJ6klNA+yc1LvxEp5MPqVsvX0gREDAsbYGx/BuzxZo9YsnRzKBNOTHgASCV3TKvRbR/m
	uVgvbiaChmlC0yHQWdUqFiXtMyl31dF/mIgjRXr2yz5PKUY0xbDWwAx90nw6/aQBm7CRHJ
	PJbO9+63EmGfRL5GeAEWBT9LNIKGnDtsbD//Z9NXUL6Nhbtv2XdMoTpBARHJH0D6L45RqB
	NboXL/h3vhmC4Y0V1SNNJAEF3aFfnXVdS74kS1U2/a5KiVbJIMKgHin8ogQ+ZA==
From: Paulo Alcantara <pc@manguebit.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, David Howells
 <dhowells@redhat.com>, linux-nfs@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-cifs@vger.kernel.org
Subject: Re: [RFC][PATCH] saner calling conventions for ->d_automount()
In-Reply-To: <20250424060845.GG2023217@ZenIV>
References: <20250424060845.GG2023217@ZenIV>
Date: Thu, 24 Apr 2025 09:37:01 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> Currently the calling conventions for ->d_automount() instances have
> an odd wart - returned new mount to be attached is expected to have
> refcount 2.
>
> That kludge is intended to make sure that mark_mounts_for_expiry() called
> before we get around to attaching that new mount to the tree won't decide
> to take it out.  finish_automount() drops the extra reference after it's
> done with attaching mount to the tree - or drops the reference twice in
> case of error.  ->d_automount() instances have rather counterintuitive
> boilerplate in them.
>
> There's a much simpler approach: have mark_mounts_for_expiry() skip the
> mounts that are yet to be mounted.  And to hell with grabbing/dropping
> those extra references.  Makes for simpler correctness analysis, at that...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

