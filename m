Return-Path: <linux-fsdevel+bounces-71552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42DCC742F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8169530577C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEA358D1A;
	Wed, 17 Dec 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UowOc4vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB53570CD;
	Wed, 17 Dec 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968500; cv=none; b=SCRhOpM9u9PJLU7Y+t4gMJuYhqNZFdBifkwma7TW+pvO0o9d8hXtZPTkvTPnwt0QzwFPHjzKOwxkCJvGL5IPcUMmqLAkCLEjHmn844Yv/+c1vvRKt1xStfTIqEIjgvbzPAcg+PHNrc5kQz2IleDa96lKobjRnynddvR42AGH7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968500; c=relaxed/simple;
	bh=xsI7FG2YpMIMSHTidbcQ1rlJbuaFmCD3fGWi/3oN45E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEP+XzNIktwIHpuYJHagOolVhCEfj9CtgnyW1j1VlETfgbquKzRBt5WKp9mKZfszx4HBpBwY0xsChYIUfelootw9zWUK+zvJHl4npsp+kFklvZk75Cu9w++LhF3zwJcV7NoSQR41IzuGWJ5os1QtTDm+qOgPKy2+YQc5WlHe6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UowOc4vc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CERaoBE62t++V6cm2Dxl/HcxEc0L4uLTptUFCgYnIpw=; b=UowOc4vcUpBJyjpGsHw6LSWUTv
	xahF1nA8rrqiwoCaE3OGePYg6Esr8GO58B53W2mcfrJvc/Bz9LhE1mnyuWNjvQjGptFefakIvIgLa
	8Vm1assJ6xFBnoIEF3SYfxX6b9weHMHMbqboAeX4+aknlPmDCKuzAIk8Vg4cTwg0oumj3RoPfCTYN
	Vtd+QmDyW8nOnjNXqk0XsfkaCfBLIhrGFwWHJXaHZK3zhKT9clVhjOzf+Z134OUko/Ru9436KeAxw
	cPXqJ52ybiO2VAzAe+y/uutzOZhHVAstPzOlhkYjh2yn81L5ZUaFwj5V+/7VJWQdzILXRhh3XxX3S
	JVhKAKvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVp5S-0000000F0ZZ-1wUu;
	Wed, 17 Dec 2025 10:48:54 +0000
Date: Wed, 17 Dec 2025 10:48:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
Message-ID: <20251217104854.GU1712166@ZenIV>
References: <20251217084704.2323682-1-mjguzik@gmail.com>
 <20251217090833.GS1712166@ZenIV>
 <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com>
 <20251217100605.GT1712166@ZenIV>
 <CAGudoHFLV5sHE1UBXR5BtPHUghnroA=m59D6yBknWnZz0mkS7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFLV5sHE1UBXR5BtPHUghnroA=m59D6yBknWnZz0mkS7A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 17, 2025 at 11:13:22AM +0100, Mateusz Guzik wrote:

> I'm not arguing for drop_links() to change behavior, but for it to be
> renamed to something which indicates there is still potential
> symlink-related clean up to do.
> 
> As an outsider, a routine named drop_${whatever} normally suggests the
> ${whatever} is fully taken care of after the call, which is not the
> case here.

*shrug*

drop_link_bodies()?  Seriously, though - the real source of headache
had been a decision (mine, IIRC) to stash LOOKUP_CACHED logics into
legitimize_links() rather than having it done in both of its callers
(try_to_unlazy() and try_to_unlazy_next()).

It could be lifted into both callers instead, but we'd need to
	* remember that it should come *before* any references get
grabbed (and there would be a constant itch to move it down -
it would even work, and past legitimize_links() we wouldn't need
drop_links(), but it would make the thing potentially do seriously
blocking IO, contrary to LOOKUP_CACHED intent)
	* remember to keep drop_links()/resetting ->depth if done
before legitimize_links().
	* keep these two in sync.

If you have a cleaner solution for that, I'm all ears.  Really.
I'm not happy with details of that area (lazy to nonlazy transitions),
but so far I hadn't been able to make it more obviously correct.
And I'd looked at your original patches and missed that fun ;-/

