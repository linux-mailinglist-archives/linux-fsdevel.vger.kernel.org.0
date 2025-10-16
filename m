Return-Path: <linux-fsdevel+bounces-64341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61508BE1759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA04E703A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2021CA00;
	Thu, 16 Oct 2025 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kX+ecOXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F537216605;
	Thu, 16 Oct 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590682; cv=none; b=aWsB1st6SiqnqV/+P7LhQ0wZPtXyWVj/UGcTZvCCOP15ngFuX34mKQqJI2JA9G/0R0Kz+3QPzcSNZBq0LUftDA04RbVvo0hqDqKdj0N+Qax49jKnnvqo6T5XOobfsMg3pdWjvoVYpw0JW4Ch25fnZrR7tUatGxEk2RIftamYGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590682; c=relaxed/simple;
	bh=ECCnn3TI8/y8/y8DCci41y7eCrVjsNbpjUUR2M/wb1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJIuzobg+knn0kw+7EYS0Lr5vDZEfrXqkH1t4+94MMyYV6qLiVoDN1vnVXbogJ2fSZuQevIx+tCGoyOvyyazu5Sd855kljrlin7LEImGYb89sSZYqq/9PBrUqvWwJpnBRz9H7xOKjhYAVJqgilurcVcHF2xjMdxMWXFhJWBf0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kX+ecOXG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=83RRaMW02lAZZkMy97sWQR+uVw4y0FfJh7nVF0t04Bk=; b=kX+ecOXGUo23ibqL6z9XtV+dMr
	FZAO8B5A2cssmhP13D4IOuXU+ZdP2yDszBs4KHZxyMs1JnTIVjRhOw2WuxmGu6OfRh759Kye69cr0
	PlO8Wo38DXVb3L0Na3KqkMGBt4SPshYCeoql4xQiYQ3wY7gzC0oUZJUoRii/XwmIzMu1/RyKZKqHV
	Ktkj0d89CONRXmDjdBXeNCkD9KxgMbGmpjjrgm0u5tixryiv4NPLgIn5jR5D0sYROhptcCWbl6Yc3
	HOfblqXCWwbqPTx5pd9PUiQVoA5reALlusiMcPs+xiIUuFtNqsqe18iBlPQrwgtwqbGhdqjclQ9HR
	v+YieS/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9G3o-00000003SW2-2m3r;
	Thu, 16 Oct 2025 04:57:56 +0000
Date: Wed, 15 Oct 2025 21:57:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Message-ID: <aPB7VOaDhBtZTD6T@infradead.org>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <CAOQ4uxhrQQmK+tc+eOjm7Pz2u=S6_2cnneyo4mNjVgyA7RNooA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhrQQmK+tc+eOjm7Pz2u=S6_2cnneyo4mNjVgyA7RNooA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 15, 2025 at 01:09:26PM +0200, Amir Goldstein wrote:
> FWIW this operation already exists in export_operations.
> It is currently only used by pnfs and only implemented by xfs.
> I would nor object for overlayfs to use this method if implemented
> and fall back to copying uuid directly from s_uuid

The get_uuid export operation is specifically about an on-disk superblock
that the pnfs client can match.  Overloading it for in-core information
would be very confusing and also problematic if it doesn't exist on-disk
in this format.  In retrospective it should be called get_disk_uuid or
something similar.


