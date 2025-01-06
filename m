Return-Path: <linux-fsdevel+bounces-38468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A9A02F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5611885866
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE51DF256;
	Mon,  6 Jan 2025 18:10:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABE13665B;
	Mon,  6 Jan 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187006; cv=none; b=OHgUi7mGN/8ddETDWna1eJxMKTohamgEWGqEDv9qZYZdtSR13wA2CXSEjowX/2oS5Daq6MVHrXkZoP5quOzQzgaJszaPHKo08Ytz7btRvzRbMmqdsCqkScqChq/NVXiw0cyXsta7H0z01HvhPHdDN09wCNeswMp06FaugFoYb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187006; c=relaxed/simple;
	bh=ISmDF3NYXI+g/hdwPzPNHQ6RI19mtoJBjqx49TSulCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxvCictJV2Frzbz9CI2PtBxHUpOlP5T3DM5BACN/bn/jmc0+2Q8JRb6MO9e6yhVBq2kClA6gnEs/a34Rbv7cX+JNfgGX3EoVUtg5IG2x4fydMjXeAE/LJZ9ROkFzXozMAdDUeTzxPY/UxqHCyXL9mw5vlCnCH2cl+UKihzWz06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6569567373; Mon,  6 Jan 2025 19:09:59 +0100 (CET)
Date: Mon, 6 Jan 2025 19:09:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <20250106180958.GA31325@lst.de>
References: <20250106151607.954940-1-hch@lst.de> <20250106151938.GA27324@lst.de> <20250106174007.GD6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106174007.GD6174@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 09:40:07AM -0800, Darrick J. Wong wrote:
> > +stx_dio_offset_align
> > +which must be provided by the file system.
> 
> I can't imagine a filesystem where dio_read_offset > dio_offset makes
> sense, but why do we need to put that in the manpage?

Well, to be backwards compatible to older userspace the value put into
stx_dio_offset_align also needs to work for reads.  Given that there
were questions about this in the RFC round I thought I'd mention it.


