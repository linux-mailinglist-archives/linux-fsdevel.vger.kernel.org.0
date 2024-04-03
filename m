Return-Path: <linux-fsdevel+bounces-15967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C3F896368
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C021C22C41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92C44C87;
	Wed,  3 Apr 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK3N90/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF0374CF;
	Wed,  3 Apr 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118028; cv=none; b=uZeRyKxgddP3zz4hAy2emBJvOYGAP0YAb0FtysHNAA0Lmptj2Q01HgwS6cBKQZLNyf/9D5xmifvPhA6iHDVEZn7MhzXFjt/wiNUF7b1JUYgbWp/OVdmLDyEd3yoP/h4W0UsIgAvzKQnEYB8vnlurUKVcx0EpqYeHuimHteYZxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118028; c=relaxed/simple;
	bh=Tcj0j+1YWOxbiPelc6hNIb/Y8mkmLGVcLgWgtH4cpsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndOmcD+VB0GFB0eWhXrkWXSGa9LDm7uFSbXv41h9pdnRWEBuH7qv8S7TBQJcKHO0n5LZN0MbQDhfwkvJctzBCMj7cT10NswBd822/2dyKJ7FHOVrRVNf0zK/z+RJSBB2Qv1UxiTBuoWKCTzV+LEv/MofUjjkHxkWHy+0RfOGkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK3N90/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C2C433C7;
	Wed,  3 Apr 2024 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712118028;
	bh=Tcj0j+1YWOxbiPelc6hNIb/Y8mkmLGVcLgWgtH4cpsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IK3N90/stwO6flnkEFAcjrGv++OvGc5A3+Q3yHAT2MbgfhRpUYiBOsKEnNGNnXCe0
	 hG6u6J5PsMNsc9UZDdPB/OsTCzD5rXcorEGJlgk/s9S7+EKycsLD+lbQDC2upMc0J7
	 9JMBbktmK8LLG6nrDCk1mtd1cr5LB16HsyEWb7SRBdjQF/otJ9NoEveRdXWcOkRu5R
	 2K7C6kdwVKAzBYqvWRb5y+Tg8Fu+b/v8SXQfgxoWCJ518/eTHc4UGwL70AC8Ccs0Ol
	 l36nqpI2SDN1oKatrTeVK4NresoHeE8IEK0lT6oKhAVj/DLfCvKIZOhBoHyEKO71Gu
	 RkAYeVxFHi2jg==
Date: Tue, 2 Apr 2024 21:20:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v15 4/9] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <20240403042026.GG2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-5-eugen.hristev@collabora.com>
 <20240403034328.GF2576@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403034328.GF2576@sol.localdomain>

On Tue, Apr 02, 2024 at 08:43:28PM -0700, Eric Biggers wrote:
> On Tue, Apr 02, 2024 at 06:48:37PM +0300, Eugen Hristev wrote:
> > +		ret = generic_ci_match(parent, fname->usr_fname,
> > +				       &fname->cf_name, de->name,
> > +				       de->name_len);
> > +		if (ret < 0) {
> > +			/*
> > +			 * Treat comparison errors as not a match.  The
> > +			 * only case where it happens is on a disk
> > +			 * corruption or ENOMEM.
> > +			 */
> > +			return false;
> >  		}
> > -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
> > -						de->name_len, false);
> > +		return ret;
> 
> Maybe write this as simply 'return ret > 0;'?

Ah, I see that patch 6 adds a check for -EINVAL here, in which case the
'if (ret < 0)' makes sense.

- Eric

