Return-Path: <linux-fsdevel+bounces-18162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D37718B6127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F79B20B62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D212A15B;
	Mon, 29 Apr 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkZM1CiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA983CBA;
	Mon, 29 Apr 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415598; cv=none; b=KI7HEqmI+BwJfD3AEKBzUO7c7FSAS0q2EidwqUIw0eslf2LLRdeGHkLvu3/+5rHInMbyAcUFSaJSrepWNlqkcd2TMDysNMDvGHfA1r45ichiNstuKlLjWmsIbeh19+rx3yDPHm4pio+6bnmWgPdC+DZy8IEFTs1oaSXrswCdf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415598; c=relaxed/simple;
	bh=xov9tAkhLOXeCB+WD3NWGD5AwHFHUPFRmN2+drO7IB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWRLuHtCLOeLmsei9SUpg4Tt5H6kxnd/lo8JXkFqaBvUYuZrPpYkiKylpvbuSl/ulRCy3Lh+rlLwrBJWClatroNK6Bgjlv35sib4kZfY6med1xBrEdjQT4pZrgqQed5x+fjdxTDau8DsqctjTUc4o3aNRA2rOlkmlRNa60X4Zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkZM1CiL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LzzXmwpqAaEN6zdIzmyjeSPaAsGThfmjHzWLfMPg7QQ=; b=dkZM1CiLRkoFeNKGw3uQgzL4m3
	2YEh+ntJZ2DyX37lquIlKtMTjYY/DLWyX9zuwdIIG8UFQ6BnaWbj7vQ0xe74GLBpxuhsmEhENEg/p
	N9s0FLEdZ5GWRUsOepsoQaZyxWtV47veBQo/nU69R0knmTXLFIn2a3z3+HvKLgBQKeCL0tJSkn1v+
	yHFI0+IkbQ1LuGLOiT7o2PGH7NkLe3U4z+S+Aw/fUNfddBs8NyDMt5yOwPwtolSX3sHBoYGtLp6F4
	o8smsFJWZmTQvAoZBqmK8SnxiAXHRH9Mly7NmjcYmMXt/3o9gnpFHYIbYtz2+VBu8zombwgPPkeG2
	/pUG7xcw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Vo7-0000000D4zN-0qT0;
	Mon, 29 Apr 2024 18:32:55 +0000
Date: Mon, 29 Apr 2024 19:32:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Groves <John@groves.net>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, John Groves <jgroves@micron.com>,
	john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com, Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 00/12] Introduce the famfs shared-memory file
 system
Message-ID: <Zi_n15gvA89rGZa_@casper.infradead.org>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714409084.git.john@groves.net>

On Mon, Apr 29, 2024 at 12:04:16PM -0500, John Groves wrote:
> This patch set introduces famfs[1] - a special-purpose fs-dax file system
> for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> CXL-specific in anyway way.
> 
> * Famfs creates a simple access method for storing and sharing data in
>   sharable memory. The memory is exposed and accessed as memory-mappable
>   dax files.
> * Famfs supports multiple hosts mounting the same file system from the
>   same memory (something existing fs-dax file systems don't do).

Yes, but we do already have two filesystems that support shared storage,
and are rather more advanced than famfs -- GFS2 and OCFS2.  What are
the pros and cons of improving either of those to support DAX rather
than starting again with a new filesystem?


