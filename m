Return-Path: <linux-fsdevel+bounces-64319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750FBE0B25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1C433582D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3C2D061B;
	Wed, 15 Oct 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="S5HTGDhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF113AA2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561369; cv=none; b=aBKkpUrEdbL3WZtT3NT3m3YE6BeEFfpE7QR+PO5+hcIBZ43C9IaEYNTVGsnUdKaczi3a8Uv5Y5NNmPTMxyYbIedYjMXODl+wrLHuUtiWm18g2QXTA86NnY5KBihilLkia3DFYoxX8KR8DSdAUBM5aaKkdZOi4PyeRahjCUepiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561369; c=relaxed/simple;
	bh=UmDLpH0vzZtApf00pfDiSU7Gyo9PT9iQwmLTp+p7NNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEj81tdgNxAhmc8+vZQky0fIZD1juOYdCLQiC1Zr/reQ6exqLHGCSEg59Ndd8h+Bm+a8febDZ6erX4m+XAzCaF2D2avFDSAf1BnqjdCP6KQzhAGKKJq/Z2HEWHWDuVdFY/ZCMeF5TrZtUs9+Iie6BjBI1h9lapRWnD808wIdI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=S5HTGDhc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so64529b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760561367; x=1761166167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auiaq9bXtW9OcLEmzCAQsL1QWCboNbAO7KbnHsw+v7A=;
        b=S5HTGDhcsc00RYv02MISYGgz5+oZIbltK9jaocIczgx9US7FsQCEdeSkdf5kM0C2hE
         uL+NsPp3Z+VIa6NPsm/Uydnbde4n8Dd9NkUGdThIHl7G0TsXJfbEZZpjZD0+Miu2NQqY
         UTV3jQIg11bThugDJeCPiHzrrd7rVCZyPoXXkoSH6njyd0le0P96a6wkzJaxWWr+hK5O
         7kjGIPH9feoYDz1AVQD4SMunR9cfMwxq53pOEvksybT6XaNi97nAmF03ZlCOEA7OXMa9
         RSrsf/GUk+aCFQGn9n3P+G2BY/5GqkEWxzjbmA5nF1SZuEE6J8W8NLsH/6V9vqbCNIkU
         w+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561367; x=1761166167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auiaq9bXtW9OcLEmzCAQsL1QWCboNbAO7KbnHsw+v7A=;
        b=D3N5oj9PCJojXz07yncvKysTlM1u6/0V73drOT1N6CQ5TiSAMWKmtVvb+2cHTV9QpY
         hylE4KByZ13zsDkILt67GV4SAVJstQmyPd47MB0qz6vj0UkUgMApbTdQA7d2Y9nCg8+/
         rxZkGShzN48wqknZUtrHi/cZpG/oJWXXGsxq/rkylBTxsvUqMJosPhpSfANQlMimLqfu
         WUuo6UYJxPATsbMNUvGs2F8qeCFZLgts6ieBs43GoYuJ+tt+nvM0OM+ZkGRFMkgiWJ/a
         Wb46k5vFjJVQTWwBzziubY5B+7gIEvRQxBmcB0GbtOpppLQZfAvIVORflVD1I6LjxjxN
         +JYg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/EBSyxFNtFswAqtaEoMuqLtUXhUB0a/hxctEY28DKTO9bYz4IgfmbpWOWmkV2PXpWJpAmYu7tErzJVd9@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEeqaEEkhFrRwinQu5f0yP0ghSmab6eOvXYrrXz+MsFiSGO1O
	+x50qXq0pbEwIInPsgbvOZT2jkiiEBOoAyLjznNd9EZs+pjiFgFcLIOUZxBTO9740uk=
X-Gm-Gg: ASbGncu+mFDX5z/dmfK3Lo+7tCIs2/hmfXl8aPoMXiqjhMyZjAGOKeCu0vTNtAUYN6H
	+lVAj1DhIgQmWHg1Tdu0TiHec7lBqRhEyr2cGZSEI4n17qJTOa6ztzI2/jQ8U85JAB8PHDFaBDJ
	fMzhoCebGwuxbDDPqK24rjkaQ+LalhiofGAVZhymIExh9oJ4EVjOOaKqD3xl4+qHvOTmM93QDm9
	tpw2E82IkhByBbn8POJlI+cLlLoft2cshtO3QqO8lh+T4pVjAlVZXKUmb09n+p9u5KrzJwWSzrm
	TZkO88uzV/rd4J6MvcgZc45aOjGVyHFs49nqgXmEsQ93TkKYtKi2XIFjcNwawvT3ZqhO2Ta7M3H
	U9IKFYaj9kVcKl8qeoM1TVMLPGuOL74psLidLVJZga1oSLQAWy7gdM/S0W9oDrZCVf++1Of8lZy
	1392mqWV6jK2LVBLJTDWzwLxoEub2uye+iVbxJIXxeSxAWcuJnGcimlFhoCcUqgA==
X-Google-Smtp-Source: AGHT+IHxmIPwCOfcZsbFhwrxgWT3gZcy36a1nJDg9vCya37PskWUDI/8725jdDe3RMayeVo56dRu2w==
X-Received: by 2002:a05:6a00:1406:b0:78a:f70d:b80c with SMTP id d2e1a72fcca58-79387826a86mr32369735b3a.22.1760561366355;
        Wed, 15 Oct 2025 13:49:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm19762406b3a.63.2025.10.15.13.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:49:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v98Qy-0000000FJEJ-1QPI;
	Thu, 16 Oct 2025 07:49:20 +1100
Date: Thu, 16 Oct 2025 07:49:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <aPAI0C23NqiON4Uv@dread.disaster.area>
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015062728.60104-3-hch@lst.de>

On Wed, Oct 15, 2025 at 03:27:15PM +0900, Christoph Hellwig wrote:
> The relatively low minimal writeback size of 4MiB leads means that
> written back inodes on rotational media are switched a lot.  Besides
> introducing additional seeks, this also can lead to extreme file
> fragmentation on zoned devices when a lot of files are cached relative
> to the available writeback bandwidth.
> 
> Add a superblock field that allows the file system to override the
> default size.

Hmmm - won't changing this for the zoned rtdev also change behaviour
for writeback on the data device?  i.e. upping the minimum for the
normal data device on XFS will mean writeback bandwidth sharing is a
lot less "fair" and higher latency when we have a mix of different
file sizes than it currently is...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

