Return-Path: <linux-fsdevel+bounces-50848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C15FAD042D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA5C3A9AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029E1A9B3D;
	Fri,  6 Jun 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vEgwYKXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9E12C544;
	Fri,  6 Jun 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220864; cv=none; b=FtVm5q8xnxIISyUMdVISYJo6+pH5Dh3Daq94aOxrHzVtOWfUN2b5tx6naKjv4353McB6qfI8AeCqrQvRaTqkjgCearloPzhxG6adYufldmxtduscBNrUM++W5MdBa/EPGjHrny6hTivo1Yya9UDmQT1hvC6DF0GLBpBwuBNA3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220864; c=relaxed/simple;
	bh=i6yRDhrgT2/zq3iSXDElxzAsOnMwawV20rQ7HStxa3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlhEage/+ho0C29RRaCbgYNSDfNXDI2H8k5qq+RlRt+KxcTEkTdEeRSu7pM2nXUVYiW1yerD7KHHuuqDmSqQJ7+a8HfwBNNw8+ux9whjvcIV0kK7nYA/Hl0UMZOhgZd0PZrq8NRMM6KxtWiRnRdnx8gI3Detvjpvr1dilYgRKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vEgwYKXW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BUMSe0tFWJRLz9VwcNCfytngVWsj4oVCG4RF0FGla5Y=; b=vEgwYKXWIxvqi2qfBNwslK5vx9
	VsPxPYEQeWsRX5tCPp3P5OFJxKugVlpqYPEFHnzLNTOKVEBcYfIYdwZ0BrM6RYJECMp9T8jN3lO4+
	Jsl6UzNw/pudNpkER7f6ou//01Wf16scHrGG1fChyR4eUJnVC0U3gIMew+NcR9Ab6zh2f2STtFwFt
	F87GCBGHHwS8dTqGei+wOgXnT6Q8DCvLPuVgW6wgUncgyHXcf6ASCgolmOMJoCmXEeBQmmmGsuojL
	wX/aYEHk8mYjsJQE7NIDj3oWM3g5GZLWQh7SXZgrygHk/5mFP7McpL1BN6do31ucnXBs7Sb5XBz8L
	hjZcZM/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNYFe-0000000HDKS-17Ib;
	Fri, 06 Jun 2025 14:40:58 +0000
Date: Fri, 6 Jun 2025 15:40:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net,
	gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 1/4] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <20250606144058.GW299672@ZenIV>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603065920.3404510-2-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 02, 2025 at 11:59:17PM -0700, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
> 
> This will be used by landlock, and BPF LSM.

Unless I'm misreading that, it does *NOT* walk to parent - it treats
step into mountpoint as a separate step.  NAK in that form - it's
simply a wrong primitive.

