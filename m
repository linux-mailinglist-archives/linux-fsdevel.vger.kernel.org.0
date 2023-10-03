Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CC7B6081
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjJCFs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJCFs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:48:26 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC076B3
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 22:48:22 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so273484241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696312102; x=1696916902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9I6c5Iwr/ba0wcKssKanfPKS8G9JmXveu7lH25s+r4=;
        b=JDH9QyogvfGIe5iICY7J39s9+tqKgFa5rrNsT2tcUPMX7rdUurAH3Gc6iROo5I5Nup
         K1Vt6gj6eY6iyO2aY0o3FVdDhnX7gLyFes7w5BQjuZ9sNVn13HdX8frNWcCXC0j5T5Gq
         uMDfUWBvBTdTi1T4rOStu4FaFpyVb6UqqNDH2QRMJFxV4E8IyO4ADXTI5cO5MylHWrLD
         caeT4zWapSr9Ss02uC9S0nIPTqr2hbg8aEAUVXDCp7/3TFYXXf+eqEV2vKesMZnUEgZT
         V8YOoHBMn1B53ML30pmJa+w6d08mXHg105klYpK7vaDra5J1VlzXIGtmiDXAejcuys1V
         DArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696312102; x=1696916902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9I6c5Iwr/ba0wcKssKanfPKS8G9JmXveu7lH25s+r4=;
        b=YYw7zqwjtmOFb6i0q/mNRyMPISjRpjlvImGOfXV0pVAPHrVdwhqcQTHY4Lbe8n6Ra+
         WBNY9NTtw3Ppjd1iz1fok8Clu8StxxOEwe1Ad34dn1kxs5YhhnXo9+XQej52yH558CLZ
         asZYduvXTqXrRYKYZx9k6jyoB5Sv8aTBN1WnoBGggrmIPoY/HnocGxmC7xaCCOrzvNFe
         p1zj1xCBY/BHi8RivF7Xy0QPAGRjUNtjIqfJsl4TT8cXHIgTLmzz0r9muqeOIrJl2baG
         NbHTJii7xMKIVHj6xRZtChFctkl9Zmn3Tkd1NFXCHxCGvo6iA1xKz9EY6KuHuhnH4cLs
         xGAw==
X-Gm-Message-State: AOJu0YxfMmnCC9Cn7tY8DZwAzt6TTvTyXtGv8ZB3EAKkD7/KX1TnzWnC
        ObTxVPNW7+t+auOy9fgATMz+lOTUDWb+NURSAFY=
X-Google-Smtp-Source: AGHT+IE/TD/7gci8Ynz+vg+opW2HyHCnA+bveARviO4k4TBQ1IQj0346GBakn5zu3Yf6vdufRdiE1l1vlq4VW0iSlsI=
X-Received: by 2002:a05:6102:104:b0:452:88da:2e1f with SMTP id
 z4-20020a056102010400b0045288da2e1fmr11572759vsq.21.1696312101940; Mon, 02
 Oct 2023 22:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231003015704.2415-1-reubenhwk@gmail.com>
In-Reply-To: <20231003015704.2415-1-reubenhwk@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Oct 2023 08:48:10 +0300
Message-ID: <CAOQ4uxi04iyf-9tnQ3vREvBwMPK-MaDVWi0KcqTNufodsxDFZg@mail.gmail.com>
Subject: Re: [PATCH v4] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     willy@infradead.org, chrubis@suse.cz, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, viro@zeniv.linux.org.uk,
        oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 3, 2023 at 4:57=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.com>=
 wrote:
>
> Readahead was factored to call generic_fadvise.  That refactor added an
> S_ISREG restriction which broke readahead on block devices.
>
> In addition to S_ISREG, this change checks S_ISBLK to fix block device
> readahead.  There is no change in behavior with any file type besides blo=
ck
> devices in this change.
>
> Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNE=
ED")
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Christian,

We've had a lot of back and forth on this patch.
I've asked Reuben to post this minimal and backportable patch
which should replace the one that is currently on the head of
vfs.misc in order to only fix the regression without other changes
of behavior.

If you happen to send any vfs fixes to 6.6, this one can also
be included but no need to rush.

It would be wrong to mix the regression fix with other changes of
behavior because the latter we may be  forced to revert in the future.

Either Reuben or I will follow up later with patches to change the
behavior of posix_fadvise and readahead(2) for pipes and sockets
as suggested by Matthew.

Thanks,
Amir.

> ---
>  mm/readahead.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index e815c114de21..6925e6959fd3 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -735,7 +735,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t =
count)
>          */
>         ret =3D -EINVAL;
>         if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> -           !S_ISREG(file_inode(f.file)->i_mode))
> +           (!S_ISREG(file_inode(f.file)->i_mode) &&
> +           !S_ISBLK(file_inode(f.file)->i_mode)))
>                 goto out;
>
>         ret =3D vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
> --
> 2.34.1
>
