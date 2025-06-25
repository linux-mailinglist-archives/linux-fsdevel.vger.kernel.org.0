Return-Path: <linux-fsdevel+bounces-52848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A6AE77AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE116801C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF81F866B;
	Wed, 25 Jun 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOG3Z5ye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF679F2;
	Wed, 25 Jun 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834896; cv=none; b=bRsdePZT8loIFec8CoR6rv2o09Bwge6+nFSVTgHj2NAdhteHOYaH601w/V44dH0GtOiSJenL9TGCZDiWsCbA7qYGpJCZS0RniCI6lHxwttWitFnAn/LojUJRLLKEA3vsvHz2V7LZynNMXHRMwpKs27rkx0+NIMnbcbgVFdDDjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834896; c=relaxed/simple;
	bh=gciUXRI5RoGH7MW8+6HdMvsnDB4tQnkO04ozRC3wZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJkmcL/hf+4ydxSo3bWqFDrGCAEf8GTiTq9DJS1Q4woX/NRfAzAH3lWUkLOxclf+eHwCjIW+DPCOkeSs7v0VsNANL3LRIbl6g49UDLOsvuo6pjnqQLMG0VV0kg+Sga5I++JG4QoGjusorP5MIKZufRnjk8Kq0QVLl9pY2TKlsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOG3Z5ye; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VrBYzP+Ry2B3NbNU4hQ6PEn7rOjvDYFr3WIL5OkLT8Q=; b=VOG3Z5yeGtYSi/UAOL3xpTDAbm
	fz2EeUA3u057vMgix5kVW07dJWOiEr903LETeJwVnXiU/0ZVvFIV/YOuHRePOukvDhQliskEU7VhG
	6FR0jY469yZ/tOAlLCUw6X0WmEpBWEf6XRXrD6AtNwZoSsBU2onD4CmDJm6v4cy9lrTCOsG5zMfNe
	dHvdDx/4+AgGVQhVNm4CAg5vNiDuBT4t/3u/9xxroRahvGs73uxhIq3AB8paSWNdqHswJygmye6tl
	OSUQD22dr9bnUe3+txxV20WY/n1c6Cz6qTtvhT41XUOrinoeQQ//47E2xXby0a9qh1MNNxzqqGOsX
	iaTikL/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUK8U-00000007kXc-33oi;
	Wed, 25 Jun 2025 07:01:34 +0000
Date: Wed, 25 Jun 2025 00:01:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: hch@infradead.org, david@fromorbit.com, djwong@kernel.org,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aFuezjrRG4L5dumV@infradead.org>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 10:44:57AM +0800, Yafang Shao wrote:
> > That's really kernel wide policy and not something magic done by a
> > single file system.
> 
> XFS already supports an optional policy for handling metadata errors via:
> /sys/fs/xfs/<disk>/error/metadata/
> 
> It would be reasonable to introduce a similar optional policy for data
> errors:
> /sys/fs/xfs/<disk>/error/data/
> 
> This data error policy could allow the filesystem to shut down immediately
> if corrupted data is detected that might otherwise be exposed to userspace.

I fully agree on that part, and would in fact argue for making it the
default.

But reporting writeback errors on read just on one file system and with
a specific option is really strange.


