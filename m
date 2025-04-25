Return-Path: <linux-fsdevel+bounces-47365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1863A9CAB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CDF4E2FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D125B669;
	Fri, 25 Apr 2025 13:40:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D50258CF9;
	Fri, 25 Apr 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588403; cv=none; b=Q3lpzJ5P5Y/kGX1ckKo/sRvktWAhhH177z3RbB2hIN9XiXROQpUrtCKKHoNr0QLts8iA2yWeo3gDxTt0pqDaIqlkYbfuuIinCIHMacni6UfM47ToGe+fIHJmf+um83oNpEoO3E0oVVkGJZBqoApuwJlhX4jZzO3cS4twm1YeCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588403; c=relaxed/simple;
	bh=VAmaaT5zxPwoAyVWLRbtiyXvyRJbEQ6BHzLBCHpYND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5eIxryeFTnfKXb67JsTrbFrStzoBtqbzNzkFwhIHPyPxcuxmO8QoZLKFp1gI1ZL4jZr3hyAD4s5L82ABITzahrB64sQErE8/fAJnCKnGbK0C5rdOOe+uL5/4B2NaIphJVckYz3tNKfrOFp1ApOp/oHdhRjbMO4adXvoI5gm2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20A8568B05; Fri, 25 Apr 2025 15:39:55 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:39:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nikita Dubrovskii <nikita@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, djwong@kernel.org,
	ebiggers@google.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, dmabe@redhat.com
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250425133954.GA6802@lst.de>
References: <20250417064042.712140-1-hch@lst.de> <d6dc234d922d8beda65f2a1eed1e2de6a50c978f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dc234d922d8beda65f2a1eed1e2de6a50c978f.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 03:32:55PM +0200, Nikita Dubrovskii wrote:
> Hi all,
> 
> We're seeing a boot failure on first boot in Fedora CoreOS starting
> with kernel 6.15.0-0.rc3, tracked here:
> https://github.com/coreos/fedora-coreos-tracker/issues/1936

This should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.fixes&id=e079d7c4db5cba1e8a315dc93030dfb6c7b49459


