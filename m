Return-Path: <linux-fsdevel+bounces-15966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88189631A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36711F22E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541843FE2E;
	Wed,  3 Apr 2024 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD8RoC2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811E3D76;
	Wed,  3 Apr 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115811; cv=none; b=XsQNAfHeCInc/u3BIb13vFz2Nt85AUpqPHNdD+Uh8kWNHgHtFbEKtxdYSTGzaEYOETU9eEXLrYFhrJrBahEe637nLQlLOop8St9efyivQtoIhWxannpK+becknDEpWDph76Ssy7e28uFh6BVm791yHxvRkm50o0mOAJiuS8spto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115811; c=relaxed/simple;
	bh=s7/TSFoZCTujo5clr5oMUi2k1rXwU6wxmLVEFWWgRkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC0h8Pks3C9v0ESh/DebaedOJVTLYf90CsMQsAm5tHnV0+n2DJwXuesY6riFS0x7K7+KM70r6ZghxHfmtUl/5Ycx0kKHwvCriiAzdgnG4DyEKfrEe25pSpGOMcG8NxZsUhCfDg2QRSoZc5V+qqY0c738pBUtkX2KE/HV+4hjTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD8RoC2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18160C433C7;
	Wed,  3 Apr 2024 03:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712115810;
	bh=s7/TSFoZCTujo5clr5oMUi2k1rXwU6wxmLVEFWWgRkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD8RoC2uZ8BxQS36zgcM+wnGfDSCz+IKoBlYePPxOpmJryZaes5zDeCrR8XuwJo/B
	 25sX34qXV3vezh48cN8ekUsylZNy64OPcySwmhAkpgHO5UKfBygdNACIisiWY1OS5+
	 +9Bx/+pbzINpirerZ0r+gT9v43p1QKpvyTNuvZb1dV5xS0ycAGbqhjSZ01XsvmuUuN
	 WvmDmekhQwtePz21O+1I6WGLUAJM55WxvdNOFjAXDf9hSNnmUpt0ZiZlqxFE0XFtcZ
	 Y8UH1+q2ZHxaSXArEUOPgZF16XUqJc/PQnH50BcDWcj7v8DxQl9JvWAz58mrIACq1j
	 tXJ9UEz9f+VaA==
Date: Tue, 2 Apr 2024 20:43:28 -0700
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
Message-ID: <20240403034328.GF2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-5-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-5-eugen.hristev@collabora.com>

On Tue, Apr 02, 2024 at 06:48:37PM +0300, Eugen Hristev wrote:
> +		ret = generic_ci_match(parent, fname->usr_fname,
> +				       &fname->cf_name, de->name,
> +				       de->name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			return false;
>  		}
> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
> -						de->name_len, false);
> +		return ret;

Maybe write this as simply 'return ret > 0;'?

- Eric

