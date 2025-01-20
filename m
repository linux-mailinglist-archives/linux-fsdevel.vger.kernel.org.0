Return-Path: <linux-fsdevel+bounces-39710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5275A17214
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ACE1881DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4D1EE00E;
	Mon, 20 Jan 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny6WkUK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274F182BC;
	Mon, 20 Jan 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394780; cv=none; b=P/m6S1QVp7ZpU0Le4KiMW4gnns8UIWtuUhnbPLeCB02XB3XaK9kPQVlhIQNPNLChUyPd6ox9k82La2RUMJqojtDEPLfl9ax7cJ1ha3I9QVZx+Zk5/2y/9+oCDqFtiGM8xqZlJKM6BQZ7IPaFCRbXSVzRw7p0LA8oYcY9QCz9Cn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394780; c=relaxed/simple;
	bh=zNUIW78iXDkYXYeQ7bq+fzMGNLWpN2FbRWbUmFizJPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHc043saZFIm0aUBaiLtdHIkud840wQ4XQpLR4BpJsrJt/UvQ5yMrw6cGbdQonPpUpEYOlyNz+tm8N1QDuFsyLC5kLYIVPjomuL8ddl9KeaD9kmmAxPhLNnx22O5/Zuj12zmS+5rMffPj/bs56mHlUBkN09BxEuhPnLvmcDnGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny6WkUK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F1C4CEDD;
	Mon, 20 Jan 2025 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737394780;
	bh=zNUIW78iXDkYXYeQ7bq+fzMGNLWpN2FbRWbUmFizJPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ny6WkUK9ZpIW351bMwjChu78ws2lNbcTPbNhJUlCnbU6eWZ+687k9ZG3VU0s6oR57
	 u/871HTl/DSdm0KhmtjWQzibIrPExDzjUlvlDI7kqqIrCoi2D9eA5Gx0UIdp/ySLYM
	 KxyAKFDi+WyysG+29lpuO7KeIgfM153bzx0RbvAbiKEGuen70NtE9PuqnsEpw26KBL
	 ixnSbz3b3rPUNZIR3a5RAaf2q6w1mLvl43gNAi4c0UEfA+5fMOourJG75ACOGhDd+X
	 R4nraXHlskBzNh29/RuYxKeiiTbkLgsGgtpyOxwYdOAW2kH2J6zng1fJpmS0uKZ8od
	 kULyOvONiDUGg==
Date: Mon, 20 Jan 2025 09:39:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250120173937.GA2268@sol.localdomain>
References: <20250120135754.GX6206@kernel.org>
 <20250117183538.881618-1-dhowells@redhat.com>
 <20250117183538.881618-4-dhowells@redhat.com>
 <1201143.1737383111@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1201143.1737383111@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 02:25:11PM +0000, David Howells wrote:
> 
> I wonder if the testmgr driver tests running the algorithms asynchronously...
> 

Multiple requests in parallel, I think you mean?  No, it doesn't, but it should.

- Eric

