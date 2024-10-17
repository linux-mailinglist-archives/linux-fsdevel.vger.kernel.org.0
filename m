Return-Path: <linux-fsdevel+bounces-32206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B89A25C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B041C217C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9C1DED57;
	Thu, 17 Oct 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldTjZuWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A781DE8BC;
	Thu, 17 Oct 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177104; cv=none; b=cpcPzJQrmQztUv4Opy4Wy0BPu+kmYSeE9dDJ+e6xh9RiWcYDV6xEgXchA9ZpBxK918DuB0/QrmV4ZN18vbqZBvUY3egiXVRJhRerUFI81SB/9euyVCwJnOECR6mMIlf00kNGzHg4rUcFmVxXt8st9SMYEjZ2xokUlegUQo+Yi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177104; c=relaxed/simple;
	bh=NTIyRLzQ+LVTBiqT2V3ffBmtxOZeoP4TrXSEXAZjlfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcjH5luKX7wwMW98vBAyJH62KuwR6zrp6pquFIk1TOr6d4Tm6SEMIBKQRlUTHg7rqCZLR9mMEbup7AIkCLMGfO97GWJyfMic83peRnYhSr9SMelr6iisfc/I4a6U+vpO5cMcISbgJTYhvYN+AFlHGY8d+PBxEPruA3JIN7C9HgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ldTjZuWk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0zVNP1Ptk3y2T2obANnHpfuDWaPH+KHZ/+LIWbdf/3s=; b=ldTjZuWk7H5wSxzdvq4d3ZehNk
	gWYbq2z7UIXQsHPimnJnKcBnVPFLc2mbw4igMIpW15i87RCeRPVh3tcE+k+Fsir4MHyn/GzzNgaoW
	Z4Z1pB0CXGNAa0HfCFbezWZn+AL2a+oVL9zrkrNGyQy44V+r91RHf6hknXmsxKIwDVV4AVycwBxsK
	oTpT6lE6eNVb8z9TAcC3YdbJetVCtzn5XrxVTEZxJx4Tmcz17EoLgDHhA29QZXHkLdbaFvSdXKe1S
	kDmaGpd9Ybfk3zKOthTT5+yf2b9ap10aAo/wqC4pDKTphFu/J30hPMo5KTUnb8uJXlgaNStNWD9MW
	ZrGpfMLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RxF-0000000FC7l-0ggJ;
	Thu, 17 Oct 2024 14:58:21 +0000
Date: Thu, 17 Oct 2024 07:58:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZxEmDbIClGM1F7e6@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> Okay, good to know, but I was hoping that there we could come up with
> an explicit list of filesystems that maintain their own private inode
> numbers outside of inode-i_ino.

Anything using iget5_locked is a good start.  Add to that file systems
implementing their own inode cache (at least xfs and bcachefs).


