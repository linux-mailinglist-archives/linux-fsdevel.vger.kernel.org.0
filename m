Return-Path: <linux-fsdevel+bounces-24448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1D93F6CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9005281024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256E14A095;
	Mon, 29 Jul 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="g6JyqTlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B9149C4D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260173; cv=none; b=KrcB9Tc0qXV8WGhKOlt0PMYYe/SwQeELRrtig9Hyundifaat3sCOc66MCDLO4fdL/PW8Yp3QCo1y9RuLzn/dV92C+IemIefIk/N8jm4l3cqPS3kCSqq2qXGbIJ82BXZ/1xD42o8UMA4KEVrps+HbGXApS1TCbdH3/rO3VSQ2Q3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260173; c=relaxed/simple;
	bh=CXFonhFXNonLB+FqwjDxk6atyVr/H0PoH0Eae7oF2cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXl+Il1hb8dM6uNH29J6LHwNYDMNBrrOFKMMN5Q2ZcFFvAVJGX+QyT+Thx48d8R2UM17D0SfnpDi1fBM4kUAwjjzV7vAW7dlBKeciaoD4/Bt1kIA6xDzhBLj6V2/ICEaAKxz0+ZYNprwdvvlVeOt4Lb44zvW2H3Xuqu2qPlqNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=g6JyqTlI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46TDa10S005006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 09:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722260163; bh=QVUC1V21zgmug77XEM1tO38YThaG7JsTP27Lu2z4v48=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=g6JyqTlIynTo0AHwUDR9SFaOCa3Wz8E+VAzwn5wgr3y2bY2Bnadzvgrq3rA3sEd3X
	 1yRpN/VmkfILttCIPsC6+2xqReKR3kxHztBPWr1zX5EmdZvueKGI+f5YQnHRCP0zJi
	 lo0zExFDZ5TkjIey0LytQgEbRiiJCUnn+tQfbFfA6rQKQf+yJgtg04037IhcxANrPa
	 dtYbVd89YPUvPRadpPu/QjG5XSwmP30YkHGfD/tMeloLo0AvWLSk5rgJH9Q2zM2osP
	 Vdpw0zGBH8WkCUfbmTBFzx4e46Xn6sWCqeCK+yiFzi9G3Q5nz5KQKciTHNtuiVlboz
	 YdlNwMXsE8XUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1C6CC15C02D3; Mon, 29 Jul 2024 09:36:01 -0400 (EDT)
Date: Mon, 29 Jul 2024 09:36:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240729133601.GA557749@mit.edu>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>

On Mon, Jul 29, 2024 at 12:18:15PM +0200, Mateusz Guzik wrote:
> 
> Are you claiming on-disk inode numbers are not guaranteed unique per
> filesystem? It sounds like utter breakage, with capital 'f'.

The reality is that there exists file systems which do not return
unique inode numbers.  For example, there are virtiofs implementations
which pass the inode numbers straight through with a fixed dev_t.  If
you have a large number of packages mounted via iscsi, and those
packages include shared libraries, then you can have two different
shared libraries with the same inode number, and then you can watch
the dynamic liunker get Very Confused, and debugging the problem can
be.... interesting.  (Three gueses how I found out about this, and the
first two don't count.  Yes, we figured out a workaround.)

So that breakage exists already, today.

For people who don't like this, they can stick to those file systems
that still guarantee unique inode numbers, at least for local disk
file systems --- for example, to use ext4 and xfs, over btrfs and
bcachefs.

However, this is a short-term expedient, and in the long term, we will
need to guide userspace to use something that is more likely to work,
such as file handles.  And ideally, this needs to be standardized at
venues such as the Austin Group, so that it becomes interfaces which
are used across operating systems, not just for Linux.  It's going to
be a multi-year, if not decade-long, effort...

						- Ted

