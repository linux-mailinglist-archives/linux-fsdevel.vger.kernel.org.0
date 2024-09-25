Return-Path: <linux-fsdevel+bounces-30085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9F98607B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3810286F22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494F18A955;
	Wed, 25 Sep 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZJHGiHAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B115B562
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269312; cv=none; b=mLUAVOZ1gSeyaRj7nf0ZNoZShu6gixzu6cEX7DS/kKOqG8YBp1B48NuxyUwSBzCXM/1QGulRnXqZg9dysDIGO07MCm5X7L40f3l+QohEZSss/rlAfPklig1xQQ2MoB2Gsi24+0mL7DfgfcitMB0OYzuc5RbHkESfJVuV8gYSk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269312; c=relaxed/simple;
	bh=/I2QyuALtHqcZ4GKUEhdX0jON2I0ZTnTM6uixWW961A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUL3yMpCYC4cemRUO/HNonVbw7o9/0pIaWIbssK+zjD4terqWAW5hukV7vInEvIbe4LULr49JtVLJg1d594g+aTEhHlJMEL/e1He/Qdz1Qo+O/zIBwB5xS1h1WGVLXSWjp9b8c2Ehlf0tTcKwpgF3FgFbaEn7J6xg/zhS6o5cGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZJHGiHAF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7191f58054aso4989044b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727269310; x=1727874110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hs7Rj+geVPl0+wE/2Riapln7P4i8+opp+f+HJRO79M=;
        b=ZJHGiHAFS2AgScucvvWX3NCYCxcshW9W19k3I9uqzfr2w399/a/heKllDE6r+cbK9Q
         qOnyEIEsCNxa6x2kjeAufWFV8+88lbP/ElRRRHj23uxgUmdPBdw1ETd1aOhvh5bkvyvB
         yqzaxM5Y3J9BxcYmTF5Fo4xducN9rUSoS8gOtzBAqX8B1KvWvumrFPOtnSxkfQGKpJNW
         f6iSuDRv5k+8jWlJtUyU2JtSEEwIq4PEUPGwHO0fPnxdMgNs9e13MXt9mRK9W27/h5RN
         VJCO4ZaZYB2YisTYoEdelYlbWoSoTvi0yQz8jLL0yRNL8u8nG0CF4tCasEPck2/kGeyu
         SA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269310; x=1727874110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hs7Rj+geVPl0+wE/2Riapln7P4i8+opp+f+HJRO79M=;
        b=bShnWIs2Ym1O2mBaesr3k0n11Q8CiYE0/QA3tKxOLtEA4tbWUV7qFWZZMI3hSLthKL
         zTid44opWyWU4/I2Nnyke9STLAqww3XUTcXyBYXWxtRVyeykFI3NxO0+KUlKm77QabfS
         JD2eFAtCyXnluekVb8s789b/SQZ/PKghs12sVWSext6bxJMdEv/5OeRocN2YWhh2dc/K
         4POkevdqPT4SClvF73Txedk/GzJTIaa9rg78o1BenqFC3TjWkhgwwsKKVLT0J0GAyaJE
         fOcLY6sQlGgZD4nycDgB+eW8B8B1q3WLrQQDcZtzJ/cfMGycV6pOOV7sfL7u9tBJaMwS
         Nh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPQokIXfVIYXxC2xQSN1/PWBps0XwxPj1Me/bN8Xpr/EUxjS7aqFNAuRcuozX+WME1wcOJ6M9+1pdAIFxn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AkWNIGWoAxQxTY0hroDrlsPHZ4EkLouITRcUYnL82y1Qatbh
	X+Wk3gKoHbXDR0i3mOr386USFcHp9dL+ieAzhy4SrwGsIU1MSr0WY48e60WK5603yVND1pqkJP2
	z
X-Google-Smtp-Source: AGHT+IGhVDXpQmSdOuPcFz0YHbnVT7KRb9mz7wJNr05mOpzbhnXZwabgK4/OENvrYl39bd7adJnW7A==
X-Received: by 2002:a05:6a21:3997:b0:1cf:e5e5:263d with SMTP id adf61e73a8af0-1d4e0bf0da3mr4193230637.35.1727269309727;
        Wed, 25 Sep 2024 06:01:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c7326dsm2566998a12.66.2024.09.25.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:01:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stReM-009sBT-2S;
	Wed, 25 Sep 2024 23:01:46 +1000
Date: Wed, 25 Sep 2024 23:01:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 237/244] iomap: fix iomap_dio_zero() for fs
 bs > system page size
Message-ID: <ZvQJuuGxixcPgTUG@dread.disaster.area>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-237-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925113641.1297102-237-sashal@kernel.org>

On Wed, Sep 25, 2024 at 07:27:38AM -0400, Sasha Levin wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> [ Upstream commit 10553a91652d995274da63fc317470f703765081 ]
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.

Please drop this. It is for support of new functionality that was
just merged and has no relevance to older kernels. It is not a bug
fix.

And ....

> +
> +	set_memory_ro((unsigned long)page_address(zero_page),
> +		      1U << IOMAP_ZERO_PAGE_ORDER);

.... this will cause stable kernel regressions.

It was removed later in the merge because it is unnecessary and
causes boot failures on (at least) some Power architectures.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

