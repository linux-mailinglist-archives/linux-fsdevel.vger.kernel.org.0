Return-Path: <linux-fsdevel+bounces-45238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D995A7507F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6973B1F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05EF1E0E0A;
	Fri, 28 Mar 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+y+56TL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BC1DED59;
	Fri, 28 Mar 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187425; cv=none; b=ILyGwhUJtKG7+7e5eTc5OxYbuKfXKWeXetrKTZMaeRevu5uyaxvuxcdNDjs8yusHqCmfMfeEOEd8Q2r+YZPn+e+maRhs4hP7YigQikry2A0i2y5CFoRvM8Kf+vHAe2NEyJWk0nv2WVKUIfY19AQFyWGxv9VulBEbQG3qqmjMfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187425; c=relaxed/simple;
	bh=O4phGZpwuNl+ZoqeFbMDQGKowzefd5Ymz70pDGjKOdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3tK5/hrJjH3XdpIGoJBDtdVSzlHomkqb3nPmV6/qRtKUNCMFIdrPGFKw44vGFieNhd2/1g9E8c9xB34vUO0uzh/kJTWUVJOQ6ihJh0hVGZnjyu8s7x9A7G6kdhVhLk3FbAr7ej3I3NeYRPTtJrwyaqQnJBDSCua4TK8rpVNKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r+y+56TL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p733MeC/DumrK+eFf9MVIXBeMjP2rdW/UhE8zHZGc2o=; b=r+y+56TLWC4CTDCQ6I2uOYHQ6+
	FF1c9uaTDHZQw0LPTD2TwREUF9SFvc0FnkK4dLA+smSPpaNxGtYLbFectcACLsMuORKjlqeLRDKP6
	5Lxis3gQ7GbvayJYTYN5qKeoTvCMpvXt3eL/ioPFAhQhyYQBec7NZ02oCqgJZjbseo6K18WYUQWt0
	kqBksyntKn8gLbqH1hqJBy5Yp5z1HpBGndrBl2xKSTMk5xFAhKIcQsKICzyQGXrHFslC2mh636obt
	pkOrU6NIpd4zNfvSq70hhAtErCFxKp40OnRcOl3y3RRRuFoCvRhi13CdaqImBRm3KkUUytguUgM2S
	KSNH5zrw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyEg5-000000084Fw-0fD4;
	Fri, 28 Mar 2025 18:43:37 +0000
Date: Fri, 28 Mar 2025 18:43:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dan.carpenter@linaro.org, ceph-devel@vger.kernel.org,
	dhowells@redhat.com, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
Message-ID: <Z-bt2HBqyVPqA5b-@casper.infradead.org>
References: <20250328183359.1101617-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328183359.1101617-1-slava@dubeyko.com>

On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> This patch moves pointer check before the first
> dereference of the pointer.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202503280852.YDB3pxUY-2Dlkp-40intel.com_&d=DwIBAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=Ud7uNdqBY_Z7LJ_oI4fwdhvxOYt_5Q58tpkMQgDWhV3199_TCnINFU28Esc0BaAH&s=QOKWZ9HKLyd6XCxW-AUoKiFFg9roId6LOM01202zAk0&e=

Ooh, that's not good.  Need to figure out a way to defeat the proofpoint
garbage.

> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index f3951253e393..6cbc33c56e0e 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_block *sb)
>  {
>  	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
>  
> -	doutc(fsc->client, "starting forced umount\n");
>  	if (!fsc)
>  		return;
> +
> +	doutc(fsc->client, "starting forced umount\n");

I don't think we should be checking fsc against NULL.  I don't see a way
that sb->s_fs_info can be set to NULL, do you?

