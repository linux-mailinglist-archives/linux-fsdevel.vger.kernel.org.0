Return-Path: <linux-fsdevel+bounces-46313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4174A86B49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 08:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F2A8C8D45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED82189BB1;
	Sat, 12 Apr 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX1enEG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85C19007F
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744439187; cv=none; b=RPSeuVemxR3B637T2hZOmPUW4iVOFj/O9V0kwu7LLZOdYcUWqBDucIZjbLkcbDYqfEe53irBCzV55YQGNXnpBZKM2i+eJHfVysTHqjfJ3HamgZl50bZ3GTOzw8lwiUfvEPROwKK2YT9rsZxe1MriSHebxWsQfBmBtvOlfPOY2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744439187; c=relaxed/simple;
	bh=rDUctU+eo2yFrQzJGJ9WESLdOn2HFEikKze7FvMeujI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImdWeAvhgMc7EtHLvZFBL9J61OYtdh9lgr4EzA2DCPJlNvQk8sVmW6WjmYEEME+mgBa9nVWJaOiTslaIDpoSXs6w7d5FTsdHoLlk9V+MfslgcJZPmiCiKiRAY7A2BfLd3ihaW/6E7zAd1lt/AK7btCu0TSpMiev61AY5m/RWAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX1enEG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744439184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhyCkAg3D5KBPITY+5+z3w4CInNBgsp1dI1Gv1I9h54=;
	b=KX1enEG+kkEhzZdIVmV66jVDbOjJBDVFpD1TC3mhT1b6f9Em2tXJVmRygEmc4PGLUdudGI
	gJtdC93KtQ73SRyrxmNq+3RX0hQNK2MAI3rD6MH9sADDhCSH3VwpnlJl2brEURTaR81gmE
	g+IFBV+WVsBrfnAPAb/B7+jQJpdmJIs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-0VylTKSWMpOzEMNOH-jZ-g-1; Sat, 12 Apr 2025 02:26:20 -0400
X-MC-Unique: 0VylTKSWMpOzEMNOH-jZ-g-1
X-Mimecast-MFC-AGG-ID: 0VylTKSWMpOzEMNOH-jZ-g_1744439180
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224347aef79so35312615ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744439179; x=1745043979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhyCkAg3D5KBPITY+5+z3w4CInNBgsp1dI1Gv1I9h54=;
        b=gqYYGSgE+DKR5mUgGLFTE/3LWyQMl5kv69cAanp6RtQm1qmQT3pzPfMspJ+gEDw4Z9
         jIZobCuhz0gAigiy5hluOywbahqXDzNi8ZkOj6PmOz69BKwVA1vds1VdrK5/YhQXsDbV
         WSkBWi3fWMRWkEV4AiYEC/HsidVEJvfH2a66oegIjc7n3G0UrkPcvI1LRirirj/Si6uj
         jIwhQxcM4KH9mFkwFw35ClQPZRbcCBLjATKKqjfJm8lrUiEJrNctGjlFaDHSf7eE/SI4
         2ZQ/3t/QfliICH7ZawzRw10W5/JchEIsd3BtSEqNeiMz7jfkRd7VlwP637oVDIA06Xlk
         N8EA==
X-Forwarded-Encrypted: i=1; AJvYcCVXR/3JST8G0fx8wu3es0x0KaZ1jl6PaImZChwBMpTUL+bovJRMPBSFsUwButWd8B52xKxAEYExGFTU8B2E@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWWBTUovaoBOY5aSrudcMiD02Zl6TLWnzkMLmIwVFYAPt9r2m
	QO4+9++6nst3ByeQ+l5IRQ744C3ysanxxCusCWB/w8CzcGW9jRwtOTpDR7tlNL6bCxUN5Zc06zd
	KBxIjHI8ys4jjME5Gyub/S5phSx5pHLQK0RA7vkMa4Eix30e4LHwo6I5nPdWuWConioVjFIehpQ
	==
X-Gm-Gg: ASbGncuGRvsI8rrjfOi0Pubre90Ho0V+2yLqqVOrxtv/fWAHCNszHX6QG4irI6ubr09
	6OtVnXU91WqL9Xhs0yE3ncKCyn3v6YbUNYg9+MT3OsHz0Qn0KbmBkEa7LukPrhb6CeUX7R32hyK
	w9V1gFIHwgQgLE0D0d886al0t4/k2v0P4Y9c6CtcHwmISEuKA5X+BVvXl4q+5dE8lge4s/W8CrZ
	Q/e+etDwenFHtIhK7EBotKl4z16k6vDgJDklhozvWvEQozLxsljbYtWEAD1A9nih8bU3U2WhKPL
	1DK7huUrQyxhkj4QSDJ8wVx6l5yrzXVa+MVxa9QDpaRsSpOc1wfl
X-Received: by 2002:a17:903:2f82:b0:220:e896:54e1 with SMTP id d9443c01a7336-22bea4bd51fmr62788735ad.26.1744439179466;
        Fri, 11 Apr 2025 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwykgm1FHlVAYRYCNvtGCZ72xv/Yq/NfJh6r0aCsqgS4KLXIoLtijsNVpq3rMRkWF2I5R09w==
X-Received: by 2002:a17:903:2f82:b0:220:e896:54e1 with SMTP id d9443c01a7336-22bea4bd51fmr62788555ad.26.1744439178916;
        Fri, 11 Apr 2025 23:26:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccca88sm60972915ad.256.2025.04.11.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 23:26:18 -0700 (PDT)
Date: Sat, 12 Apr 2025 14:26:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <20250412062614.cvq4dqbcpkmwtzmh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328164609.188062-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328164609.188062-1-zlang@kernel.org>

On Sat, Mar 29, 2025 at 12:46:09AM +0800, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> 
> The v1 patch and review points:
> https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> 
> V2 did below things:
> 1) Fix some wrong english sentences
> 2) Explain the meaning of "+" and "-".
> 3) Add a link to btrfs comment.
> 4) Split ext2/3/4 to 3 lines.
> 5) Reorder the fs list by "Level".

Any more review points on this patch? If no more, I'll merge it as it got
an ACK at least. We still can update it later if anyone need.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
>  README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..5ceaa0c1e 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,93 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> +
> +As xfstests has many test cases that can be run on some other filesystems,
> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.
> +
> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +
> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> +("+" means a slightly higher than the current level, but not reach to the next.
> +"-" is opposite, means a little bit lower than the current level.)
> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> +|            |       | notes.html#fstests-setup                                |
> ++------------+-------+---------------------------------------------------------+
> +| Ext4       |  L4   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext3       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Exfat      |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| AFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| FUSE       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| GFS2       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Glusterfs  |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| JFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| pvfs2      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> ++------------+-------+---------------------------------------------------------+
> +| ubifs      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| udf        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Virtiofs   |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| 9p         |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +
>  _______________________
>  BUILDING THE FSQA SUITE
>  _______________________
> -- 
> 2.47.1
> 
> 


