Return-Path: <linux-fsdevel+bounces-67156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811CC37171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC1660A64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032B3358AA;
	Wed,  5 Nov 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JjbVpDcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE32DF703
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360696; cv=none; b=eyq2+HJBvE/dPQRiVt8PTrTk0+Z4TUd9nJ4U+GSG8IhhfjJrLbkFLaZan2NkuZKSprMW5TnMa/wxi/LCaHypRDA3N/Q/H/fXqaE9SWBL8SwU2EFyyEVxDinA5frzVqMVGuP2IZKcncGh6NmjQgaO0CjKv45sq2R/T1RlU74SpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360696; c=relaxed/simple;
	bh=IB05EblKhL135eVzQOGdqVSAaRbQ8gKw4M6wwiiepkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqR4S80j9B7YcRn2Sm23crRFsvbmapI3C0m/pCNpwrCCG9YLjGMhVe7b9y7SJTAvJsvyPiYbRfM40697PPF9E7grZ6Br1LB7QTdWLCB0i80J241B2dP/WzLWS7vfEW8Hx3gdeL9m9B+rrgET3f/8IgWO7xpGBT632ElQY2JiYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JjbVpDcO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427007b1fe5so29684f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762360693; x=1762965493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbHuXuLIzszW8ax5jC5mySex6PqwZ4YZgNRjtsqrskA=;
        b=JjbVpDcOf/jiZBXuv/Otryyu0ZhthITMaIM4IW5/I5u5/BHU/4A0CHtA2N47nCKou6
         D7lcNz2/0Wq+NcsqBrKncBY+WPY0HdD8qx2+OjcWZteyFVcWJWywCBZXJzejiZ/yBmwj
         YqCaaOBN2qBrYL2BRNkblAFeEVD33wH+N+reHxqig8ySmaeNkPOHLFXjqFNlGV7/jlJw
         NVe4vRxEeZ/hzLLn6TyPQ/7fNyBpFJ8uO+Nl7O/3PQdE9SklxUApTtW5jgdGodoKS5N5
         MfaoKFrZgZrtL2Xiv0QaUBmIKfhy8o4UHX2AcmzxiljuguNPzuaV5SZYFjhUrruGNfdm
         OAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360693; x=1762965493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbHuXuLIzszW8ax5jC5mySex6PqwZ4YZgNRjtsqrskA=;
        b=LnHhGvn7dPwHgayZmrCmDJ7VNwpV9Gn6ZKu4eeR6jLCJmbrAEa2nG/yekB2HNi4aTu
         bKg1A5DzmRy0GkGLfkLz/VHeMrfEoLxpPWM+qigDG+72tH5z0lkRtdcBIvgzcCqhFWQM
         kT0R4VHq93uQ2L2gzaWx0N5VGao0gsMSD5GM2hNNuMMzvjLnMM48v76hM8YVYhoQ2UZG
         oyvrj0vEf4wR/4qazmaQmsTufHgLaxru5xfxIOQCquOQzzDG54rO+fD/ttZn5FlIBs3K
         wgWZqwazqIm2Eb/BywRlj1eaQL3gxIECS0uk/B3mQra4GaLaxuvnihq9E5Emm+9AaJp+
         iBUA==
X-Gm-Message-State: AOJu0YyQ5Vi5vCvYfcUoTBufAn7qBCbgbLxpGbsbQaI/X88WjM0Jn2zy
	rjvxfOJT+DQ5xBtfUiO5GnTSLGbHrndhZrWwu095P5ySbLYA5mlSjb0+K4HV1fMAZWRuiQhV6zy
	zQ4lYh5OT7ua29o5LjVyD7vTOrVkJV5raDlaBkn/OhA==
X-Gm-Gg: ASbGnct8/ir+Yp1AMqgXPCllHTHdULJcVhBj+pW/DCAMvMOpzoiI2LYuAFuWFRc3xpx
	yiQWMU/IVA67ZlisCa9bKV6fe7SVZvTy3tl6n8DSvQ/pq/IY6VQXZ88ggvA9xN1qCDsxodJ0Gh7
	iNkYaaO15qM/XQO2gqH1k+N/iLUBn87bcSTOacqwxl/M44KhQiMnFcpto+Wn2QbSLuwkT2S5YvD
	xRO0UJ+s5wGZDedj09ReBEJYbX9O8ApmzD0og5IsTUrc/qo0t8p4lxbv03lU6KCwgZvQJn4hp9U
	whMn2H9uo7QxwPxvlOYIX32Igii6/75r2rCzRpG+UKYysic2Xfz0DTOLcQ==
X-Google-Smtp-Source: AGHT+IGJNIa/9qEOs2E840EbJH/OcafXkhGwOmmMo0TDuK8YRSQn+tMgefKtPW2tb5cKsMD1UIAuP2frisELZBu421U=
X-Received: by 2002:a05:6000:615:b0:3e9:ee54:af71 with SMTP id
 ffacd0b85a97d-429e32c82e0mr3641151f8f.12.1762360693049; Wed, 05 Nov 2025
 08:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-3-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-3-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 17:38:01 +0100
X-Gm-Features: AWmQ_bmQvhyjy3LzyEZU5BgedQdx4krqy6phuMugNr7MqLhXhxb6SOC0zAoqXec
Message-ID: <CAPjX3FfPyENVNve4Fe6YkYvTEwK3FBhaQ8ux1os9VVp_hYVRSA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] btrfs: use super write guard btrfs_run_defrag_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:14, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/btrfs/defrag.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 7b277934f66f..35fb8ee164dc 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -254,10 +254,9 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>         range.extent_thresh = defrag->extent_thresh;
>         file_ra_state_init(ra, inode->vfs_inode.i_mapping);
>
> -       sb_start_write(fs_info->sb);
> -       ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
> -                               BTRFS_DEFRAG_BATCH);
> -       sb_end_write(fs_info->sb);
> +       scoped_guard(super_write, fs_info->sb)
> +               ret = btrfs_defrag_file(inode, ra, &range,
> +                                       defrag->transid, BTRFS_DEFRAG_BATCH);

We accept lines with up to ~100 characters in btrfs code.

--nX

>         iput(&inode->vfs_inode);
>
>         if (ret < 0)
>
> --
> 2.47.3
>
>

