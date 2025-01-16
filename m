Return-Path: <linux-fsdevel+bounces-39421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A743AA13FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88D8188DC28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA922CBED;
	Thu, 16 Jan 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D7JMhbnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F2AE96;
	Thu, 16 Jan 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046407; cv=none; b=uV2RA53ZhIIPTsdMuWlqDArp3J6L/VUsUVty4e6xRT/u9da2n6sLyIXyBpwsxiRmClkQQ5A36xRRLonKt7JGw481QVeHMbIk9nQQvMHcY2eqF+ZtHmYoLQUwxa13dwg25BoDDsWf05gneBO/4E5UuqhVUoXvdhK8j2/dASJMJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046407; c=relaxed/simple;
	bh=DmAb0hg37d8agfMfK6DuQyqJA+dKjgyaQhYqW6WNrpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1DLQRKaVPief/vuY+pLMkmPpj7169FhJ6pxEqbWGEngrARV7IthGhPrnUcDzSz2p07SnbOVO3dqr97rupTUHgz1ekZZml02GTQw0IFgxeQ4gRDK8VcL1makrF7DEexXivjtRTweB1J3Odbzz19aRFhWv6TmYQXnALuWMz9cnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D7JMhbnh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AZPnt4u/63R23QX0Ew6hbU3z9/99bMabaVueXujsE0c=; b=D7JMhbnhC3GIOyeKH6ndRRE+fI
	oVzd2INUVr+uCTmJmolNO4RNQSp7fGZoG/lSq/QSLbtQaLeizPTCOeHLs1hdpdoXQHzCNxbrseMcm
	jecx8pG6OTr+CRetodQKQ9kEJ5Nj6HLyeSLT9d9mW4GH4Wuy1ColI8BOOfA1q8VLmN+IHEbcE2NHU
	MCOdGLDc/XHICNEDwIlD0z5680ypaCWHWg031ow5R5Yb9eVuxHplg1BCVSCLcAvuUxP6BhE1cdK5+
	p5M6Uy3SjLPY7V8y35+2BEkR7SMVpS036Iyzgm+IkpKqs7qXSyPEkvKpaL3uxH96J+22GZOPqe/CT
	9FX/2iRA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYT7R-00000002TVr-2QJ3;
	Thu, 16 Jan 2025 16:53:21 +0000
Date: Thu, 16 Jan 2025 16:53:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <20250116165321.GH1977892@ZenIV>
References: <20250116124949.GA2446417@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116124949.GA2446417@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 07:49:49AM -0500, Theodore Ts'o wrote:

> Secondly, we've had a very long time to let the dentry interface
> mature, and so (a) the fundamental architecture of the dcache hasn't
> been changing as much in the past few years, and (b) we should have
> enough understanding of the interface to understand where we could put
> tracepoints (e.g., close to the syscall interface) which would make it
> much less likely that there would be any need to make
> backwards-incompatible changes to tracepoints.

FWIW, earlier this week I'd been going through the piles of tracepoints
playing with ->d_name.  Mature interface or not, they do manage to
fuck that up...

