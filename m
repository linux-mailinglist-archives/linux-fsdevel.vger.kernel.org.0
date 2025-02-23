Return-Path: <linux-fsdevel+bounces-42346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D67A40C58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 01:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB9518936E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9448472;
	Sun, 23 Feb 2025 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Oy+Un3XV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B991FDA;
	Sun, 23 Feb 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269959; cv=none; b=T4KQ8IngdLThVZvPhBRzNiv9JEcydiN5hu8H9nfV7AgdTDu7671q/ml0wNkFp40y5BdNHlZ+Txf3gUQT335YRfN0dqnET9w4+ROKbdAJ+3hGnmbMsKQQH4QcoTZ9lbx+Hwekky+wn9OpHv3gwvYNv6R7hrWHleJvSK8eAO1bbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269959; c=relaxed/simple;
	bh=1QnKUgdCE88C85NWfcFRtBJ0gf73IhCGIt9jdDAqSgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3QpbGpVhlFa0wg/LaTBKQanshBqaUkEoltu9gFUpK5g8HuF7SViNA0egV62xWL7lz8SOGq57TkLia8ENSj7iB9KiF67gNRhAQdgT0Vn8erAF/jFuwfXSuM63NzpgeXjTj2jnUx8qKO1z554scTAVxI4aSQS0YAX3s0wHsL2WUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Oy+Un3XV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X4invFkt085GdRdNZcmr3hjreaj/LTQt5B32EC7GIHk=; b=Oy+Un3XVgh8E0/1V/vQj3NL3VA
	ocOh36PTyAEMktFV+R0ks0K8w6mMIs2ID+71u5mE0Bxs9s6wl72F0TapUveMEPUTINtOk5b3Y9SKZ
	bk11+N9pNHmYx8sg4z9UfrDDuS7SX2EAHzLOdca4Ote3a27WBtqL3/TrdgxR3HUBAiw6Vj1bE9ctp
	d7NyjyNfb44W9zMQAFMLLC74mkjw/qGxI5YzUx29J4cV3tNi7gGXE0aZJ2La5odd1GgpwBxMelcR2
	W/pahyGrnLGXnt5DiOYeFSp5S2bFQ7md6r6PNRrgTI13wu0esdeku2V20rgybzzFH1Mq9AuLm/5q4
	2X2vC0Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlziD-00000005hSM-2lLs;
	Sun, 23 Feb 2025 00:19:13 +0000
Date: Sun, 23 Feb 2025 00:19:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net,
	gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <20250223001913.GQ1977892@ZenIV>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
 <202502210936.8A4F1AB@keescook>
 <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 22, 2025 at 01:12:47PM +0100, Mateusz Guzik wrote:

> General tune is not holding the codebase hostage to obsolete (and
> probably not at all operational) components. If in doubt, prune it.

What exactly is being held hostage, though?  Do we have an API change
that gets blocked just by the old filesystems and if so, which one
it is?

