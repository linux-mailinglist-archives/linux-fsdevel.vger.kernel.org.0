Return-Path: <linux-fsdevel+bounces-44833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325DA6CFC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E9E3B5BDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15267603F;
	Sun, 23 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSL7Aj4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079220EB;
	Sun, 23 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742740537; cv=none; b=qTktQiUaY0J+uxxmxF9B+9MQtRK1DbPqrK+OeQ6EXuWgguMVdi6DyCrJkc9E7ZryDzxoKSeT5TPqxERHO1tMBUG6O5k5BZi3zX+PXSA0rX55Kh4ZZN0rnYv4HJAU6VZuQprGiEr4Nz/bbV6gbN7NQy6csVoF6E0pxmP3KH+RzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742740537; c=relaxed/simple;
	bh=fziawMd78CZigb6/dN6hhhitcVeOD2HqMNrtndJclkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk2NB6yuHBwxkQLKpTA0N7bp2hucLJOa2Az9FEjt+mgTaiaKXDz1MnVicIWcjHgbUL4C29P4lPBhfbKX++PN8f/31sEjkGY7kWFgmZM2UvEWfFfDo3R0wCAvTDJycvgYhvBiuilxugKX5e5qZQX/fyefSgUe06XrU+tb/6nbQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSL7Aj4r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fziawMd78CZigb6/dN6hhhitcVeOD2HqMNrtndJclkU=; b=WSL7Aj4rgx50fdQAEQp0GNQn82
	MjPMqjtLV3FMDbHGRVw69NYcwaNjzk5lHBPgu6vX/pTBFtU5JB6u/NdML+RXezLKSzwlS60cK4MZT
	45mmiKGMQqCL4MnG1AcK9tsnlKztcLnMeBJ+zO7FhZFaXH5lLwXi6VM5HIMbebaFhy9jTNEbdTyUE
	dzaCP7FTv2N7wQsFt2axq/mSSiccNpj+1CSRJLaZDk3QlBmTvOmZ2QS46QeVu17tcl6F7jRsYIMEH
	V/3NsidycQImRQ1R611L+loFvEbupe5n99OketO8hoqKxlFk6TzsE7GGC+KvzEi+IxyD8dmTXOdDZ
	icOD+Jig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twMQE-00000006gaN-1w2B;
	Sun, 23 Mar 2025 14:35:30 +0000
Date: Sun, 23 Mar 2025 14:35:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] iov_iter: Add composite, scatterlist and skbuff
 iterator types
Message-ID: <Z-AcMpe7WOpPeBvT@casper.infradead.org>
References: <20250321161407.3333724-1-dhowells@redhat.com>
 <Z9-oaC3lVIMQ4rUF@infradead.org>
 <107a8fbf-c36d-4870-be86-ec1415139cab@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107a8fbf-c36d-4870-be86-ec1415139cab@suse.de>

On Sun, Mar 23, 2025 at 02:39:25PM +0100, Hannes Reinecke wrote:
> Can we have a session around this?

Wednesday, 10:30

