Return-Path: <linux-fsdevel+bounces-53298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FFAED405
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1773B321D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C01C862C;
	Mon, 30 Jun 2025 05:44:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5D19D07A;
	Mon, 30 Jun 2025 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262275; cv=none; b=fTa0GLTNGZYeR0Xk1+NYBsd2DQvPk05z+gG//0WjU1HXRWoJ/Q9WFH/9NkUwk0L/fNgLmudbEyRpjKDWHUKbz6hBgfNtAjh9/87UJ/zgJO4sSUwUIKyBqjNT5+CZwZqsoPVqA0CUOrmnL7DHBJvqsnDyJ/3690IQVHSbo8hF7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262275; c=relaxed/simple;
	bh=yOnid076kHmBDuip0/alV1Nm9VaQqhKwJ+sLa4F5NNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbX31rvkEZ4tkKDTCEfTA23AN0Bh7TP4kbBcQo3T9DE+wRKdz48HIlK/NVDLEqlwAb/uSlkSAeeSN+x4U2DP07oGCSrUgRUTzRGXoVQy+JzENZK777VIckjTIM/K/jWiFiYqkKC+MnRWZY3Sn2wf0urs169fr2d5UsiI0uKYNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3783168AA6; Mon, 30 Jun 2025 07:44:31 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:44:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 06/12] iomap: move all ioend handling to ioend.c
Message-ID: <20250630054430.GD28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-7-hch@lst.de> <aF61grplkxy7RXie@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF61grplkxy7RXie@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 11:15:14AM -0400, Brian Foster wrote:
> >  #include <linux/iomap.h>
> >  #include <linux/list_sort.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/writeback.h>
> >  #include "internal.h"
> > +#include "trace.h"
> 
> Can any of these now be dropped from buffered-io.c?

I'll check, but I suspect not.


