Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4845AE38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbhKWVU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbhKWVUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:20:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20EC06173E
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:17:09 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n85so514219pfd.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
        b=z/Kv5aF3II2Q1LX6Aazu4oeYGV1DsHDm6VPftSCm/GsXUqcvpUYlHGhNQfvcAEzM+t
         KHEErzvzy9AE7efI2veDZidjjq+fK6s2UJs7fEhnYmQiPFx9rvXEwel822roodlc/FcK
         DEv5SfZdo4Mf/qMs7Jb75ZFTHTDu0awILjq9sqTvXs+VIsFn7y/1XB/C+/lY4NwLFtHP
         cHAfa2a7eS26AcezybSCXTWBbxiGPri9iUr8Wx/IV+DiOD4YHSNiMvTZGqn4/3tFE8gU
         fEqZVpI1Dt83hXy63DNbfv4vosQWDr6RKn8ZmI1PKEqbMIgBEyzoH/HXIZQqJ3XqzuZq
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
        b=mESjql3TtkzCmWndlQfPseeBdb8AFihIMzxP11QxrH8EnYGf+U8bw595rgBYrn/hoM
         5ZF6s80WQ7ZTo8dx5bv6mLHSOimH5C8vlR1w2jVxKBcX3P7+JowZNGwoTe4Xu60UQAmc
         /xkdgOclQXPHjDYh2eOYh/7woaIKYiz6BrgORRaoLxVClp5zihnGBH/Wua4jZZR/hPwW
         rSSry7/MnSrFNxL0mJQ0Cs1nwv/eCNqkOURj5LbNT7fFDleZQxDHuUDWrmUwpvzuAfjG
         gnaEH9VL7+i5dTl4KsFkp4W8SQ/J4Sfs0+DLsPqYEmwwMtPY+1+KqeNz2/C9QU2N/mQJ
         wf+g==
X-Gm-Message-State: AOAM533q6Rj8JMSreFwd/OkOPKZdR8xkIXTtTBpkPCrjZqHTZRobUabb
        7MCHcMM2+mUPrCeWZe65D6UQ8BsyKst7C/mEwSvcWw==
X-Google-Smtp-Source: ABdhPJxo6xmNJWXyaaVPBEUy4anrM6xGk5zJ5S54bOFTPTbJYWg88+GG8ODe3guk693xmG8x/Zkzy+Ul3gB1uuDCJIA=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6112849pgb.356.1637702228750;
 Tue, 23 Nov 2021 13:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-17-hch@lst.de>
In-Reply-To: <20211109083309.584081-17-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:16:58 -0800
Message-ID: <CAPcyv4jjvoT=aW+_Ks+8L60HG0ypesSi8A+a5F2JXu1dEWHVCw@mail.gmail.com>
Subject: Re: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The file relative offset must have the same alignment as the storage
> offset, so use that and get rid of the call to iomap_sector.

Agree.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
