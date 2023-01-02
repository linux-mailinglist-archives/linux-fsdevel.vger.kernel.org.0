Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13365B17F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjABLvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 06:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjABLuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:50:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C263C6;
        Mon,  2 Jan 2023 03:50:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so66109151ejc.3;
        Mon, 02 Jan 2023 03:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XiRDUPHQfJKrh1tv7ySme3BRWwotcQPxzDkvFbZofLA=;
        b=hzCiH0BUxJMKBvB2Z9EyQmXK6dDRsa7ZpCuTT4xPyBDVy+ovurNFPaP64wyhjBQ44Q
         IAiab6WKo0rs0hGg/YSO93LryQBOJudHoKhiYG1OHc2cF2q1wTysVeYqu7MQNL4KWra2
         ICrjhxzSo4T5LwA4HOvKQs8BJehlMPNBaw3p+5QRyZkfIc0XTt369sCjZOeLCCgv31al
         Z8y7f+WEtSG+aWxZUxS7mlszVCg+1KLpg0y0CCnseEPcBcdZsXeajUZ+RgiNLLB8UCEW
         6mNC5h85zyq+aNNYm6Jebizlivyh3AXCBlDyaF3+vmvG8zdTzyaP4lJ2xLTzAhSg3ppG
         Kw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiRDUPHQfJKrh1tv7ySme3BRWwotcQPxzDkvFbZofLA=;
        b=sp2SxBL7q4H6fq5TVcW3dwFibTcbH6uh24bJbTQnwGKJtop64oQ3lC8hzrhfg0H7Kq
         tD2iUJX2W9qG0ep3j2Ljn0n7VoKIGN1pi+Rof8DsaL7GHyHclJAqlEYlcsz2DLc5jMqN
         90vagcSYeDBBrkEhMXEwcOoftrvCu7Iw7quiLxZ0ajEEjKU4TN4WxNLy8n1tC6VKy2d1
         vh9kaf2YI0KLVHENZgsyiC5UBZ1I2AsQjDmwJ0cM79976tXpre/Ft12Mw6/6zmzY/hoF
         sLBQaLXggaU8r/fwtehncAzrSCyef+e4hJQl2j0qP7+zuQONSnxr0EiiyPKDz1zOv5w/
         RsXA==
X-Gm-Message-State: AFqh2kpYozakRx1re3uiR8AW05LlsPhG0psa/ZmM8kYv3uh35iEDEM0+
        AHm7rDlJ5vTmPOIeP8N6uLqveOIiBbJ4cdkrT0E=
X-Google-Smtp-Source: AMrXdXvB1EQn1hP5gfze1tQPXFIa+8YuBSvBWMo3uE7lpj1qTrzRRi89RdK1emE1whGtefCku3/G/RZhWTwe9rN1UL0=
X-Received: by 2002:a17:906:708f:b0:7c4:e857:e0b8 with SMTP id
 b15-20020a170906708f00b007c4e857e0b8mr2656948ejk.603.1672660243906; Mon, 02
 Jan 2023 03:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20221214033512.659913-1-xiubli@redhat.com>
In-Reply-To: <20221214033512.659913-1-xiubli@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 2 Jan 2023 12:50:32 +0100
Message-ID: <CAOi1vP8v_ggvwA+FwctU-97a89KU-wrSPz0oMuNdMQU8gFeT7g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ceph: fix the use-after-free bug for file_lock
To:     xiubli@redhat.com
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org,
        mchangir@redhat.com, lhenriques@suse.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 4:35 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Changed in V5:
> - s/fl_inode/inode/
>
> Changed in V4:
> - repeat the afs in fs.h instead of adding ceph specific header file
>
> Changed in V3:
> - switched to vfs_inode_has_locks() helper to fix another ceph file lock
> bug, thanks Jeff!
> - this patch series is based on Jeff's previous VFS lock patch:
>   https://patchwork.kernel.org/project/ceph-devel/list/?series=695950
>
> Changed in V2:
> - switch to file_lock.fl_u to fix the race bug
> - and the most code will be in the ceph layer
>
>
> Xiubo Li (2):
>   ceph: switch to vfs_inode_has_locks() to fix file lock bug
>   ceph: add ceph specific member support for file_lock
>
>  fs/ceph/caps.c     |  2 +-
>  fs/ceph/locks.c    | 24 ++++++++++++++++++------
>  fs/ceph/super.h    |  1 -
>  include/linux/fs.h |  3 +++
>  4 files changed, 22 insertions(+), 8 deletions(-)
>
> --
> 2.31.1
>

Hi Xiubo,

I have adjusted the title of the second patch to actually reflect its
purpose: "ceph: avoid use-after-free in ceph_fl_release_lock()".  With
that:

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
