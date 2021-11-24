Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4420245B2E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbhKXDzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbhKXDzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:55:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE9C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:52:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b11so730956pld.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
        b=lAK1cPsbcZgDOnzv+wRyX5hFeuNtWn74alyzSOfh2WTiCK6b1Gd9bfDzl0+LSFYqBx
         NFA78tBSHfT8IWLc76OROAypo1vlQiiVSp+deqPBmSErFfOP18cWXFbnZCxI9VIMHHuR
         rkB6XFn/xh99StS9siD+gMovD+TGGHheUMxQDm6Fs4TRxLl6LVPgdXFahdYzrs2kgHk1
         2vtAqiLmzKNsso+noEF/MbJXbTSUoUVvNEOcLZD7XraD8UxaJOkOnpqbEwEn6rei4bjJ
         t5MvTN9s/WuPOzLWfQKYxVJtbNdZgfs/23Dfq3WeRbXM/0WgTMF9HeylQ/9xSVmw3Fc5
         g5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
        b=sbIVqL1n3VkkrHV3PQDODl945tW4kzpJEAyX/FG7USrYQf+C/ofjqtAamsWi8C20A0
         cD/kZZkelMFf9XonXUi7qyRpH4N/NfUNmavAJ0s6KcGCRUa4ik9B4mOGISkFEomMTmlu
         A6Ki6MnQct7WrLYF+boLuK/UwhnZU9nJsh1csHNyNtcFVk/M8LygMYUhDKx9QmCtZ1wp
         OSV3+auuszcARc8TGL08W76+JEzYNMc0TIvbZjgLFRvs8r+FnqrtAFUVsPM+qjPbv9LU
         7sOavNYaCN12kePloyBcbtZfXzl+7rVnImdqYryzyS0/GlkTNm6HnsJSK++Mlous48Jo
         qwJg==
X-Gm-Message-State: AOAM531A7YH084CZZuvn4694YovY/Xt0X3crHXewbRTASXalb5TpZiSh
        GWGzI8+978S5mwuWm6VMMdysWvXriMaMNYUMD0Fxxw==
X-Google-Smtp-Source: ABdhPJymXNtj/xuoHYk/qKEwmz57TlRY6ykmrutCD2G8CDlG536bSV07F4JpqasRcpvkUcp5iE8OReW1Fq5UwnxXf/0=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr10703847pjb.8.1637725942362;
 Tue, 23 Nov 2021 19:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-30-hch@lst.de>
In-Reply-To: <20211109083309.584081-30-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:52:11 -0800
Message-ID: <CAPcyv4gNH1ex_6+pHmpv_pWGV8H8KomzWFtfMvtntNe++x8OBA@mail.gmail.com>
Subject: Re: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
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
> The file system DAX code now does not require the block code.  So allow
> building a kernel with fuse DAX but not block layer.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
