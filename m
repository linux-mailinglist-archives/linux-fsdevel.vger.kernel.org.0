Return-Path: <linux-fsdevel+bounces-29618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D063297B753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 07:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879FB1F23F01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2314A09E;
	Wed, 18 Sep 2024 05:09:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382C1422A8;
	Wed, 18 Sep 2024 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636182; cv=none; b=YsbaIzJPxPvWij3CirNPmm0QhrPCUf0yZWxsdu2JVjEJKnYJU20HTvKMW0AZ/289/kkCMYJaHrF7IFz5rn94wrLVtx3RwDhXA45WCirgF8qWEWsrMCznwsoUF+dBovpEIaHvCVL7AQ1ZHvzUiWoEUYtangzYPFvTB+YpJRS+T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636182; c=relaxed/simple;
	bh=awEXlbWPxLKLo3JNZr/9iYBR3LXutkaUdH4WaRr/LtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdIt31yHrepBIrRsApigXb+vFPK3ErIqL8NPLrjJziL0PQT3HAZ19w+m/pOqxHKiY5QNF1Ao3bbq/SmvWsXHIpGnmcyuiQxKoM8AwNlAioYM6vSdeRomGHdYzId+phvqDT0qaOcU+CHrvXFlafG3Lm2tyg6jQQiNBKDSV8i4w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B2DD227A88; Wed, 18 Sep 2024 07:09:36 +0200 (CEST)
Date: Wed, 18 Sep 2024 07:09:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: factor out a xfs_file_write_zero_eof helper
Message-ID: <20240918050936.GA31238@lst.de>
References: <20240910043949.3481298-1-hch@lst.de> <20240910043949.3481298-7-hch@lst.de> <20240917211419.GC182177@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917211419.GC182177@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 02:14:19PM -0700, Darrick J. Wong wrote:
> I gotta say, I'm not a big fan of the "return 1 to loop again" behavior.
> Can you add a comment at the top stating that this is a possible return
> value and why it gets returned?

Sure.  If you have a better idea I'm all ears, too.


