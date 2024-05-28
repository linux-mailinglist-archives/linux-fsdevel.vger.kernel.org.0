Return-Path: <linux-fsdevel+bounces-20335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF5A8D1909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03631C248DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9ED16C68B;
	Tue, 28 May 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Oe28dRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380F17E8F0;
	Tue, 28 May 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893805; cv=none; b=Q4Gh0Ic5jAHpoejdliKniMw5DeQZ4axCHEHrL0DgY9nR/ZBigYp5+98V77RhhFTcTEitna7NJo+JoEzD0LDu2WyPaGQYcUehFghWnAYJPF3mWhXSBTt8iarpXQ1+MouN//fEOkaioCo+iKVMIA5nXSyBSBF3uta3zKzKCqE5fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893805; c=relaxed/simple;
	bh=HZTSW9bk0tYqiV8s902Z5erz0IAIj3Ddec7NKMcXKuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcdnhwZ2rcIZkHGoaw3TRsKZvG7l/KfeKtSbWu8FXHqGFNiE2NkI96KR2HX5MYMluzj/b7t4YzdtGRP1wCb2cnx21MBaFY9JwetzFRIZjT0/dQEF/D0rASFxTCC7riltQO7CRD1tbUgPBb8fuD48d3HVIt5IbOL24RNIOdVpGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Oe28dRK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/V95dGngcEuYhnc9wQ2EmcS5NmDhpxdlRNxDZQXorMo=; b=3Oe28dRKP+yOmfYUOcyQY9Z3tw
	pfqgCiwn9vLXOe6WZnGtMfdZjYrwA1TfPbw3EXjTlX+TYFBQji9oZhbACS8EwKYk2qqMI6kxrINsj
	8YDC4j59DjrB7GKkn+Ps8sFCLUynKPzBVL9k1geDfthmvu4V9PvhvXCs7nqU/goTLUQkVGDqZd+i/
	6rapaEXOCmcN8zBYT2szMbkciaEBhbHn0Dc+PhrTGyXvlJBmpw+PlK2z6CSaWl/OK5N2lGDhdqo0p
	RyPmSYsxxycJEDYe4kcqoawHE+5khkOWOXBPCUCbUQGOnQPfYv6jn7+6uYaKOoHqw9OnJjfs0cyYk
	q1tJcZzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuVY-00000000HqA-0021;
	Tue, 28 May 2024 10:56:44 +0000
Date: Tue, 28 May 2024 03:56:43 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlW4a6Zdt9SPTt80@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
 <20240528101152.kyvtx623djnxwonm@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528101152.kyvtx623djnxwonm@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 12:11:52PM +0200, Jan Kara wrote:
> So some fanotify users may use open_by_handle_at() and name_to_handle_at()
> but we specifically designed fanotify to not depend on this mount id
> feature of the API (because it wasn't really usable couple of years ago
> when we were designing this with Amir). fanotify returns fsid + fhandle in
> its events and userspace is expected to build a mapping of fsid ->
> "whatever it needs to identify a filesystem" when placing fanotify marks.
> If it wants to open file / directory where events happened, then this
> usually means keeping fsid -> "some open fd on fs" mapping so that it can
> then use open_by_handle_at() for opening.

Which seems like another argument for my version of the handles to
include the fsid.  Although IIRC the fanotify fsid is only 64 bits which
isn't really good entropy, so we might have to rev that as well.


