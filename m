Return-Path: <linux-fsdevel+bounces-2492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E57E6409
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FF12812D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DE6AB1;
	Thu,  9 Nov 2023 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yoaqgvv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62E2582;
	Thu,  9 Nov 2023 06:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0F2704;
	Wed,  8 Nov 2023 22:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BXl1kMwLz/sGoIGEwLgEGx5mcxtY3G2PlZMGFZuRyVA=; b=yoaqgvv62kMFmdh1VUBaSSZzpI
	RMTRWk83IIt27cHxj180gOricDmleBMrquywNUboFnf3DHcH4/LXCj70LIZSqnD+j4Nn5iIwNnVXU
	vlveYKPt7+nMWHopxPm2acncfQwWqnBn7ofvD7meoFKvwJ7/vDiPLhhdqMfP3fh46ElJqlN9bxsEc
	n00LNPhA1WkISzSaHu3zyk1BBtOPJvnQb57PwfbxI/LS353pUquPczk2io/JwPnvkisgIxDpJEiiM
	5NqRMlDRrvhIuNyjYWL1vOMaN+5uftonZhl9le/JSFFMN1uohxAEBJ/5Qbe33Rid4bsasXY3zg4mx
	zNyNpiSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yv6-005RlW-0B;
	Thu, 09 Nov 2023 06:53:40 +0000
Date: Wed, 8 Nov 2023 22:53:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUyB9Dr8rOnmNwtH@infradead.org>
References: <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-atemwege-polterabend-694ca7612cf8@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 05:16:32PM +0100, Christian Brauner wrote:
> > Well, if we want to legitimize the historic btrfs behavior the way to
> > find out is if st_dev changes without that being a mount point, so
> > an extra flag would be redundant.
> 
> The device number may also change on overlayfs per directory in certain
> circumstances so it doesn't work in the general case.
> 
> Plus that requires a lot of gymnastics in the general case as you need
> to statx() the file, call statfs() to figure out that it is a btrfs
> filesystem, retrieve the device number of the superblock/filesystem and
> compare that with the device number returned from stat(). And that's the
> btrfs specific case.

Why would you care about the device of the super block?  You need to
compare it with the parent.

> For bcachefs this doesn't work because it doesn't
> seem to change st_dev.

Well, that's going to be really broken then.  But hey, if we merge
these kinds of things without review we'll have to live ith it :(

But maybe we just need to throw in the towel when we have three
file systems now that think they can just do random undocument and
not backward compatbile things with their inode numbers and declare
the inode number of a compeltely meaningless cookie..

