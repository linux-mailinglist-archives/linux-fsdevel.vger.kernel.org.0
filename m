Return-Path: <linux-fsdevel+bounces-34727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39B9C8208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 05:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831791F23A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A27A1E9078;
	Thu, 14 Nov 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xfdi9ziT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAD1386B4;
	Thu, 14 Nov 2024 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559078; cv=none; b=lpMZeZ14im4ec64H5WmRvN+QQNHmHVr2pToeby9SFFwXt1dqtNuTdQkTJ+r5t9Mb+ofHdVll2rG23GD4XzMj+74ZNbyoNg/2vsVG60la38oBlLFwELKtpCUFrb+MUwrgjXm4bj3PEqwxikdgmM2wbBso8UuWWs0qwQFNMY21Arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559078; c=relaxed/simple;
	bh=7ljqjFYMI0iknZu8gispeiqdxGiEPPP1Xd2xKIx+XKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVq2P1s6FectPLFBxbplAU13Vq8Mdy5j7n2i7V3zndk9RU8Pgk+Wb+ZIA2SgpS9i3lJTik5t2TGAuq998bRHeuSb8cgg5c02lUND3/kSrZIX6mysA/uhsCRAbw78UFUctmNr4Frjjsd0qULTk+orwxn17ZFuJbUUr+8M+seWEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xfdi9ziT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ljqjFYMI0iknZu8gispeiqdxGiEPPP1Xd2xKIx+XKo=; b=xfdi9ziTwdm8THeikj+z+Z1hdg
	r7NK41p0aVm9+pf7/A6dLLqqC0s1AEkwRYU4RUNVC3qM8M5mjb2UNcXA7Btsfj/tacBRdbKh5HfPf
	2yja3l1TecGphV5qn8n+ApFncqtMMvVjU3EIBG/nGD4/g5RvYSRyRa7D2ZoQvkRJ4+mvuMyj9hrYx
	JFof+CeAHdykOFGJIexQ4X+dl7LganbvCIARhindXRK5gVq5YKy6umtKIA+mOPPKK7w2rnROUrS6x
	MmRBC3rv6uOSNe2BUeS9+01C9zWo60XE7rspE51tj9aecMa7J/fwuW4/vKgDg51eULnMmtuZ1I857
	amXsT+sA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBRc9-00000008mVE-19Ni;
	Thu, 14 Nov 2024 04:37:53 +0000
Date: Wed, 13 Nov 2024 20:37:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Message-ID: <ZzV-oVtytT28gHz2@infradead.org>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 13, 2024 at 05:55:24PM +0000, Erin Shepherd wrote:
> For pidfs, there is no reason to restrict file handle decoding by
> CAP_DAC_READ_SEARCH.

Why is there no reason, i.e. why do you think it is safe.

>Introduce an export_ops flag that can indicate
> this

Also why is is desirable?

To be this looks more than sketchy with the actual exporting hat on,
but I guess that's now how the cool kids use open by handle these days.

