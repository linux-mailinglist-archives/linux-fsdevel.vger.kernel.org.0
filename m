Return-Path: <linux-fsdevel+bounces-52000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2ACADE2AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FC33B78DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FB1EF389;
	Wed, 18 Jun 2025 04:42:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635281E0DFE;
	Wed, 18 Jun 2025 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221771; cv=none; b=a5gHB1GrYDG06D2rdTnRWMWIgfslFfT9ocQiiBBNPKfFneCl8oyJKvua/kxgfOwzO8W6DUUUFOTQnSQdee1o6IOxdkRoMo8fWaCyyLSOjWxZBgA9EQgGtWCA5FPVPhp7KyIEdzWmvVx0wYgUjj80HyzXcfqN/inzhjOEdhSswAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221771; c=relaxed/simple;
	bh=64LSAUY1JgTsZ/KfhgkJc08tr2q6f+vecZUfS+LiPqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4kqzKuV6u3TUtgueSEFhGbEDkrgwcCMLiR9MmzIQRY0WRVHL6bMGp5wSuok1V15cQM3iwa8QFTx9/uiOSouG8Iu2bK3VN4X08Xr+nf8Qa55PmnSrBnzjVPZTdtFYMuFt1+AJD1uC6Aej3rc0ih0EDDuRb9prvBWUzW2+ayjQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABB4268D0E; Wed, 18 Jun 2025 06:42:46 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:42:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 07/11] iomap: rename iomap_writepage_map to
 iomap_writeback_folio
Message-ID: <20250618044246.GD28041@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-8-hch@lst.de> <CAJnrk1bdps-eetwZOu_2Sri7oeVAa7F+22LOjo=Z+Bh86drWwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bdps-eetwZOu_2Sri7oeVAa7F+22LOjo=Z+Bh86drWwA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 12:44:04PM -0700, Joanne Koong wrote:
> On Tue, Jun 17, 2025 at 3:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > ->writepage is gone, and our naming wasn't always that great to start
> > with.
> 
> Should iomap_writepage_ctx be renamed too then?
> 
> Not trying to be pedantic, but the commit title only mentions
> iomap_writepage_map, but this also has stuff for
> iomap_writepage_handle_eof, so maybe the title should be reworded?

Good point.  The renaming was mostly so that the newly exported symbol
has a sane name.  But we're also touching all the iomap_writepages
calls anyway, so that might be worth cleaning up, too.

