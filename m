Return-Path: <linux-fsdevel+bounces-57963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BEB272FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4558B722E98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977928751A;
	Thu, 14 Aug 2025 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EUeK9YVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFA284B26
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213906; cv=none; b=oxXnUgFdx1gamIQ8fkjRPX7oJuuU9esaGLOPUG8/UM4raDWW6TFxjdjp6m3fcKbt4sNksraD2PkXwmCbT6+cNJdUceZexYpM4Jvm+Ndp3oLRcNqNOsBaOKP3a1MG+9UKPQHnZ3aH6P5uoziokcKfaguin2r+yOg14P5qwoiRawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213906; c=relaxed/simple;
	bh=i8cpnedLJzFT1jT8Y6BTsTyqYETnhM8JRZmtOFli/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcLU281dtCHpr5HkZT/SdNIJYV0njf6v/p+oFqi29pai3J+NmhuI8LrUpXYTrc48K3bu2oh6K+8aUYiEiW0lfi7mVin6dSI1buarihckapmDlCGS8BylpL9kcbqKxZevCTO/UeRc/GUbZvNkLR8YV+1+XEcHo0/6ElkwZPafTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EUeK9YVk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i8cpnedLJzFT1jT8Y6BTsTyqYETnhM8JRZmtOFli/FY=; b=EUeK9YVkk4RDM+T5QCNQYjckNt
	5Xk/ita6AVkam2MftKY1U+cfGkl7zT5+sPTVw8/y1K3w/UTgeBRGzN0eqWA+50mUHyf9KZLnd8t5L
	wLj9Oi0S4hwPhCrPua8pVGaP3f/mtp8Yr85KWifxQLWO9MXilBHIn6aeT4x+L6mV/MECpj/ZB03Gy
	lkpcCz4ntIbDWriuFPjUa4DZxZXVojTxK4hV7CncFjF7IG4YKe7KqyYsOU03zCAhrH7DPWPVevaDp
	6BJi1MYYvlXgRqIbl0ZA9F2WWCqTd0I4FuLCEAWlYT45lJ3bcSKaOkT3J0Ny+h2eJfYCUo9nS9+sy
	U4ndzcLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umhJe-0000000AESL-0Fax;
	Thu, 14 Aug 2025 23:25:02 +0000
Date: Fri, 15 Aug 2025 00:25:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <20250814232502.GR222315@ZenIV>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
 <aJw0hU0u9smq8aHq@ly-workstation>
 <20250813071303.GH222315@ZenIV>
 <20250813073224.GI222315@ZenIV>
 <20250814232114.GQ222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814232114.GQ222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 15, 2025 at 12:21:14AM +0100, Al Viro wrote:

> while mount --bind a a do echo splat; done

that, of course, should've been

while mount --bind a a; do echo splat; done


