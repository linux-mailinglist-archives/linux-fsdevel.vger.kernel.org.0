Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17420417083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbhIXK7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbhIXK7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:59:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA12C061574;
        Fri, 24 Sep 2021 03:57:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so37581123lfd.12;
        Fri, 24 Sep 2021 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s17FqViMBOr8Te4pehncbfRy5I9CQXJfZ+kmZOISVmI=;
        b=h9etuSw1jD93JbwOUW3o4MInJt6oeyweOqViRx2JaKrpBJ36hKeubAJ5Bf8BbdB0ll
         TkTSbI2q65OmpuOOl5HBYOQgASys9d7IK4137Z0fPmsTGyVm+ZDS5XOg+a4YPkYGDLMl
         Auz1ekwhzwcSQPZcLekBTcNgIV0+Ki25HkUw9iLBVf+gpRjKcus/UrIGP5OosXiVPYNK
         hki9i0+Ej9YO7b0072Ntp6VsahNjZgLanQvmvBHlRilrPts2ytBEPCC+WnRgDrQRcgTp
         LsiOMZfkRl17WxmbsgyqGdipsSMhUmx2rhJ5GAN+tghRskWZP9He3d09h6tf8wMPRTH8
         F3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s17FqViMBOr8Te4pehncbfRy5I9CQXJfZ+kmZOISVmI=;
        b=dBSy4SoPc0M3bAs5ETlltiF7Fh5JleHfofAVZg2XPSjya86gOGzkhdewFJR12IfcFU
         YAckwYas/80iQuA+KwheVSZnEa5pq981oN4n2xMCHmVWuBHtYwOytF0+xFwbqNMOwB38
         sFRgnxha7suZqCY0jKMbqeCJQr8IoujHcP+IKQaxoFM2YToIFqeORwrNwkER9dWgnHHQ
         Y2sxOtpVuWg3j8GluKi3aa3zglrV946TuAt/OXBIIOa4n6nzLW6aBTEX6KBB5Dxx0lPa
         9P8CYpEgwWcTEHrOzZF7TavvKaLhCm6bPMfeo1liHZohaq2uUApy/00JnDzujAXK9Eij
         Yvng==
X-Gm-Message-State: AOAM531hrBAfJ5CusrQVWtiu+AIGKP+UMARvqEqjuhZCKuQ4DOtL3yjr
        E6ZzE97rIaOYKSdV1LsdhwgspihGgHI=
X-Google-Smtp-Source: ABdhPJzenVfwFCRai6X+jcxzqXd58vHhLuJqJKoFAqquzev4tm44s0FiVN8Fd1wDnjDnvrMF4S39dg==
X-Received: by 2002:ac2:5f41:: with SMTP id 1mr9048364lfz.79.1632481052882;
        Fri, 24 Sep 2021 03:57:32 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w19sm887695ljd.110.2021.09.24.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:57:32 -0700 (PDT)
Date:   Fri, 24 Sep 2021 13:57:30 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] fs/ntfs3: Refactor locking in inode_operations
Message-ID: <20210924105730.2fyzesynznjieddj@kari-VirtualBox>
References: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:38:39PM +0300, Konstantin Komarov wrote:
> Speed up work with dir lock.
> Theoretically in successful cases those locks aren't needed at all.
> But proving the same for error cases is difficult.
> So instead of removing them we just move them.
> 
> V2:
>   added patch, that fixes logical error in ntfs_create_inode

Whole series

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> 
> Konstantin Komarov (6):
>   fs/ntfs3: Fix logical error in ntfs_create_inode
>   fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode
>   fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
>   fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
>   fs/ntfs3: Change posix_acl_equiv_mode to posix_acl_update_mode
>   fs/ntfs3: Refactoring lock in ntfs_init_acl
> 
>  fs/ntfs3/inode.c | 19 ++++++++---
>  fs/ntfs3/namei.c | 20 -----------
>  fs/ntfs3/xattr.c | 88 +++++++++++++++++-------------------------------
>  3 files changed, 46 insertions(+), 81 deletions(-)
> 
> -- 
> 2.33.0
> 
