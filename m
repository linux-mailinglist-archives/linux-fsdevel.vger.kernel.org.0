Return-Path: <linux-fsdevel+bounces-53297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4FAED401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAFE18939FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDCF1C862C;
	Mon, 30 Jun 2025 05:44:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193805227;
	Mon, 30 Jun 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262252; cv=none; b=Gw3bviIA73QtcwzKAW8LkkmQeiM/AkblUtwZM7wdW594CQ0MRBMC2cJk4dr6MLYo9MNV8BEJHsJR8fOM6o1Xir/sljgP+FG1kCA0ijO6Y1dKQ0hEP49xqeyUxzAiJhuNHnywR26KhJCTFavaSAPsfQXCjh8qFOZTuh1dtm/ijYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262252; c=relaxed/simple;
	bh=bbG/IJXT1k4JaXHt5uQI6CEmW1FSMMbQiMySOKQcVaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IexiQLJPMjAFwk+APxsCY/rcdtfQ9N1u+UkPdk+Q0wBExPrjSmXkYVBZtBtKI8Yo6JRBAHdtRo94RDJVuvygl008CndXhvoU1UeH0ufNxGEP5nets7I0HPSVeRh2l448lHUQoZRNdGqSKDI3npJ+I3aPNuAqnNpcL8/aqNdPyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8880D68AA6; Mon, 30 Jun 2025 07:44:07 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:44:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
Message-ID: <20250630054407.GC28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-2-hch@lst.de> <aF601H1HVkw-g_Gk@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF601H1HVkw-g_Gk@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> I find it slightly annoying that the struct name now implies 'wbc,'
> which is obviously used by the writeback_control inside it. It would be
> nice to eventually rename wpc to something more useful, but that's for
> another patch:

True, but wbc is already taken by the writeback_control structure.
Maybe I should just drop the renaming for now?

