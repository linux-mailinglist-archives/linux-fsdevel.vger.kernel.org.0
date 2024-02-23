Return-Path: <linux-fsdevel+bounces-12585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097E86155E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A47A286FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B137823AC;
	Fri, 23 Feb 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MgzcAiwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A21DFF9;
	Fri, 23 Feb 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701484; cv=none; b=aUYAHmxtUOtuHzdLAT6NnYvUQBfH1YpewNGzM6/U4INcHz7sXccVFtF3cmqMY3Cr3OmA877I6XdIuIVJSigyuH+0Rj9U1zGVSPZVm/zg9mgwZZkR1RlLcj/MNxS0wUluN4hzXxu2ITgzakwiaBaJ0DaQxbJZoIldsguILDnd/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701484; c=relaxed/simple;
	bh=snju8i8I0RUYEXzKnwVKNgI1aVi68jifWTXjYWifv94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbxnSOtq9Ey/uMkZmGgR8qofhC07LaXtNu+I+dwuaxrEza0vYOUs8wYf2V5lsolIKYWIDrUs3FAd4caxsIN7HSSyp3081e64jSiCoY5N89RBZeMwnKHEYx9Wx0Szz3cJeZUZGxUqwuobxUb2Grq3SYvexjvR7NcfFHKfyqvMEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MgzcAiwp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=MF3Qgk7knpbBl0mbT42qZNN0FOGek89e7NBszsKaFPE=; b=MgzcAiwp1JBNPUtRGATGvBwx+M
	CStp1G0L26HISpEujYZl8RH7p6ABrTnlmhGF3oUfZlMGyGMEf4TwTa9fIjM34FKpNQie3gi/ITMJW
	zb2dvQnScrw2SYhq1KFB7xafji1jJ0GB3zwbOup+k59cRgqWuCkXQyB5mHTytDVgDxEA5P7KwkeeK
	NtjodihCG9x1D4+aYPwsKl7luGw7UkBp00vu4bKQslPDyEXZKQWKr0XObJB3OVXOYmKv6ksSMs7wO
	Bq4eigHgYsN6ovmdfSxJjMexA3n1R91EfB/jWyhanDUW8sbmu4L8LHj4gBkcNCp36oIVGG2bt8gBv
	xQ/pnzJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdXJ8-00000009wbh-16HU;
	Fri, 23 Feb 2024 15:17:52 +0000
Date: Fri, 23 Feb 2024 07:17:50 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: treewide: constify ctl_table_root::set_ownership
Message-ID: <Zdi3HsFzG-p81CjG@bombadil.infradead.org>
References: <20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net>
 <ZY12sLZYlQ09zU6D@bombadil.infradead.org>
 <23edfaea-fcee-4151-bfa8-d71d11a24401@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23edfaea-fcee-4151-bfa8-d71d11a24401@t-8ch.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 23, 2024 at 02:16:15PM +0100, Thomas Weißschuh wrote:
> On 2023-12-28 05:22:56-0800, Luis Chamberlain wrote:
> > On Tue, Dec 26, 2023 at 01:32:42PM +0100, Thomas Weißschuh wrote:
> > > The set_ownership callback is not supposed to modify the ctl_table.
> > > Enforce this expectation via the typesystem.
> > > 
> > > The patch was created with the following coccinelle script:
> > > 
> > >   virtual patch
> > >   virtual context
> > >   virtual report
> > 
> > If you remove this virtual stuff and mention how we verify manually
> > through the build how users do not exits which rely on modifying the the
> > table I thinkt these two patches are ready, thanks for doing this in
> > Coccinelle it helps me review this faster!
> 
> Actually the 'table' parameter is never even used.

Oh wow.

> Do you prefer to drop it completely?

Absolutely.

  Luis

