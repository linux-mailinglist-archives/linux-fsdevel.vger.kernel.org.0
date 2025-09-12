Return-Path: <linux-fsdevel+bounces-61004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9867B543B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405CD1C27C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D92BF00D;
	Fri, 12 Sep 2025 07:19:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B0299A8E;
	Fri, 12 Sep 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661581; cv=none; b=IbpzYEK+gMLTNSGqaliZuld9uH97Dz/hMQ0QMO7re/OyyyfBfms+krSv52icz3K6F7LFEX8V65G1iiKb7aS7P4Sxlu5FWI07dgL/oP15FOHVXYuw0E+uSrqC0llfJF9w5shmXhBmk5fW0cIZtIB6z9hcTvm3w4VqGJtCyMvjjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661581; c=relaxed/simple;
	bh=n6KFPyZG50tvr49XB10kNyIdDXCIddtOnvL5YtoPBVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTO/OLSrIz73Wcx48s1j6AcpZAcAi8WfMrS/+JfaFqBawqo3bcnJm+2R4C3IFedT2irs7j7DIkU6AHXvgf/pJ3HVvSMv2G4zOkz7gSewuXgFBGCRlqbCAYn8bb/PsmrqmTpUdYROYQES+Tt5H/oMc7u1XeegDEzAEvUQWHs0/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B6A868BEB; Fri, 12 Sep 2025 09:19:36 +0200 (CEST)
Date: Fri, 12 Sep 2025 09:19:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Christoph Hellwig <hch@lst.de>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <20250912071935.GC13505@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-2-9e5443af0e34@kernel.org> <20250729222252.GJ2672049@frogsfrogsfrogs> <20250811114337.GA8850@lst.de> <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh> <20250912011433.GH1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912011433.GH1587915@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 11, 2025 at 06:14:33PM -0700, Darrick J. Wong wrote:
> TBH I've started wondering if what fsverity wants is filemap_fault(),
> but with a special flag that enables faults beyond EOF.  After all, it
> creates a folio, reads the data from disk, and returns a locked folio.

filemap_faul actually does a lot of mmap-specific things.


