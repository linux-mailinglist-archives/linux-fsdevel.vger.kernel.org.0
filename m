Return-Path: <linux-fsdevel+bounces-58345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC22B2CF2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CEC3B3D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A9287247;
	Tue, 19 Aug 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNtinz25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80882353346;
	Tue, 19 Aug 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641832; cv=none; b=pLAcEqNlwo/Zlcgiwu3WfT4UW80oQU7Y59oacbxgF/s05G111/EzgLalkfJKw2/QjYFZkm3snoXcqRrX8TnCXa3Z1Eau+P1eIw4SRSwBd0VRmxp7qBJ+K0Klqoraa2wydfe02oflVlCn0MvXRh3ClOanTjQ/GkHqLgtq1h3GtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641832; c=relaxed/simple;
	bh=hxKNVzwm+0xg7CiDywgUBg6GHS2F2cVK6OSq8JAgv0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3UQH4m6tPrbVNpVUUiiGgiqdZl1ZmLy+rVLbDlI4fpjQT67wGvSo7xFwDSxImPPratnoj9JpG35BEI7wmsHB2ciPFXUPTd9VMoIn72x4+hqURcF80wbtL6XMRf93FgytN5LMsDhxUCKxj95haTnX+41qJJOrFWTeV5kAEyHdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNtinz25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B56C4CEF1;
	Tue, 19 Aug 2025 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755641832;
	bh=hxKNVzwm+0xg7CiDywgUBg6GHS2F2cVK6OSq8JAgv0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNtinz25M4hJVHOFhujRaR+8bFeXgOCDh0RMbM1fycUNrfZjjqtRV/cB6J6rdxI1A
	 E1Jizr/OpdHnhY5k4pUbLJ0a/NVIcqkMxEKaTHnIZZkQhihgifev0doEbryGx8cC8G
	 Vr5jembNJoMNp4/O6XjeyQDPzThU6ZaN941caMvVXjBjmKLcg/ebuhQ8h1RrxdXRtF
	 fKT4UxSrtKp2ZJg/KlrMg/N+kDqIZmCrNdguCrcOTiftAk3EIOvebj8ZC/Efj7byps
	 LVmAHWZ9eucxCxTyt0iJdxc081s8sY9vMJvptiaeegi2WSn/NoozEA/OwJEkNRHcGl
	 MhalCSkLvMnOw==
Date: Tue, 19 Aug 2025 15:17:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <20250819221711.GF7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <20250814180512.GV7942@frogsfrogsfrogs>
 <a6smxrjvz5zifw2wattd7abmxhsizkh7vmwrkruqe3l4k6tg7e@gjwj44tqgpnq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6smxrjvz5zifw2wattd7abmxhsizkh7vmwrkruqe3l4k6tg7e@gjwj44tqgpnq>

On Sat, Aug 16, 2025 at 10:00:23AM -0500, John Groves wrote:
> On 25/08/14 11:05AM, Darrick J. Wong wrote:
> <snip>
> > It's possible that famfs could use the mapping upsertion notification to
> > upload mappings into the kernel.  As far as I can tell, fuse servers can
> > send notifications even when they're in the middle of handling a fuse
> > request, so the famfs daemon's ->open function could upload mappings
> > before completing the open operation.
> > 
> 
> Famfs dax mappings don't change (and might or might not ever change).
> Plus, famfs is exposing memory, so it must run at memory speed - which
> is why it needs to cache the entire fmap for any active file. That way
> mapping faults happen at lookup-in-fmap speed (which is order 1 for
> interleaved fmaps, and order-small-n for non-interleaved.
> 
> I wouldn't rule out ever using upsert, but probably not before we
> integrate famfs with PNFS, or some other major generalizing event.

Hrm?  No, you'd just make the famfs ->open function upsert all the
relevant mappings.  Since the mappings are all fully written and
(presumably) within EOF, they'll stay in the cache forever and you never
have to upload them ever again.

Though it's probably smarter to wait for the first ->iomap_begin to do
the upserting because you wouldn't want waste kernel memory until
something actually wants to do IO to the file.

--D

> Thanks,
> John
> 
> <snip>
> 
> 

