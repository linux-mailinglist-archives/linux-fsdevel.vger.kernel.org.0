Return-Path: <linux-fsdevel+bounces-74383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D4D39FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BF03035258
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD52F6183;
	Mon, 19 Jan 2026 07:28:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831872F12BA;
	Mon, 19 Jan 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807688; cv=none; b=CchlVOrjfPVAP7ZHwzM9deEnNYkdehWD9Joe1kKkLzJeIbkcKltbNK5MdN2qaoeGmdcHwC95T+WguUtgrNB+1HMO7f8ldu3FTobsvNIjJhXhUg3JvY/mOAFmGivrMLp4jnxnxKIWNxZMbqjZUL70HWeV70WzQ+mjt7FReyd1bFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807688; c=relaxed/simple;
	bh=AFg0K9/lVrF33QZ6EH4vxFe65XJulJFmdoLWIU6522M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IATtune3vnK2PEX1DaLuEtKdCJcqSKyYKm4naewYY3kXUW3gtUU6uX6mMBlASZQKfD1KCHnaS8juW4MMWPFN5Iomcdpy4JYiWrLFcRcVCnvYuv4tb4qIl70z3IBQaFXh3naeTVOma3w3Aa16zwGXF7cS657INRUP8XRGP5W3mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71D1E227A88; Mon, 19 Jan 2026 08:28:02 +0100 (CET)
Date: Mon, 19 Jan 2026 08:28:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Message-ID: <20260119072802.GA2562@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-3-lihongbo22@huawei.com> <20260116153829.GB21174@lst.de> <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com> <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 09:44:59AM +0800, Gao Xiang wrote:
> But I'm not sure if there is a case as `#if defined() || defined()`,
> it seems it cannot be simply replaced with `#ifdef`.

They can't.  If you have multiple statements compined using operators
you need to use #if and defined().


