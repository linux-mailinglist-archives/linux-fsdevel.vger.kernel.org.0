Return-Path: <linux-fsdevel+bounces-5102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A08080C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 07:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C9281A96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3D1947D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iNg3ojIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F0110
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 22:03:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce403523e5so187857b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 22:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701928997; x=1702533797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw2nLSqvqX2XEheC59D1y8xR9yWzVJ975ni9isQco04=;
        b=iNg3ojILUH+npH7vCfbZrwNGYrBHYFdEGWzBdNo0xywLZ+puNN8h6eupGiCAyHIcaG
         v8kmphKRSi2biLPMvItjVf/+rj76PPVRFDpMycUJgcTpFmzkSkLsduASw3LsK/fy9LnQ
         pCmFap0wXcJ4TS1w+x8kQKqjTOq9TIGvVTEJuA3/ZwJ+CKZPjnw+R83C/wXn7Ifrc30j
         uimqTo+p3GH3XLNmziVCiGwm86yhy1MZ/t/+UtJL4qRUGMk07fLasXeg3GG6K37Dbe36
         1i64UjjOvlKArHuEFMgqbikgQ+e7K3of2cL+sdjUKUHkPXh5jUtPdpfgI+EtsWQiNeNY
         oaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928997; x=1702533797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw2nLSqvqX2XEheC59D1y8xR9yWzVJ975ni9isQco04=;
        b=WZ9bEMrVP3pdhjASq7r1hMFrcwupuxJsEMZFDzrPH06eHtyt5vMLptmx+NaFSYQvJU
         dpCIraaqmXyV89hOSKSwdHPjyuYvaQjfeLqkvGk+/ax4YjT7sI/HwpbBdrzzHcd9l7E1
         uv8LWi79DDGux2ZDPcES2TieMGqspaIM+oSi7LeEA6gCWE0lHksIXIlf0bd70ralN2/e
         WHcmV9SsgGg5E92qUUpkhohqOAPBUMN6nV11uocJwtgghFTCgBIfg8VvkWmm8HxhPV8K
         YqAACi/pvVp0u5T9YjgHJ48Z6mfzkOGT560IHQJdxFf81sqjS5pTL+zCUNDs2q6bX7XN
         OpeA==
X-Gm-Message-State: AOJu0Yz4TGkMmG/7tYdjpTQvroXQeV7jtVc7P4JZ6zLWLWc0O7erGwA1
	Knsn/LpuQOJGX6nHYF6KMv2vRg==
X-Google-Smtp-Source: AGHT+IFgd6UXrTBxn5Iid8zFZidrdE58MM/eMedRH7B3IU8UEspNZeFe4AO8VUuMn1n7T9+bA5Ox3w==
X-Received: by 2002:a05:6a00:2195:b0:6ce:2d6d:24ac with SMTP id h21-20020a056a00219500b006ce2d6d24acmr2087457pfi.20.1701928997517;
        Wed, 06 Dec 2023 22:03:17 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id g193-20020a636bca000000b005b7dd356f75sm435756pgc.32.2023.12.06.22.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:03:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rB7Te-004xC7-2R;
	Thu, 07 Dec 2023 17:03:14 +1100
Date: Thu, 7 Dec 2023 17:03:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] vfs: inode cache conversion to hash-bl
Message-ID: <ZXFgIlVDNqFvEADn@dread.disaster.area>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-9-david@fromorbit.com>
 <20231207045844.u26r5vn26gtmqwe5@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207045844.u26r5vn26gtmqwe5@moria.home.lan>

On Wed, Dec 06, 2023 at 11:58:44PM -0500, Kent Overstreet wrote:
> On Wed, Dec 06, 2023 at 05:05:37PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Scalability of the global inode_hash_lock really sucks for
> > filesystems that use the vfs inode cache (i.e. everything but XFS).
> 
> Ages ago, we talked about (and I attempted, but ended up swearing at
> inode lifetime rules) - conversion to rhashtable instead, which I still
> believe would be preferable since that code is fully lockless (and
> resizeable, of course). But it turned out to be a much bigger project...

I don't think that the size of the has table is a big issue at the
moment. We already have RCU lookups for the inode cache
(find_inode_rcu() and find_inode_by_ino_rcu()) even before this
patchset, so we don't need rhashtable for that.

We still have to prevent duplicate inodes from being added to the cache
due to racing inserts, so I think we still need some form of
serialisation on the "lookup miss+insert" side. I've not thought
about it further than that - the hash-bl removes the existing
VFS contention points and the limitations move to
filesystem internal algorithms once again.

So until the filesystems can scale to much larger thread counts and
put the pressure back on the VFS inode cache scalability, I
don't see any need to try to do anything more complex or smarter...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

