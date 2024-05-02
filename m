Return-Path: <linux-fsdevel+bounces-18514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153E8BA042
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D191F2429D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1817334F;
	Thu,  2 May 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wks69KRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62916FF50;
	Thu,  2 May 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674258; cv=none; b=cCPNSfP89+VCdqGNyQdUqrQvcWb9xvTCOKvGh+4fiRouU+9eVWW47fBYKQLJlLr3pisPyKdlmU13X/GNdh/Nu/LHoz1fVVOg8CkW3Yt/xbkigptDKJa1njVLom6dLohVz8b43BYL9PtZ/eyAVPMSYXGVeWosh9E57C9n7YpySXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674258; c=relaxed/simple;
	bh=ylWnqEAvyEPIc7SRwZTXG/C5/yblx7yHflIdhEkEBI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLbtTpKQzAACIIZpOD20FU5LzZRoSILdNjCK3fiMOHOZUZLKi9enPHQtQa6oH5F8bcXu4jwTEzt+cZALVSmFH5tyvCmHPXFSrFaf+/TEqiToUwwJTVaYctoGbg5zdBNF808mpoy5bVlEC/y8w7cWc7dH3dgOeKvUEIbwhpdn+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wks69KRw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OItBiYM5ob5YgXgkQ6abRqbiUvcg7Ar2dwHm/F2y9hU=; b=Wks69KRwLVADkkQwyu3MAFQc+r
	5l4UOtjB0kNAzHV2QkWq4viz2G1Wp4JXY87rMZbGKDBugzrb6BZAS6Zsl4i5wzQpg30FIT5UQ5v3W
	6T1BF1ZUcftoesCK6MsqMY2dPLt0iGILpEhJlsdT2E19tgWlB6t62W7j1VBJC5zCK5wO80IrkrUcU
	X+fSTHaeSJ0FxE0L30QM3ekCFqtF9FZl5v92iteUosgih0w969rCrmdLAJOWNYbyWe66QG9BgT7IK
	lrHmj7aho3QeE/Ik8vdoySLcG9QxkD1dCN7bN6UfVoftP4v+e/LSpE3DdUYx1VOelvAIpNmqDa1m+
	o4O/ss1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2b62-009dDH-3A;
	Thu, 02 May 2024 18:23:55 +0000
Date: Thu, 2 May 2024 19:23:54 +0100
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
Subject: Re: [RFC PATCH v2 08/12] famfs: module operations & fs_context
Message-ID: <20240502182354.GH2118490@ZenIV>
References: <cover.1714409084.git.john@groves.net>
 <86694a1a663ab0b6e8e35c7b187f5ad179103482.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86694a1a663ab0b6e8e35c7b187f5ad179103482.1714409084.git.john@groves.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 12:04:24PM -0500, John Groves wrote:
> +	case S_IFREG:
> +		inode->i_op = NULL /* famfs_file_inode_operations */;
> +		inode->i_fop = NULL /* &famfs_file_operations */;

Don't.  We should never, ever store NULL in either.  
	inode->i_op = &empty_iops;
	inode->i_fop = &no_open_fops;
in inode_init_always() is there precisely to avoid doing that.

IOW, the right thing would be something along the lines of
		/* inode->i_op = famfs_file_inode_operations */;
if you want a placeholder for a patch later in the series - or
simply /* methods will be set here in a commit or two */

