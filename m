Return-Path: <linux-fsdevel+bounces-55955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DAB10F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B20DAC0A20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA02253359;
	Thu, 24 Jul 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aIkKpr3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB51917F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371990; cv=none; b=ZYrIzvfa1A4hZtFjyJ+UAll2LZcRFP86xxRobwjI1Ffj2vtn84w6jN415X+KV9de075WnUnYdzqrWbbLFaYApu2wxGdK2aIeTS5V8HCV1/G9/1T9xYA0CQTCw4iHA+iSyEMoAYUyYqucaF4DLfQgptob8NGzaQvZD7DBWRKVIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371990; c=relaxed/simple;
	bh=CZGtv9aUNHH8Vm962FI5Bu2mdugNacdEuWkgrSi2XOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9bEaw+UTwDF5W6OOhV6WlGRCwyHjYcGbjVfxSmNFlIzdpPmZG6+gLJkafpHKB8N9UcDU0LthMIPn0793TyjPoEVK8BII55iTLy0AjLz/O+aOOcorL9v29u6z70ePpp82CTEdcmuWjhhv2TdhcKZaKsrGo74X0+pU3okwu2yy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aIkKpr3a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CZGtv9aUNHH8Vm962FI5Bu2mdugNacdEuWkgrSi2XOg=; b=aIkKpr3atzQfyu2UJu8+RZx7KW
	nTsJGt/YRC7pdQaFp9FJr/kw/fgEfcpY+b6odm+IrwvNzW9LhLoROcWhuDWpZuV0y/rfysduyFApR
	e8a2xH1JDoQxFmnJOxRGh32AZN+V5uNHqFOvbRZdBR/RmmxhzLRg+sSQEpM98MjZbNF28Ymu6EGw9
	MUu08ZrmJBqclO1+jF/m0sqa9AioG7LkNr0rSIG41/9n/AjBxpV1emwSN7lqs64qHgkD+Y1JKnmDj
	hSNid70QXiRl7DHvGuwW8zw31J3mfisVqum6yJkKUL1axpLcUoPg5MP+Q57nvmR4AJCQ98s4QtdJ3
	zoHiQn0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uey9H-00000005is9-2uFj;
	Thu, 24 Jul 2025 15:46:23 +0000
Date: Thu, 24 Jul 2025 16:46:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	kent.overstreet@linux.dev
Subject: Re: [PATCH] fs: mark file_remove_privs_flags static
Message-ID: <20250724154623.GT2580412@ZenIV>
References: <20250724074854.3316911-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724074854.3316911-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 24, 2025 at 09:48:54AM +0200, Christoph Hellwig wrote:
> file_remove_privs_flags is only used inside of inode.c, mark it static.

That's close being a revert of 66a67c860cce "fs: file_remove_privs_flags()";
I've no objections per se, but at least a Cc to Kent and summary of the
history in commit message would be useful.

AFAICS, the history is more or less "the only in-tree user got reverted
in August 2024 and hadn't come back since then; its removal did not
touch the export", but I've no idea if it has successors yet to be merged
back into the tree.

Again, I've no problem with making the damn thing static, but some context
would be useful.

