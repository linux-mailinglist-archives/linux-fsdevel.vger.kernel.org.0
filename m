Return-Path: <linux-fsdevel+bounces-18515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F148BA08C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5281C2277A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F51A0B13;
	Thu,  2 May 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s37Qe4Sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C217B4F3;
	Thu,  2 May 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674579; cv=none; b=TrDeln8X6SPajPQ/k6KZVxRbz7nhBE6S237RCGKmWEgMC/3c2tp63bM+18zUdPObBodtoaFwhSAapE4g5VIoT0Cdl4Xi15T/29FNEBAlS39fhmNAWLK+trAhi1G2G8K3xSSmmfmnisjefMCFmcRwoSk0rPF79jEeUHDdH1lXIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674579; c=relaxed/simple;
	bh=n9wAFg7ArJZyYeoIbQJLeJ0JAPxeyk3nvUQsM+OediM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3coLk3t917gJeVeWnwinWaK2tMXcEQVF/Ff21oDJKnZHdeSmP8Ng/cfU72LqNFHBeW/2p0Gi7Z8cWA+BX9UnarR2e3hLzye8+h38+U1vafmaCPhshxlJngWGSSzVvlitALYb2BcAN7jiKx7vhCYeZCHEP1vU4WgvvYC3EZDjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s37Qe4Sx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h5sk8LNA2G99FVrO1CPwUk4qXbxohKMDilL9oo/KuyQ=; b=s37Qe4Sx/9fEEjKGVG8fSm1mji
	rlgji2926uZvD6z9e6MYMCwSiPfka7ZP9fOKcPe/l0czLhwwWVuJIrMpfAmnz044AahICjhackJdo
	6RtIaJPwxzoDej6D5Tfxwy1EpVsfFPrvwlYs5qda3gL9tftRJLDalAQkgU/6Z1vzv0N0cL1kqwbkP
	RJK4Z1jUuhmQ6byaXIegdWEkV6QPfDPt5Zdop75sM62rORyVWRo6Gmltou4XWB2yd+0BgADH6U0cQ
	Apk0yiI7SZmQJlYw6c8buwo445QKJbgStrw1KN4nhQLkKtZz1sgAvum15GLv5dqMdrK8B8OU4ZOC+
	6wsBoiEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2bBH-009dTw-2t;
	Thu, 02 May 2024 18:29:20 +0000
Date: Thu, 2 May 2024 19:29:19 +0100
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
Subject: Re: [RFC PATCH v2 10/12] famfs: Introduce file_operations read/write
Message-ID: <20240502182919.GI2118490@ZenIV>
References: <cover.1714409084.git.john@groves.net>
 <4584f1e26802af540a60eadb70f42c6ac5fe4679.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4584f1e26802af540a60eadb70f42c6ac5fe4679.1714409084.git.john@groves.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 12:04:26PM -0500, John Groves wrote:
> +const struct file_operations famfs_file_operations = {
> +	.owner             = THIS_MODULE,

Not needed, unless you are planning something really weird
(using it for misc device, etc.)

