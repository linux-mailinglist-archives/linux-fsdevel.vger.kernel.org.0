Return-Path: <linux-fsdevel+bounces-18321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56678B7673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EF91C20DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03280172790;
	Tue, 30 Apr 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QihpQKBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12029171658
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481801; cv=none; b=RWwMGVNYGXh64b9asAO6hWkqMoR4no1rVby7IPrGm36HDf9wEU8/17Z/UpvOWwhd1E3Asa0I/IA6k1pe+YvIS4vkstqEDnejNXkalaYVFuv4KcyoCclmV5Go3XddqSKIJp3W/loNTvfk+WKkeuTqOB1xYGHebNgsbtz/DtKhHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481801; c=relaxed/simple;
	bh=6xUgLOFdCuxBZJL1hn9eXwjjUUhUqAR1+BQPgXPLP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtzjN5GToRfifF5fKWHbUUnUeS1YEF04vMx4V9W72NcRIQoe4TiNbjF9eZbvtYwEgWYY6zOmOF4lxfYakz196AKLO00opr/2ITW/S5T80NsaVQ15VC4nfBxapBY5S+ikyF01q8HtIsk7aYcyuwGtrGlGBFWiIccEvWeA6GLLwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QihpQKBk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gvLa7sIDHO8kY1gdoDajG1u00oK5nehvTUav+G6vTU=;
	b=QihpQKBkC7ttYo5IXpUmBinb8+oiWu5RApLbuHRsXwGjZsDF4lf/8rB2YfMWaUBKqjTEt7
	6n30pfX0/QBnF0ij1JzjyNHNDwvNecSysxpMMzXtotRhE0gv2zkhtB6HEBhRcBeLdPNjCs
	mpTgEu/UVDu2rtkrnCfp7CLuupCwp2c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-1vWtwg8KP9ikiaei5zLalg-1; Tue, 30 Apr 2024 08:56:37 -0400
X-MC-Unique: 1vWtwg8KP9ikiaei5zLalg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so54477735ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481796; x=1715086596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gvLa7sIDHO8kY1gdoDajG1u00oK5nehvTUav+G6vTU=;
        b=jvhsQzKXGHD2+WzcJWMC6Of6wm9s6s/QK4WDc/4ETtB2IdBHz7Io5ZR2rzFJph0K2X
         lYFbfPJJHgadE428RpxfKtZ1K7eFMbOxWwFISkB71f7IFsMkYJl0UKpHPhQXIb7RlUMt
         /hppKafVJ+9OJiDTi47xhF4luLAzrseN7bLepmS/rDtgXQWlHP54Gs2X8qHT6yPumQ3G
         DAsH43iyjLXZwIzPp+MGKl++Hce16uEZY5FwH1ZQzl0mi3tQOk/lGTrUE98WKeIwSk3q
         E1svE0KCmFD415uT+014vozzxUUP4b4HsWNVT1n1eXnNcTnQUA6lxllXyZnDJvUw2t9p
         4zsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5hOD74ifHhUfxZV9HUSWZsLtREum1rq/OutwS6h+1bmO+BXDjZktkXW68ZfIPQGAvl66Xu7XOstlfdSboDa/Km/vNgV0SqrDlGPqgyg==
X-Gm-Message-State: AOJu0Ywlvuo/Te6tAvyggEFNkefJRzdWSlifE6F2aoAhY5YeKdlV9h7g
	EfMWyDkDUaIotTzR26toaleA8C0kWtW7BIWhgXTavOdDKuRBKnUKh4iLRNorw7oSZyNnvdoXFnG
	RSzb0lus6IquCXPRueNdbuU0tiLY2FTeD16Co9LsXjY4jIHbUHCbB2Uja4rWPOA==
X-Received: by 2002:a05:6e02:1987:b0:36b:837:db0e with SMTP id g7-20020a056e02198700b0036b0837db0emr18708036ilf.1.1714481796414;
        Tue, 30 Apr 2024 05:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAF1DkWU7ljBktLEfu0Y8dV1p17PuOLL/W4Kwzja5W5B2CaMpV5ljAlwN7cy3HrodfzDUArw==
X-Received: by 2002:a05:6e02:1987:b0:36b:837:db0e with SMTP id g7-20020a056e02198700b0036b0837db0emr18708010ilf.1.1714481795897;
        Tue, 30 Apr 2024 05:56:35 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i1-20020a056e0212c100b0036c4d41e1ebsm1014741ilm.26.2024.04.30.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:56:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:56:32 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: test disabling fsverity
Message-ID: <7v6qwlhjqrgz5vznrwkfucx2tz2uc4qbo4h7hivausf7fzf5wa@ecq64sxnj5t3>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>

On 2024-04-29 20:42:05, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a test to make sure that we can disable fsverity on a file that
> doesn't pass fsverity validation on its contents anymore.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/1881     |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1881.out |   28 +++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100755 tests/xfs/1881
>  create mode 100644 tests/xfs/1881.out
> 
> 
> diff --git a/tests/xfs/1881 b/tests/xfs/1881
> new file mode 100755
> index 0000000000..411802d7c7
> --- /dev/null
> +++ b/tests/xfs/1881
> @@ -0,0 +1,111 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1881
> +#
> +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> +# that we can still disable fsverity, at least for the latter cases.
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
> +_require_xfs_io_command noverity
> +_require_scratch_nocheck	# corruption test
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +_require_xfs_has_feature "$SCRATCH_MNT" verity
> +VICTIM_FILE="$SCRATCH_MNT/a"
> +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"

also here, if not needed in 1880

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


