Return-Path: <linux-fsdevel+bounces-41258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D287FA2CE1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E766188C46B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970B1A5B8E;
	Fri,  7 Feb 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XPqQTXCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D623C8D9;
	Fri,  7 Feb 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960123; cv=none; b=t5SyakdAALd/1wLnlJTIZQp1YBkcpeQCRWAQ81NhPaeIqyTI/xAUOyUGSh+Apxj+niEI0KDZuNnL0sV1bfzBixPpG0Dn7lBR27ou1T+JxMAr5JQLBpFddNIU1btnW6MMKOVZajMp/T8ok/8y+c4PwD4O6Nc8zoFDcjVUBpLN6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960123; c=relaxed/simple;
	bh=NQPJ6Xw2FmXRPyTd9Iz6WTK2CqyRPnr1wlHCflc8Yz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUwMw0mwItNebKhwGZeyL3iuZGw/u+i+W9gn5j31pwZl59x2eERDql9iHSG2jwvX2JbmlbWwzv4hlToXfBhuuWSrgYn2snjVgMcFFsuokQ1kQE5GYhMMNvOdEBO5EO6kualvEP4KnfbJUxvF11/Thi49oAx3+1BxhN7RwBGDEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XPqQTXCb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQScnJ6ROIj15+1bl0fDPE1w/8lc99rQdupUtYs2ct4=; b=XPqQTXCbS1tcVILoMa5Kgkqktt
	H/xkJvrkiuSxQamyd4x/jNpbx+eIEZm1b68bLcCG5wBc2Dm7ceFoaBhhxWabJyccr1CPF7l94awrm
	+Pu7TK1OpMK77pfkyReLESH+NlNhoDYdE6S1yjLJRNOF5ZPaLrvIpn51areWS6CDLrKAwdKTYlhGl
	bGNb+8dO/IGW7en9/WZ17Ah/oNUg9x8U9oXbyMnAbDfYH/e52dl9Ul2pbSVXP372MArHXjJFAnG+q
	aPU+yMU+ImlicRPHM7zx0aaTHTqDRf7a1ltW/0EItLGOiPtsTp8BO1YBg9xNfg0m25l/BXqWroWeg
	+0snNoGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUxr-00000006Yhe-2J7n;
	Fri, 07 Feb 2025 20:28:39 +0000
Date: Fri, 7 Feb 2025 20:28:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races
 with rename etc
Message-ID: <20250207202839.GI1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-14-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-14-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:50PM +1100, NeilBrown wrote:

> +	if (dentry->d_flags & LOOKUP_RCU) {

Really?

