Return-Path: <linux-fsdevel+bounces-64210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B88BDCD5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF8A1893EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097C1C862D;
	Wed, 15 Oct 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNBm8zcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC4306D48;
	Wed, 15 Oct 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512298; cv=none; b=XSFUJcEFD99mpBpU1VdmSp6OHexqWHOR0HctwKuVJljGqhfjX9auE6bQi7oL9OpTRS/QNFueQHFKKjqURmgnQ1Z1OuLALWyMlOu15OQcSuYvrKRUhatc5qLcF3bcsYO8faXPt3Wt3/5jQucbFYu0nAMMVzhK3TBf6HMxcHreVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512298; c=relaxed/simple;
	bh=+YN9iv/JKaRpqQa6Ykr9VD5uGu2CRTjueccIgjbhdmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCoq5VoECLxmK6PA70brMbbKc+DUvVXASCfTzo6I8BOESicLrK3M2BHTZqGeckA4UvkqZ+TFFvyGB5DBIY8XjOneg4Qj2k5bYBhUnxHS3GSeWhUzpOt8j5Ji/fi8KBNAtearN90oS0RZQoZPERs6OqRw33xI51RhUkzrojWmJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNBm8zcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B2C4CEF8;
	Wed, 15 Oct 2025 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512297;
	bh=+YN9iv/JKaRpqQa6Ykr9VD5uGu2CRTjueccIgjbhdmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNBm8zcxxXY1bW1Jx06JgkcDaCYB11moLnPLADeWeaWCvoe+GRIL0gbf+sLlgCe8H
	 +4D2ONNcUJrEZhesbBBxoePGgm7yTsePEWpUYmgXc+OlpJWn31es/QnYEIacJlczjV
	 AGqlxBiCtfiAaIOFXEEPOdbNvfxpdv4ToC6RwzhjswvOyRpFJWrDMkK2mmere5UNUK
	 n95C4lY8blVz38eHiYgRsWE9qLEnTySygu9US6T8CCeOceZyPTwE+d8dQdcy+MhGcm
	 lNdY8F4mJ0ycz6JQ22eUXpGtijKX9rOy2ctsVK4riTq5HqsMbQ26s4Gni4Nl9NZZA6
	 WYJXlAJsLTW8A==
Message-ID: <f7c41a0a-94d0-4189-b05c-bea31429b1be@kernel.org>
Date: Wed, 15 Oct 2025 16:11:35 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: allow file systems to increase the minimum writeback chunk size
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 hans.holmberg@wdc.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251015062728.60104-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251015062728.60104-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/15 15:27, Christoph Hellwig wrote:
> Hi all,
> 
> The relatively low minimal writeback size of 4MiB leads means that
> written back inodes on rotational media are switched a lot.  Besides
> introducing additional seeks, this also can lead to extreme file
> fragmentation on zoned devices when a lot of files are cached relative
> to the available writeback bandwidth.
> 							         
> Add a superblock field that allows the file system to override the
> default size, and set it to the zone size for zoned XFS.

For the series:

Tested-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

