Return-Path: <linux-fsdevel+bounces-2344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533427E4E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738401C20A21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838B65E;
	Wed,  8 Nov 2023 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dyrs8TH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42159641;
	Wed,  8 Nov 2023 00:56:38 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11C10F6;
	Tue,  7 Nov 2023 16:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cuvgmkWOC2IuAeh5mDaz4oGbyGgrwHqcs+Lrz0SU840=; b=Dyrs8TH13oiU4C0vNJHCAJdpiu
	YUmALd21mxiaLBiPrw1Qc/6r8s63t86Yf/jG4Ex5d0LxpGrSgh+kUFV1iEljld1mkayPar8i0HXJR
	DapxwmM/tkU7BlxTORQ8LFgtCsrSgIPw3kouwsjgdIEGRgMavN4UsFO8TL3uQI60smXok37esGuxY
	lPk3A+NJjrEaDZGRXVyi/HmXCclcaUMd2eu73uy14QnpSMz+vlikVshW05H3YvBVPGXYle+F80pMB
	7FDHP4KVtcc61rEane4nMZ1ky9fp4REdfJp4w/Y9HI4EE3UG1web/6acUcKdpUXhPpvqblDSXmKxE
	Ncx0XePw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Wrs-00ClSt-3D;
	Wed, 08 Nov 2023 00:56:29 +0000
Date: Wed, 8 Nov 2023 00:56:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 10/19] rust: fs: introduce `FileSystem::read_folio`
Message-ID: <20231108005628.GW1957730@ZenIV>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-11-wedsonaf@gmail.com>
 <ZUq3nZgedcA5CF0V@casper.infradead.org>
 <20231107222257.GV1957730@ZenIV>
 <CANeycqo9dpt6kB=5wizKXAF0bZLMTBr_p5QR+NB53_NDVe=agw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqo9dpt6kB=5wizKXAF0bZLMTBr_p5QR+NB53_NDVe=agw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 07, 2023 at 09:35:44PM -0300, Wedson Almeida Filho wrote:

> > While we are at it, lookup is also very much not a per-filesystem operation.
> > Take a look at e.g. procfs, for an obvious example...
> 
> The C api offers the greatest freedom: one could write a file system
> where each file has its own set of mapping_ops, inode_ops and
> file_ops; and while we could choose to replicate this freedom in Rust
> but we haven't.

Too bad.
 
> Mostly because we don't need it, and we've been repeatedly told (by
> Greg KH and others) not to introduce abstractions/bindings for
> anything for which there isn't a user. Besides being a longstanding
> rule in the kernel, they also say that they can't reasonably decide if
> the interfaces are good if they can't see the users.

The interfaces are *already* there.  If it's going to be a separate
set of operations for Rust and for the rest of the filesystems, we
have a major problem right there.

> The existing Rust users (tarfs and puzzlefs) only need a single
> lookup. And a quick grep (git grep \\\.lookup\\\> -- fs/) appears to
> show that the vast majority of C filesystems only have a single lookup
> as well. So we choose simplicity, knowing well that we may have to
> revisit it in the future if the needs change.
> 
> > Wait a minute... what in name of everything unholy is that thing doing tied
> > to inodes in the first place?
> 
> For the same reason as above, we don't need it in our current
> filesystems. A bunch of C ones (e.g., xfs, ext2, romfs, erofs) only
> use the dentry to get the name and later call d_splice_alias(), so we
> hide the name extraction and call to d_splice_alias() in the
> "trampoline" function.

What controls the lifecycle of that stuff from the Rust point of view?

