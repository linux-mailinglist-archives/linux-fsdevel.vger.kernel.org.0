Return-Path: <linux-fsdevel+bounces-37073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358C9ED1C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6132916486C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011021DDC13;
	Wed, 11 Dec 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f2A3wR7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBA1DDA39;
	Wed, 11 Dec 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934612; cv=none; b=OQSW9shCUUooktXGFFZX4SBewl0gCKjb5swR/btRQgVeoqjtr2GzozpCO0v9NVdvmT634hWCLGrbsNeeYgv4IyLFL1Yvu295GYdi4IANbUvbnEPvxsrVYonvqA30csiAucgo1qaIjrSVJTv0lcHJ8UEceTH4ezRR8jt6px78Ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934612; c=relaxed/simple;
	bh=m1Xd2Ttjwv8Ql6ASwyFJCC3LyTAaBmtGm4EwDWWwSPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPq019KBZZHtqBCbgpoQS4TEgdv2PSJaT+1cXY6AqPKEKe+EW7KBBuQ143YDGq6mzkojfCKyYIjjB+Jt9mxgcFbRtycHfjEtiI8Cwd9SX9sQP9gjmjFQZF3Y6szP6MGx1y0875t/9uEti03d7CPINCM8gdCjEFiKK+6cBmmW9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f2A3wR7L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m1Xd2Ttjwv8Ql6ASwyFJCC3LyTAaBmtGm4EwDWWwSPk=; b=f2A3wR7L4U9IhsRbVEYP/wsR4r
	ZURPs1NEhz1PjyWpjAFpCSDulJ7ricFHjDdg9gBZG99MlLWIdY9EMZzemVYV7ucgd4tWMiYBpL0a7
	B8L4a2lCG2fAGay53XqOWJDqIQ5zZi901yxiJNNhyC2qNgmm/cCRy4+NCQ8uSAdk041P0xDs5Kyg0
	zLvI4tFAGcEQLfepiHjgCGEEhzsR5JvPq3IfWD2lCjp53dXorBrrgPGx8250ftVp53ZdU8dFN4iBL
	tyAB+K7ynOymnYSlE+/kn59VITQtFFcQi1x3nbBXQ5YRlK4D7TbFVd9eETRQX7b6UFO9VWjLx87fO
	9EqrkCxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLPbD-00000007HJq-3Mgu;
	Wed, 11 Dec 2024 16:30:07 +0000
Date: Wed, 11 Dec 2024 16:30:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix is_mnt_ns_file()
Message-ID: <20241211163007.GG3387508@ZenIV>
References: <20241211121118.85268-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211121118.85268-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 11, 2024 at 01:11:17PM +0100, Miklos Szeredi wrote:
> Commit 1fa08aece425 ("nsfs: convert to path_from_stashed() helper") reused
> nsfs dentry's d_fsdata, which no longer contains a pointer to
> proc_ns_operations.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

