Return-Path: <linux-fsdevel+bounces-59446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B99B38EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E890366BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAD630C370;
	Wed, 27 Aug 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBjpwJv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92D30FC05
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334984; cv=none; b=jK/JRQhFWe8pDXZF5EP5GNobF3vP0+m8H4gipKwx4gfZky6vSf37P7mwlmLtlvIIZAsnAmjB2gofCzJPJCdLCXWxhZCGdJYOEgnrVPgmq1KsWqBn+s1699XCU7q7VC/yMooMx/vSVWtMZ12QNqjtWsIJFX9Yb7pigPnq8V8IR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334984; c=relaxed/simple;
	bh=g6y6sbsOTvrERxODvCs31LXuAYdUnhdSkyL20Ov/pHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYh12L76IVz6tu603RFQc6u6T9lfXThjlOZEDQsn7u7KTrB8llFSjh5BSZZKEQqpiXmFSQDHAlx6gfmu+F4OQB5naqaPsqOpCmvJXb0q8kG/GDUa90XEuqDywUEsftIXuVonYB//pDPBVFs5WPqG5PaHwtpOtGZ1JB1R/x8n5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBjpwJv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F9AC4CEEB;
	Wed, 27 Aug 2025 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756334983;
	bh=g6y6sbsOTvrERxODvCs31LXuAYdUnhdSkyL20Ov/pHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBjpwJv00JjeA8YfrTctI9j0rykgJRE3+YJWLR0E+VvTXf5DkLThFCB+JsJ5tEPzX
	 L65+GIRY+EU7GeSYCsJhBDAUaBzoO8xNZYjwywVknh8kh5HYfJmD0tEqBMEOvUekeR
	 LDemk8pMjw0ZfJynA9KHXVts8mRzjNp2G9eWwDMI=
Date: Wed, 27 Aug 2025 18:49:42 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250827-military-grinning-orca-edb838@lemur>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>

On Wed, Aug 27, 2025 at 10:49:21AM -0700, Linus Torvalds wrote:
> Which is why I think it is so bass-ackwards to add a link to the
> posting in the commit. That literally is useless garbage unless the
> posting generated discussion. The link to the posting is not likely to
> be the most relevant thing: it tends to be *much* more productive to
> instead search lore for the commit ID and the subject line of the
> commit.

Main trouble is that we can't always reliably arrive at the source of the
patch in lore based on the commit. The subject line can be tricky to search
for if it uses quotes, brackets, or other characters that aren't reliably
tokenized. Furthermore, there can be situations where the results can be
ambiguous. For example, a [PATCH v7] could have been posted after the
maintainer had already accepted [PATCH v6], in which case the maintainer will
ask for a new bugfix series to be sent instead.

Similarly, we can't reliably go from the commit to the patch-id that we can
use to search the archives:

- the maintainer may have rebased the patch series, resulting in a different
  patch-id
- the original submission may have been generated with a different patch
  algorithm (histogram vs. myers is the usual culprit)
- the maintainer may have tweaked the patch for cosmetic reasons

All of the above may result in a different git-patch-id that no longer matches
the original submission.

I have recommended that Link: trailers indicating the provenance of the series
should use a dedicated domain name: patch.msgid.link. This should clearly
indicate to you that following this link will take you to the original
submission, not to any other discussion. I haven't yet made this the default
in b4, but I should probably do that.

Anyone can already make this their default by setting the following in their
.gitconfig:

    [b4]
        linkmask = https://patch.msgid.link/%s

-K

