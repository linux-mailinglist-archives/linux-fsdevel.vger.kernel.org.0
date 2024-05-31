Return-Path: <linux-fsdevel+bounces-20602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0A8D59A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 06:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8731C22B78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89478C88;
	Fri, 31 May 2024 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQyewlPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69F1C6A7;
	Fri, 31 May 2024 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717130934; cv=none; b=iGhcyj60+3BH2HLo7WUSw3mQmPKIxnsQVzL6aHZdDw+xEGQ9fJYVhIDcX76qftHSbTP+XJuzcsbYAXOhDBntFWaVKZxJ5aB/0XcBuNQaNmEr3EmTvqbGDgHOTr9ZWiMFnNmY/i/2bLGedawN/cx9aIoYEMtiY1kMvqd8Wd9UdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717130934; c=relaxed/simple;
	bh=rwZVOoPGbQlEDRXpL/1iSA1Qlmy2Y3mYxOuSyODH8DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LioG8EfHFgb/95hJRoScLp9RV3TjoNcb4MxIPJ82v3g4qumCT90ffvNnBD7XrZE40wn2STAltF7Rh5W9MKnupsQbGToQZlbfQrqOoozdDEnDIl2RsPxfpH2YmpstOE7qBXie13XfB45w+xq1UGIWTSCRxHK5XEOckpE0Z6UTnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQyewlPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4820CC116B1;
	Fri, 31 May 2024 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717130933;
	bh=rwZVOoPGbQlEDRXpL/1iSA1Qlmy2Y3mYxOuSyODH8DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQyewlPkyzvr81BeLKj47j+oHAqkafhoB/DIsCyjteH/CtWXrQVDA48PvKdxBmfee
	 zVVS1mq2JRFLY/VqjYaHMzIM2EHhSCXNXFBZbI8I2QsYuIgrC5df9DV7TAbQSPYVTr
	 1JBb6aIJPLQ0xOYth6tTT18KncAR+xuNRLJuQ4UHFvZt8VsgyKsMjqvPFNhyKlsl92
	 bOwYAeQHqzAWUdtm8uCrsujcNo5y9tDP2xRew8aIvsSXyHTrtML0VdEBSzV+nsppvr
	 JjG6SXii9vIY3wlq5gEHudVMg4tV7gJO+EEZIDKrBencsaHSr+SOAa4GMSNwu0jiO/
	 8bIa0hL5yG7ng==
Date: Thu, 30 May 2024 21:48:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	adilger.kernel@dilger.ca, tytso@mit.edu, krisman@suse.de,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	kernel@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v17 3/7] libfs: Introduce case-insensitive string
 comparison helper
Message-ID: <20240531044851.GE6505@sol.localdomain>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
 <20240529082634.141286-4-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529082634.141286-4-eugen.hristev@collabora.com>

On Wed, May 29, 2024 at 11:26:30AM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +
> +	if (dirent.len == (folded_name->name ? folded_name->len : name->len) &&
> +	    !memcmp(name->name, dirent.name, dirent.len))
> +		goto out;

Shouldn't it be just 'name->len' instead of
'(folded_name->name ? folded_name->len : name->len)'?

- Eric

