Return-Path: <linux-fsdevel+bounces-37619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BE9F4666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605F61887E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B321DE2CE;
	Tue, 17 Dec 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEavuovh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F19189521;
	Tue, 17 Dec 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425162; cv=none; b=rDq0gj2vxrstzbf2IkOgPV2hgONIqfAQ0nHOL0MvpzEZVESx3S5pIq/oaY+zEsyqh6YaiwkCQxnWIHJxSiZB+zAz11kjbcSmc7HdQCKj/H/ybVoAYZek10yZ1ZZO9C6iEiRrVZID5oo91wAlIbPMJ/eR5qmGTKaoTA5qQ9lBYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425162; c=relaxed/simple;
	bh=v0wC3EmDzpJ5rtXafBHFBqZKn7QcVsaUP5J66gQcMuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhAmnyxzXsu74aq9Vp+eD9Ov0e0E5cA6t3nvjz8ZfXDAD3qfRgXMTx5iVA/a43u3P7pTsztAvYFWyjy67Xdnoz9qfRS6aK4v2XWlbzj4pyqeapfSTUA8sEAlIAABKUSIAFenohpmfRhTO8JPABGzf0Xa3gBn0nvS4iGmnrPeJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEavuovh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02854C4CED3;
	Tue, 17 Dec 2024 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425162;
	bh=v0wC3EmDzpJ5rtXafBHFBqZKn7QcVsaUP5J66gQcMuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEavuovhwjHO+ZZ0Py9ypSfjFfDpa+JdH1qIR9ziSDjwRQKltKQQ4yjkNgNX8l533
	 /HJIs4AY3QczC2FyeY//hFrWlyfe6zQxWdEjNUoiC65UeWDsWYwkCEtRn1UvdInDrO
	 sd/O3wkn3Fmor7YIo+6KY9VstidnT4T6u+zp0CD5bzrkXsB6eDCyBLLLHI2BIM5Yee
	 FxbBO3f8M+UCXwC/p3+CAqeT/v+ufHsPXIqm/aZQIi6M7u5SrHeXfuWeBa8bSDAxCb
	 U1wzr96CE4TDscWUcJjkJ0Rq101cxHKBS525V3ZdGU78T7pr4gdckN3G1zfPKzwPiu
	 1WDUlgpRgmonQ==
Date: Tue, 17 Dec 2024 00:46:00 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 02/11] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
Message-ID: <Z2E6SAoeKq4mKGjI@bombadil.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
 <Z10DbUnisJJMl0zW@casper.infradead.org>
 <Z2B36lejOx434hAR@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2B36lejOx434hAR@bombadil.infradead.org>

So all XFS failures were due to flaky tests and failures, reproducible
on the baseline.
 
  Luis

