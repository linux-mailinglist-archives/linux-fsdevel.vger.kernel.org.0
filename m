Return-Path: <linux-fsdevel+bounces-61771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB7FB59ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9D33B216D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044083469F8;
	Tue, 16 Sep 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsKJuFwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D912C2357;
	Tue, 16 Sep 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034256; cv=none; b=HTlehpOLEEf24GtIm7SK0cQlIRX2FNNXnmuPVabRvQ7s15ilPLb+8xBv/YsbNRGjJQAl9CGGXaeSiyFv1ZQC7SzQZOqn5/PCaWFc1PEIoUXafajWgxT4Vb+GgwWv+DKtdWG20fKj2WhZaq+BbO/ZJynsH4V3IwH1nE7Qvo0yvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034256; c=relaxed/simple;
	bh=PIYBiE5w8xKX+GnRe1IKo1pQgkYNq+pJKfN5WE2vBqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu2e7bF3aMz+xNGLfS6Y/a1H81JnPm2OaPAHQ+ARA8/w3XGn6s7LQLsnKHh0KlghnsjWzQJ3z1YM0mFzMNtde4gQQXJwpSEGM/PG3Yr5IBk7cNS+EZu4Q7HXBixhjkUtr+g/pnJIF+DyiE1FVDp6B6YG6Wb+0PLWz+LIroW+QHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsKJuFwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B35AC4CEEB;
	Tue, 16 Sep 2025 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034256;
	bh=PIYBiE5w8xKX+GnRe1IKo1pQgkYNq+pJKfN5WE2vBqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsKJuFwneGLsKYAs+0bT5CefPEabxGNOMRBRnOBdSXYAZueIXU1MunUXJuCUzaOj6
	 ve3voXG1A2nV8BXS541Gk1a9tDveO+hOsLgts+vz96/UUw9LDgKAAKMe2Vr48UB5Sf
	 YbYw5nVoPdEGWiAUG9f5FTzKYeh/M5szgdvsK4Eoh9KroSxj3ATM+9y4p/3JM801Gb
	 mZpdOWFKln8UTOJ7/9YjdOCQzY/5YjtcogKu8v0d8aWepCn3x5kGjl0PbA2ZhoSp9J
	 6OuVDHZbaA0IQCtJ+X2BMCsNzozhnXwLgSQX/cZBWDk9JbksH3mjv1BbBEYMHba9oX
	 znMIZO2V2dtyQ==
Date: Tue, 16 Sep 2025 07:50:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/2] iomap: error out on file IO when there is no
 inline_data buffer
Message-ID: <20250916145055.GF8096@frogsfrogsfrogs>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
 <175798150460.382342.6574514049895510791.stgit@frogsfrogsfrogs>
 <aMlrI3IfhtyI0eYR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlrI3IfhtyI0eYR@infradead.org>

On Tue, Sep 16, 2025 at 06:50:27AM -0700, Christoph Hellwig wrote:
> > +	if (WARN_ON_ONCE(iomap->inline_data == NULL))
> 
> Shorten this to just !iomap->inline_data instead of checking for NULL?
> 
> Same for the other two.
> 
> Otherwise this looks good, and I'd prefer to see it go upstream ASAP
> instead of hiding it in your big patch pile if possible.

Ok.  Will fix and resend as an independent series.

--D

