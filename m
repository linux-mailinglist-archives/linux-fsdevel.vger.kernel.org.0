Return-Path: <linux-fsdevel+bounces-66946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43848C3102C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796E918C1295
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39771DDC08;
	Tue,  4 Nov 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV7J1MhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34941DA55
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259626; cv=none; b=snvO4P6KKKZm5YfmRoXsZQrGw3osujHtXCFXIztc9aB+cLVE27h/dfQUmn3Pz5bpZUcM4R98brUZ5uOWBgpF4eHphrkY/00o65jjSYyOdQTSE14MvrnIKRoCYywnB8q40ObHBcrKxMawuLCFrQ+dzXlH74HlsrlCQkeGlpPtuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259626; c=relaxed/simple;
	bh=PVG/u/rBRJtGXc7icffonY7sSvjL0w8UC+NsDC4RqhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ScRArWuRfmGBN4rfAWiJ15zotbl8SoFqfNoAsG82AgFKzlOHQZZkFUcFnNBMMr/dB/BmNLmiFuv6ZuoSX91wH6ZbL0UvT5MgDnFldSGbfLHDp8rsL8L3FZVu1RkaRrbfmPkSBT+v7+bpk0jcnNazsxyCvhrl23c13sAHpw39WC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV7J1MhR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29558061c68so32311075ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259623; x=1762864423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=gV7J1MhRmn62F5zM9AFF5163CxrhGjqCIvlisytWIbGoMhUdo8L0WHCJCAEjTHNKJR
         wdtLGJdQJLDRGL4uTiaZsH5OIkBE04KlizY5y8mb81o5v5J/HJb1GgvCyhspkzhXO0Ko
         HLlYZBNyOWNyC8EKfQQhdsvolw1Vq6AePzTCIT34DnRkVR9ZQT090KCtGTTceC19x8M1
         amUhZ7PwnGdaQtpe5AO6A+XqSKZY09RGwRPrfQB4fuMc6wXkh1jlmywVMwwE3ZWTtBaf
         oZ/8Lz0QDKwWIhkzPvrv7njY08lt+GNV2k2xHxqeAgt0aqS4c6qOqR/hx/mHhYfeztu3
         dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259623; x=1762864423;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=M7VUW6vk2mBmwWlg47tSyfOI+vWtQ4h0WQhfPHJ0SFaVObN1fg3fb54vbMA79YiLpB
         h+66hPey9Asp3Qgb3mMb0oIFyCMmPnKK1d7AyF9R1IAENNqsrH6poABeUIhFhnTmnaQu
         lUAUD3my8VnPE1OLMzkRYTCkSnY0XpTo00YO6yMTcUe7XTbZiW5B/HzPhEedNA2fQ+01
         HAoGukFs8ktdKwVll4/5YNxCevKY1buY3JGnHRtXn6yRptn8uj/EcToV4kbDsFLKEQil
         HMoThgEUpBWlwknp4+YsNiNYFZ/JSzFQePxQoahIH/q7VEH6OJLA3bvZds4rDd3NCHUS
         oCtA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kUUpeK9OsmetydmU8PmcvAYROAYyRcyiUTpjqmLN7jKTU9JPGWqdeUWuQKjIip356BDfrW2Fwj3Yg5MO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyykm9E1he5o3I+eEwn99i0oPGWOzDHCOfw2mDuPbaUNrcfwXPo
	b2MNKXOHZOyY1iENDuQcjiv03Cy0IeQfnUhniTFr6E3FJLZXCNu+GUF1
X-Gm-Gg: ASbGncuKMhjEJsso+98lgRpOYuP5qM2JIQ8Fnsd6DximBtHQhXtKfbDBhLxiBrYSuam
	zB70xci6aszw6g4u/lYjlXzmXwbuKIIDiAcKoyZqB1e1wQQp9QR8ho5tuYw/HdxiLAVIT/pHZIW
	7IY/XanIFohHUJHskuC1C6IOkGIZtxw7kNU2x1ET/GD+UtLC3lJ7mbkvwG17HpLpZN6CmTRPoxo
	dhCIgsQ/uWn8unFn0/cpbRqmQFj/jwSY/bwycBbhLmnGMKHDayomLFf2C82HFOf//xrsCn5XRja
	wzUbZJYdcBq/hGqOiRQrfdGy/QaoNaPXRt29FbmrUS9IXM/GQgljFXSEUBN4ZhFnI0gRtpiQoSk
	B11PjHFM0oYmRfzofLJjDIdStdUTDojNfcVUMSjp/rvIdNTV2dZ+XKjJw7uG8se68lyJ0WMjVXf
	k+k3nR77tmFqK6NKq4UrY4G9X9cOrbuOVdNHpbSCscOa1hc+poz57h6Q==
X-Google-Smtp-Source: AGHT+IFcDWr3KBlNMXeLNPkyZZOa63IpUuqeGF/O+KRb8PWkuF5qhGuak3PkMEe642XnoKQJ5ppqRw==
X-Received: by 2002:a17:902:da8b:b0:295:2cb6:f498 with SMTP id d9443c01a7336-2952cb6f55emr159576605ad.7.1762259623021;
        Tue, 04 Nov 2025 04:33:43 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.200.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d181sm26106575ad.85.2025.11.04.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:33:40 -0800 (PST)
Message-ID: <a162ddcbd8c73adf43c7c64179db06ce60b087d6.camel@gmail.com>
Subject: Re: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to
 buffered writes
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 18:03:35 +0530
In-Reply-To: <20251029071537.1127397-4-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 08:15 +0100, Christoph Hellwig wrote:
> Doing sub-block direct writes to COW inodes is not supported by XFS,
> because new blocks need to be allocated as a whole.  Such writes
Okay, since allocation of new blocks involves whole lot of metatdata updates/transactions etc and
that would consume a lot of time and in this large window the user buffer(for direct I/O) can be re-
used/freed which would cause corruptions?
Just thinking out loud: What if we supported sub-block direct IO in XFS and indeed allocated new
blocks+ update the metadata structures and then directly write the user data to the newly allocated
blocks instead of using the page cache? Assuming the application doesn't modify the user data buffer
- can we (at least theoritically) do such kind of sub-block DIO?
--NR
> fall back to buffered I/O, and really should be using the
> IOCB_DONTCACHE that didn't exist when the code was added to mimic
Just curious: How was it mimiced? 
> direct I/O semantics as closely as possible.  Also clear the
> IOCB_DIRECT flags so that later code can't get confused by it being
> set for something that at this point is not a direct I/O operation
> any more.
This makes sense to me.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5703b6681b1d..e09ae86e118e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1119,6 +1119,9 @@ xfs_file_write_iter(
>  		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		iocb->ki_flags |= IOCB_DONTCACHE;
>  	}
>  
>  	if (xfs_is_zoned_inode(ip))


