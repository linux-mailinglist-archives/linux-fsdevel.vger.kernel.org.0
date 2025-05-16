Return-Path: <linux-fsdevel+bounces-49266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F5AB9E8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F9C3AC94D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C319047A;
	Fri, 16 May 2025 14:20:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DB16F8E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405256; cv=none; b=vF/KQeNN9BP8iFuFam0PHrBdA8Awv7M/sLfPFykL/uM3nsXwmLBNizdL0kTWQFhGb99cP6sF4K6hhYccrGcPbWClZ6HMO0sVOyRyXfq62blom8IcYUhcx2E/MbAfBlrA2igIbwFEw6yBqgedYcaQWzvOzuTRkQwrYAR/pzQdTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405256; c=relaxed/simple;
	bh=qlyRcbfx3AUnA02GPrwtW/A/90p+kkWt/OJuUZbMQ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0dkZ+5LGwbZWMRKL9JTahymNRZkNinQ7t2pZxS5Z2W8rpRbJMKDEGhqzSz7DNup7GFpKhsLcxAZWcWg41iSYxhaUX0Q5eu4rUamcGvBsHDN8EtVYnVdiwXK4vq4hXKRuAwqRA9vV0QTUBeLutQ5Z8m72s4vNvSpq4L0lKDwKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GEKPdF009602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:20:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E6D932E00DD; Fri, 16 May 2025 10:20:24 -0400 (EDT)
Date: Fri, 16 May 2025 10:20:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250516142024.GA21503@mit.edu>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516130547.GV1509@brightrain.aerifal.cx>

On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
 
> In general, raw kernel interfaces do not conform to any version of
> POSIX; they're just a low-impedance-mismatch set of inferfaces that
> facilitate implementing POSIX at the userspace libc layer. So I don't
> think this should be documented as "Linux doesn't conform" but
> (hopefully, once glibc fixes this) "old versions of glibc did not
> conform".

If glibc maintainers want to deal with breaking userspace, then as a
kernel developer, I'm happy to let them deal with the
angry/disappointed users and application programmers.  :-)

						- Ted

