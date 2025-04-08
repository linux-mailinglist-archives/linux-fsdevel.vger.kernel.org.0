Return-Path: <linux-fsdevel+bounces-46021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E779EA8159B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF237B930B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1A241CB5;
	Tue,  8 Apr 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om8FOAy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443122D4D4;
	Tue,  8 Apr 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139632; cv=none; b=CuLKOyRqhP985YLbswIYjq7RKG998QKj7FxUDKs63ZFfWsjWUd/CmZJ4ZnEQ3M+3mB9NeORYz75g94VRVW6a7BVhWRmcceMti62OBTUv1yhc2j8qEViDx3IXCPNE1Kqfx3MnLPZiq3W9VSrER1Sx3m7tOd4wUCJIpvTwaU9P0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139632; c=relaxed/simple;
	bh=UVl5iTpHM260MX/3qRXPG3WLcoNsa+ERXi0+vvajOWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0vjq44EdL1tfUTO/PVv4UvwNgNw0ts13JERx/xKXsKu+6XGg+GoJCTXG11uay5hkxiwV8HIBq0kXRszdypCALg2cGnjXwMtHENhb9mh/P3xBBzBhbnjeLboZHJu+AVHKmRTVSA3l2Y3//v507Zwj+yz3772eCLswU2H5t2cRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om8FOAy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02892C4CEE8;
	Tue,  8 Apr 2025 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139631;
	bh=UVl5iTpHM260MX/3qRXPG3WLcoNsa+ERXi0+vvajOWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Om8FOAy0qhkOWGJRJHKZThT6ySOVxlDEeP7MuKeO1JluzhLZ/kY/7hbMh5f0oYzvm
	 q7eLzs5ecG5R5HRMIICOJGuGQinJkbiNcTqrHvkw3LtSfK9AAs/liKBkKNtGPd0vCU
	 I41pxt/qyia4nsRlDYwLlufw9j6shNU/jkMiRS74rVhwG636xUr3fJVSIdwJ8iYzWX
	 lr/JlQFQPC879+UkgIKoaQYeQKbBCMXeOJX19rdsRN57O3bcyKci5b79V/ARdqr9lc
	 I28SgqstrSsLLBEbzvKBH+TpoKOdFS5fIo1peHgLE12Hdsd6oD0DqanIYKD99eHhVf
	 JZezGNqrbr8iw==
Date: Tue, 8 Apr 2025 12:13:49 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, David Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Tso Ted <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z_V1bRTwRk4a1nD-@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
 <Z_VwF1MA-R7MgDVG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VwF1MA-R7MgDVG@casper.infradead.org>

On Tue, Apr 08, 2025 at 07:51:03PM +0100, Matthew Wilcox wrote:
> And then we call readahead, which will happily put order-2 folios
> in the pagecache because of my bug that we've never bothered fixing.

What was that BTW?

  Luis

