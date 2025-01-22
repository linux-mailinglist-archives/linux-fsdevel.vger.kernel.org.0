Return-Path: <linux-fsdevel+bounces-39820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D9FA18BAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 07:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409213ABDFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9899191F99;
	Wed, 22 Jan 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDP9PhoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E132EAE6;
	Wed, 22 Jan 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525944; cv=none; b=ATYJG8dNNBygWIz811VJ2DD275yDzR97Yc1Op6QrC+sGfDa3DgMsSLlnjw/O8Pv6MbBSPINS1pkAH/nqfFNKL97aWcmb5VZUKcgLBV9E8Pk5GGi34KI7/ySbyvG4TX3fdVeq25ODIfNqEY9zp6Gcu2TLeWL8Be2q9H7cZBtke+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525944; c=relaxed/simple;
	bh=C8xb2q2wb/qdNRvZ0IIAZ7pc/kza8Ocaz92/GhCLNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdC2DYT2z1HKxtOqsP4e66ZHaE5tYjzqY6I9S1WqoYtF275zrp9xY82hC52hKkqehXtSfq1DnQ12VGHyqIfZQSAT1q0kiwIuxh6kDhCaohkRS8a9IWU/0MuRivgqxNECCM+incxTKOXo17dCOlPiNBE3MOGcZJltncM9hBqi0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hDP9PhoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3c8fMqRFp7W4ULSrZsyUXZR7MWnLpaFuVa0XgO+nrMw=; b=hDP9PhoZChUBnCxrL+JSAFsrWX
	/P+Dbvdoc7eyiClKSj8lwaqnsubYlmbrZ6odfGTnbtuwv37WZdODDe7ByFOYTn10igIu5tSJEglpm
	/65H80ETFBmMyQDZ8BNX8lWA9S7F5Uq4+svVIQXs1t+mgXuijJsJCJ9Tuj4isTO3VidloFkendZTn
	HEKVnMTo4oRAH8iNABuprQ0bW92KR5cej8YwmcimXvyDZVpiMdaTcI1KRKTx90os2GPj7Me7uk6w9
	Vknc21524ThrgQDVw26dMdkv7xgZyQbHwVMD8EKI0Bc4GQiyrZ4caWrUkNoE/vfErnIdZmEQyDrTf
	rLkhjRqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1taTrw-00000009SGL-1UrO;
	Wed, 22 Jan 2025 06:05:40 +0000
Date: Tue, 21 Jan 2025 22:05:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <Z5CKtOwB8ZsbX4N4@infradead.org>
References: <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117202112.GH3561231@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117202112.GH3561231@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 17, 2025 at 12:21:12PM -0800, Darrick J. Wong wrote:
> > Full disclosure - I have an out of tree xfs patch that implements
> > ioctls XFS_IOC_[GS]ETDOSATTRAT and stashes these
> > attributes in the unused di_dmevmask space.
> 
> [cc linux-xfs]
> 
> Urrrrk, please don't fork the xfs ondisk format!

Yeah, adding your own bits to any file system on-disk format is a huge
no-go.


