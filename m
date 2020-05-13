Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E058E1D0C71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEMJjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 05:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgEMJjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 05:39:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A5C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 02:39:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs4so7421055edb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n37Br68mT3eu7bt7O2ori7dTgHwPTR+OlLQZux388k=;
        b=kZwzRgOVSQWkZ6cKU5Hp+/CoTc4SrRaCmdeB1VmystM7ZjNS9JynkDBfxHfX3j5HTs
         k2EIsIbbu4slPHjLlLAQLp9VZmHdqfus9YuLcG65X9OxgGoqYz6C6xwQzzdMaIsUfako
         mR0G9mWsvU9MJeaqmYJHG3T7cj0GnQgTpj6K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n37Br68mT3eu7bt7O2ori7dTgHwPTR+OlLQZux388k=;
        b=P+9zp15u2M8mEo7398j5jRjSnJ50LHMPJXMqq6gbPATVlmp983swE7E32GTkHRulNR
         b4jB2OxTKsCftas6veKjnDITczGAozNILpgCAUmGN7E9BP6to1DRulmr3IPdffGszX+D
         IZn589OGO1iRqlJio0Oue6IJS5TWNQV/DEFXTyc5Y1V1xm/GXvze66/gbUEUtcnxHZJm
         vEQ8ceccB24tS4jhm/6lUcoYCbizzhTuxytUKgLIn3dw8tzvlG9eRChC1pZ9xf+Ul5qL
         1M14Dyp3HsDv9tok9H5tsi8cJFS9KCffdbCxYOVs0iJoGDeCDeVR65v6B16TdG0ZIaj/
         c00A==
X-Gm-Message-State: AGi0PuaCFlWLt1Q4KUN0TzjCAXWrnUdD1Ym9cOcHqm9xMAK7eD/JuCUp
        6Zq5VQRDW0emGIrkxYGzbtQZJaGfW1sGVJGoUDbHsQ==
X-Google-Smtp-Source: APiQypJ/AAVzDk7nv2dSrO12rbDpJCozar/xmxKZiK/g1OQEUMeePYASPm8fXMtPAIpeQxRWsOSHx6T1rerhC0I0T28=
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr16670857edb.134.1589362785444;
 Wed, 13 May 2020 02:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com> <20200512022904.75689-1-eguan@linux.alibaba.com>
In-Reply-To: <20200512022904.75689-1-eguan@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 May 2020 11:39:34 +0200
Message-ID: <CAJfpegsVN-DuruF8E-hq2dxhsEciPOA+pBUdZSu6VHb3VAiTRw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: invalidate inode attr in writeback cache mode
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 4:29 AM Eryu Guan <eguan@linux.alibaba.com> wrote:
>
> Under writeback mode, inode->i_blocks is not updated, making utils du
> read st.blocks as 0.
>
> For example, when using virtiofs (cache=always & nondax mode) with
> writeback_cache enabled, writing a new file and check its disk usage
> with du, du reports 0 usage.
>
>   # uname -r
>   5.6.0-rc6+
>   # mount -t virtiofs virtiofs /mnt/virtiofs
>   # rm -f /mnt/virtiofs/testfile
>
>   # create new file and do extend write
>   # xfs_io -fc "pwrite 0 4k" /mnt/virtiofs/testfile
>   wrote 4096/4096 bytes at offset 0
>   4 KiB, 1 ops; 0.0001 sec (28.103 MiB/sec and 7194.2446 ops/sec)
>   # du -k /mnt/virtiofs/testfile
>   0               <==== disk usage is 0
>   # stat -c %s,%b /mnt/virtiofs/testfile
>   4096,0          <==== i_size is correct, but st_blocks is 0
>
> Fix it by invalidating attr in fuse_flush(), so we get up-to-date attr
> from server on next getattr.

Thanks, applied.

I started thinking: why is fuse_flush() only writing out dirty pages
if fc->no_flush is false?   It just doesn't make sense...  But that's
an independent bug, and I'll do a separate patch for that.

Thanks,
Miklos
