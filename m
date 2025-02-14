Return-Path: <linux-fsdevel+bounces-41758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179EA36744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 22:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B87189585F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3E1D89FA;
	Fri, 14 Feb 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcP0YW2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3D17E;
	Fri, 14 Feb 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567495; cv=none; b=JGFdkHE8e8+QgRMmGaKnlhKbdkmaw3CKVF6T3/2625NX+ZMNG47HID1WFp39x8UQ9dONfCduyWnfNLZD9/aaCdsWcGovzYZgJ/w2IV93vGR/oqnlnqk52evRksRsaVlcnVqSF/D7VeN2iFHcM5qiCDtxkG90Pr3mXvsLZdfbo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567495; c=relaxed/simple;
	bh=t/nLr8wbSu5SyEaE4qp/jYgLpJ3+SEC36Kq+dRYN91I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Q7jTG0didwdZ8uWUbE5PRSJQKtAuS3ce2BOdTTHU3WLVsO7lFpkoGp+IgyUIv/tEfuQNmKjmPGd28EkIH+vYRvetX48/+vmmN3Ll/RHIeV+Rfp9rKXSw9wOEX/7Sl+UVhZn7M/4gRcPMEqk0Y0yAkC5ThuHZb2IBcXy18MR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EcP0YW2h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=meJ1FZFZz/yDH/VdBFQCpuoSR+r5abS6wu/TcPuNnFs=; b=EcP0YW2hkMootsVdmcdHMeKFVD
	VfeWeLFoEkz+ICwhSxDTl985+t/Iizl2OeBxugzA/UsKwT+Ryqp2Za3qcMMeepGvUxCvr+EEjzOev
	D6F/ehl8qvmLw5mYBGAZXSIqdbRRqPqw0dZIVNpiHuyw5uhFjCEY92Q43GfR/02rwU6niy2OcgFM1
	i5F46RTltVerJiUvMKePDx4kNkv9USbGpdrPtHsUWlo8Q+MY8sN1bUuNyORpMFeHHKlulkg+GaWDI
	AGSJTFAsKNUlVnN/34dr0FT2nyCLi8vAJoiTHSvQIfpFV3yRymlplWq9cuxfIWe6SI+ffxASlkftd
	Hg016TQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tj2yB-0000000C3o7-0dne;
	Fri, 14 Feb 2025 21:11:31 +0000
Date: Fri, 14 Feb 2025 21:11:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
Message-ID: <Z6-xg-p_mi3I1aMq@casper.infradead.org>
References: <20250205000249.123054-1-slava@dubeyko.com>
 <20250205000249.123054-4-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205000249.123054-4-slava@dubeyko.com>

On Tue, Feb 04, 2025 at 04:02:48PM -0800, Viacheslav Dubeyko wrote:
> This patch implements refactoring of ceph_submit_write()
> and also it solves the second issue.
> 
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This kind of giant refactoring to solve a bug is a really bad idea.
First, it's going to need to be backported to older kernels.  How far
back?  You need to identify that with a Fixes: line.

It's also really hard to review and know whether it's right.  You might
have introduced several new bugs while doing it.  In general, bugfixes
first, refactor later.  I *think* this means we can do without 1/7 of
the patches I resent earlier today, but it's really hard to be sure.

