Return-Path: <linux-fsdevel+bounces-40190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0791A202F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 02:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15045164614
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E33FB0E;
	Tue, 28 Jan 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DMWdI4Fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB3EAF6;
	Tue, 28 Jan 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027285; cv=none; b=E3son6GY8LzHn2/AZUXc2c13K+Nb7l9ep46aszrW38yXpJk1ss+r7sNSZmUjkl6yb7GLbvgcTg0kfnXWhZ+UX2d/mTMTpysqR7JPIT25zCq2VvkCzBv200MbWZ5IJ4u0dcXoFxaShilm3U3RQX6qqyBulK9IafxaqaNqz7zZiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027285; c=relaxed/simple;
	bh=5czwCU0OL0YSdrWAeYMWeHm7EIXU9DatuCsb7uKPMDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly2yxreQYN/Z6W6y25GPOqc2816M5B8jv1RJTK7LOtNUuMVYawNOhB6ZT3Vz3RY2RTyIG+DWApouA6f8lbGKp+MtM0oGkL9EshtwAfYkRBqmBo4DveAEwRB3bg6TNjpWpafPBKSPTzvIjUT/80Ot7HM/CnBYCj5mtso6T5Tmd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DMWdI4Fm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EyybTzIQEkRBlhw7e+ZaoDQDGc1xnfTa0nhSd+gp8t0=; b=DMWdI4FmF0/u2juZX+mqJkYn+W
	eqcNumCAEnPRviXMn0yiff0dg5Q1B7ZATfjsUt/WbutCB8SFuf/iBm23kOE8+b8f/y5lkrroqVSYF
	tCytRe0WXt9d7qTk4kDXB11Chh65T/VqOkzIQVBukXO0o63Nka/uVr6yMul/AQWNwKRKqFLpVYYcO
	ZlaWeqvDD7iq6l3nOmoRsxCdsPIqMZue9dJmibmH1+oxr3QPzPFQ3u+DCG9gz8XhQDO5lD3cbl7oB
	Szk42yH0vQM7EbVI4nOY7s6dZo+cv54F7ZettIeEjwoHbwIklhBSDy+Ja6XF7oTgQ26/m6a6etU8v
	hWfO1vPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcaI4-0000000DqJs-3nma;
	Tue, 28 Jan 2025 01:21:20 +0000
Date: Tue, 28 Jan 2025 01:21:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250128012120.GL1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
 <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyuiqR9wJ5pn_d-vmPL9uOFtTVuJsjVxkWvvwzhWEP4A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 04:43:13PM -0800, Linus Torvalds wrote:

> I'm thinking mainly dentry_string_cmp(), which currently does things
> one byte at a time at least partially for the "I must not overrun a
> NUL character because 'len' may be bogus" reason.

Umm...  On some architectures it does, but mostly that's the ones
where unaligned word loads are costly.  Which target do you have
in mind?

