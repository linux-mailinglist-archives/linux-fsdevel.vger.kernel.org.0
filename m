Return-Path: <linux-fsdevel+bounces-34632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805589C6DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB4285F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C71FF7D3;
	Wed, 13 Nov 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnAdtq3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF4193092;
	Wed, 13 Nov 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497752; cv=none; b=PhoQVPZvwIS3+aoXcHWT0ygJ0+CcQ5HFMmL/s1tIR+s0SL2IAPBc5qzNdthfqp1RRfu06cls+StroyCGROTDlTpNPzB9QtzQKY890JT1kNhlWyzzwQZU2371c8D9Czje+Je71oLwLPJ93ylCE6Z3ecfbtvrWhwiqOBT8zXEsiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497752; c=relaxed/simple;
	bh=nIRY7kDRxnRtDsAanq8DQawb4Rr2pPM6wgCV4O6OY5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kruuuRjZC9w7mCze/XyevbwDK9t3UpQ3yBynlZnut5XiulXRyKERt/8g3NVjXA+TQBOFrC3aTDp9APwIsws8c7gQmGH0ksrD2FhJFj10ZOfztL5TdlvJsR3Vowsac8lGgAVIbsqGLEbqshMWw7N90ahnziKGic8v+MpM1Wzw1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnAdtq3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65E4C4CECD;
	Wed, 13 Nov 2024 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731497752;
	bh=nIRY7kDRxnRtDsAanq8DQawb4Rr2pPM6wgCV4O6OY5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnAdtq3NFaev7YWXgags4+WlKs2uTQRAd1kMFNMs6mp7TX38oSXzpDPzBrBe8KUCA
	 BShjv4vNJa3dxcFRkxbXRv247rgUbFBndAdP5IEjWZQoPss1XlX7eDYmOX2jIQdWxB
	 Y05Tt4J8XFJ/WVlf8lLk9/M/Y8H4iplhwy0sQEyBxcEk3z4cnMn3NA8SrY3phsZ71z
	 P9fo/SrpeEV5zNSHNLSercCUihTskv7EoWO/zfuAdhmhhXLk7i4erVJWchfFPwZ71I
	 OdZE2ERx/0GO0Fchs3CNm5X6W6uGUS04x3t6H+sqSvQYQh7dW4/wruP01nSqR6PLRa
	 oIdtShh99X3ug==
Date: Wed, 13 Nov 2024 12:35:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	paul@paul-moore.com, bluca@debian.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Message-ID: <20241113-geahndet-nullpunkt-e4ebe45d4d21@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <45e2da5392c07cfc139a014fbac512bfe14113a7.camel@kernel.org>
 <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>

On Tue, Nov 12, 2024 at 11:43:13PM +0100, Erin Shepherd wrote:
> On 12/11/2024 14:57, Jeff Layton wrote:
> > On Tue, 2024-11-12 at 14:10 +0100, Christian Brauner wrote:
> > We should really just move to storing 64-bit inode numbers internally
> > on 32-bit machines. That would at least make statx() give you all 64
> > bits on 32-bit host.
> 
> I think that would be ideal from the perspective of exposing it to
> userspace.
> It does leave the question of going back from inode to pidfd unsolved
> though.I like the name_to_handle_at/open_by_handle_at approach because

Indeed it doesn't solve it because it's possible that a given struct pid
never had a pidfd created for it and thus no inode actually does exist.
So when you're decoding a pidfs file handle you need to go to a struct
pid based on some property. The pid is fine for that and it is
equivalen to how pidfd_open() works.

> it neatly solves both sides of the problem with APIs we already have and
> understand
> 
> > Hmm... I guess pid namespaces don't have a convenient 64-bit ID like
> > mount namespaces do? In that case, stashing the pid from init_ns is
> > probably the next best thing.
> 
> Not that I could identify, no; so stashing the PID seemed like the most
> pragmatic
> approach.
> 
> I'm not 100% sure it should be a documented property of the file handle
> format; I
> somewhat think that everything after the PID inode should be opaque to
> userspace
> and subject to change in the future (to the point I considered xoring it
> with a
> magic constant to make it less obvious to userspace/make it more obvious
> that its
> not to be relied upon; but that to my knowledge is not something that
> the kernel
> has done elsewhere).
> 
> - Erin
> 

