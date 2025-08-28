Return-Path: <linux-fsdevel+bounces-59461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85050B390E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 03:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B79C7A5778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 01:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF91E376C;
	Thu, 28 Aug 2025 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wTa+YOgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B163101DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343732; cv=none; b=re7b4MyLgcnqSspyb3vDlfsMs5/3WMcnNTkU9Xo3IJI/Z6bBqsts/ye8R0EaHiQf02gTYHCUdvPuGFLJyNYBKl1ZPoi28gUPYztTJGNtt6rnADhLdcgJuNuvAcZCqzabiS+hhEDB7m5Dh7KiRlN9J1fWMsen08y+dvGbvxyblFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343732; c=relaxed/simple;
	bh=xS7OOztXJpxWZxmfd1xB+VFa4w37jkM8MttIS9H9wPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXb1wl71SmL76546MaJD08Mst3wkGRY+HoGipVcfacbAeqrdZPF98g6OuGs5bUFViZ3PLzkB2ZxbHSCjtAz7zdc54F2jptplTw5HVfhpjRDFXeWO2SqjI9O3l9TQ/tGX/XkilqMHycj5h+wFDtCUxLYbMDhpKMkfy5JelaPiy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wTa+YOgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD230C4CEF5;
	Thu, 28 Aug 2025 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756343731;
	bh=xS7OOztXJpxWZxmfd1xB+VFa4w37jkM8MttIS9H9wPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wTa+YOgZLfQBJ9imo9rPzFg6ZLn35wogLPJ5SCS0T5nkM2jO1Z9EOMK+neELiAKDe
	 0ACjadwo9YQJQooFPO6vEND3rI40qXkvq2Onk5a8pvDmaS2qCVScjnzCS3RT5udcCT
	 D8RVE+EiTZpTAvi0IcfL9JWEdePJv8E2BWv/F4uo=
Date: Wed, 27 Aug 2025 21:15:26 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250827-gecko-of-satisfying-lightning-be96af@lemur>
References: <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur>
 <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
 <20250827-sandy-dog-of-perspective-54c2ce@lemur>
 <20250828010017.GZ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828010017.GZ39973@ZenIV>

On Thu, Aug 28, 2025 at 02:00:17AM +0100, Al Viro wrote:
> > I'm not sure what you mean. The Link: trailer is added when the maintainer
> > pulls in the series into their tree. It's not put there by the submitter. The
> > maintainer marks a reliable mapping of "this commit came from this thread" and
> > we the use this info for multiple purposes:
> 
> You are overloading the terms here - "pull" as in (basically) git am and "pull"
> as in git pull and its ilk...
> 
> And I still don't understand how is that supposed to apply when patches are
> _developed_ in git branches.  In situation when submitter == maintainer.

Then there's no external provenance, so there is no need for this kind of
mapping. You will submit your changes as a pull request and you'll get
notified when it's merged (via the PR tracker bot).

There is a hybrid workflow as well:

- maintainer develops a patch series
- maintainer sends it to the list for review
- maintainer pulls in the trailers

In that case, we don't automatically put provenance trailers into patches, but
you can still achieve the same result if instead of merging your local branch
you merge the series from the list, but this is more of a corner case
scenario.

-K

