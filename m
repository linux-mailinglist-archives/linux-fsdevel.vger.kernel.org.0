Return-Path: <linux-fsdevel+bounces-877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C37D1E69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945CA282043
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4E1119C;
	Sat, 21 Oct 2023 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h2bJcLEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E3DDB9;
	Sat, 21 Oct 2023 17:01:25 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C6F4;
	Sat, 21 Oct 2023 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cJEQZ4egf/92ZN0ghYzh3JXkRsrD00uyIGEq6ofiDw8=; b=h2bJcLEgxe02BEhgihox4K+jYb
	OrdzE4kgxNccFDOYf71pe70fCbZ9SMKUdmdlogGt93TETimEyXkJSp4+psSALyPX/h+DSJat8HJ5G
	eOeEtLosXJNLw1fikVd2vOXXTWZEUgjTLXrppmEgGcUG3QvgJEvdWjuW/9HGj1neSGItAmb/43Ilb
	iIvIOL8gGPSwxis1RvFf4uVr4XO93yBQdgCMU6hqlfNZ9EpecgqZYqbXv5MSm5Nux+yjrjngbhQCN
	CSDHywibmb39nzIUb67ow63gHZwlxxlAtSt26xFIazPjtTLkX5tsCqPH8lpFXb5kbrCVlIq4AROtS
	BB6pf+mA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1quFLS-002ilz-Ec; Sat, 21 Oct 2023 17:01:02 +0000
Date: Sat, 21 Oct 2023 18:01:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZTQDztmY0ivPcGO/@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
 <ZTHPOfy4dhj0x5ch@boqun-archlinux>
 <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
 <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTP06kdjBQzZ3KYD@Boquns-Mac-mini.home>

On Sat, Oct 21, 2023 at 08:57:30AM -0700, Boqun Feng wrote:
> You're not wrong, my suggestion here had the assumption that write part
> of ->i_state is atomic (I hadn't look into that). Now a quick look tells
> it isn't, for example in fs/f2fs/namei.c, there is:
> 
> 	inode->i_state |= I_LINKABLE;

But it doesn't matter what f2fs does to _its_ inodes.  tarfs will never
see an f2fs inode.  I don't know what the rules are around inode->i_state;
I'm only an expert on the page cache, not the rest of the VFS.  So
what are the rules around modifying i_state for the VFS?


