Return-Path: <linux-fsdevel+bounces-18316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0AD8B75BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3102844DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4013FD6F;
	Tue, 30 Apr 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6J4lvun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8F12B73
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480204; cv=none; b=AjL195maxJT2R/wmIL+tvabZ+QmC2/QsQFyKdjgBbu3oTABBGSOr0tP+6W/WTJPdRLpktzGs4peG8mM1d4872HzWGiaQ+dc445s2z1JRi2h16duNxzrgfO0wSowWdIoFeaIq0/xv9pGkvSbnhRknl26DUk7d5dQYK7wqsUsmY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480204; c=relaxed/simple;
	bh=rvl2LGQYTgzq38mG6SzOpcDNFvD/j4jBEIgOtnfpgmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsHcZNuQUKzJArlxC+Z47xZSKEZWStnxvhAa+71FaLcaMeWw8VotGOs9XMvJbH5hm+fA4fAQONdqs1rUC7QTTL0cr2IB9excldjbCu05X9w73SfOGTh559AKprJ0N9ipRk8XcgYT9RK1f651HbcZvPF8HPHb+4ZnUY95cInwyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6J4lvun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714480201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSKTo0fsUqmzxcGkY1pyXO8izPBGY9fWGNOTqw95lTQ=;
	b=A6J4lvun1KlwYAb2Ix0K0OWTyD2KtEZFwJrsbn3KrPA9zr5CBGVdNug4o6MZvr7IyKtzR8
	DCLytg7V2bF5lHBf56C+qZdat24PD37sdadJKPFKz4W5N3bkojASZivg53G++cgXUh6lZX
	okqyu67HN278I9GpWVRSoAgvKaLl4EA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-PSc7PI4mMBuye8CjWUsR6g-1; Tue, 30 Apr 2024 08:29:30 -0400
X-MC-Unique: PSc7PI4mMBuye8CjWUsR6g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a55709e5254so272822766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 05:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480145; x=1715084945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSKTo0fsUqmzxcGkY1pyXO8izPBGY9fWGNOTqw95lTQ=;
        b=uJmbvad66LP1lD2JPLIbOtb0x+cWN1yPTpTXQqPC7dsFVo7CqmBPFXlJ5IzsxWU1lC
         pAmEwZTeVj7lhYjfCSg0lyL3y9c2uXg6izOY2x1e9au7FQYPg5tyHJx7yuIDIBEp2CnJ
         HJvjpiKe5yBmrdxoTsQNqf0n9GolF+8Q7JhWb3sHPYx2W0VmcsXO1Y4kpGI0qkh4vFJC
         n7k2TvjVgf4zvKG9aL1q0PCFpPVL2h4mThFK1XJoLJLzVNz+YyenqmHDWth3q+Bejc9F
         DUv9+QY60Z1JVZYqNLv7upXL0Ah5bbRC7PVYKewNH9Xu9WnmY2dpTvOTGbkGxQorynIH
         lolQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9udzvFpfCtTVa9NUF/1LP+hwJlcSVwjZu29JgWW/AAlS7I6GgCg3zMQeHSm7/5V4t21lVGi3vqFT3Nbk0L7RfWRzyiKimTxUeSkDrg==
X-Gm-Message-State: AOJu0Yz8M2jrYwU0c96OCo0ylMpi6Y1w2FVe8VIdDqFXzU7PRZtK2mkp
	nselbFmw/yFhChW4gKizSJ3hb8cb/jDvwDWDvO4dBnezA0SSqvAy6AKiyPEoRoHnDsDLjcFjap9
	/81S19z0D8O+3wlQBTnnCvaQtPtbn7RMXp7Rwjo4abLSaeaXfwoLOx/uXeMdMqg==
X-Received: by 2002:a17:906:140a:b0:a55:b05b:cdf2 with SMTP id p10-20020a170906140a00b00a55b05bcdf2mr1982561ejc.21.1714480145009;
        Tue, 30 Apr 2024 05:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExbEF0B6PaeOO+gY91rAjKvEnZ0XZPuVp+IG/Xa1dBjLeL09mDJp7gx/hEZ7mhWw+WUvxzVQ==
X-Received: by 2002:a17:906:140a:b0:a55:b05b:cdf2 with SMTP id p10-20020a170906140a00b00a55b05bcdf2mr1982527ejc.21.1714480144432;
        Tue, 30 Apr 2024 05:29:04 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id u3-20020a170906b10300b00a52552a8605sm14992175ejy.159.2024.04.30.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:29:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:29:03 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: test xfs_scrub detection and correction of
 corrupt fsverity metadata
Message-ID: <4atckq27cuppwfue762g3xctp46dnwmjffawuxqsdfq6qeb5rd@g4snomzn7v4g>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688039.962488.5264219734710985894.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688039.962488.5264219734710985894.stgit@frogsfrogsfrogs>

On 2024-04-29 20:41:50, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a basic test to ensure that xfs_scrub media scans complain about
> files that don't pass fsverity validation.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1880.out |   37 ++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100755 tests/xfs/1880
>  create mode 100644 tests/xfs/1880.out
> 
> 
> diff --git a/tests/xfs/1880 b/tests/xfs/1880
> new file mode 100755
> index 0000000000..a2119f04c2
> --- /dev/null
> +++ b/tests/xfs/1880
> @@ -0,0 +1,135 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1880
> +#
> +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> +# that xfs_scrub detects this and repairs whatever it can.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick verity
> +
> +_cleanup()
> +{
> +	cd /
> +	_restore_fsverity_signatures
> +	rm -f $tmp.*
> +}
> +
> +. ./common/verity
> +. ./common/filter
> +. ./common/fuzzy
> +
> +_supported_fs xfs
> +_require_scratch_verity
> +_disable_fsverity_signatures
> +_require_fsverity_corruption
> +_require_scratch_nocheck	# fsck test
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +_require_scratch_xfs_scrub
> +_require_xfs_has_feature "$SCRATCH_MNT" verity
> +VICTIM_FILE="$SCRATCH_MNT/a"
> +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"

I think this is not necessary, _require_scratch_verity already does
check if verity can be enabled (with more detailed errors).

Otherwise, looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


