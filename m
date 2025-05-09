Return-Path: <linux-fsdevel+bounces-48618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11751AB179C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8381B523726
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6F229B35;
	Fri,  9 May 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bmMNTaFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BD5464E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801769; cv=none; b=AnGMJMIhWaZFkqxa+1Jkmhn+Lm7xzO/PsPWlJ77UjV2y4QHqhdAbrpUyYB9hChz630BQ6hca74Mytya+fOGmcAmM13imAVasZNeU2sn37OveT5xMvkqrofs3oPQ+6i+GGrRbw7TvxjMAVEiTM+mn6FTZ7L0sWx0nwRvVza0snWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801769; c=relaxed/simple;
	bh=J9Go2AU2FeIE9/7MGNHWhoSeT7V2+V/CGMggB3jBZL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzoJCh6EI72KP01SVxFXKdmvKB6+c4nB/n0BXqGZlzaEfwcGd6I25j1MuHZlDiLkHrGf30pW9tddg3VZOzwQ2nwb6Ri0v0iKgXf5ULxNr8Tjvs0IqoDNSufniHSCTeUBy2d6gPpB/1yf6T4qeU10NWfpqsIRUsrlCtQcAw9Kz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bmMNTaFx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cad6a4fae4so381465685a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746801766; x=1747406566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81Xnhl4kXRO4UGVjUuSNBUo2sVegpcm3EGgqXOdwxU0=;
        b=bmMNTaFxc48UU12Wfla1qhrN1CPgvCRwrcqH0a+pscGu8PqXlEFJoXw0E/DDOZg06H
         MFh4u/128pWp5GUspJTnkjeVmmWUc+QBCBwK+L5ToFY5nFaSVCGWW1tIky0/kbLNAVdK
         BIzZ4U8juz10Igc0Ass5hrqt6xWWV0qWl7yU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801766; x=1747406566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Xnhl4kXRO4UGVjUuSNBUo2sVegpcm3EGgqXOdwxU0=;
        b=rQXXKC+gpIAsuDr3AqAMfr4vwNXOvObFTXzy/bVqbqtlUMSuUN90mWT+U4oVJKZvLi
         rwMOp6tX3MgjnoN1oVMGQAaqZyUfCE5upoio0sM4my6bDBpFv8nxqjm7+JyE3/Jdrw2t
         B1luDNGi68OmUiXtoPADKiATrkwjL8WoEtJ5sv5BGHTaeXSuQO2CfPFnAtrzqOkYbzQ5
         TJx/z+BN1aP0/iEt6jFAGvY5Y8tX5AkdHb4qDBsiKSdoh0+Hm2c0wHkeFI8x97cGWHFO
         eS6fWmfMyjuMXtFkLvkU38zNlIkGg8BMr3K+k0G6N9RAdMd3eKJZXnUODYDpBdwafz02
         9Fmw==
X-Gm-Message-State: AOJu0Yx0TO0G3QYay4+lQMAEpJMLiJJHu7Jb8UPcVNHRkITvAdL36nsY
	AKk0TK/hV+rbUAuLGF6L0cmltukcOameD2xexnSmXLpshWHH08n6Apmj5YCa/qN1+8Cj0HSbl2G
	zshmml3KIxwoePaPSxIk9FiDJDgXfONRKVxbDZQ==
X-Gm-Gg: ASbGnctQuy6/vPBGaBmrMGrEkreTdIHVpPphXAljtXpjBHEZFgPpTi8H1RnHvscPkms
	3HJDkTa+3DcOZtw0uxk03kwq/4OQZWJyZ6fDE1Rsx44DviCuQmsx6rHGI2ludAdJTf7886mlZLj
	m8w5NCT5JAoHsLTSKCawsTLaVN
X-Google-Smtp-Source: AGHT+IGwUdA8jxa8eGyPtYQRfJpuBLmhGsSWFfmYjyfGcBEFHY/1UcaEwi2yz9hdQxD26rt6LstDeVEz3jK1chDPFzU=
X-Received: by 2002:a05:620a:137a:b0:7ca:f039:d471 with SMTP id
 af79cd13be357-7cd01155c1cmr500551485a.52.1746801765979; Fri, 09 May 2025
 07:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN6PR19MB31871E9C762EDF477DC48CE5BE8D2@BN6PR19MB3187.namprd19.prod.outlook.com>
In-Reply-To: <BN6PR19MB31871E9C762EDF477DC48CE5BE8D2@BN6PR19MB3187.namprd19.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 16:42:35 +0200
X-Gm-Features: ATxdqUEDxzs4hXNNwbpcM7y3jYzh1qid90HdcHQEtJPMtkog-nmU0oe0wGU6zHY
Message-ID: <CAJfpegvq-7geNFn1+U3c5SXY8rR4=i6_XcsdFw4zOQEUg5kXaA@mail.gmail.com>
Subject: Re: [PATCH V4] fs/fuse: fix race between concurrent setattr from
 multiple nodes
To: Guang Yuan Wu <gwu@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 06:04, Guang Yuan Wu <gwu@ddn.com> wrote:
>
>     fuse: fix race between concurrent setattrs from multiple nodes
>
>     When mounting a user-space filesystem on multiple clients, after
>     concurrent ->setattr() calls from different node, stale inode
>     attributes may be cached in some node.
>
>     This is caused by fuse_setattr() racing with
>     fuse_reverse_inval_inode().
>
>     When filesystem server receives setattr request, the client node
>     with valid iattr cached will be required to update the fuse_inode's
>     attr_version and invalidate the cache by fuse_reverse_inval_inode(),
>     and at the next call to ->getattr() they will be fetched from user
>     space.
>
>     The race scenario is:
>     1. client-1 sends setattr (iattr-1) request to server
>     2. client-1 receives the reply from server
>     3. before client-1 updates iattr-1 to the cached attributes by
>        fuse_change_attributes_common(), server receives another setattr
>        (iattr-2) request from client-2
>     4. server requests client-1 to update the inode attr_version and
>        invalidate the cached iattr, and iattr-1 becomes staled
>     5. client-2 receives the reply from server, and caches iattr-2
>     6. continue with step 2, client-1 invokes
>        fuse_change_attributes_common(), and caches iattr-1
>
>     The issue has been observed from concurrent of chmod, chown, or
>     truncate, which all invoke ->setattr() call.
>
>     The solution is to use fuse_inode's attr_version to check whether
>     the attributes have been modified during the setattr request's
>     lifetime.  If so, mark the attributes as invalid in the function
>     fuse_change_attributes_common().
>
> Signed-off-by: Guang Yuan Wu <gwu@ddn.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Applied with minor modification (see fuse.git#for-next).  Thanks.

Miklos

