Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5263B77DBA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjHPIFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbjHPIF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:05:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3DC2705
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:05:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c136ee106so826318666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692173119; x=1692777919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvdVBocTF3g82OdbrW1329iCJNDsO6RbmMm+mRrv4jM=;
        b=FAifJtLCb7k6UxvB4wQioo15Zy3SJO9y0ggCGvixx4OaWlavjkvPjeLGAGIP4DLx8r
         wi+5c7M9kvPr8BKBCRQbJByB7rpEkXzG1Y3axJa/Lt4PcAwRZQhoPd4DfnJfcio87QP/
         KDUQUuCjT3Q498xn/TtYisguaMITjFhaf+CJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173119; x=1692777919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvdVBocTF3g82OdbrW1329iCJNDsO6RbmMm+mRrv4jM=;
        b=i8S0+d+hMDjOgew97UqjOM9EhASRwCydzjHELdRt9vXIqJR3Z2oIaNlHCeBRdXmW2a
         GJHHmHji3Z8JCXnBMOm47tPI99j5ETVdwgkUbSogYI9wWSHOuQiG0ijxiqxS9SECfg/Q
         G+onu3hwqRNiKaZPkGjMjB3zZ+qb7KFDREvGGvQYuhp3ZdPOE2RcNjjj923Iwz6Ms1Cu
         owecHRCSDCcddut5FZI5uRjGqg5eUucPl230GB/b74ogrBuKsy9PfaeNoI+4Fo2XblMV
         eNC+n0fMXxfM5KCCBzCioQ1Oh+y21+zjiMsBeGNn2OaqFG2Tx5qZZ89EdeztzLcDnxbW
         jibw==
X-Gm-Message-State: AOJu0Yy7GYJwr7l60b2La1AVa4nxEe79E+k2GBwtatWGc2PtBrekorv0
        vmMh5cR87W4me/pg6Ptu3o+JtlckogPX/PZ3Pv3G3/MdsJcbjEkltZs=
X-Google-Smtp-Source: AGHT+IFQRdhEhXVXFZy1tOAt7zLwCmVCjGMzpQKaXqJKHb+Wy/2fovO0+2JhzK9GXQneeiD0x9EU97yIUu+SAXiZPrk=
X-Received: by 2002:a17:906:5195:b0:99d:f6e9:1cf8 with SMTP id
 y21-20020a170906519500b0099df6e91cf8mr355025ejk.20.1692173119472; Wed, 16 Aug
 2023 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtjQxPd-nncaf+7pvowSJHx+2mLgOZBJuCLXetnSCuqog@mail.gmail.com>
 <202308110712.37B7CIwo078462@mse-fl2.zte.com.cn>
In-Reply-To: <202308110712.37B7CIwo078462@mse-fl2.zte.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Aug 2023 10:05:08 +0200
Message-ID: <CAJfpegtrmm=+9QkQoQm3t2=GjcwTEAcmCt_ChLkXjn9Bg7M_UA@mail.gmail.com>
Subject: Re:  [PATCH] nlookup missing decrement in fuse_direntplus_link
To:     ruan.meisi@zte.com.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Aug 2023 at 09:12, <ruan.meisi@zte.com.cn> wrote:
>
> From 53aad83672123dbe01bcef9f9026becc4e93ee9f Mon Sep 17 00:00:00 2001
> From: ruanmeisi <ruan.meisi@zte.com.cn>
> Date: Tue, 25 Apr 2023 19:13:54 +0800
> Subject: [PATCH] nlookup missing decrement in fuse_direntplus_link
>
> During our debugging of glusterfs, we found an Assertion
> failed error: inode_lookup >= nlookup, which was caused by the
> nlookup value in the kernel being greater than that in the FUSE
> file system.The issue was introduced by fuse_direntplus_link,
> where in the function, fuse_iget increments nlookup, and if
> d_splice_alias returns failure, fuse_direntplus_link returns
> failure without decrementing nlookup
> https://github.com/gluster/glusterfs/pull/4081
>
> Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>

Applied, thanks.

Miklos
