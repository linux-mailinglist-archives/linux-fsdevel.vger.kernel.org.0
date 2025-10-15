Return-Path: <linux-fsdevel+bounces-64218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEFBDD8D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D7054357D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035431770E;
	Wed, 15 Oct 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDVrwX78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C62D8DDF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518513; cv=none; b=b6KDRu+Rgqb/QyrGzav7Ftz3c7Y8lRZgt029QuOUF1hVECWJ887qqfjbcrt2EU1+BUPzjM9swYkDDDWpUUf/jfj4fi/FFJ2gk0qlSG+mwovQTMOFTDgmAPpQUiSD8JPpvhWhqeW7lEWGiqSlQ77/gHh89jxXpGI/dPIJoI3yQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518513; c=relaxed/simple;
	bh=PnZYoZixlZe2UBYMbO2OeSihGeWSGTpgJH47W2yN5lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5WWt+uDsFMreYgqcDQY98R6ibuF+2fxyWjNgOJ8PH96KxDMHCI3lRbBwFzC/pqbGLP7bli6sNaoqWEMPiLSmmCUMGEX/X1oOMtaxMakV2cZw3qVmOpNZykUwOa+9e++KF+ggpepRIQvzTDdxTHuuSyHQJGlVN0Vu36wnpmI+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDVrwX78; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b27b50090so1162769366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760518510; x=1761123310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=hDVrwX788HazW20XAu5qXC7mRNc5tjfz+7Ar4WRwjCw9A6W0MtWF6SAdjAsy4R6AMT
         I8zqj2O+e/BAMD3M1uvKSWKiDaHcsAl7QE40ZCg293FW8UrFE1slH4ZF9OOVqhhHR3PI
         /8QbZOFTlQG38mQNpFfOmEXqLUGmNsMT7F478QM9cs8PvxlB9kUNVzq0nUYeWOszXaM5
         L8RskbqL/IrIIjciUMCn3qYI3ODe1/yLZX3iXMVCZi0WSEgzVfWqUxlKtbdzd//j+lwD
         BnktJeQFkjOAUoMc9CmAc3C5ozjU2H1NXaTn/uXA3pzsgXqgOZmzNwj5XoSxVxweUuf0
         21HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518510; x=1761123310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=Av++h03UbPHcF+ofSKA6Z7QzTVI3biAG5UWue88r47qt9biwTH9uHfYic0AUXqStpx
         gCEfGEOjVNl8s3c+y/Vnj0oQ+yL8sonjU2CNFAEM6UKGp4od3yYQlcTSQvSd74FN4DJU
         d/FwLNWqjQ4eFDRt2/GRCOYzEkW75lgiGm421rtObifjRVqbVWvUVQJ0/AZ7PO31ky2I
         Xnaeann+wGEySFoS9lhMD9LdkfxQ4lIbAuV9boFnfeNNsAFRGJH7RDyrRBMoSy9U7/W1
         65kLRp82iZpzaZVOP2Mhq80otVyabE/o0Av6c6hiNF8A85fg2RJ1n+RiR6G3EKfKQTvF
         V2ew==
X-Forwarded-Encrypted: i=1; AJvYcCXc2O8f5H2NcGqZfXz0psS/C+zwOvghDX2zKIRhOWcCnaTQkRYovAMAUzyepSqN4FcPc3lfgifaioyoAbY1@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZkKpkrx1IKWNKr0NxYT/uSivJmZ4xLZ0mNorXcGO8vGHr1eQ
	pn6G+t2tOLRD9r/nePfNFy4wrMUWbv483G/FvNc1GizavQGgtfms0mUjOHL/uaNsfhOtz+pl0xX
	YgczqGGFbV3Y9RXSUyt1FqkWh3/GR2qM=
X-Gm-Gg: ASbGncuDqISnKI6OxwpX/MYO/MEGFmx96wJgCsX6/m+vZk66KCZwsIGgPlOE+b0aFnE
	Ct3pDNzSQWYnVv9cjCCcf5PkbdxOkNhiB3GR0q5LDyBgLbLiTql1+3CmyhjUArUH6zKQeYQoTrX
	hVaNmJc31UNb1imBItEQVc2Fme3fvbqZOtwgUSYMj17/20i37r0tIypGXxtO1mbdNo89zlGFbCh
	oCP/bZbpKhHR8L0bZtqnts+PGrdGadE3SP3/D9yUNllSeuw
X-Google-Smtp-Source: AGHT+IFTcVXJ2k4Io0gR55B+LOiUs0D6lc9nA2FkAagSET75wVrURhguyB7dmaTVjRb2yFF3HFNEaUx2J8d6K4IUlfA=
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr3185549666b.30.1760518509261; Wed, 15 Oct 2025
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com> <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
In-Reply-To: <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 15 Oct 2025 14:24:57 +0530
X-Gm-Features: AS18NWBrpUjyPc8mxzcKZ88p2FW9F32bwQuz9_BbcqcNCJwm-Zl4oTpr4byxBk0
Message-ID: <CALYkqXp9Wewk=P79r+Q8HjngUOSWq71ZA6NBm5fPSj9EZHh1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> Nice results.  Is testing planned for other filesystems?
>

The changes currently improve the writeback performance for XFS only.
We have introduced a callback that other filesystems can implement to
decide which writeback context an inode should be affined to.

This is because the decision to affine an inode to a particular
writeback context depends on the FS geometry. For example, in XFS
inodes belonging to the same allocation group should be affined to the
same writeback context. Arbitrarily distributing inodes across
different writeback contexts can lead to contention of FS resources,
which can degrade performance.

I conducted a sanity check on the performance of EXT4, BTRFS, and F2FS
with the current changes, and the results show no performance impact.

