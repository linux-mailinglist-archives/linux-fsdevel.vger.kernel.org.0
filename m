Return-Path: <linux-fsdevel+bounces-32620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036989AB863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 23:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46E7284AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610F1CCEE9;
	Tue, 22 Oct 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfgoC1Qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC201130AF6;
	Tue, 22 Oct 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632061; cv=none; b=TLGfoxj5LssVL+YRiTnHpZsDH2AsK2VN3RBkgj7eTseyWLdw5H7Rse9mLgJ1TQDmW3L8cOENLkIkIvBamuDdHg+/DITjorZFYPq+gODYx6zyebfIwLfXF76GsBu3vwBuw45Z7RalxIoRt4zwXwZEx1AjhLu9/VDvHM/kUM4BwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632061; c=relaxed/simple;
	bh=sDikwQmGWUyknPMu+lvLDRBfL1SGRChaQOsYt5oIGIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMqpzNxpmnUZFMGzUL8QbF7DyKgqg0oNNUuls6Y/5CXDRsKPDvXDT23R9ZarUTof/aWx2mT3ZC4MYaw2eHE4RwcXKi5gf5dMyJBwtnRaNXDxG3QEKFVvxJjcRPu2by0DI79YGyfMN2rNoJukns70xC9N8x4vbwbilWvZtdBfVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfgoC1Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F39C4CEC3;
	Tue, 22 Oct 2024 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632061;
	bh=sDikwQmGWUyknPMu+lvLDRBfL1SGRChaQOsYt5oIGIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfgoC1QxZjUODPaeHBpz4Liy2tZU54LYmEt+HNIZprye0HXqWHLQZzq4oJ7QK8WY9
	 SGA4v2PYYXgAFa6tNeYpnWRkuPvAHAp+XRnkWfxQwnmWkws4qwdkX1f34GSz+gwzhb
	 CSQRLQ/6GEl4GI6dA3L/fz8qSyw0hqq9F1LiOXNTk7V+FiGGPlTx93+IW6fkLgzbEs
	 y1ADO3QrZnZJ3F+bE4B3ZaGZEMr3TAyDcy3tclxTupKIdk7kVv8mw4b04LDzhN/3ZJ
	 wZ7hjsAu5vAKFOoQNU3FYmX2EoHtajpxJOu/P8oqzdtzKO6NZ6S1WUN7tODG4zklX3
	 BgIdRa7XEN81g==
Date: Tue, 22 Oct 2024 17:20:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, hch@infradead.org,
	broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <ZxgXO_uhxhZYtuRZ@sashalap>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <20241022204931.GL21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241022204931.GL21836@frogsfrogsfrogs>

On Tue, Oct 22, 2024 at 01:49:31PM -0700, Darrick J. Wong wrote:
>On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
>> other information that would be useful?
>
>As a maintainer I probably would've found this to be annoying, but with
>all my other outside observer / participant hats on, I think it's very
>good to have a bot to expose maintainers not following the process.

This was my thinking too. Maybe it makes sense for the bot to shut up if
things look good (i.e. >N days in stable, everything on the mailing
list). Or maybe just a simple "LGTM" or a "Reviewed-by:..."?

>> Commits that weren't found on lore.kernel.org/all:
>> --------------------
>> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
>> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
>> bc6d2d10418e1 bcachefs: fsck: Improve hash_check_key()
>> dc96656b20eb6 bcachefs: bch2_hash_set_or_get_in_snapshot()
>> 15a3836c8ed7b bcachefs: Repair mismatches in inode hash seed, type
>> d8e879377ffb3 bcachefs: Add hash seed, type to inode_to_text()
>> 78cf0ae636a55 bcachefs: INODE_STR_HASH() for bch_inode_unpacked
>> b96f8cd3870a1 bcachefs: Run in-kernel offline fsck without ratelimit errors
>> 4007bbb203a0c bcachefS: ec: fix data type on stripe deletion
>
>Especially since there were already two whole roarings about this!
>This was a very good demonstration!
>
>PS: Would you be willing to share the part that searches lore?  There's
>a few other git.kernel.org repos that might be interesting.

It's all at https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/

In particular, the query-lore.sh script.

-- 
Thanks,
Sasha

