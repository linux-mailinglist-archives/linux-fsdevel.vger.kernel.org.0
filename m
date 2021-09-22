Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C04415028
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhIVSwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhIVSwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:52:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D2C061574;
        Wed, 22 Sep 2021 11:51:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g41so15697441lfv.1;
        Wed, 22 Sep 2021 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TVdYbzVz6L9w50OAN8iUpXr44c199Ry+YrB4JvrmzuU=;
        b=XhDztYIsxAa8cjARTwToxeBqNr3RFSJROe439D2C4d1++xECT6ukhhChELX3or3ymO
         awldyLjasKf59wVaHWsThVsQmZfrlKKngJ1aM0do2U0Lkdd4o9L8k3ceYLoYnFxO76qp
         svQIFrp5oRNKLXt0Fj6hqZJYlGOkFbC1tBe+lODs6/nRhu5ub2ZcoLhRlv7NE/9dP154
         PDKiSZokRhXyHUiYyl5sQT7KLMC26NDzgSSJVoMOAnkHFUYJww+j8/SRlhHDCkG6cXLm
         4vewTEIanzwHwJVG13uUdchNSp8JjAlBSW3n/fV69M/dbp580Han4QuMKabQC1nU+L13
         pPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVdYbzVz6L9w50OAN8iUpXr44c199Ry+YrB4JvrmzuU=;
        b=dESbIs4cdGVBG83A+XlB+PbD7ZNrtNpAxmUlBoloz9csr4XdgORLbLiW93CmQRLk3n
         uXmYWM6rII1g6vqVWudsdAfkHp1G/pQBTEYoBhEaS+52lDQjn/PYGmiDbjDjkY6AzELO
         cDbJSTBsqN3BUCLDhrhGYtyDYUJax3nRorTBwOGQMF7ywOK9+ZLC+up/BaXMBGXgebSd
         LLdCd4Hi6utrT7dQmrvrqIv3XHAkSCpQQ64iZFZvytyaoPqftKKqeouH8IFWbkbcBvva
         4a2hlDK7gq5pcvD2MXomBW/Mu5xU871VHW4eONVfaz3CSgDVk73e7lNQWa2JzbsxVwSI
         9aew==
X-Gm-Message-State: AOAM533RAGP0Ia+yD9R8bld1oycsYE8j4sj/C0p2zRZkKpAcmTG7ts57
        bGH5J8bXLwElUuIcppadsAJXyiNiyLo=
X-Google-Smtp-Source: ABdhPJyXuXlABlOCKqBOspLUw2wr+pcY6KLy6RyaUp3HLUSDjtqsTkWsufvlbMKSTJZcGw+uptSFgw==
X-Received: by 2002:ac2:5978:: with SMTP id h24mr461208lfp.426.1632336683335;
        Wed, 22 Sep 2021 11:51:23 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id a16sm239618lfu.274.2021.09.22.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:51:23 -0700 (PDT)
Date:   Wed, 22 Sep 2021 21:51:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Refactor locking in inode_operations
Message-ID: <20210922185121.gke6tigiqkfwovis@kari-VirtualBox>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Subject in this message needs fs/ntfs3 minor thing but try to remember
next time.

On Wed, Sep 22, 2021 at 07:15:19PM +0300, Konstantin Komarov wrote:
> Speed up work with dir lock.
> Theoretically in successful cases those locks aren't needed at all.
> But proving the same for error cases is difficult.
> So instead of removing them we just move them.

Maybe add this info also to first patch. 

Overall nice to see now good patch series which has very nice splits. It
was easy to review. Like I say in same message already try to write
little more to commit messages this will make reviewing even more easy
and we start to get nice history which can be used to develepment and
maintain work.

> 
> Konstantin Komarov (5):
>   fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode
>   fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
>   fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
>   fs/ntfs3: Change posix_acl_equiv_mode to posix_acl_update_mode
>   fs/ntfs3: Refactoring lock in ntfs_init_acl
> 
>  fs/ntfs3/inode.c | 17 ++++++++--
>  fs/ntfs3/namei.c | 20 -----------
>  fs/ntfs3/xattr.c | 88 +++++++++++++++++-------------------------------
>  3 files changed, 45 insertions(+), 80 deletions(-)
> 
> -- 
> 2.33.0
