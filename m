Return-Path: <linux-fsdevel+bounces-25075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98E948A40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745ED1F21E13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C716A38B;
	Tue,  6 Aug 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCkTvYh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B1547DE;
	Tue,  6 Aug 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929898; cv=none; b=TmP3u/3ZMUp1vYVezVGneVIIKpnyBDbDfMiIPfKWBb5unmyWY3Q5wxwW6CmxBjwL/ny3DPDZNqS4fXk/FPv4yZ3LsJHTI/ejJi5qiL0XhRMDwmWhR8YAZXpEtx28K6k/J+uENoZ7ZwfF9Mo0p6QxRdgFfkcUzKsJz/3Mu+mPRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929898; c=relaxed/simple;
	bh=52a78dRRUlEtuA42foEjlPuvHuJZdiMY70ZGvdQVk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzSzKfp84OoExEetG7XHPFDqnEij7KbzbAr+4R4P010UhTl/P9+5YBRJpgd/Gk48cMfWOD2fp2A/zI+ja0O+RVSGvTnB+HgcsDFrbPKWXWSMbWHeMXfqNAK/xIV8t8PBxxHfmODbs55ZA35HA8/6ypjcfCPBxCf1Od34NthWpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCkTvYh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CB6C32786;
	Tue,  6 Aug 2024 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722929897;
	bh=52a78dRRUlEtuA42foEjlPuvHuJZdiMY70ZGvdQVk1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCkTvYh+KdIzbSCjmcXp8B16eP7phOR9/AajzX6KtuSKI1MRQtiXzjTU2HzcDdVVC
	 AczAUdlqbL7aDwUIzrTuQfA9NXge6GpF55pl2fZVONqgnBBNy+ZxKYGBqwEDZzpaAP
	 VMtMW6YbGLR1E2noTBPzMgo6lUY15zR6RdVX7wKA=
Date: Tue, 6 Aug 2024 09:38:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Message-ID: <2024080615-ointment-undertone-9a8e@gregkh>
References: <20240805100109.14367-1-rgbi3307@gmail.com>
 <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>

On Tue, Aug 06, 2024 at 04:32:22PM +0900, JaeJoon Jung wrote:
> Since I've been working on something called a new Hash Table, it may
> not be needed in the kernel right now.

We don't review, or accept, changes that are not actually needed in the
kernel tree as that would be a huge waste of reviewer time and energy
for no actual benefit.

sorry,

greg k-h

