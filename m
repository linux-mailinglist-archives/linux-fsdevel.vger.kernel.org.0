Return-Path: <linux-fsdevel+bounces-60397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80991B46665
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 00:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9A1AC5E4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147AC2F60AD;
	Fri,  5 Sep 2025 22:00:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FE2F49E2;
	Fri,  5 Sep 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109647; cv=none; b=fgn93fow2W8bWwR5KE/RY9UMaF0mguYvf9uTVPwus+42cMAclJekq6AESeBfOywv0X5U8TxDn15cBIa4/fq+PEylIETBtAdhO4xHkn1CFORs8q9by7fysSz+5PkkiYwbkET1fXZjbo8lUWr0gMLb1r4uXho1gTz0Jtaio7UHW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109647; c=relaxed/simple;
	bh=j/pA2fzHA0vQpVSS+7LQLgV8sgM69iIKB3Wgf2YP/is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXBI8SXMGrHKrSAwiCzgpSLXpFx4VKstLIPDp+0cHN8tljGzGbPZ/gckzZuRBaH0gIMynJ5QBylTJsAxpRrmAfeOPtXFMb29XRcAMyUZ334tZquNS/ZoVEDEk8Tt1uVE4TvnZNMJHaKhO/2A1Jtjx+aCYV+vMbsbtU1xDzNEbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id DFDA9409CE;
	Sat,  6 Sep 2025 00:00:43 +0200 (CEST)
Date: Sat, 6 Sep 2025 00:00:42 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com
Subject: Re: [RFC PATCH 18/20] ceph: add comments to metadata structures in
 string_table.h
Message-ID: <aLtdivQ9_BuZF3wM@swift.blarg.de>
References: <20250905200108.151563-1-slava@dubeyko.com>
 <20250905200108.151563-19-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905200108.151563-19-slava@dubeyko.com>

On 2025/09/05 22:01, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> +/*
> + * Reference-counted string metadata: Interned string with automatic memory
> + * management and deduplication. Uses red-black tree for efficient lookup and
> + * RCU for safe concurrent access. Strings are immutable and shared across
> + * multiple users to reduce memory usage.
> + */

No, it doesn't use rbtree AND rcu.  It uses rbtree OR rcu - it's a
union, it cannot use both.  But when does it use one or the other?
That would have been helpful to know.

>  struct ceph_string {
> +	/* Reference counting for automatic cleanup */
>  	struct kref kref;

In the other patch, you wrote that reference counting is "for safe
shared access", and now it's "for automatic cleanup".  But it's really
neither.  Reference counters do not do automatic cleanup.  They are a
tool to be able to detect when the last reference is dropped.  And
then you can do the cleanup.  But that is not automatic.  You have to
implement it manually for eac use of struct kref.

This comment is confusing and adds no value.

>  	union {
> +		/* Red-black tree node for string table lookup */
>  		struct rb_node node;
> +		/* RCU head for safe deferred cleanup */
>  		struct rcu_head rcu;

These two comments add no value, they don't explain anything that
isn't already obvious from looking at the struct types.  Explaining
that "rb_node" is a "Red-black tree node" is just noise that doesn't
belong here; if anything, it belongs to the rbtree_node documentation.
Repeating such text everywhere has a negative impact on people's time.

>  	};
> +	/* Length of the string in bytes */
>  	size_t len;
> +	/* Variable-length string data (NUL-terminated) */
>  	char str[];

The "[]" and the "NUL-terminated" and the "len" field already imply
that it's variable-length.  Writing this again is just noise.

