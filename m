Return-Path: <linux-fsdevel+bounces-19301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030518C2F9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 07:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C01C210CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E24501F;
	Sat, 11 May 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6RNZzXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2B802
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715404026; cv=none; b=RnJOOupnIBEThHP9O0b7wliJ6KW4BdjQRrhbOTln1dYf5AQnJsTEBdX7wCHXf4u1Ubw4gQYeyihRzm3Hg5HWgBGtQHHdXdGDqpCzuKC6UwPESFtOTcwDl/s5OaWNZaHILhewn9Y60xAGd2FMCmEdkh0iQFW2rLajbU3qgZjAFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715404026; c=relaxed/simple;
	bh=2av7ldVmFODATl7G8x4XJ+ukXmnPObiC8mhBCT9hXG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg5lTTQNCL7R8uS0sJ0/dQochh4gqcck8ymRLpF4ETrO3DVutud1CY4oYx9zUyqGBn8p1usFe/55Ehn7ARpXLC8kCJsQZkp87Aa/QUMUlBuUjJ/inK6gQqCAmhMAQSrA72h7Gfamm0RXFimTughaLfDtA5HdQ4oieUVLINmf9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6RNZzXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715404023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TDNPYoMHZa+LiLBXZt4zxOSaybPS9naQJyx782OpWkg=;
	b=W6RNZzXkmx8gWX7jmRz3mKi9S/xwBQ1EsezKeXMU8qvs2F2bVc/BiRN9NPz+KDI8KOz7f9
	Jp9TLHhsLkP4/3mSjwRGXYop/z0abFqU810yoZWooGoy045Yt836tSjIdo+2p09yr4dsrN
	Gz+RpCPx2koblmbDuKHUFMiMeVe0oxA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-S9NI0gHoNbaY_WO2QXOyBQ-1; Sat, 11 May 2024 01:01:52 -0400
X-MC-Unique: S9NI0gHoNbaY_WO2QXOyBQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6f47c380709so1911663b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 22:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715403711; x=1716008511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDNPYoMHZa+LiLBXZt4zxOSaybPS9naQJyx782OpWkg=;
        b=CyhzopgYc5tf4zWtG5lvhdbSqW9P3VIl1N0P1Yj9gHWTCJcgTT1Lvc/IkGMDLHkSL3
         2ybiKxlpdH2gd7amBAhP3BGmxZ0Og+50scuGl1kSSekK97rwu+MzNhI0uTrLDJaAOnpW
         tU1q2HUUM7TVfM8unhU2kDrM/Qd3buUyFWCA4BqrOttkzLbg04OlKzEL6ODCuJi/84/k
         7d+ywGLI7GRuDLqozGYViaXSTnhEgLwHW+WC3kfJUekxuWbTJ03kq7UCKUNvRkfWsmLY
         Fc6Rp8+XTyv+tua+leCtdvYdNJ8jcpUq1tgfts2zuYj0oqNldnqMwCbQZYGGEBmnu3Tf
         CVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYaQZpaz8qOPpOcicAfYHA9pgNHzolecezL97chi9LSjiu4Yw51twxaGGTMpb0jeYyMqTOiF3s5RjC/Rl83/3eSvTFDaO+K7KvnK4cdw==
X-Gm-Message-State: AOJu0Yxxtupa4Xy/Ds7oI1L9N2xS2hQAniFaFRiNwVfP4zfz384S7Edx
	jV2kqKH53YXhawq3m6GrVJ4I0Yn7wd2YugEgIc2QUH1BjM4dXi+K2B2mxwwsXlNKmqQ6Tqm+u2a
	iNsCoQ2OfIZJNXYsOwHZbtExTY+huLAer/Etwpdv6YWzVx4UJoOB7Jv/OSZvSejo=
X-Received: by 2002:a05:6a20:7fa6:b0:1a9:6c18:7e96 with SMTP id adf61e73a8af0-1afde0e69demr4892821637.19.1715403710729;
        Fri, 10 May 2024 22:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBhS7yx2/bYWVvxBcMHhgvRgVdDMAnNnxTYn3AXqsfsQ/3xg5yARrJakUCW2UTPsJc3GeR9Q==
X-Received: by 2002:a05:6a20:7fa6:b0:1a9:6c18:7e96 with SMTP id adf61e73a8af0-1afde0e69demr4892793637.19.1715403710008;
        Fri, 10 May 2024 22:01:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782d89sm4030893a91.55.2024.05.10.22.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 22:01:49 -0700 (PDT)
Date: Sat, 11 May 2024 13:01:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCHSET v5.6] fstests: fs-verity support for XFS
Message-ID: <20240511050146.vc4jr2gagwjwwhdp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240430031134.GH360919@frogsfrogsfrogs>
 <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>

Hi Darrick,

Due to only half of this patchset got reviewed, so I'd like to wait for your
later version. I won't pick up part of this patchset to merge this time, I
think better to merge it as an integrated patchset.

Thanks,
Zorro

On Mon, Apr 29, 2024 at 08:19:24PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This patchset adds support for fsverity to XFS.  In keeping with
> Andrey's original design, XFS stores all fsverity metadata in the
> extended attribute data.  However, I've made a few changes to the code:
> First, it now caches merkle tree blocks directly instead of abusing the
> buffer cache.  This reduces lookup overhead quite a bit, at a cost of
> needing a new shrinker for cached merkle tree blocks.
> 
> To reduce the ondisk footprint further, I also made the verity
> enablement code detect trailing zeroes whenever fsverity tells us to
> write a buffer, and elide storing the zeroes.  To further reduce the
> footprint of sparse files, I also skip writing merkle tree blocks if the
> block contents are entirely hashes of zeroes.
> 
> Next, I implemented more of the tooling around verity, such as debugger
> support, as much fsck support as I can manage without knowing the
> internal format of the fsverity information; and added support for
> xfs_scrub to read fsverity files to validate the consistency of the data
> against the merkle tree.
> 
> Finally, I add the ability for administrators to turn off fsverity,
> which might help recovering damaged data from an inconsistent file.
> 
> From Andrey Albershteyn:
> 
> Here's v5 of my patchset of adding fs-verity support to XFS.
> 
> This implementation uses extended attributes to store fs-verity
> metadata. The Merkle tree blocks are stored in the remote extended
> attributes. The names are offsets into the tree.
> From Darrick J. Wong:
> 
> This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
> fsverity for XFS.
> 
> The biggest thing that I didn't like in the v5 patchset is the abuse of
> the data device's buffer cache to store the incore version of the merkle
> tree blocks.  Not only do verity state flags end up in xfs_buf, but the
> double-alloc flag wastes memory and doesn't remain internally consistent
> if the xattrs shift around.
> 
> I replaced all of that with a per-inode xarray that indexes incore
> merkle tree blocks.  For cache hits, this dramatically reduces the
> amount of work that xfs has to do to feed fsverity.  The per-block
> overhead is much lower (8 bytes instead of ~300 for xfs_bufs), and we no
> longer have to entertain layering violations in the buffer cache.  I
> also added a per-filesystem shrinker so that reclaim can cull cached
> merkle tree blocks, starting with the leaf tree nodes.
> 
> I've also rolled in some changes recommended by the fsverity maintainer,
> fixed some organization and naming problems in the xfs code, fixed a
> collision in the xfs_inode iflags, and improved dead merkle tree cleanup
> per the discussion of the v5 series.  At this point I'm happy enough
> with this code to start integrating and testing it in my trees, so it's
> time to send it out a coherent patchset for comments.
> 
> For v5.3, I've added bits and pieces of online and offline repair
> support, reduced the size of partially filled merkle tree blocks by
> removing trailing zeroes, changed the xattr hash function to better
> avoid collisions between merkle tree keys, made the fsverity
> invalidation bitmap unnecessary, and made it so that we can save space
> on sparse verity files by not storing merkle tree blocks that hash
> totally zeroed data blocks.
> 
> From Andrey Albershteyn:
> 
> Here's v5 of my patchset of adding fs-verity support to XFS.
> 
> This implementation uses extended attributes to store fs-verity
> metadata. The Merkle tree blocks are stored in the remote extended
> attributes. The names are offsets into the tree.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D
> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity
> 
> xfsprogs git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity
> ---
> Commits in this patchset:
>  * common/verity: enable fsverity for XFS
>  * xfs/{021,122}: adapt to fsverity xattrs
>  * xfs/122: adapt to fsverity
>  * xfs: test xfs_scrub detection and correction of corrupt fsverity metadata
>  * xfs: test disabling fsverity
>  * common/populate: add verity files to populate xfs images
> ---
>  common/populate    |   24 +++++++++
>  common/verity      |   39 ++++++++++++++-
>  tests/xfs/021      |    3 +
>  tests/xfs/122.out  |    3 +
>  tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1880.out |   37 ++++++++++++++
>  tests/xfs/1881     |  111 +++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1881.out |   28 +++++++++++
>  8 files changed, 378 insertions(+), 2 deletions(-)
>  create mode 100755 tests/xfs/1880
>  create mode 100644 tests/xfs/1880.out
>  create mode 100755 tests/xfs/1881
>  create mode 100644 tests/xfs/1881.out
> 


