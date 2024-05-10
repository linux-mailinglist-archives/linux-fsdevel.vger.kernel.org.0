Return-Path: <linux-fsdevel+bounces-19231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73788C1BD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 02:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64883B20E59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10864A33;
	Fri, 10 May 2024 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T3WiZ4yo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278967F;
	Fri, 10 May 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302156; cv=none; b=T4jrYTXAt0u+N7dxjW2b9b4xNpgWfLRJTK859h1J1FAxfX65Ped7r5cHU0MPxCkUzBSGFeEJqXYbYofH2Twekrhqj3sgJCAZQZfbO33/KFjLXB10sdPo40Zd4NaCG6qJHPM4nsqe30XKuASFZWUGwJcYPy0+Abb+L7pG83t6jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302156; c=relaxed/simple;
	bh=qYhCSYTs+qCd0PpT/L634psqhkgm3QsohLmZ2vDK6WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RApezEPMt14SRJaWroxl8MAMqA1c4/gkRCuJg+2VpK8Or5N9yqYHF0UP9YcZ9+QjIT+7DV3UO4NJ999acJB3gEuZdWljswC3ukoS59tJQ3SCZNhgcm2jNCPgZmIRZr9XIO6RViCp6kU4xsr5+uaj5GOF+GR10TFDcNO91fXwWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T3WiZ4yo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fJHHsV9OVYCdiIXyI2ulel4nF4HT9OKeM/HlpsXG0Gw=; b=T3WiZ4yoTea+vAJZNjsd0wzHq9
	9STf//iLal1+tt75yZwzT+7q2LWK4trDJGyeQmhOS1dxvVini8GlYKTz+td9pl5SaeML7g787dLex
	4FqveDpVNvQbmTRidJvfONiFCR168ZHbLeoI7AGqUF7JTZGWp+W+yrYU3RiY0PL+wlMDAvOzqu9ui
	YBJP9GsjbZyPo2UCB90ITMBvp0UVHBgK47wdODadZFDdMuQTPpg8P/WSnH5T5pEpSkZfepyNcbuD1
	93ZRSsoE7j6YSOJt6XR2VNBjG15BBh1iNd57HPyat0RPidSPGXiaObnmZyAX+USMG/e2xNU0NXPF/
	jLe1APfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5ERe-001tr2-0H;
	Fri, 10 May 2024 00:49:06 +0000
Date: Fri, 10 May 2024 01:49:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <20240510004906.GU2118490@ZenIV>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 12:35:51AM +0000, Justin Stitt wrote:
> @@ -147,7 +147,9 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
>  	struct dentry *dentry = file->f_path.dentry;
>  	switch (whence) {
>  		case 1:
> -			offset += file->f_pos;
> +			/* cannot represent offset with loff_t */
> +			if (check_add_overflow(offset, file->f_pos, &offset))
> +				return -EOVERFLOW;

Instead of -EINVAL it correctly returns in such cases?  Why?

