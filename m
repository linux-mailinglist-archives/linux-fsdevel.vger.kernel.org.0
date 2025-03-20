Return-Path: <linux-fsdevel+bounces-44506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE3A69F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8D174A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9E1E1A16;
	Thu, 20 Mar 2025 05:34:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279117A2E2;
	Thu, 20 Mar 2025 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448862; cv=none; b=W+E4goC0yUfGQYfkhgHDRWz3rPWi2m+ZsQYdhp+22p4/s8LMWmk79gENjP6vfkL27B5Cv81KwT/5Dqvr5IJXBaL3+aJSH7nEneTy9O2LZX6l6naJsPyPaD5ac8BJ0svUgL5AoADvqzXx6g87ORhdQ5qeMZe8C7gHP0jbBKLfrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448862; c=relaxed/simple;
	bh=NXOA1i1mfLJj2eeNDdx1fCLit7TPef48eIRXWIGcF1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg4B+NqkP72GPz9TTrOP9cKWEYcavhfnAGL7kPpMfJzVbIboUGJk8VPsBqeEXCbqF1vuLW1UPALn/N5zkzs7FmnFuBPIPTJuLHI3DqRaqKK1XFPBNxJ/rtwMsmXxsqM8VRmO4JOkrUFJad2I5JZksOtx6tXLsZcT4l85wmr5axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76D7968AA6; Thu, 20 Mar 2025 06:34:16 +0100 (CET)
Date: Thu, 20 Mar 2025 06:34:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <20250320053416.GA12664@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de> <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45> <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com> <20250319062923.GA23686@lst.de> <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 01:04:14PM +0100, Mateusz Guzik wrote:
> The change is cosmetic and has an unintended impact on code gen, which
> imo already puts a question mark on it.
> 
> Neither the change itself nor the resulting impact are of note and in
> that case I would err on just not including it for the time being, but
> that's just my $0.03.

Im not sure how you came up with that opinion but as you might have
guessed I don't agree at all.  Having the proper types is more than
just cosmetic, on the other hand the code generation change you
see can easily be argued as cosmetic.  You've also completely ignored
the request to show any indication that it actually matters the
slightest.


