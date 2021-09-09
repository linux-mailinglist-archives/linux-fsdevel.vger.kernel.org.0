Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F455405902
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhIIO2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbhIIO22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:28:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C26C022587;
        Thu,  9 Sep 2021 06:10:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e23so3612951lfj.9;
        Thu, 09 Sep 2021 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KHHoXrJ+SWW5a+9TtCJiIXbU7xyrGDf/8+LvAfdLqDE=;
        b=PpJMwvr4XwaYDUeqvg+foTmVL2OPhrRKP7dZuNVVDjKveMWs8caoJjpQeu5cuPwj7R
         G2F/iZWpZtSreegjcTtfB/5Gb8rs15S6J2fPFYdpXhzAMj3813MEbJT5xKwXHSbOzHBi
         6aHSgRHY+dz0eCE2lAi69SfixQ0r3e823BU2wvLfVmxfmZZjn0j/tVUQlGJhgwRZ3aI0
         ZeB249bCY81LdhwDSDkNNQm1Y/0CYP/e4zRJHjsdYg/TBhsZuYIRjayCDD1c8L/UlvtE
         YCff0MJyqgrh4i8F/Z189NiZ0f5tROaSmgcwEF491imA4hDSZcHwxvjnKV2SR4Eb1Ber
         msBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KHHoXrJ+SWW5a+9TtCJiIXbU7xyrGDf/8+LvAfdLqDE=;
        b=z9fpTP7+n6yFvdREgT6wnndbKCKuR/ESxSSqV+jUhiRA4XGr7tsBvg5cGBQITzczua
         0QvVf61SI9h9+N7Hujvjf90k5E0lUpl/hhiovy8RYAlKMdbbzEcFmT5+ikYBkERtl1ht
         Muwbekt4H/LRM7k7R5xr7UKf8J2Syincymqb3825gxwb5OaxyGCq+q6KDp3cWzwz3shE
         gitwTZm7rKFf8+6b9nbj3b4RGXqazd5dTgXL1T2rb1nwUzIyPqK5vWGv7G1ybrL76/bV
         G3KzN1UxrqSr40n2Z/H6n0julGBpV118bfucxrhca0IZwAMeKfl7rMais7QEKMRliuCe
         nypA==
X-Gm-Message-State: AOAM532N9quyEhdSsFuWUy0c6IdwnMScODOlIaIgxF/3dnC2GWzIoybH
        dpAYY38E7erY+HxvdSeiPpfqEXBpGsM=
X-Google-Smtp-Source: ABdhPJw0fUflj9KJzjYW3MEnAJFaoPREIExujmJjLB0R16NBBZacjdzjI4wTTx3sL6g1P5gG3g2mLw==
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr2263936lfu.253.1631193004167;
        Thu, 09 Sep 2021 06:10:04 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w9sm211056ljo.36.2021.09.09.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:10:03 -0700 (PDT)
Date:   Thu, 9 Sep 2021 16:10:02 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs/ntfs3: Speed up hardlink creation
Message-ID: <20210909131002.sketqhqczh4ahe74@kari-VirtualBox>
References: <db0989dd-c03b-d252-905c-f0ebd0abe27f@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0989dd-c03b-d252-905c-f0ebd0abe27f@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:57:51PM +0300, Konstantin Komarov wrote:
> xfstest 041 was taking some time before failing,
> so this series aims to fix it and speed up.

Please replay patch series against to cover letter.

> 
> Konstantin Komarov (3):
>   fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
>   fs/ntfs3: Change max hardlinks limit to 4000
>   fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update
> 
>  fs/ntfs3/attrib.c   | 2 +-
>  fs/ntfs3/attrlist.c | 6 +++---
>  fs/ntfs3/frecord.c  | 6 +++++-
>  fs/ntfs3/fslog.c    | 9 +++++----
>  fs/ntfs3/fsntfs.c   | 8 ++++----
>  fs/ntfs3/inode.c    | 2 +-
>  fs/ntfs3/ntfs.h     | 3 ++-
>  fs/ntfs3/ntfs_fs.h  | 4 ++--
>  fs/ntfs3/xattr.c    | 2 +-
>  9 files changed, 24 insertions(+), 18 deletions(-)
> 
> -- 
> 2.28.0
> 
