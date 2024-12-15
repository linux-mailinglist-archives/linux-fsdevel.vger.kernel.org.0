Return-Path: <linux-fsdevel+bounces-37430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9C9F219D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 01:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A1018865F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE44C96;
	Sun, 15 Dec 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVqT0ecJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9731FDD;
	Sun, 15 Dec 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734223172; cv=none; b=hgB20qovZoA44hD1/7ElWq/fdwGKfOfUe3LsM4z3HLKDQCbwnQL9wkY2gJJhDDOfwiNqllnD/d8iG252Chp5fugV2VxcdqP/2gWSqY5tgBv1Jm44kFh+rReSE+52Up1nJ3ii5widWmSMfMvxKm4T7sneZOkUHh2Z/xUtw6XoiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734223172; c=relaxed/simple;
	bh=blAmohXRs9at+HamL5FS6EkRRQ6jC3J+Ym8WUxcXnYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Psi+IvLk+aDh6n6qsOnRszwC4vOu/q82Y6uQp/HjcC+8l77Ikp7SH/TYzo9jE3m5T28aTEznbCoOehhhURcg/vB9/XhK8JBhKtZMPSOBHB15o+0KDXaz2dnLvp6cDLIGP4Wt7beAPX9gCAAiSNSOJnTHdcnHu5nWgJhse7wFcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qVqT0ecJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=blAmohXRs9at+HamL5FS6EkRRQ6jC3J+Ym8WUxcXnYA=; b=qVqT0ecJFv+8q586RYNyoKOk6x
	mLTEuRWKgr8hyOa99W93AGNDywVc/IVk3WYph2UOp0cyrafxJLYH90Xbd8pQ3UL+JxgnSUxJQfP/f
	zI1tR3uM/bvLmOXyi/pUEbVTktbXHRmEXSCCNJNN3G/MYD4iIu3J0BMwsG5BrTe/i7MYAbF+8BAXB
	z1a1KD1a9pITp5RGP6qU9eeN5sBo8mspiyecYq0LYBz6g/OMh5F+DRaJSweIHnBgMtl+3FwqQh5dT
	62l0letUYISXD2GiwthkhyoO48FRPRPj+tGkc3tdAbQL2eT6e8qqWwTjCWIrLANiDifQk62H5vv7s
	OP9C3DDg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMcfI-00000006B66-35qg;
	Sun, 15 Dec 2024 00:39:20 +0000
Date: Sun, 15 Dec 2024 00:39:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 10/11] nvme: remove superfluous block size check
Message-ID: <Z14lOOex77dgvIQB@casper.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-11-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214031050.1337920-11-mcgrof@kernel.org>

On Fri, Dec 13, 2024 at 07:10:48PM -0800, Luis Chamberlain wrote:
> The block layer already validates proper block sizes with
> blk_validate_block_size() for us so we can remove this now
> superfluous check.

If this patch were correct, it couldn't go far enough ("valid" is now
only assigned true, so it can be removed and the function could return
void, etc).

But I think there's still utility in checking the current configuration
to see if it can be supported by the block layer, and setting capacity
to 0 if it's not (so that the namespace can be reconfigured).

