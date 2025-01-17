Return-Path: <linux-fsdevel+bounces-39461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E9A14832
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9E416991C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED0A1F5610;
	Fri, 17 Jan 2025 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WdgojwVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96571096F;
	Fri, 17 Jan 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080458; cv=none; b=sU6dTauo8qyRSqeC6WZKqqPPawaVmodSVojFFVjpN9G7vyz/yrMKhJ7K8zMDWAgYTDhtvQ49tJ0s2dmrFYSLGAMREz2B91QGWUHMO1TtNv0v3dkXQvTIH1cLvvBjQmvUpaPxm6nV5x90Pd69WJXEvPBgqS9SoDhJYLo3QWpLq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080458; c=relaxed/simple;
	bh=JBTt/Z9N7iV2G4ysKTG/4TQLBwC2L4Iv5ftPog5zH2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3ljQLHevNOz67CKkDg0gPyK1IUDGxZC7Zj4ZixQaJd1vDf65N5GHStou9NyjJ5rjbbeZUf8QljOWSqnWgwtJLZnUPPyhtDINPzCRvj1W8UWk0pl/XrvTR9h41rUvzF5td8rTJuSn75HVE0XSoMiAG25GJxamA8vDDZrs+G+4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WdgojwVN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R+0iTCh5BnZffFpeZ7Q9d0IL57elABKcSRb0Ed4n1rY=; b=WdgojwVN2p1xjODo/ipBJE4rzn
	bg3gKYAimrBl/UTfkCGfrpSlDR+e2rSF05rpXMR9evje4nBRBcXMJe+ma8ZKjW39HNAzKC9IrYwcW
	Fm9jnAP4cWZ261RT7ayFIEqbSVqAStb9l/JXSmvaRCRv2dyLDwl4HPL7NGApf5UHg+Obhf13J1wrv
	pLaW5fmleTteTTwQ6p5lM6xGpeGBZaa5vAtA9mepM0U/kXCTrfTmwTfNaon03ukCp2XSkEvFdegJv
	KrkjqRQklyyah1jjlvYgwYMG5TsqUuMyzyIWJPNvdQICGmqEYhEmzcwPQG1+ZOGAn/t4DE4012mmN
	/vuRuuSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYbyc-00000002pqv-33T6;
	Fri, 17 Jan 2025 02:20:50 +0000
Date: Fri, 17 Jan 2025 02:20:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	lsf-pc@lists.linux-foundation.org,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <20250117022050.GO1977892@ZenIV>
References: <20250116124949.GA2446417@mit.edu>
 <Z4l3rb11fJqNravu@dread.disaster.area>
 <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbe6vWS3wvmvTcCAQY6bZf2G-D6msgvwYHyWVg3HnMXSg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 01:43:39PM -0800, Andrii Nakryiko wrote:

>   - relative stability of tracepoints in terms of naming, semantics,
> arguments. While not stable APIs, tracepoints are "more stable" in
> practice due to more deliberate and strategic placement (usually), so
> they tend to get renamed or changed much less frequently.
> 
> So, as far as BPF is concerned, tracepoints are still preferable to
> kprobes for something like VFS, and just because BPF can be used with
> kprobes easily doesn't mean BPF users don't need useful tracepoints.

The problem is, exact same reasons invite their use by LSM-in-BPF and
similar projects, and once that happens, the rules regarding stability
will bite and bite _hard_.

And from what I've seen from the same LSM-in-BPF folks, it won't stay
within relatively stable areas - not for long, anyway.

