Return-Path: <linux-fsdevel+bounces-42210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D5A3EC2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 06:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D467AA5F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467F1F3BB9;
	Fri, 21 Feb 2025 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvtV3BLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D550134A8;
	Fri, 21 Feb 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114970; cv=none; b=NE2++Z0NOLMdHdZmF7gz4+2yMyHcQJF50Bg9vM160VyqjapGzW+JW/Vus/n2dW/zoBAJpe6h9Dr+UfR74NAgWT7JSN/3Vpfzs9AhBGK1NHN/5pc/l5mmMEvN60GuimqOoKJjn5T3iY4rViKdDnT7O18u+erDYiHdrNbXyny7ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114970; c=relaxed/simple;
	bh=qyKx1Uio48EpW8mmolxwvCLrQvqI0ZmZ7qaTipsK/c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRKekzkq1X6UzzOEeJ48pNNOZ4U+8s0Kwut6oSwnuqIJPbKsLHVnK5Jw4cp9A7DNGrvWL3x6pR6T3CdOLbsMelp3ZS39u4n9y7Bzsj1iW+8dyW5EKigjzteFErFIohIwH2omVXZC/GRRu0vlTB2sJ/+U5pyYsT47ulhq+iBKMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvtV3BLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB08CC4CEE2;
	Fri, 21 Feb 2025 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740114969;
	bh=qyKx1Uio48EpW8mmolxwvCLrQvqI0ZmZ7qaTipsK/c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvtV3BLvXlDq8Jatlgcn9Cf0azHX7ljoo54+qZfrlSYIlY9YOdeKP7z/bxU0H2Dps
	 TNw4tdQSEVADb96Tjz72gZqY7VIWBkp7PHr0Z1VsjJCqKbWTelolVh0kPEbsPZ1IVL
	 a+Ajtn73L7U0dS5E72g7mGvskXLbExwioYL9mDTf1J+P6ZGw2zK9Dz5/qestKHDnxu
	 q332qLHKJhuXKDf3tWHN/3BPqPX3IwGGE6+6GDCxwi4xovgDouZWd8vjszkbq7WfwT
	 Y0GbwfdO7JArKmmcALMzfsR2Vkb0Uv/4kBOstq/eZvnEkWvXa7nJxSNJdIMeKuI3Bw
	 59BFdwIfJ8lHg==
Date: Thu, 20 Feb 2025 21:16:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <20250221051607.GA1259@sol.localdomain>
References: <20250221051004.2951759-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221051004.2951759-1-willy@infradead.org>

On Fri, Feb 21, 2025 at 05:10:01AM +0000, Matthew Wilcox (Oracle) wrote:
> ext4 and ceph already have a folio to pass; f2fs needs to be properly
> converted but this will do for now.  This removes a reference
> to page->index and page->mapping as well as removing a call to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

It's still assumed to be a small folio though, right?  It still just allocates a
"bounce page", not a "bounce folio".

- Eric

