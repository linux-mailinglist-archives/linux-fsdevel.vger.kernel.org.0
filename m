Return-Path: <linux-fsdevel+bounces-74067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED4D2E0E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5991303B1B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB23043D6;
	Fri, 16 Jan 2026 08:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7523043C8;
	Fri, 16 Jan 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552220; cv=none; b=eAXPOCaojUP0Xe/3i+5ovH/bdOUB9uwRcJ6vF/yKnKAxiseG3NJVj2jBp+MuZh6tPe+vqyyGde8YScmKySb8TfzRr64LVdKd6qke0FVmFFryg967rFEe/MffPCBo4EQqJnqILA17f8P6XPQ5Ra8GCJ5IJsPl2Nm0rL/dsyRz2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552220; c=relaxed/simple;
	bh=2VtDB2SsRNUBa/39qfpgdYGNC8XFsbyVUJX50ASgVnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkPskaticlE9Ja1O7+/rSOBtpTxUhRwd+HI0ngMi3HF0ccre3Dxco59u8MCZQzGROC9pOgtKzY7WQ24fWAql+adNfQ12tmzeSofwVePZOv1IAkI8A7LDHIE4I8wjrd+9ueI9tmuuoXcfKju2nd9vjU0wNNT+u4DDnoFwmkldKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74506227AAA; Fri, 16 Jan 2026 09:30:13 +0100 (CET)
Date: Fri, 16 Jan 2026 09:30:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 04/14] ntfs: update inode operations
Message-ID: <20260116083012.GC15119@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-5-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-5-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  int ntfs_test_inode(struct inode *vi, void *data)
>  {
> -	ntfs_attr *na = (ntfs_attr *)data;
> -	ntfs_inode *ni;
> +	struct ntfs_attr *na = (struct ntfs_attr *)data;

No need to cast from void pointers to other pointer types.

> +	struct ntfs_inode *ni;
>  
>  	if (vi->i_ino != na->mft_no)
>  		return 0;
> +
>  	ni = NTFS_I(vi);

Nit: If you're touchiung this anyway, the ni initialization could be
moved to the declaration line.


