Return-Path: <linux-fsdevel+bounces-14693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA187E281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E26280E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFE1EB21;
	Mon, 18 Mar 2024 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHp1mlmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2961E871
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732180; cv=none; b=tBnAstD+Dlb9K8Uyit3jxly3xSbUiWXLTK9omSDcFjDtlZRo127W3vbWeOQyQBnUa/Dh/kPXS013/nAkyD1aTpcIyYTqRebMTuiArBKBRcmzThu0MARDF/ntMV5ssUbVRxYgZ8TF8IyfZxPPIUllvkUFvUoFeUd44VOqUAU1N6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732180; c=relaxed/simple;
	bh=ITAeD2o4uzZJY9w6vlbq7Xo0uWJDTZefzMBUhhdQkRU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CcsP8jpzxECisZ9qOfhUZPLJlwOmdyvCc9YqoYs0+yZR+fZg67XJxHKYWhiv2TR8/j2fgJattw4NJk/HmlwweRTPWhIwqIHgyMQDll04I0VDJgXNcqJ7XiX/LsVjKeYgneQH9SLye+oBOkKjo6GsFsX4bpSshO7BjyTKQicPhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHp1mlmv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710732176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=60yJdxR/coTR1I9stBh6i+IXkRxwtpnPoK4mumXSE/s=;
	b=JHp1mlmvE+w4yldxRRcFNXABpXQC9bsOmXk4ZyqGGsa7AR6L+3lC4J/lbsoYB5eevpbD6P
	mWWqrZNee51nw9R8gIr4PZTAa8AyNp+DqIfhzQv2cBncwV2pdpWVdjasIBOSkCvgd0o2X2
	G0h9nzF2kHcSrNIHppSWRr5cQ+b3yl0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-LdpUrblCOv-lRXoQUcMDMw-1; Sun, 17 Mar 2024 23:22:53 -0400
X-MC-Unique: LdpUrblCOv-lRXoQUcMDMw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29bacf6d11eso3235248a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 20:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710732172; x=1711336972;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60yJdxR/coTR1I9stBh6i+IXkRxwtpnPoK4mumXSE/s=;
        b=vGkmXkRaj0oaNJprsmQ68Qdveuo2k1f7RnnjaXYYeppRpFFFpxaHDjhGsffMuO0Vqd
         ad4mlXhUEzV9hkPmuq4Bryptt+DX/dYqFKvwZ/4QxFHExcYrYHsexJ0umAF7fPxGr1w9
         PhW0ctx34hXuOFp8ygha70zuq4lDZ6zY9aoRIIUjvvHpIQaFYUqurnjfQyAoQwNaB8/6
         hyqowZ0rRGV1FI0EZwLQf8HoAYZ0O4RcSIiPJ18KyPLW+My6H14W3SKGjDWqU1rdnAzw
         ZdZfrOkI3m9zmD8plHSTdLmNqj3kfA0jp0MCmx7wgfW9cPFPB2DRMF7hTbt1ZjhN0k3X
         cJyA==
X-Forwarded-Encrypted: i=1; AJvYcCWIDgDOuixzv7LgpljWvMMJbvLNHF+oeAVrsQQonmoLAnkUog2N2sMLuNFsdJ+apIHPqY6Gp55OI0sAV3IVPA3sQajs2EpW7tNExvVSzg==
X-Gm-Message-State: AOJu0YwK8cjSoEv38iZ0OMN/l9QRLLByed7IBhNcQeWCj4WYBP+m2tqA
	sKcrM2qrVm73SGrMMN3SphqWIeNVgmm7p/JXzT9cb8Oc9XmV7jhKe3WV6X2wMY1zG+yo5Kv7bj5
	kj5pX5ouYfLAMXZBiemndM4dGaTbsgnpqXmGEOiP+ddqXicuFu8y4l3icZggaNeAUJMWaCGKuCo
	vxJdN8aoxZRVyJjkjimNhf2hnloH6UCkyMK9m95ZuUzdB51yZecUU=
X-Received: by 2002:a17:90b:4f85:b0:29f:ad98:b7ac with SMTP id qe5-20020a17090b4f8500b0029fad98b7acmr962596pjb.24.1710732171649;
        Sun, 17 Mar 2024 20:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOtsdqBE37hjk5FvEGfAgENv3gIGIa454PkTPAE9RtAzat6Wnq0Q6TWUlH9LUDx8Xt3xGRgCXXoeCKW5+Pmc0=
X-Received: by 2002:a17:90b:4f85:b0:29f:ad98:b7ac with SMTP id
 qe5-20020a17090b4f8500b0029fad98b7acmr962586pjb.24.1710732171157; Sun, 17 Mar
 2024 20:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 18 Mar 2024 11:22:39 +0800
Message-ID: <CAHj4cs8tbDwKRwfS1=DmooP73ysM__xAb2PQc6XsAmWR+VuYmg@mail.gmail.com>
Subject: [bug report] blktests nbd/003 lead kernel panic
To: linux-block <linux-block@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi
CKI recently reported one 100% reproduced panic[2] during blktests
nbd/003 on mainline from Mar 12, We didn't bisect it, but the first
commit we hit the problem was[1], pls help check it.

[1]
Commit message: Merge tag 'vfs-6.9.uuid' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs  (6.8.0,
mainline.kernel.org, 0f1a8766)

[2]
[ 1958.972721] run blktests nbd/003 at 2024-03-17 00:17:54
[ 1960.191937] mount_clear_soc: attempt to access beyond end of device
[ 1960.191937] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.192975] EXT4-fs (nbd0): unable to read superblock
[ 1960.194390] nbd0: detected capacity change from 0 to 20971520
[ 1960.195259] block nbd0: shutting down sockets
[ 1960.196731] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 1960.197458] Buffer I/O error on dev nbd0, logical block 0, async page read
[ 1960.197828] Buffer I/O error on dev nbd0, logical block 1, async page read
[ 1960.198176] Buffer I/O error on dev nbd0, logical block 2, async page read
[ 1960.198521] Buffer I/O error on dev nbd0, logical block 3, async page read
[ 1960.200421] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 1960.200918] Buffer I/O error on dev nbd0, logical block 0, async page read
[ 1960.201272] Buffer I/O error on dev nbd0, logical block 1, async page read
[ 1960.201638] Buffer I/O error on dev nbd0, logical block 2, async page read
[ 1960.202004] Buffer I/O error on dev nbd0, logical block 3, async page read
[ 1960.202385] ldm_validate_partition_table(): Disk read failed.
[ 1960.203201]  nbd0: unable to read partition table
[ 1960.203846] nbd0: partition table beyond EOD, truncated
[ 1960.204135] mount_clear_soc: attempt to access beyond end of device
[ 1960.204135] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.205131] EXT4-fs (nbd0): unable to read superblock
[ 1960.205951] mount_clear_soc: attempt to access beyond end of device
[ 1960.205951] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.207020] EXT4-fs (nbd0): unable to read superblock
[ 1960.207852] mount_clear_soc: attempt to access beyond end of device
[ 1960.207852] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.208991] EXT4-fs (nbd0): unable to read superblock
[ 1960.209915] mount_clear_soc: attempt to access beyond end of device
[ 1960.209915] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.211011] EXT4-fs (nbd0): unable to read superblock
[ 1960.211874] mount_clear_soc: attempt to access beyond end of device
[ 1960.211874] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.213030] EXT4-fs (nbd0): unable to read superblock
[ 1960.213940] mount_clear_soc: attempt to access beyond end of device
[ 1960.213940] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.215014] EXT4-fs (nbd0): unable to read superblock
[ 1960.215979] mount_clear_soc: attempt to access beyond end of device
[ 1960.215979] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.217080] EXT4-fs (nbd0): unable to read superblock
[ 1960.218108] mount_clear_soc: attempt to access beyond end of device
[ 1960.218108] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.219179] EXT4-fs (nbd0): unable to read superblock
[ 1960.220240] mount_clear_soc: attempt to access beyond end of device
[ 1960.220240] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1960.221301] EXT4-fs (nbd0): unable to read superblock
[ 1960.222232] EXT4-fs (nbd0): unable to read superblock
[ 1960.223184] EXT4-fs (nbd0): unable to read superblock
[ 1960.2515XT4-fs (nbd0): unable to read superblock
[ 1960.725161] EXT4-fs (nbd0): unable to read superblock
[ 1960.726466] EXT4-fs (nbd0): unable to read superblock
[ 1960.727608] EXT4-fs (nbd0): unable to read superblock
[ 1960.728735] EXT4-fs (nbd0): unable to read superblock
[ 1960.729936] EXT4-fs (nbd0): unable to read superblock
[ 1960.731384] EXT4-fs (nbd0): unable to read superblock
[ 1960.732549] EXT4-fs (nbd0): unable to read superblock
[ 1960.733705] EXT4-fs (nbd0): unable to read superblock
[ 1960.734684] EXT4-fs (nbd0): unable to read superblock
[ 1960.736129] EXT4-fs (nbd0): unable to read superblock
[ 1960.737279] EXT4-fs (nbd0): unable to read superblock
[ 1960.738602] EXT4-fs (nbd0): unable to read superblock
[ 1960.739782] EXT4-fs (nbd0): unable to read superblock
[ 1960.740977] EXT4-fs (nbd0): unable to read superblock
[ 1960.742091] EXT4-fs (nbd0): unable to read superblock
[ 1960.743224] EXT4-fs (nbd0): unable to read superblock
[ 1960.744431] EXT4-fs (nbd0): unable to read superblock
[ 1960.745712] EXT4-fs (nbd0): unable to read superblock
[ 1960.747001] EXT4-fs (nbd0): unable to read superblock
[ 1960.748272] EXT4-fs (nbd0): unable to read superblock
[ 1960.749417] EXT4-fs (nbd0): unable to read super[ 1961.240923]
EXT4-fs (nbd0): unable to read superblock
[ 1961.251356] EXT4-fs (nbd0): unable to read superblock
[ 1961.252550] EXT4-fs (nbd0): unable to read superblock
[ 1961.254150] EXT4-fs (nbd0): unable to read superblock
[ 1961.255535] EXT4-fs (nbd0): unable to read superblock
[ 1961.256591] EXT4-fs (nbd0): unable to read superblock
[ 1961.257787] EXT4-fs (nbd0): unable to read superblock
[ 1961.258931] EXT4-fs (nbd0): unable to read superblock
[ 1961.259970] EXT4-fs (nbd0): unable to read superblock
[ 1961.261323] EXT4-fs (nbd0): unable to read superblock
[ 1961.262494] EXT4-fs (nbd0): unable to read superblock
[ 1961.263715] EXT4-fs (nbd0): unable to read superblock
[ 1961.264991] EXT4-fs (nbd0): unable to read superblock
[ 1961.266122] EXT4-fs (nbd0): unable to read superblock
[ 1961.267279] EXT4-fs (nbd0): unable to read superblock
[ 1961.268437] EXT4-fs (nbd0): unable to read superblock
[ 1961.269543] EXT4-fs (nbd0): unable to read superblock
[ 1961.270535] EXT4-fs (nbd0): unable to read superblock
[ 1961.271606] EXT4-fs (nbd0): unable to read superblock
[ 1961.272626] EXT4-fs (nbd0): unable to read superblock
[ 1961.273679] EXT4-fs (nbd0): unable to read superblock
[ 1961.274721] EXT4-fs (nbd0): unable to read superblock[ 1961.769303]
EXT4-fs (nbd0): unable to read superblock
[ 1961.776594] EXT4-fs (nbd0): unable to read superblock
[ 1961.777954] EXT4-fs (nbd0): unable to read superblock
[ 1961.779495] EXT4-fs (nbd0): unable to read superblock
[ 1961.780668] EXT4-fs (nbd0): unable to read superblock
[ 1961.781779] EXT4-fs (nbd0): unable to read superblock
[ 1961.782660] EXT4-fs (nbd0): unable to read superblock
[ 1961.783670] EXT4-fs (nbd0): unable to read superblock
[ 1961.784746] EXT4-fs (nbd0): unable to read superblock
[ 1961.785656] EXT4-fs (nbd0): unable to read superblock
[ 1961.786988] EXT4-fs (nbd0): unable to read superblock
[ 1961.788270] EXT4-fs (nbd0): unable to read superblock
[ 1961.789463] EXT4-fs (nbd0): unable to read superblock
[ 1961.790684] EXT4-fs (nbd0): unable to read superblock
[ 1961.791758] EXT4-fs (nbd0): unable to read superblock
[ 1961.792764] EXT4-fs (nbd0): unable to read superblock
[ 1961.793864] EXT4-fs (nbd0): unable to read superblock
[ 1961.794883] EXT4-fs (nbd0): unable to read superblock
[ 1961.795889] EXT4-fs (nbd0): unable to read superblock
[ 1961.796912] EXT4-fs (nbd0): unable to read superblock
[ 1961.797982] EXT4-fs (nbd0): unable to read superblock
[ 1961.799208] EXT4-fs (nbd0): unable to read superblock
[ 1961.800292] EXT4-fs (nbd0): unable to read superblock
[ 1961.801355] EXT4-fs (nbd0): unable to read superblock
[ 1961.802389] EXT4-fperblock
[ 1962.303795] EXT4-fs (nbd0): unable to read superblock
[ 1962.305132] EXT4-fs (nbd0): unable to read superblock
[ 1962.306409] EXT4-fs (nbd0): unable to read superblock
[ 1962.307708] EXT4-fs (nbd0): unable to read superblock
[ 1962.308935] EXT4-fs (nbd0): unable to read superblock
[ 1962.310120] EXT4-fs (nbd0): unable to read superblock
[ 1962.311294] EXT4-fs (nbd0): unable to read superblock
[ 1962.312513] EXT4-fs (nbd0): unable to read superblock
[ 1962.313702] EXT4-fs (nbd0): unable to read superblock
[ 1962.314682] EXT4-fs (nbd0): unable to read superblock
[ 1962.315748] EXT4-fs (nbd0): unable to read superblock
[ 1962.316891] EXT4-fs (nbd0): unable to read superblock
[ 1962.318041] EXT4-fs (nbd0): unable to read superblock
[ 1962.319213] EXT4-fs (nbd0): unable to read superblock
[ 1962.320443] EXT4-fs (nbd0): unable to read superblock
[ 1962.321536] EXT4-fs (nbd0): unable to read superblock
[ 1962.322579] EXT4-fs (nbd0): unable to read superblock
[ 1962.323626] EXT4-fs (nbd0): unable to read superblock
[ 1962.324674] EXT4-fs (nbd0): unable to read superblock
[ 1962.325620] EXT4-fs (nbd0): unable to read superblock
[ 1962.326700] EXT4-fs (nbd0): unable to read superblock
[ 1962.327640] EXT4-fperblock
[ 1962.828982] EXT4-fs (nbd0): unable to read superblock
[ 1962.830270] EXT4-fs (nbd0): unable to read superblock
[ 1962.831500] EXT4-fs (nbd0): unable to read superblock
[ 1962.832782] EXT4-fs (nbd0): unable to read superblock
[ 1962.833862] EXT4-fs (nbd0): unable to read superblock
[ 1962.835039] EXT4-fs (nbd0): unable to read superblock
[ 1962.836420] EXT4-fs (nbd0): unable to read superblock
[ 1962.837434] EXT4-fs (nbd0): unable to read superblock
[ 1962.838755] EXT4-fs (nbd0): unable to read superblock
[ 1962.839996] EXT4-fs (nbd0): unable to read superblock
[ 1962.841161] EXT4-fs (nbd0): unable to read superblock
[ 1962.842484] EXT4-fs (nbd0): unable to read superblock
[ 1962.843745] EXT4-fs (nbd0): unable to read superblock
[ 1962.844748] EXT4-fs (nbd0): unable to read superblock
[ 1962.845678] EXT4-fs (nbd0): unable to read superblock
[ 1962.846676] EXT4-fs (nbd0): unable to read superblock
[ 1962.847650] EXT4-fs (nbd0): unable to read superblock
[ 1962.848708] EXT4-fs (nbd0): unable to read superblock
[ 1962.849657] EXT4-fs (nbd0): unable to read superblock
[ 1962.850658] EXT4-fs (nbd0): unable to read superblock
[ 1962.851653] EXT4-fs (nbd0): unable to read superblock
[ 1962.852571] EXT4-fs (nbd0): unable to read supeXT4-fs (nbd0):
unable to read superblock
[ 1963.254601] EXT4-fs (nbd0): unable to read superblock
[ 1963.255816] EXT4-fs (nbd0): unable to read superblock
[ 1963.257007] EXT4-fs (nbd0): unable to read superblock
[ 1963.258287] EXT4-fs (nbd0): unable to read superblock
[ 1963.259540] EXT4-fs (nbd0): unable to read superblock
[ 1963.260949] EXT4-fs (nbd0): unable to read superblock
[ 1963.262073] EXT4-fs (nbd0): unable to read superblock
[ 1963.263255] EXT4-fs (nbd0): unable to read superblock
[ 1963.264556] EXT4-fs (nbd0): unable to read superblock
[ 1963.265629] EXT4-fs (nbd0): unable to read superblock
[ 1963.266712] EXT4-fs (nbd0): unable to read superblock
[ 1963.267759] EXT4-fs (nbd0): unable to read superblock
[ 1963.268781] EXT4-fs (nbd0): unable to read superblock
[ 1963.269994] EXT4-fs (nbd0): unable to read superblock
[ 1963.271123] EXT4-fs (nbd0): unable to read superblock
[ 1963.272488] EXT4-fs (nbd0): unable to read superblock
[ 1963.273740] EXT4-fs (nbd0): unable to read superblock
[ 1963.274963] EXT4-fs (nbd0): unable to read superblock
[ 1963.276084] EXT4-fs (nbd0): unable to read superblock
[ 1963.277491] EXT4-fs (nperblock
[ 1963.778803] EXT4-fs (nbd0): unable to read superblock
[ 1963.780006] EXT4-fs (nbd0): unable to read superblock
[ 1963.781222] EXT4-fs (nbd0): unable to read superblock
[ 1963.782590] EXT4-fs (nbd0): unable to read superblock
[ 1963.783705] EXT4-fs (nbd0): unable to read superblock
[ 1963.784871] EXT4-fs (nbd0): unable to read superblock
[ 1963.786064] EXT4-fs (nbd0): unable to read superblock
[ 1963.787274] EXT4-fs (nbd0): unable to read superblock
[ 1963.788490] EXT4-fs (nbd0): unable to read superblock
[ 1963.789886] EXT4-fs (nbd0): unable to read superblock
[ 1963.791190] EXT4-fs (nbd0): unable to read superblock
[ 1963.792375] EXT4-fs (nbd0): unable to read superblock
[ 1963.793567] EXT4-fs (nbd0): unable to read superblock
[ 1963.795024] EXT4-fs (nbd0): unable to read superblock
[ 1963.796257] EXT4-fs (nbd0): unable to read superblock
[ 1963.797488] EXT4-fs (nbd0): unable to read superblock
[ 1963.798578] EXT4-fs (nbd0): unable to read superblock
[ 1963.799581] EXT4-fs (nbd0): unable to read superblock
[ 1963.800628] EXT4-fs (nbd0): unable to read superblock
[ 1963.801746] EXT4-fs (nbd0): unable to read superblock
[ 1963.802954] EXT4-fs (nbd0): unable to read superblock
[ 1963XT4-fs (nbd0): unable to read superblock
[ 1964.304751] EXT4-fs (nbd0): unable to read superblock
[ 1964.305880] EXT4-fs (nbd0): unable to read superblock
[ 1964.307073] EXT4-fs (nbd0): unable to read superblock
[ 1964.308417] EXT4-fs (nbd0): unable to read superblock
[ 1964.309567] EXT4-fs (nbd0): unable to read superblock
[ 1964.310702] EXT4-fs (nbd0): unable to read superblock
[ 1964.311732] EXT4-fs (nbd0): unable to read superblock
[ 1964.312797] EXT4-fs (nbd0): unable to read superblock
[ 1964.313966] EXT4-fs (nbd0): unable to read superblock
[ 1964.315098] EXT4-fs (nbd0): unable to read superblock
[ 1964.316325] EXT4-fs (nbd0): unable to read superblock
[ 1964.317292] EXT4-fs (nbd0): unable to read superblock
[ 1964.318254] EXT4-fs (nbd0): unable to read superblock
[ 1964.319484] EXT4-fs (nbd0): unable to read superblock
[ 1964.320690] EXT4-fs (nbd0): unable to read superblock
[ 1964.321654] EXT4-fs (nbd0): unable to read superblock
[ 1964.322677] EXT4-fs (nbd0): unable to read superblock
[ 1964.323821] EXT4-fs (nbd0): unable to read superblock
[ 1964.325088] EXT4-fs (nbd0): unable to read s[ 1964.826671] EXT4-fs
(nbd0): unable to read superblock
[ 1964.827837] EXT4-fs (nbd0): unable to read superblock
[ 1964.829110] EXT4-fs (nbd0): unable to read superblock
[ 1964.830370] EXT4-fs (nbd0): unable to read superblock
[ 1964.831591] EXT4-fs (nbd0): unable to read superblock
[ 1964.832720] EXT4-fs (nbd0): unable to read superblock
[ 1964.833711] EXT4-fs (nbd0): unable to read superblock
[ 1964.834904] EXT4-fs (nbd0): unable to read superblock
[ 1964.836119] EXT4-fs (nbd0): unable to read superblock
[ 1964.837462] EXT4-fs (nbd0): unable to read superblock
[ 1964.838563] EXT4-fs (nbd0): unable to read superblock
[ 1964.839732] EXT4-fs (nbd0): unable to read superblock
[ 1964.841018] EXT4-fs (nbd0): unable to read superblock
[ 1964.842147] EXT4-fs (nbd0): unable to read superblock
[ 1964.843357] EXT4-fs (nbd0): unable to read superblock
[ 1964.844368] EXT4-fs (nbd0): unable to read superblock
[ 1964.845506] EXT4-fs (nbd0): unable to read superblock
[ 1964.846639] EXT4-fs (nbd0): unable to read superblock
[ 1964.847537] EXT4-fs (nbd0): unable to read superblock
[ 1964.848711] EXT4-fs (nbd0): unable to read superblock
[ 1964.879io_check_eod: 226 callbacks suppressed
[ 1965.302867] mount_clear_soc: attempt to access beyond end of device
[ 1965.302867] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.351009] EXT4-fs (nbd0): unable to read superblock
[ 1965.352242] mount_clear_soc: attempt to access beyond end of device
[ 1965.352242] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.353307] EXT4-fs (nbd0): unable to read superblock
[ 1965.354610] mount_clear_soc: attempt to access beyond end of device
[ 1965.354610] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.355613] EXT4-fs (nbd0): unable to read superblock
[ 1965.356798] mount_clear_soc: attempt to access beyond end of device
[ 1965.356798] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.357890] EXT4-fs (nbd0): unable to read superblock
[ 1965.358943] mount_clear_soc: attempt to access beyond end of device
[ 1965.358943] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.360117] EXT4-fs (nbd0): unable to read superblock
[ 1965.361191] mount_clear_soc: attempt to access beyond end of device
[ 1965.361191] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.362233] EXT4-fs (nbd0): unable to read superblock
[ 1965.363217] mount_clear_soc: attempt to access beyond end of device
[nr_sectors = 2 limit=0
[ 1965.864302] EXT4-fs (nbd0): unable to read superblock
[ 1965.865571] mount_clear_soc: attempt to access beyond end of device
[ 1965.865571] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.866591] EXT4-fs (nbd0): unable to read superblock
[ 1965.867786] mount_clear_soc: attempt to access beyond end of device
[ 1965.867786] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1965.868906] EXT4-fs (nbd0): unable to read superblock
[ 1965.870151] EXT4-fs (nbd0): unable to read superblock
[ 1965.871487] EXT4-fs (nbd0): unable to read superblock
[ 1965.872595] EXT4-fs (nbd0): unable to read superblock
[ 1965.873736] EXT4-fs (nbd0): unable to read superblock
[ 1965.874997] EXT4-fs (nbd0): unable to read superblock
[ 1965.876149] EXT4-fs (nbd0): unable to read superblock
[ 1965.877479] EXT4-fs (nbd0): unable to read superblock
[ 1965.879177] EXT4-fs (nbd0): unable to read superblock
[ 1965.880498] EXT4-fs (nbd0): unable to read superblock
[ 1965.881584] EXT4-fs (nbd0): unable to read superblock
[ 1965.882842] EXT4-fs (nbd0): unable toperblock
[ 1966.384383] EXT4-fs (nbd0): unable to read superblock
[ 1966.385648] EXT4-fs (nbd0): unable to read superblock
[ 1966.386939] EXT4-fs (nbd0): unable to read superblock
[ 1966.388125] EXT4-fs (nbd0): unable to read superblock
[ 1966.389459] EXT4-fs (nbd0): unable to read superblock
[ 1966.390748] EXT4-fs (nbd0): unable to read superblock
[ 1966.392003] EXT4-fs (nbd0): unable to read superblock
[ 1966.393201] EXT4-fs (nbd0): unable to read superblock
[ 1966.394544] EXT4-fs (nbd0): unable to read superblock
[ 1966.395743] EXT4-fs (nbd0): unable to read superblock
[ 1966.396833] EXT4-fs (nbd0): unable to read superblock
[ 1966.397799] EXT4-fs (nbd0): unable to read superblock
[ 1966.398971] EXT4-fs (nbd0): unable to read superblock
[ 1966.400179] EXT4-fs (nbd0): unable to read superblock
[ 1966.401383] EXT4-fs (nbd0): unable to read superblock
[ 1966.402472] EXT4-fs (nbd0): unable to read superblock
[ 1966.403730] EXT4-fs (nbd0): unable to read superblock
[ 1966.404791] EXT4-fs (nbd0): unable to read superblock
[ 1966.405855] EXT4-fs (nbd0): unable to read superblock
[ 196XT4-fs (nbd0): unable to read superblock
[ 1966.807515] EXT4-fs (nbd0): unable to read superblock
[ 1966.808814] EXT4-fs (nbd0): unable to read superblock
[ 1966.810034] EXT4-fs (nbd0): unable to read superblock
[ 1966.811238] EXT4-fs (nbd0): unable to read superblock
[ 1966.812577] EXT4-fs (nbd0): unable to read superblock
[ 1966.813679] EXT4-fs (nbd0): unable to read superblock
[ 1966.814928] EXT4-fs (nbd0): unable to read superblock
[ 1966.816167] EXT4-fs (nbd0): unable to read superblock
[ 1966.817551] EXT4-fs (nbd0): unable to read superblock
[ 1966.818796] EXT4-fs (nbd0): unable to read superblock
[ 1966.819914] EXT4-fs (nbd0): unable to read superblock
[ 1966.821035] EXT4-fs (nbd0): unable to read superblock
[ 1966.822430] EXT4-fs (nbd0): unable to read superblock
[ 1966.823800] EXT4-fs (nbd0): unable to read superblock
[ 1966.825156] EXT4-fs (nbd0): unable to read superblock
[ 1966.826454] EXT4-fs (nbd0): unable to read superblock
[ 1966.827617] EXT4-fs (nbd0): unable to read superblock
[ 1966.828804] EXT4-fs (nbd0): unable to read superblock
[ 1966.829741] EXT4-fs (nbd0): unable to read superblock
[ 1966.830956] EXT4-fs (nbperblock
[ 1967.332488] EXT4-fs (nbd0): unable to read superblock
[ 1967.333868] EXT4-fs (nbd0): unable to read superblock
[ 1967.335094] EXT4-fs (nbd0): unable to read superblock
[ 1967.336428] EXT4-fs (nbd0): unable to read superblock
[ 1967.337695] EXT4-fs (nbd0): unable to read superblock
[ 1967.338896] EXT4-fs (nbd0): unable to read superblock
[ 1967.340071] EXT4-fs (nbd0): unable to read superblock
[ 1967.341248] EXT4-fs (nbd0): unable to read superblock
[ 1967.342619] EXT4-fs (nbd0): unable to read superblock
[ 1967.343894] EXT4-fs (nbd0): unable to read superblock
[ 1967.345060] EXT4-fs (nbd0): unable to read superblock
[ 1967.346474] EXT4-fs (nbd0): unable to read superblock
[ 1967.347792] EXT4-fs (nbd0): unable to read superblock
[ 1967.349003] EXT4-fs (nbd0): unable to read superblock
[ 1967.350395] EXT4-fs (nbd0): unable to read superblock
[ 1967.351747] EXT4-fs (nbd0): unable to read superblock
[ 1967.352737] EXT4-fs (nbd0): unable to read superblock
[ 1967.353756] EXT4-fs (nbd0): unable to read superblock
[ 1967.355008] EXT4-fs (nbd0): unable to read superblock
[ 1967.356323] EXT4-fs (nbd0): unable to read superblock
[ 1967.357618] EXT4-fs (nbdperblock
[ 1967.858991] EXT4-fs (nbd0): unable to read superblock
[ 1967.860160] EXT4-fs (nbd0): unable to read superblock
[ 1967.861756] EXT4-fs (nbd0): unable to read superblock
[ 1967.863055] EXT4-fs (nbd0): unable to read superblock
[ 1967.864493] EXT4-fs (nbd0): unable to read superblock
[ 1967.865762] EXT4-fs (nbd0): unable to read superblock
[ 1967.867017] EXT4-fs (nbd0): unable to read superblock
[ 1967.868449] EXT4-fs (nbd0): unable to read superblock
[ 1967.869716] EXT4-fs (nbd0): unable to read superblock
[ 1967.871118] EXT4-fs (nbd0): unable to read superblock
[ 1967.872507] EXT4-fs (nbd0): unable to read superblock
[ 1967.873794] EXT4-fs (nbd0): unable to read superblock
[ 1967.875087] EXT4-fs (nbd0): unable to read superblock
[ 1967.876262] EXT4-fs (nbd0): unable to read superblock
[ 1967.877604] EXT4-fs (nbd0): unable to read superblock
[ 1967.879644] EXT4-fs (nbd0): unable to read superblock
[ 1967.880867] EXT4-fs (nbd0): unable to read superblock
[ 1967.882136] EXT4-fs (nbd0): unable to read superblock
[ 1967.883483] EXT4-fs (nbd0): unable to read superblock
[ 1967.884715] EXT4-fs (nbd0): unable to read superblock
[ 1967.886040] EXT4-fs (nbd0): unable to read superblock
[ 1967.887220] EXT4-fs (nbd0): unable to read superblock
[ 1967.888566] EXT4-fs (nbd0): unable to read superblock
[ 1967.889673] EXT4-fs (nbd0): unable to read superblock
[ 1967.890897] EXT4-fs (nbd0): unable to read superblock
[ 1967.892052] EXT4-fs (nbd0):nable to read superblock
[ 1968.393772] EXT4-fs (nbd0): unable to read superblock
[ 1968.395087] EXT4-fs (nbd0): unable to read superblock
[ 1968.396414] EXT4-fs (nbd0): unable to read superblock
[ 1968.397752] EXT4-fs (nbd0): unable to read superblock
[ 1968.399036] EXT4-fs (nbd0): unable to read superblock
[ 1968.400338] EXT4-fs (nbd0): unable to read superblock
[ 1968.401699] EXT4-fs (nbd0): unable to read superblock
[ 1968.402928] EXT4-fs (nbd0): unable to read superblock
[ 1968.404187] EXT4-fs (nbd0): unable to read superblock
[ 1968.405561] EXT4-fs (nbd0): unable to read superblock
[ 1968.406862] EXT4-fs (nbd0): unable to read superblock
[ 1968.408117] EXT4-fs (nbd0): unable to read superblock
[ 1968.409472] EXT4-fs (nbd0): unable to read superblock
[ 1968.410806] EXT4-fs (nbd0): unable to read superblock
[ 1968.412001] EXT4-fs (nbd0): unable to read superblock
[ 1968.413062] EXT4-fs (nbd0): unable to read superblock
[ 1968.414294] EXT4-fs (nbd0): unable to read superblock
[ 1968.415574] EXT4-fs (nbd0): unable to read superblock
[ 1968.416864] EXT4-fs (nbd0): unable to read superblock
[ 1968.418182] EXT4-fs (nbd0): unable to read superblock
[ 1968.419594] EXT4-fs (nbd0): unable to read superblock
[ 1968.XT4-fs (nbd0): unable to read superblock
[ 1968.921536] EXT4-fs (nbd0): unable to read superblock
[ 1968.922607] EXT4-fs (nbd0): unable to read superblock
[ 1968.923842] EXT4-fs (nbd0): unable to read superblock
[ 1968.925111] EXT4-fs (nbd0): unable to read superblock
[ 1968.926578] EXT4-fs (nbd0): unable to read superblock
[ 1968.927822] EXT4-fs (nbd0): unable to read superblock
[ 1968.928951] EXT4-fs (nbd0): unable to read superblock
[ 1968.930040] EXT4-fs (nbd0): unable to read superblock
[ 1968.931187] EXT4-fs (nbd0): unable to read superblock
[ 1968.932392] EXT4-fs (nbd0): unable to read superblock
[ 1968.933534] EXT4-fs (nbd0): unable to read superblock
[ 1968.934919] EXT4-fs (nbd0): unable to read superblock
[ 1968.936053] EXT4-fs (nbd0): unable to read superblock
[ 1968.937189] EXT4-fs (nbd0): unable to read superblock
[ 1968.938516] EXT4-fs (nbd0): unable to read superblock
[ 1968.939730] EXT4-fs (nbd0): unable to read superblock
[ 1968.940939] EXT4-fs (nbd0): unable to read superblock
[ 1968.942064] EXT4-fs (nbd0): unable to read superblock
[ 1968.943292] EXT4-fs (nbd0): unable to read superblock
[ 1968.944552] EXT4-fs (nbd0): unable to read superb[ 1969.434709]
EXT4-fs (nbd0): unable to read superblock
[ 1969.446413] EXT4-fs (nbd0): unable to read superblock
[ 1969.447651] EXT4-fs (nbd0): unable to read superblock
[ 1969.448940] EXT4-fs (nbd0): unable to read superblock
[ 1969.450019] EXT4-fs (nbd0): unable to read superblock
[ 1969.451324] EXT4-fs (nbd0): unable to read superblock
[ 1969.452568] EXT4-fs (nbd0): unable to read superblock
[ 1969.453692] EXT4-fs (nbd0): unable to read superblock
[ 1969.454829] EXT4-fs (nbd0): unable to read superblock
[ 1969.456246] EXT4-fs (nbd0): unable to read superblock
[ 1969.457578] EXT4-fs (nbd0): unable to read superblock
[ 1969.458841] EXT4-fs (nbd0): unable to read superblock
[ 1969.460127] EXT4-fs (nbd0): unable to read superblock
[ 1969.461502] EXT4-fs (nbd0): unable to read superblock
[ 1969.462804] EXT4-fs (nbd0): unable to read superblock
[ 1969.463860] EXT4-fs (nbd0): unable to read superblock
[ 1969.465039] EXT4-fs (nbd0): unable to read superblock
[ 1969.465989] EXT4-fs (nbd0): unable to read superblock
[ 1969.467005] EXT4-fs (nbd0): unable to read superblock
[ 1969.468098] EXT4-fs (nbd0): unable to read superblock
[ 1969.469265] EXT4-fs (nbd0): unable to read superblock
[ 1969.470522] EXT4-fs (nbd0): unable to read superblock
[ 1969.471633] EXT4-fs (nbd0): unable to read superblocXT4-fs (nbd0):
unable to read superblock
[ 1969.873378] EXT4-fs (nbd0): unable to read superblock
[ 1969.875075] EXT4-fs (nbd0): unable to read superblock
[ 1969.876415] EXT4-fs (nbd0): unable to read superblock
[ 1969.878475] EXT4-fs (nbd0): unable to read superblock
[ 1969.879625] EXT4-fs (nbd0): unable to read superblock
[ 1969.881027] EXT4-fs (nbd0): unable to read superblock
[ 1969.882237] EXT4-fs (nbd0): unable to read superblock
[ 1969.883698] EXT4-fs (nbd0): unable to read superblock
[ 1969.884947] EXT4-fs (nbd0): unable to read superblock
[ 1969.886205] EXT4-fs (nbd0): unable to read superblock
[ 1969.887415] EXT4-fs (nbd0): unable to read superblock
[ 1969.888692] EXT4-fs (nbd0): unable to read superblock
[ 1969.889891] EXT4-fs (nbd0): unable to read superblock
[ 1969.891025] EXT4-fs (nbd0): unable to read superblock
[ 1969.892109] EXT4-fs (nbd0): unable to read superblock
[ 1969.893421] EXT4-fs (nbd0): unable to read superblock
[ 1969.894754] EXT4-fs (nbd0): unable to read superblock
[ 1969.895946] EXT4-fs (nbd0): unable to read superblock
[ 1969.897157] EXT4-fs (nbd0): unable to read superblock
[ 1969.898387] EXT4-fs (nbd0): unable to read superblock
[ 1969.899713] EXT4-fs (nbd0): unable to read sperblock
[ 1970.401549] bio_check_eod: 210 callbacks suppressed
[ 1970.401554] mount_clear_soc: attempt to access beyond end of device
[ 1970.401554] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.403386] EXT4-fs (nbd0): unable to read superblock
[ 1970.404592] mount_clear_soc: attempt to access beyond end of device
[ 1970.404592] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.405660] EXT4-fs (nbd0): unable to read superblock
[ 1970.406944] mount_clear_soc: attempt to access beyond end of device
[ 1970.406944] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.408074] EXT4-fs (nbd0): unable to read superblock
[ 1970.409264] mount_clear_soc: attempt to access beyond end of device
[ 1970.409264] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.410520] EXT4-fs (nbd0): unable to read superblock
[ 1970.411704] mount_clear_soc: attempt to access beyond end of device
[ 1970.411704] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.412851] EXT4-fs (nbd0): unable to read superblock
[ 1970.414014] mount_clear_soc: attempt to access beyond end of device
[ 1970.414014] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.415097] EXT4-fs (nbd0): unable to read superblock
[ 1970.416330] mount_clear_soc: attempt to acces67120] nbd0: rw=4096,
sector=2, nr_sectors = 2 limit=0
[ 1970.917990] EXT4-fs (nbd0): unable to read superblock
[ 1970.919273] mount_clear_soc: attempt to access beyond end of device
[ 1970.919273] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.920541] EXT4-fs (nbd0): unable to read superblock
[ 1970.921894] mount_clear_soc: attempt to access beyond end of device
[ 1970.921894] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1970.922979] EXT4-fs (nbd0): unable to read superblock
[ 1970.924048] EXT4-fs (nbd0): unable to read superblock
[ 1970.925234] EXT4-fs (nbd0): unable to read superblock
[ 1970.926397] EXT4-fs (nbd0): unable to read superblock
[ 1970.927619] EXT4-fs (nbd0): unable to read superblock
[ 1970.928881] EXT4-fs (nbd0): unable to read superblock
[ 1970.930101] EXT4-fs (nbd0): unable to read superblock
[ 1970.931216] EXT4-fs (nbd0): unable to read superblock
[ 1970.932587] EXT4-fs (nbd0): unable to read superblock
[ 1970.933800] EXT4-fs (nbd0): unable to read superblock
[ 1970.934921] EXT4-fs (nbd0): unable to read superblock
[ 1970.936074] EXT4-fs (nbd0): unable to read superblock
[ 1970.937272] EXT4-fs (nbd0): unable to read superblock
[ 1970.938518] EXT4-fs (nbd0): unable to read super[ 1971.439977]
EXT4-fs (nbd0): unable to read superblock
[ 1971.441138] EXT4-fs (nbd0): unable to read superblock
[ 1971.442545] EXT4-fs (nbd0): unable to read superblock
[ 1971.443886] EXT4-fs (nbd0): unable to read superblock
[ 1971.445055] EXT4-fs (nbd0): unable to read superblock
[ 1971.446192] EXT4-fs (nbd0): unable to read superblock
[ 1971.447646] EXT4-fs (nbd0): unable to read superblock
[ 1971.448964] EXT4-fs (nbd0): unable to read superblock
[ 1971.450108] EXT4-fs (nbd0): unable to read superblock
[ 1971.451538] EXT4-fs (nbd0): unable to read superblock
[ 1971.452877] EXT4-fs (nbd0): unable to read superblock
[ 1971.454019] EXT4-fs (nbd0): unable to read superblock
[ 1971.455126] EXT4-fs (nbd0): unable to read superblock
[ 1971.456541] EXT4-fs (nbd0): unable to read superblock
[ 1971.457775] EXT4-fs (nbd0): unable to read superblock
[ 1971.458936] EXT4-fs (nbd0): unable to read superblock
[ 1971.460117] EXT4-fs (nbd0): unable to read superblock
[ 1971.461490] EXT4-fs (nbd0): unable to read superblock
[ 1971.462596] EXT4-fs (nbd0): unable to read superblock
[ 1971.463902] EXT4-fs (nbd0): unable to read superblock
[ 1971.465182] EXT4-fs (nbd0): unable to read superblock
[ 1971.466450] EXT4-fs (nbd0): unable to read superblock
[ 1971.467630] EXT4-fs (nbd0): unable to read superbl[ 1971.967075]
EXT4-fs (nbd0): unable to read superblock
[ 1971.969578] EXT4-fs (nbd0): unable to read superblock
[ 1971.970836] EXT4-fs (nbd0): unable to read superblock
[ 1971.972149] EXT4-fs (nbd0): unable to read superblock
[ 1971.973543] EXT4-fs (nbd0): unable to read superblock
[ 1971.974864] EXT4-fs (nbd0): unable to read superblock
[ 1971.975870] EXT4-fs (nbd0): unable to read superblock
[ 1971.976890] EXT4-fs (nbd0): unable to read superblock
[ 1971.978414] EXT4-fs (nbd0): unable to read superblock
[ 1971.979558] EXT4-fs (nbd0): unable to read superblock
[ 1971.980639] EXT4-fs (nbd0): unable to read superblock
[ 1971.981734] EXT4-fs (nbd0): unable to read superblock
[ 1971.982758] EXT4-fs (nbd0): unable to read superblock
[ 1971.983869] EXT4-fs (nbd0): unable to read superblock
[ 1971.984783] EXT4-fs (nbd0): unable to read superblock
[ 1971.986014] EXT4-fs (nbd0): unable to read superblock
[ 1971.986920] EXT4-fs (nbd0): unable to read superblock
[ 1971.987864] EXT4-fs (nbd0): unable to read superblock
[ 1971.989016] EXT4-fs (nbd0): unable to read superblock
[ 1971.989911] EXT4-fs (nbd0): unable to read superblock
[ 1971.990761] EXT4-fs (nbd0): unable [ 1972.492289] EXT4-fs (nbd0):
unable to read superblock
[ 1972.493687] EXT4-fs (nbd0): unable to read superblock
[ 1972.494988] EXT4-fs (nbd0): unable to read superblock
[ 1972.496177] EXT4-fs (nbd0): unable to read superblock
[ 1972.497656] EXT4-fs (nbd0): unable to read superblock
[ 1972.498883] EXT4-fs (nbd0): unable to read superblock
[ 1972.500168] EXT4-fs (nbd0): unable to read superblock
[ 1972.501586] EXT4-fs (nbd0): unable to read superblock
[ 1972.502905] EXT4-fs (nbd0): unable to read superblock
[ 1972.504588] EXT4-fs (nbd0): unable to read superblock
[ 1972.505905] EXT4-fs (nbd0): unable to read superblock
[ 1972.507266] EXT4-fs (nbd0): unable to read superblock
[ 1972.508695] EXT4-fs (nbd0): unable to read superblock
[ 1972.509969] EXT4-fs (nbd0): unable to read superblock
[ 1972.511141] EXT4-fs (nbd0): unable to read superblock
[ 1972.512423] EXT4-fs (nbd0): unable to read superblock
[ 1972.513625] EXT4-fs (nbd0): unable to read superblock
[ 1972.514714] EXT4-fs (nbd0): unable to read superblock
[ 1972.516068] EXT4-fs (nbd0): unable to read superblock
[ 1972.517208] EXT4-fs (nbd0): unable to read superblock
[ 1972.548XT4-fs (nbd0): unable to read superblock
[ 1973.019078] EXT4-fs (nbd0): unable to read superblock
[ 1973.020565] EXT4-fs (nbd0): unable to read superblock
[ 1973.021932] EXT4-fs (nbd0): unable to read superblock
[ 1973.023134] EXT4-fs (nbd0): unable to read superblock
[ 1973.024605] EXT4-fs (nbd0): unable to read superblock
[ 1973.025755] EXT4-fs (nbd0): unable to read superblock
[ 1973.026872] EXT4-fs (nbd0): unable to read superblock
[ 1973.028181] EXT4-fs (nbd0): unable to read superblock
[ 1973.029412] EXT4-fs (nbd0): unable to read superblock
[ 1973.030657] EXT4-fs (nbd0): unable to read superblock
[ 1973.031930] EXT4-fs (nbd0): unable to read superblock
[ 1973.033112] EXT4-fs (nbd0): unable to read superblock
[ 1973.034274] EXT4-fs (nbd0): unable to read superblock
[ 1973.035467] EXT4-fs (nbd0): unable to read superblock
[ 1973.036672] EXT4-fs (nbd0): unable to read superblock
[ 1973.037878] EXT4-fs (nbd0): unable to read superblock
[ 1973.039075] EXT4-fs (nbd0): unable to read superblock
[ 1973.040057] EXT4-fs (nbd0): unable to read superblock
[ 1973.041061] EXT4-fs (nbd0): unable to read superblock
[ 1973.042092] EXT4-fs (nbd0): unable to read superblock
[ 1973.043203] EXT4-fs (nbd0): unable to read superblock
[ 1973.044258] EXT4-fs (nbd0): unable to read superblock
[ 1973.045557] EXT4-fs (nbd0): unable t[ 1973.430952] EXT4-fs (nbd0):
unable to read superblock
[ 1973.447205] EXT4-fs (nbd0): unable to read superblock
[ 1973.448741] EXT4-fs (nbd0): unable to read superblock
[ 1973.449877] EXT4-fs (nbd0): unable to read superblock
[ 1973.450919] EXT4-fs (nbd0): unable to read superblock
[ 1973.452192] EXT4-fs (nbd0): unable to read superblock
[ 1973.453600] EXT4-fs (nbd0): unable to read superblock
[ 1973.454682] EXT4-fs (nbd0): unable to read superblock
[ 1973.455893] EXT4-fs (nbd0): unable to read superblock
[ 1973.457170] EXT4-fs (nbd0): unable to read superblock
[ 1973.458317] EXT4-fs (nbd0): unable to read superblock
[ 1973.459596] EXT4-fs (nbd0): unable to read superblock
[ 1973.461197] EXT4-fs (nbd0): unable to read superblock
[ 1973.462475] EXT4-fs (nbd0): unable to read superblock
[ 1973.463621] EXT4-fs (nbd0): unable to read superblock
[ 1973.465069] EXT4-fs (nbd0): unable to read superblock
[ 1973.466208] EXT4-fs (nbd0): unable to read superblock
[ 1973.467558] EXT4-fs (nbd0): unable to read superblock
[ 1973.469073] EXT4-fs (nbd0): unable to read superblock
[ 1973.470293] EXT4-fs (nbd0): unable to read superblock
[ 1973.471588] EXT4-fs (nbd0): unable to read superblock
[ 1973.472837] EXT4-fs (nbd0): unable to read superblock
[ 1973.473753] EXT4-fs (nbd0): unable to read superblock
[ 1973.474920] EXT4-fs (nbd0): unable to read superblock
[ 1973.475938] EXT4-fs (nbd0): unable to read superblock
[ 1973.477404] EXT4-fs (nbd0): unable to[ 1973.979001] EXT4-fs (nbd0):
unable to read superblock
[ 1973.980320] EXT4-fs (nbd0): unable to read superblock
[ 1973.981812] EXT4-fs (nbd0): unable to read superblock
[ 1973.983017] EXT4-fs (nbd0): unable to read superblock
[ 1973.984322] EXT4-fs (nbd0): unable to read superblock
[ 1973.985738] EXT4-fs (nbd0): unable to read superblock
[ 1973.987155] EXT4-fs (nbd0): unable to read superblock
[ 1973.988483] EXT4-fs (nbd0): unable to read superblock
[ 1973.990115] EXT4-fs (nbd0): unable to read superblock
[ 1973.991275] EXT4-fs (nbd0): unable to read superblock
[ 1973.992552] EXT4-fs (nbd0): unable to read superblock
[ 1973.993765] EXT4-fs (nbd0): unable to read superblock
[ 1973.994944] EXT4-fs (nbd0): unable to read superblock
[ 1973.996145] EXT4-fs (nbd0): unable to read superblock
[ 1973.997285] EXT4-fs (nbd0): unable to read superblock
[ 1973.998482] EXT4-fs (nbd0): unable to read superblock
[ 1973.999627] EXT4-fs (nbd0): unable to read superblock
[ 1974.000697] EXT4-fs (nbd0): unable to read superblock
[ 1974.001706] EXT4-fs (nbd0): unable to read superblock
[ 1974.002880] EXT4-fs (nbd0): unable to read superblock
[ 1974.03[ 1974.475084] EXT4-fs (nbd0): unable to read superblock
[ 1974.505082] EXT4-fs (nbd0): unable to read superblock
[ 1974.506143] EXT4-fs (nbd0): unable to read superblock
[ 1974.507386] EXT4-fs (nbd0): unable to read superblock
[ 1974.508735] EXT4-fs (nbd0): unable to read superblock
[ 1974.510034] EXT4-fs (nbd0): unable to read superblock
[ 1974.511149] EXT4-fs (nbd0): unable to read superblock
[ 1974.512369] EXT4-fs (nbd0): unable to read superblock
[ 1974.513666] EXT4-fs (nbd0): unable to read superblock
[ 1974.514934] EXT4-fs (nbd0): unable to read superblock
[ 1974.516180] EXT4-fs (nbd0): unable to read superblock
[ 1974.517522] EXT4-fs (nbd0): unable to read superblock
[ 1974.518802] EXT4-fs (nbd0): unable to read superblock
[ 1974.519970] EXT4-fs (nbd0): unable to read superblock
[ 1974.521141] EXT4-fs (nbd0): unable to read superblock
[ 1974.522234] EXT4-fs (nbd0): unable to read superblock
[ 1974.523580] EXT4-fs (nbd0): unable to read superblock
[ 1974.524815] EXT4-fs (nbd0): unable to read superblock
[ 1974.526017] EXT4-fs (nbd0): unable to read superblock
[ 1974.527196] EXT4-fs (nbd0): unable to read superblock
[ 1974.528593] EXT4-fs (nbd0): unable to read superblock
[ 1974.529885] EXT4-fs (nbd0): unable to read superblock
[ [ 1975.031424] EXT4-fs (nbd0): unable to read superblock
[ 1975.032782] EXT4-fs (nbd0): unable to read superblock
[ 1975.034091] EXT4-fs (nbd0): unable to read superblock
[ 1975.035352] EXT4-fs (nbd0): unable to read superblock
[ 1975.036692] EXT4-fs (nbd0): unable to read superblock
[ 1975.037991] EXT4-fs (nbd0): unable to read superblock
[ 1975.039322] EXT4-fs (nbd0): unable to read superblock
[ 1975.040565] EXT4-fs (nbd0): unable to read superblock
[ 1975.041701] EXT4-fs (nbd0): unable to read superblock
[ 1975.042957] EXT4-fs (nbd0): unable to read superblock
[ 1975.044086] EXT4-fs (nbd0): unable to read superblock
[ 1975.045396] EXT4-fs (nbd0): unable to read superblock
[ 1975.046711] EXT4-fs (nbd0): unable to read superblock
[ 1975.047956] EXT4-fs (nbd0): unable to read superblock
[ 1975.048935] EXT4-fs (nbd0): unable to read superblock
[ 1975.050139] EXT4-fs (nbd0): unable to read superblock
[ 1975.051296] EXT4-fs (nbd0): unable to read superblock
[ 1975.052417] EXT4-fs (nbd0): unable to read superblock
[ 1975.053654] EXT4-fs (nbd0): unable to read superblock
[ 1975.054968] EXT4-fs (nbd0): unable to read superblock
[ 1975.08[ 1975.531562] bio_check_eod: 215 callbacks suppressed
[ 1975.531566] mount_clear_soc: attempt to access beyond end of device
[ 1975.531566] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.557154] EXT4-fs (nbd0): unable to read superblock
[ 1975.558576] mount_clear_soc: attempt to access beyond end of device
[ 1975.558576] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.559633] EXT4-fs (nbd0): unable to read superblock
[ 1975.560951] mount_clear_soc: attempt to access beyond end of device
[ 1975.560951] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.561954] EXT4-fs (nbd0): unable to read superblock
[ 1975.563104] mount_clear_soc: attempt to access beyond end of device
[ 1975.563104] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.564184] EXT4-fs (nbd0): unable to read superblock
[ 1975.565473] mount_clear_soc: attempt to access beyond end of device
[ 1975.565473] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.566587] EXT4-fs (nbd0): unable to read superblock
[ 1975.567951] mount_clear_soc: attempt to access beyond end of device
[ 1975.567951] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.569011] EXT4-fs (nbd0): unable to read superblock
[ 1975.570196] mount_clear_soc: attempt to access beyond end of device
[ 1975.570196] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ s beyond end of device
[ 1975.771395] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1975.965355] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1975.965358] #PF: supervisor instruction fetch in kernel mode
[ 1975.965360] #PF: error_code(0x0010) - not-present page
[ 1975.965362] PGD 0 P4D 0
[ 1975.965365] Oops: 0010 [#1] PREEMPT SMP PTI
[ 1975.965369] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G        W I
     6.8.0 #1
[ 1975.965373] Hardware name: HP ProLiant DL360e Gen8, BIOS P73 05/24/2019
[ 1975.965375] RIP: 0010:0x0
[ 1976.072029] EXT4-fs (nbd0): unable to read superblock
[ 1976.072297] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 1976.073790] mount_clear_soc: attempt to access beyond end of device
[ 1976.073790] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1976.074355] RSP: 0018:ffffb79741fc0eb8 EFLAGS: 00010282
[ 1976.074709] EXT4-fs (nbd0): unable to read superblock
[ 1976.074822]
[ 1976.075594] mount_clear_soc: attempt to access beyond end of device
[ 1976.075594] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 1976.076338] RAX: 0000000000000001 RBX: 0000000000000003 RCX: 0000000000000000
[ 1976.076624] EXT4-fs (nbd0): unable to read superblock
[ 1976.076870] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94d18d952ce8
[ 1976.077974] EXT4-fs (nbd0): unable to read superblock
[ 1976.078348] RBP: ffff94d2[ 1976.080108] R13: ffffb79741fc0ef0 R14:
0000000000000002 R15: 0000000000000000
[ 1976.080111] FS:  0000000000000000(0000) GS:ffff94d4b7900000(0000)
knlGS:0000000000000000
[ 1976.080983] EXT4-fs (nbd0): unable to read superblock
[ 1976.247337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1976.247340] CR2: ffffffffffffffd6 CR3: 00000000b8422003 CR4: 00000000000606f0
[ 1976.247343] Call Trace:
[ 1976.247345]  <IRQ>
[ 1976.247346]  ? __die+0x23/0x70
[ 1976.247353]  ? page_fault_oops+0x170/0x580
[ 1976.247357]  ? exc_page_fault+0x7e/0x180
[ 1976.247363]  ? asm_exc_page_fault+0x26/0x30
[ 1976.247371]  rcu_do_batch+0x1c6/0x560
[ 1976.441610] EXT4-fs (nbd0): unable to read superblock
[ 1976.578818]  ? rcu_do_batch+0x165/0x560
[ 1976.578823]  rcu_core+0x1b2/0x4b0
[ 1976.578827]  __do_softirq+0xd9/0x2c5
[ 1976.578833]  __irq_exit_rcu+0x95/0xb0
[ 1976.582102] EXT4-fs (nbd0): unable to read superblock
[ 1976.582138]  sysvec_apic_timer_interrupt+0x71/0x90
[ 1976.583407] EXT4-fs (nbd0): unable to read superblock
[ 1976.583567]  </IRQ>
[ 1976.583569]  <TASK>
[ 1976.583570]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1976.583575] RIP: 0010:cpuidle_enter_state+0xc6/0x420
[ 1976.583578] Code: 00 00 e8 8d f5 13 ff e[ 1976.584827] RSP:
0018:ffffb7974123fe98 EFLAGS: 00000246
[ 1976.584830] RAX: ffff94d4b7900000 RBX: 0000000000000004 RCX: 0000000000000000
[ 1976.584832] RDX: 000001cbfcef036a RSI: fffffe40b5d57332 RDI: 0000000000000000
[ 1976.584833] RBP: ffff94d4b7941108 R08: 0000000000000002 R09: 0000000000000369
[ 1976.584835] R10: 0000000000000018 R11: ffff94d4b79343e4 R12: ffffffffb7647220
[ 1976.584837] R13: 000001cbfcef036a R14: 0000000000000004 R15: 0000000000000000
[ 1976.584840]  ? cpuidle_enter_state+0xb7/0x420
[ 1976.584843]  cpuidle_enter+0x2d/0x40
[ 1976.585710] EXT4-fs (nbd0): unable to read superblock
[ 1976.585811]  do_idle+0x1e5/0x240
[ 1976.586621] EXT4-fs (nbd0): unable to read superblock
[ 1976.586825]  cpu_startup_entry+0x28/0x30
[ 1976.587568] EXT4-fs (nbd0): unable to read superblock
[ 1976.588147]  start_secondary+0x11c/0x140
[ 1976.588992] EXT4-fs (nbd0): unable to read superblock
[ 1976.589410]  common_startup_64+0x13e/0x141
[ 1976.590267] EXT4-fs (nbd0): unable to read superblock
[ 1976.956881]  </TASK>
[ 1976.956882] Modules linked in: nbd nvme_keyring nvme_core nvme_auth
pktcdvd rfkill intel_rapl_msr intel_rapl_common sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp sunrpc kvm_intel
ipmi_ssif kvm rapl intel_cstate
[ 1[ 1977.094336] EXT4-fs (nbd0): unable to read superblock
[ 1977.094740]  ipmi_si intel_pmc_bxt hpilo ipmi_devintf igb pcspkr
acpi_power_meter iTCO_vendor_support ioatdma lpc_ich ipmi_msghandler
dca fuse loop nfnetlink zram xfs crct10dif_pclmul crc32c_intel
polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3
sha256_ssse3 sha1_ssse3 serio_raw mgag200 i2c_algo_bit hpwdt
[ 1977.095963] EXT4-fs (nbd0): unable to read superblock
[ 1977.096494]  [last unloaded: crc32_pclmul]
[ 1977.097365] EXT4-fs (nbd0): unable to read superblock
[ 1977.097489]
[ 1977.097492] CR2: 0000000000000000
[ 1977.098348] EXT4-fs (nbd0): unable to read superblock
[ 1977.098402] ---[ end trace 0000000000000000 ]---
[ 1977.129544] EXT4-fs (nbd0): unable to read superblock
[ 1977.271906] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1977.348338] EXT4-fs (nbd0): unable to read superblock
[ 1977.491887] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1977.594276] EXT4-fs (nbd0): unable to read superblock
[ 1977.603176] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1977.604077] EXT4-fs (nbd0): unable to read superblock
[ 1977.607491] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1977.607773] EXT4-fs (nbd0): unable to read superblock
[ 1977.609318] EXT4-fs (nbd0):[ 1977.864344] Code: Unable to access
opcode bytes at 0xffffffffffffffd6.
[ 1977.864345] RSP: 0018:ffffb79741fc0eb8 EFLAGS: 00010282
[ 1977.864348] RAX: 0000000000000001 RBX: 0000000000000003 RCX: 0000000000000000
[ 1977.864349] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94d18d952ce8
[ 1977.864351] RBP: ffff94d2c0f95180 R08: 00000000000008f7 R09: 000000000000001a
[ 1977.864353] R10: 0000000062616c73 R11: 00000000616c7320 R12: ffff94d4b7937080
[ 1977.864355] R13: ffffb79741fc0ef0 R14: 0000000000000002 R15: 0000000000000000
[ 1977.864357] FS:  0000000000000000(0000) GS:ffff94d4b7900000(0000)
knlGS:0000000000000000
[ 1977.864359] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1977.864360] CR2: ffffffffffffffd6 CR3: 00000000b8422003 CR4: 00000000000606f0
[ 1977.864363] Kernel panic - not syncing: Fatal exception in interrupt
[ 1977.864426] Kernel Offset: 0x34000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1978.116728] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---


--
Best Regards,
  Yi Zhang


