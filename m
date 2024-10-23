Return-Path: <linux-fsdevel+bounces-32649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9E9AC818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56D3284AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55881A0BF1;
	Wed, 23 Oct 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X1QTC3h4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38483136331;
	Wed, 23 Oct 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680187; cv=none; b=avCyFtdMBzfhjT+GD9fqRWbkHOt4lS73xPGrXw92wqA9s+I7UtkdqP1Gm1NiQT/hfmF3ql/Tat/OqtkAxWlr5PFcEIbRleG8EyJ3U5N+onNWRsVZcagbPmm3byy/dYBd4fiMQMIr+wp+aT7rCQKc8bVNAQetQaZYuje7aqryaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680187; c=relaxed/simple;
	bh=d6NEfppfDlfC61zIqpllXBJMb1Ukgbu81UT9i6+T9Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSJFy96GpDbq9l+32m0rspOVvgo9cP0AdNfaRMaYRNQJj3EBGL8A0dX6u4x07zoho8hEn80judeKXyTCw+Z7CEZQzmXNJwVMlhQLmFni4T1kKEpy1FJ2JsgUrzTtuexU/bgBZWSqMZAJXKyS2oV7JhNLDn1vvdjdaeyPt9KHynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=X1QTC3h4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729680180;
	bh=d6NEfppfDlfC61zIqpllXBJMb1Ukgbu81UT9i6+T9Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X1QTC3h4hqMN6S8z2D7EYOljvNpYiovXWFf82Yi9sAAl7sBRU60Hle/zrmYVOxz8w
	 3eXCjinuYr7NkCcukIDJ3sEHVKueDku3Nm+lNbbt5YMDoZ6aL5o5/fs818moDrA5xB
	 qPK3q0t5evDeCN3lqGUQJMV5PvgQ4A2U4RTz4Axm+ebRsflC8ajkCfrh3jSm3ltvP4
	 Ud3vIEFoFvQCmRUyYRjLvCMxx7ytjofAIZRaUfUhpk/0ocp/7O46XXfgPenI0MlPUG
	 BKXtd3gzH5L1WmqpWFRxs05cFl0XyF+/tdEMCZD7T8no1J8un6kXmMe60oHW0rFfyp
	 MP5b14Watz/0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYQcN0vFlz4w2K;
	Wed, 23 Oct 2024 21:43:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sasha Levin <sashal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, hch@infradead.org, broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
In-Reply-To: <ZxgXO_uhxhZYtuRZ@sashalap>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap> <20241022204931.GL21836@frogsfrogsfrogs>
 <ZxgXO_uhxhZYtuRZ@sashalap>
Date: Wed, 23 Oct 2024 21:42:59 +1100
Message-ID: <87iktj2j7w.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sasha,

This is awesome.

Sasha Levin <sashal@kernel.org> writes:
> On Tue, Oct 22, 2024 at 01:49:31PM -0700, Darrick J. Wong wrote:
>>On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
>>> other information that would be useful?
>>
>>As a maintainer I probably would've found this to be annoying, but with
>>all my other outside observer / participant hats on, I think it's very
>>good to have a bot to expose maintainers not following the process.
>
> This was my thinking too. Maybe it makes sense for the bot to shut up if
> things look good (i.e. >N days in stable, everything on the mailing
> list). Or maybe just a simple "LGTM" or a "Reviewed-by:..."?

I think it has to reply with something, otherwise folks will wonder if
the bot has broken or missed their pull request.

But if all commits were in in linux-next and posted to a list, then the
only content is the "Days in linux-next" histogram, which is not that long
and is useful information IMHO.

It would be nice if you could trim the tail of the histogram below the
last populated row, that would make it more concise.

For fixes pulls it is sometimes legitimate for commits not to have been
in linux-next. But I think it's still good for the bot to highlight
those, ideally fixes that miss linux-next are either very urgent or
minor.

>>> Commits that weren't found on lore.kernel.org/all:
>>> --------------------
>>> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
>>> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
>>> bc6d2d10418e1 bcachefs: fsck: Improve hash_check_key()
>>> dc96656b20eb6 bcachefs: bch2_hash_set_or_get_in_snapshot()
>>> 15a3836c8ed7b bcachefs: Repair mismatches in inode hash seed, type
>>> d8e879377ffb3 bcachefs: Add hash seed, type to inode_to_text()
>>> 78cf0ae636a55 bcachefs: INODE_STR_HASH() for bch_inode_unpacked
>>> b96f8cd3870a1 bcachefs: Run in-kernel offline fsck without ratelimit errors
>>> 4007bbb203a0c bcachefS: ec: fix data type on stripe deletion

Are you searching by message id, or subject? I sometimes edit subjects
when applying patches, so a subject search could miss some.

cheers

