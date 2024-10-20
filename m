Return-Path: <linux-fsdevel+bounces-32441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AA29A5362
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404341C20FA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD40183CA6;
	Sun, 20 Oct 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5dLhz0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A485FBF0;
	Sun, 20 Oct 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729417708; cv=none; b=h6Ch/4ya1JUel/H9+erGUzS3vOQZmkJPTRE0y5PBne0JI2sv3IlObnCTxHaaa80YFXe30Yf5KJsDWAfy5eZ18ldtKmN0cHjJadH7PIibMw08bkRKiPfd2oKAUJtmKdFv4Ykfo+tjBD8g1X29+eAgCJyULym/gwP8Fxh0I+Q3/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729417708; c=relaxed/simple;
	bh=L3whGAyCtfk52Zej/fOSJGWKP4dlYCEiXFi6zyG46Ao=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BfAK3yKehxCdzaUiDd8w+cd7YekxdyW64721zl0IaCtSrZ7ikpEj3YnpU5JS0y7lbO7KPylP8kR94NiJ5J+EoaW9+r4foxmDG6IpIhRLa6LDxUT6VUrQlNAyGkVt0Mwo+xTXgvqw3zBYe8SZZxD3ajRC2s/Q1F2E7uidRRjXFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5dLhz0j; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso2317019a12.3;
        Sun, 20 Oct 2024 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729417706; x=1730022506; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldn27lzLHuOpCiGlLeOSNBCC/qe0KrC1TVYFVBtlbwk=;
        b=D5dLhz0j4QXh8FgyIZR3tHvfbBXtq3MxOnLLNkWmwpGCI7HUIn9chHFvhgdi+Wk/f3
         k5CG8yUyUNfD+HkayVQtaFXFN23OMgB3c97h8T+GkDxvKJGBPUXnEJpHiX0wAtqC/zhO
         +tqb3/FYg+BW0c9ev3mKttqfG4hbdJyw7YRdkin1im+zwaCoCdDJzSJJaTDScmbiaLZC
         NFx/jiFU3fPUrSba6rmvXLQYcD0BMVr9ibvhr04Cgy3+0S7UNKTKMYFCoIPv//vyTB+d
         TjEwWsEDl2E9nbhzxVv+NMFyg7KlS7fRhGhpiRGfYNS+Gyq2V4w9id4VN/96OQxy8aRW
         hlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729417706; x=1730022506;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldn27lzLHuOpCiGlLeOSNBCC/qe0KrC1TVYFVBtlbwk=;
        b=k3TE+BAByd828YfvninfAnAvqJO1xRzCNb6VMUU1o8ACedOZdi7GnJEgLZxuq8eI2c
         wqYdR4+zltkxseO8SUtt1MrqgbGhQp/G2euvzeUtOR5+BYY2fS7cOsPCWUWUHXHODCd/
         wCCXrF5OM81J3murJzpoaV2CGsx1QLfl5OObhmJkErl8yJJm0eAwK2Nh01jA/TAMzkED
         WWL87PsKlrhpc+m82wtoR4SyWxHb3zrtb1NLElGZZ1p3hbt8fY+Kj9/WbF0+CFARjwge
         CGmqjRYOiX3XGXxC3Mtdjtn9KiyBPonr5hxyTfy8RTwcFRdR6G6vsX2iKu3KHX84GMZu
         J4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvXpfscHUmYQymngKbok5fBFbE4hVn+uzkUpyB8AVxQ7KbP11bYZwdMsdYcU3vJrlCw37yT04+bBfR@vger.kernel.org, AJvYcCVXvjp3Md2LpaomCZHV5rfmKs3f4oQLc8bUrcu4Btn2QSZ+ptAlSpfzkd/xr+7YhPCzz0BYnClYhedjthop@vger.kernel.org, AJvYcCW5zlR2ssE+l7EhArGgP2REbh4b20VXpn/bCeLUmfHcPMN9/vdqSYjzCeH/1dh11ErMyTSEl0W/+LwhyNFI@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJad/YmrjJv7gdk5U+YT83wmKufwymEWUv6HEDZlG2Vgx12mK
	hUHZS3RaasW/AkOxJK5Jl3XPiktq8yEN5h8D8C93I9qpJqJi7nOV
X-Google-Smtp-Source: AGHT+IFKCdM/qCR/SvMRMS1hpLJmhhAfa4mB09hQj79THgWcoIQjCDAzhIcy5MenLEoPOatm9GkM5A==
X-Received: by 2002:a05:6a21:330b:b0:1d9:1e36:8f97 with SMTP id adf61e73a8af0-1d92c4dfef5mr10424074637.19.1729417705701;
        Sun, 20 Oct 2024 02:48:25 -0700 (PDT)
Received: from dw-tp ([171.76.81.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabd9bebsm783827a12.80.2024.10.20.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 02:48:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de, martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org, ojaswin@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v10 7/8] xfs: Validate atomic writes
In-Reply-To: <20241019125113.369994-8-john.g.garry@oracle.com>
Date: Sun, 20 Oct 2024 15:14:11 +0530
Message-ID: <87plnvglck.fsf@gmail.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com> <20241019125113.369994-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Validate that an atomic write adheres to length/offset rules. Currently
> we can only write a single FS block.
>
> For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
> FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
> ATOMICWRITES flags would also need to be set for the inode.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index b19916b11fd5..1ccbc1eb75c9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -852,6 +852,20 @@ xfs_file_write_iter(
>  	if (IS_DAX(inode))
>  		return xfs_file_dax_write(iocb, from);
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		/*
> +		 * Currently only atomic writing of a single FS block is
> +		 * supported. It would be possible to atomic write smaller than
> +		 * a FS block, but there is no requirement to support this.
> +		 * Note that iomap also does not support this yet.
> +		 */
> +		if (ocount != ip->i_mount->m_sb.sb_blocksize)
> +			return -EINVAL;

Shouldn't we "return -ENOTSUPP" ? 
Given we are later going to add support for ocount > sb_blocksize.

-ritesh

