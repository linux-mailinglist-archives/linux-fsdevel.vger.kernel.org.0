Return-Path: <linux-fsdevel+bounces-18513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAD28BA02E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A691B289651
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF384173335;
	Thu,  2 May 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s1dmyspa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF95172BCC;
	Thu,  2 May 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673879; cv=none; b=pL+DNmMAvgcC39TYtiLDIPJ2Ft6s5s9Q0XPq4cqKgfzzuJHwGGNHUGPGC6ehM0+WU8tATaIKKsn1ENq4dIEl/Ml3LslwDRf+o+tSEq39o79CgpJH13wcEkyRt3xIVKBq0GRaDSqWLTL8XyqVW83UsGUqh84aLw7N9DhGqmMzrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673879; c=relaxed/simple;
	bh=E2/Y6J7NstGDN5G+OLb9BK9JxiFU3j74+Vpxh9Lgc58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWg1CscauaPLI+0dW6QDu8HDX77LsIfzn0l1uCcjo0YJAO5WFPDLU8rFcY/9PzU8ZIioeN8jHc0depkYaxVxhk5M+BZfvPygDwwPg+xhz6nFLWY7x2+98EKleVLTNEJKwq+CeCAD77v43Y4OPQXkq1z39IMi9mrRh35NAPdtOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s1dmyspa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E2/Y6J7NstGDN5G+OLb9BK9JxiFU3j74+Vpxh9Lgc58=; b=s1dmyspa6Avs2bch76r+b3luAo
	A2PKXmXrAp+abshWjuWyXwHTkGYD279gFWFCY6mEx/d5SQ+i7b7a/SNIwYIW6r8KKvGMVQn/zUUwx
	7nTmEY4Kx+LHI5CSxKctd3vT8PF9fR/c2PZctXLWg7nKgtq/drT5ZU/AuXXvoetfuW/8tX1xlIKkC
	fi7LYYAFrK662zZY78ZYcQG6cSYjVihE3L9OnbAuO6uXxVpG+5yD6HtEIiGaF/LE5mB0DoNB2qrEd
	OJyT8oEm2YWDIyM84feYXvdfh2wINmI84S4HdVCBA6DCPyQEUunLFjgGaQvxn6WZl/0ONNYjL2z/+
	wMIMg+/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2azc-009cti-1w;
	Thu, 02 May 2024 18:17:16 +0000
Date: Thu, 2 May 2024 19:17:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Groves <John@groves.net>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	John Groves <jgroves@micron.com>, john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
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
Subject: Re: [RFC PATCH v2 07/12] famfs prep: Add fs/super.c:kill_char_super()
Message-ID: <20240502181716.GG2118490@ZenIV>
References: <cover.1714409084.git.john@groves.net>
 <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 12:04:23PM -0500, John Groves wrote:
> Famfs needs a slightly different kill_super variant than already existed.
> Putting it local to famfs would require exporting d_genocide(); this
> seemed a bit cleaner.

What's wrong with kill_litter_super()?

