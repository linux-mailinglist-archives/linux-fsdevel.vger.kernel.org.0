Return-Path: <linux-fsdevel+bounces-35227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9279D2D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A12C1F226B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CF1D220E;
	Tue, 19 Nov 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dnx6oMFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF91D2200
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038861; cv=none; b=ZLy0QGL/udq0FRhHmP3pEjIA4KV8oszDUDcvYIS8PsIlEFuE6sRmGwSTBMkiVLhTD++QZ2E+LJ+5e7tz8v8QzfiQ36BmsMEuETxgYI6ZmsXblIujS42OGXjSYM+qLo12NxSyZqbRorcbVlGxsS8PlBpzUmVUGVIMKXw75rsVEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038861; c=relaxed/simple;
	bh=B/CRgf6QEQAQtv8iVQ9mb6j0mNUPZ1JQpaRVs00JmsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiA1jxvNBj/aU1Px6G3JlKkaTsxeL65NmN2e0wxM3ddR1fpKdJgLQ2CK2ibYuvV1L92Cc7JFaexIrv2ExpVZIdXwgfJnci3W3kCP2iXcAPDx/p/CNG0BTgiw4MN/GTKWF7Eci+l3n9WeX6VKp9DkmCnvLBkKySCEgMVPIryUOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dnx6oMFn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.137.16])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AJHrtC8009481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732038839; bh=P4+3SOCenpcIKOGL/YLix12jX+t6A3qO46sLOcazePc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dnx6oMFn4PUjWKO/r/XcdD03ZLZtFo4dDdkyqclgxqVryFTCdvNJbZLOJrearsQvF
	 ad+KwW223NS7dv/y6MPnnMYkihCClSlr4jMIiYUwUx+paeSMHCxZMb84MXb2z7haB7
	 Z30HAPW5E9K7laDiv0RD28ZV/7AO355ZXwNlUOKyBQbqvarTcPWZxpY+8w87EE1obw
	 YzKpabQBZnVONLKaiBpi39Em8R2v3GmlOEhZ35giK1XGQUKwvDBm8GLVr0kvOVqI/w
	 5Agj7EvTHQmpnZ4O3i+YRwzzNbTkgw/eSsPx/m7hRr994EIxPtnPSc6OXfhlq27w6h
	 C8nJAONewAIbA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5AA48340857; Tue, 19 Nov 2024 12:53:55 -0500 (EST)
Date: Tue, 19 Nov 2024 09:53:55 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hughd@google.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] symlink length caching
Message-ID: <20241119175355.GB3484088@mit.edu>
References: <20241119094555.660666-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119094555.660666-1-mjguzik@gmail.com>

On Tue, Nov 19, 2024 at 10:45:52AM +0100, Mateusz Guzik wrote:
> 
> On my v1 Jan remarked 1.5% is not a particularly high win questioning
> whether doing this makes sense. I noted the value is only this small
> because of other slowdowns.

Do you have a workload in mind which calls readlink() at sufficiently
high numbers such that this would be noticeable in
non-micro-benchmarks?  What motiviated you to do this work?

Thanks,

					- Ted

