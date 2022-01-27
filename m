Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E909649ED91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 22:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiA0ViV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 16:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbiA0ViU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:38:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB875C061753;
        Thu, 27 Jan 2022 13:38:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id y15so7872257lfa.9;
        Thu, 27 Jan 2022 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+U+izVFukrEKq10kL5qCCsiT3qJmeLAo+mnNrOVCPU=;
        b=DwtRea8LCCOg/PGJHjd1bTltmn0bHa2clILkAwGYtZppoAY25qIBMTxyD6B5uMLit6
         7wk+d+sZiWX35l8wQaAoyrJ9H5CizW30SYci3NU1ojzD14qB67btK2MGpyfbQ3U8Fswu
         zxqpCDGkYCIAg/NDZ5r6/eIuacbMkuvBlqu9ammCZDYbuScyx0/VXZFI/czsoS4aCdCY
         RzPo3aqhubsJoGDCZLj5SmdkiGyLla36RWFVNiU5MVGZ7MrbcY5xEOS4+eUv/n2M8qYN
         MVuY5Y428ZMyJxOjYYJ1BtbtHPjLQ+HBbJ/bfmBPwl0UHF3vKl1N9F7XDbteSxFshMZ6
         OfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+U+izVFukrEKq10kL5qCCsiT3qJmeLAo+mnNrOVCPU=;
        b=Nz0EAoWz0IU/5WY3XHQMld9RLIE6u7H0aYgobmmD8kamzGg4mtcs2vPs82+vygFZBt
         wetvkYu+4j9dTaJ+VCqIfs5TCKyUN4YPJhhpFIH4rkOsDCTQh7BDs7XqOYs50TyyyVFm
         nC+2yi1kUgxt+ZfZV/8/FqNnFNnAsHoHevE+n702XoJS7fGe0IrVPUkPN0lus3Q4qxdr
         PX3/2VPJswkQk2VdBHhf6k+P/rPrT1KL0RlchBhA90Jz7wCUp0RRHY8kkO+0NBL5zldr
         lkh6ZRtsqBJuYMN5eJHnWQKpXysNyQ7MNgZ8/GjmNUq2NRaHwAYPlQKy5K58rmQ7BpyR
         A2LQ==
X-Gm-Message-State: AOAM531sNM8rAlW1WGBQD6c5OKhWmvFn7lvHDDkZeQpPog30lN0stT46
        OZ2Sn9M3UNT1e1PT386yBetUxlKU3IzyQDGjJf4=
X-Google-Smtp-Source: ABdhPJxaVoQ4SfBVmSOjFCGrgluhZGplrFWaRNqk5pMVob8JHRQWRWEKNtxwMeMPmpBWjy5SR70YaIdo0zrC/X/8wRA=
X-Received: by 2002:ac2:58f7:: with SMTP id v23mr4043478lfo.390.1643319497799;
 Thu, 27 Jan 2022 13:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de> <20220124091107.642561-3-hch@lst.de>
In-Reply-To: <20220124091107.642561-3-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 28 Jan 2022 06:38:05 +0900
Message-ID: <CAKFNMomoLqbbOwg5d6aBHCyGT5v+NF=N2Rm3QwYk8NDXsoJHtA@mail.gmail.com>
Subject: Re: [PATCH 02/19] nilfs2: remove nilfs_alloc_seg_bio
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 6:11 PM Christoph Hellwig <hch@lst.de> wrote:
>
> bio_alloc will never fail when it can sleep.  Remove the now simple
> nilfs_alloc_seg_bio helper and open code it in the only caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nilfs2/segbuf.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks!

Ryusuke Konishi
