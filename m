Return-Path: <linux-fsdevel+bounces-30203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A22987B06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33E0286E15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB3189BA5;
	Thu, 26 Sep 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="STgj/2H9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6218991A;
	Thu, 26 Sep 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388512; cv=none; b=rezFAnykkIoA/lE4R7MMnMM0oPpV7MN9cl+jS4PVOyJRGMhClZQ/nqXqptvoCjGBjRQn5xstwkAuQKrPLkX4GlRLX6UoF0Onh5iIj/wWofM6uLV9Mnny9Hyac5zFxfGNllKPXIEBgun+n64lZvv35HFGKLAXGrhCrEoY9JwJBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388512; c=relaxed/simple;
	bh=SEcyKZhUdqyvT/a0YMGjgny0uLX7fCadLutERnzCrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf+roGOKKMM37N8JK47oFc8+ZfiyAZBckxJMVAXzuamW7fhTz1cey/YAiC3GYPHMpLKEvMLGpe1W9wgkHv07QpfVK5tRjRM+dcud5ofgtRHN9q2jgx2UfsVJhA5SuW7sdp1kta5wLkntoB+YxwgQYXiKvjtKFB9wR/iqpXV6CwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=STgj/2H9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iSRgFKCG9F0JO0YOzBUN908kFzxuI0PQwnx9+5kbiSw=; b=STgj/2H920gV0pTP7QbaJhpcMF
	NQfUOGnmBqKc2pHmYDkLNdKk9pFuF6Q0thBOWoxSoNrl0lGcTQDn83BEUI1AcK8DdicAaUULVG5zO
	O9SKrFeK88XCW+mD1+OsEGkbzf9W7os/85XgLDVIEpgdf45RZNdLJ1MMrL8jqs+LBN2KCK5eTDlVR
	UR2DfGlT9pqCEoC+zTOrJiEXPhXXlEYZTaa9HumBiI4BaYsTV8Vwp5rzyLY6Nww2cM/0+5v/Gy/bS
	wH3xEqWer0N2VNKT5uXD5z0Xi+cBKUwf5SVDSp+TsGKAg899qiYZNvjCcD1eq9OekTZ54VyYNuPIQ
	mb7v66qQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stwer-0000000FnUw-1JsK;
	Thu, 26 Sep 2024 22:08:21 +0000
Date: Thu, 26 Sep 2024 23:08:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
Message-ID: <20240926220821.GP3550746@ZenIV>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 26, 2024 at 02:58:56PM +0000, Alice Ryhl wrote:
> Add accessors for the file position. Most of the time, you should not
> use these methods directly, and you should instead use a guard for the
> file position to prove that you hold the fpos lock. However, under
> limited circumstances, files are allowed to choose a different locking
> strategy for their file position. These accessors can be used to handle
> that case.
> 
> For now, these accessors are the only way to access the file position
> within the llseek and read_iter callbacks.

You really should not do that within ->read_iter().  If your method
does that, it has the wrong signature.

If nothing else, it should be usable for preadv(2), so what file position
are you talking about?

