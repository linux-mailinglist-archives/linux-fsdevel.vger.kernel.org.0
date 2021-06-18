Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964073AD2C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFRT0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFRT0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:26:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79427C061574;
        Fri, 18 Jun 2021 12:23:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h4so18351436lfu.8;
        Fri, 18 Jun 2021 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJYtupphDCmu77PX56LTsXy1IMzi9xJT77pPzOxDSDM=;
        b=gD/RYXfz0mNz+yTp5PQH4LevE+8wLfrU5oRILAKuCAoDO/hQSiDKJHv5x8zwElQo7F
         JgwX01vNqJnh16J9lbc5OoKT+t5p2jz79OplZzyUYdchofjx3Bn/vdPeV/oCA8XoHXdu
         FvI1v9mVHVTWEK0Dr9Yf/kguBOxkr39p1tHZHiieWHmfkScU9bxld09J/rR+fS2L7BnE
         /PyYCSsLX/6HHM7jmbTaRq1KP3fTX3VBZIgrR7Jaw/lTY+2ieMoYBuxd4gE4897152Qb
         hRutMZUOAEsqtadRDz4eox7i1v9/T2PirJKgiQZhoCsutOX04NcTZUBd2XObJlvdW5qn
         ptvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJYtupphDCmu77PX56LTsXy1IMzi9xJT77pPzOxDSDM=;
        b=MRtZHqFLd45TWmZm+0ybWv4g1VtX0P1jORK9d61fWr28lsA9b6p++yZ91ar1vzau1I
         rSjWMgPF8W6F56MkEUM10Q46J78Kg+JfpXGpCB77CqV4Wb9urr9mdxHhzcxm0YOKJjPB
         mpqIg2+nFrWd3bLjnrlkBg8qwuCjJyKxIPpJ8e8UCORgcKJv9/SNItbJSycvCuz4JeiU
         Higd46wctYZTPhctLFuQm2X316oSJwluv29T+uzoptlKWWoKZ1qqeCpw8ZQR62QzmTro
         9eZ7QpgqwJP44z2Y7YcHDMuCTpbBK2opoTaFSpeUmWFZwL1+kd5DciHSA+s9xmzzxpdG
         jSSQ==
X-Gm-Message-State: AOAM533WbBsmMeRqpLW7kB0Lcz0EhOwDvo1FsmUsG5epdpt9WdHYWy8Q
        QuXZ5twhn+GYJ/KFPlbzZDYi2pimE1o=
X-Google-Smtp-Source: ABdhPJzRYZYz40Q70v+ank0Gb84kB/qvhhZlP+8v/vkAzsLPVi9heDctBa2FGz/EnNkaOcb/grUlwg==
X-Received: by 2002:a05:6512:74f:: with SMTP id c15mr4276741lfs.506.1624044236195;
        Fri, 18 Jun 2021 12:23:56 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id f6sm1167188ljp.49.2021.06.18.12.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 12:23:55 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire up
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-4-hch@lst.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ddafcc0d-8636-46ca-44b7-54392e0d22b4@gmail.com>
Date:   Fri, 18 Jun 2021 22:23:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614061512.3966143-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

14.06.2021 09:15, Christoph Hellwig пишет:
> Remove the CONFIG_BLOCK default to __set_page_dirty_buffers and just
> wire that method up for the missing instances.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/adfs/inode.c     |  1 +
>  fs/affs/file.c      |  2 ++
>  fs/bfs/file.c       |  1 +
>  fs/block_dev.c      |  1 +
>  fs/exfat/inode.c    |  1 +
>  fs/ext2/inode.c     |  2 ++
>  fs/fat/inode.c      |  1 +
>  fs/gfs2/meta_io.c   |  2 ++
>  fs/hfs/inode.c      |  2 ++
>  fs/hfsplus/inode.c  |  2 ++
>  fs/hpfs/file.c      |  1 +
>  fs/jfs/inode.c      |  1 +
>  fs/minix/inode.c    |  1 +
>  fs/nilfs2/mdt.c     |  1 +
>  fs/ocfs2/aops.c     |  1 +
>  fs/omfs/file.c      |  1 +
>  fs/sysv/itree.c     |  1 +
>  fs/udf/file.c       |  1 +
>  fs/udf/inode.c      |  1 +
>  fs/ufs/inode.c      |  1 +
>  mm/page-writeback.c | 18 ++++--------------
>  21 files changed, 29 insertions(+), 14 deletions(-)

The ecryptfs is now crashing with NULL deference, please fix.
