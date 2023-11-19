Return-Path: <linux-fsdevel+bounces-3170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008007F091B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942C2B209B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 21:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1841614F70;
	Sun, 19 Nov 2023 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GhHe25Av"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6DE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 13:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pT+V7kAPtRPjewuTj5A9OhUWljqsGYnraOTy8eAk7ZI=; b=GhHe25AvVS7MbpW8FHxBw8zkm9
	mlwEWxkRiq1gmwZEbSNIiK90OP2A+LasWTO7UdkUo8gBsJHG41xDDPmura9od7ews1Gjk3e6pzdIQ
	xxhD40RDOPhI565+E4BIG9F57Z067/uJsoiMC+w4DJ7MIpIOQzbMRH1XJVNW0ezXn0iZ5SNlFv7I1
	XcmRvEpOyEgplZ2iIPRdq5Fnodh0iBD/DnD6GSWK2qVuq/GUVLy6+TaJQc6Yqm2wHLAlpu/mw7dJI
	TmlVGQbVDXcuNhXxDGoJAyj+SC4ehMya594QVe+j8Wpeyle3XdMDZf6KtP39qR7qwZTcsQELML2AD
	hyIQ93rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r4p7P-000PMc-2q;
	Sun, 19 Nov 2023 21:14:15 +0000
Date: Sun, 19 Nov 2023 21:14:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jeff Layton <jlayton@redhat.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231119211415.GB38156@ZenIV>
References: <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
 <ZVk2m1scRfy4Xq0C@tissot.1015granger.net>
 <20231118233626.GH1957730@ZenIV>
 <8F8B8E49-7AC9-4ECE-9CAE-8512D9C1DACB@oracle.com>
 <46914DA1-E529-43FD-97B6-F995AD933156@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46914DA1-E529-43FD-97B6-F995AD933156@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 19, 2023 at 08:22:30PM +0000, Chuck Lever III wrote:

> lockdep assertion failure
> 
> Call Trace:
>  <TASK>
>  ? show_regs+0x5d/0x64
>  ? offset_dir_llseek+0x39/0xa3
>  ? __warn+0xab/0x158
>  ? report_bug+0xd0/0x144
>  ? offset_dir_llseek+0x39/0xa3
>  ? handle_bug+0x45/0x74
>  ? exc_invalid_op+0x18/0x68
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? offset_dir_llseek+0x39/0xa3
>  ? __pfx_nfs3svc_encode_entryplus3+0x10/0x10 [nfsd]
>  vfs_llseek+0x1f/0x31
>  nfsd_readdir+0x64/0xb7 [nfsd]

Lovely...  Said that, file here is thread-local, so all accesses
to it are serialized.  The same file has ->iterate_shared() called
without ->f_pos_lock a well...

So that's whatever serialization between ->iterate_shared and ->llseek,
really; for normally opened files that's going to be on fdget_pos()
in relevant syscalls, for something private it's up to whatever's
opened them.

