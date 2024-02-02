Return-Path: <linux-fsdevel+bounces-10035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF08473AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CED41C2452E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBD145B3E;
	Fri,  2 Feb 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bfntJQMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5B1474BA
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888981; cv=none; b=W90mKQhaSTf3Mhg67eOHTeQrRiuINyKsscykBcpgMTyaP5M+nt6i+dK5S+WS+t7hNShAGRNpA9uTRGMEQsigmXY1/pP74W33s0ONfECcLHkc1R15vj02g0xl8ZGZuYO7PmQcgTvcYfs08tIETa3owX6Lt60+Dv7hSgkEPNXcRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888981; c=relaxed/simple;
	bh=Pqqd2eCMatPfNpTdinIeb7af4EambkaxKfyLK1ad1Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX5XZx6A0P5Ns1IIbZdvts0xuy2m1IDkHK8WoXMvaJGToq3c2TkIpNrWhbe48KBJvGoNampqZPWqYPOp78vKohus0OKC+i10TIKYVfGI4DqYthEaXlqHXxBDwij4QbsQ5w9Q+grCILoMLfS38SaLqJwxgQtHU2QNuAltX96IfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bfntJQMa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a35e9161b8cso311620266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 07:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706888977; x=1707493777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S6WHSaSMQdpDBFdRz2NpMLyLIbPyvC4EWIKUuVbjxdA=;
        b=bfntJQMamCc2glmIRwBKSKHpW2Iz87zrzHU81CxTb8Jx5gMKXzmuDZE9+LJfQfr7eB
         4fyOehYHv1VCSdqCtx/2baq8TvTn9pMYdQ2MjFT2CwhwCDohpWFfEK4zxn2WQdZJ6+KW
         svyi8hgsgV1+SFTfDwscuAiQhF7ewM76YP3Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888977; x=1707493777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6WHSaSMQdpDBFdRz2NpMLyLIbPyvC4EWIKUuVbjxdA=;
        b=pGJJxzXbFHnNyTdpLTFLiRVY5h9/ckZLhdnN7oCg3ay9SwkphpPoMVL2y5124AZlgy
         WoD7T4dPk44RzySEhWkHjTH8oDUG6CIgXj6ShPjqmunPrrTxaE0D/U7Dz3e4UPz+Ip2c
         MmRkDKFa8+2ig+msCNDn0NfkDeX36SkASNLAtZ7PxFHSPAxIxdJW/LVc4zTggRnKfgif
         NRfFrHuqjcKHG22LFQX71b1q5VSKHCJr7xaCma2S7GbD6TjzKkWbW1bVnuhCjl5AWTZB
         fK12lhokbFlL95rttTsAl1xmoAxiDJY57hUeyEExb91LsNvEPwBqWUfMUvEUTZFWXckH
         3nkA==
X-Gm-Message-State: AOJu0YwSlcvKVNtINvMzIQLdztHglNPTbtFeqIIVwpVMwPwprSP0bLT6
	Md4P4963qD6GbwE5IJMfkbmkKqnGGIfvDmadlpMxIL2UdZog1RSwamTZoDMZ4LWtRYI4N/RfSZF
	V/zZ2S6VR016TFyKoxRGysdG/R/vv/KY2R2d7To1LmX2EZnaijC4=
X-Google-Smtp-Source: AGHT+IHZ9NS+o7bc9uF/lDy33EFbzEr/Bqm4y71OvHirCkmIM4Zm+o5O9OqDCL+pDgpSoShJ0nU+oEFY19GixZz1mZg=
X-Received: by 2002:a17:907:3da0:b0:a35:fa06:aced with SMTP id
 he32-20020a1709073da000b00a35fa06acedmr2305784ejc.65.1706888976886; Fri, 02
 Feb 2024 07:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
 <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
 <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
 <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com>
 <CAJfpegs4hQg93Dariy5hz4bsxiFKoRuLsB5aRO4S6iiu6_DAKw@mail.gmail.com>
 <CAOQ4uxhNS81=Fry+K6dF45ab==Y4ijpWUkUmvpf2E1hJrkzC3w@mail.gmail.com> <CAOQ4uxgrgoEZ34Deyg3RYJJM8+XuWVtDB9tzcXCiQvzcba8bhQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgrgoEZ34Deyg3RYJJM8+XuWVtDB9tzcXCiQvzcba8bhQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 16:49:25 +0100
Message-ID: <CAJfpeguLBa4OzoBcxYwf0e_swctKvNGnVXLpmomU6a9wy=5f0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:03, Amir Goldstein <amir73il@gmail.com> wrote:

>  static int fuse_dir_open(struct inode *inode, struct file *file)
>  {
> -       return fuse_open_common(inode, file, true);
> +       struct fuse_mount *fm = get_fuse_mount(inode);
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +       int err;
> +
> +       if (fuse_is_bad(inode))
> +               return -EIO;
> +
> +       err = generic_file_open(inode, file);
> +       if (err)
> +               return err;
> +
> +       err = fuse_do_open(fm, get_node_id(inode), file, true);
> +       if (!err) {
> +               struct fuse_file *ff = file->private_data;
> +
> +               err = fuse_finish_open(inode, file);

I'd prefer fuse_finish_open() to be expanded as well.  FMODE_WRITE is
always false for directories.  The other two FOPEN_ flags don't make
sense for directories, but let's just leave them for a later cleanup.

Thanks,
Miklos

