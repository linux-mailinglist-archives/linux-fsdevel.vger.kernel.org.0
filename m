Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAF4C53B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 04:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFTCOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 22:14:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36168 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfFTCOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:14:22 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so207942ioh.3;
        Wed, 19 Jun 2019 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CT8hlrXVlTQmAih9bPn62q6lhl2ZtSQvdUbzFuBlEhw=;
        b=mLHzwm4s78ijFOuibu94vz9s0tlyHHC4RZuFjv0uzt/kn1V2umCjZqxHN3bcx0h1u9
         RKnSqgSf2x8IxwE0aGRmo3e0rpTdZPsC66VULu/1foY8zbWl/loQD1Fp+UCDShnFox/o
         0iXNXC3JrDDLb7E+OS3CE/UquUHBypQj5pTribYniyPV6rsR3sHGVmgYSCF7nWPROTNg
         VSvRPAXFmFYW4GjbsA0t2WcMhgzBE5i0TToz5ks7GBnTokbjqo/FaH8s73u4xvDpyj9R
         DmVov9yUhFb4WByqS6N+gFL/Mb8xXHRgNVrgUoh0rzJ7Ld+DmrceUas0gFJ2Le6Yf2Ou
         LaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CT8hlrXVlTQmAih9bPn62q6lhl2ZtSQvdUbzFuBlEhw=;
        b=ZX/GRrtAzrOtKM2oO6ifSYxJliOuyaxtNBHD8qQtU4k4KHMgBvHzhF51RGBuNM7s9L
         pOvb3OtnTyqKp6mNNPd/Nt5gSa7EwR+4VZCwTq6dXksWO8sbouB3FGzrXUQrFrJ7UPKu
         ONg2WUwg/sybAnCEQaup0xZ2DjUsq38uByqrdEHQgWp4kjKsNMQsa2KZTnRcZVYNBSNC
         jUuVyEMBSs1YmyJ3sDbvt1ohCeovM/aqp/ksenqWBDc1tsBNsg8Q2sk5cu729b1Hw7YR
         MupOrA230NtWqpWQn6geKB8jRcYfy2JHcP1BuO7z7sLlH9M0yrXwDVA8SYHI4Kd39UO2
         tNeA==
X-Gm-Message-State: APjAAAURVE0UhcESIARp5U19wdd1KhnpKwera8yloyGP41T7WcRJLBdX
        mAF/P2WMMesPfyY+cXT7R6dVLylmwkCupmgxZj9Xt/We
X-Google-Smtp-Source: APXvYqza1O5vy/sMEXqio8vDj2ErJ1IMEfPJ6U9XMwIzVL98XV+0sA717DKpUHr2iaiGrtOr5oc+UrSRpmdUpCcaiUU=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr26972589iob.49.1560996861462;
 Wed, 19 Jun 2019 19:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
In-Reply-To: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 20 Jun 2019 12:14:10 +1000
Message-ID: <CAN05THSoKCKCFXkzfSiKC0XUb3R1S3B9nc2b9B+8ksKDn+NE_A@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:45 AM Steve French via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Patch attached fixes the case where copy_file_range over an SMB3 mount
> tries to go beyond the end of file of the source file.  This fixes
> xfstests generic/430 and generic/431
>
> Amir's patches had added a similar change in the VFS layer, but
> presumably harmless to have the check in cifs.ko as well to ensure
> that we don't try to copy beyond end of the source file (otherwise
> SMB3 servers will return an error on copychunk rather than doing the
> partial copy (up to end of the source file) that copy_file_range
> expects).

+ if (src_off >= inode->i_size) {
+ cifs_dbg(FYI, "nothing to do on copychunk\n");
+ goto cchunk_out; /* nothing to do */
+ } else if (src_off + len > inode->i_size) {
+ /* consider adding check to see if src oplocked */
+ len = inode->i_size - src_off;
+ cifs_dbg(FYI, "adjust copychunk len %lld less\n", len);
+ }

This makes us return rc == 0 when this triggers. Is that what we want?
Looking at "man copy_file_range" suggests we should return -EINVAL in
both these cases.



>
>
>
> --
> Thanks,
>
> Steve
