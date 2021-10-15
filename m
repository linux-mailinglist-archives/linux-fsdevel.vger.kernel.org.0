Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267342F46D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhJON4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhJON4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:56:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5EFC061570;
        Fri, 15 Oct 2021 06:54:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x192so7077028lff.12;
        Fri, 15 Oct 2021 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffV9EXIvpsxi/zzat9M/mXqT6D2BowDOkY1JbwoxMOs=;
        b=dywwSbIGuXR+dXQSROUIhljg5+mHDSiHww9Tc5QE/0KVc6D96c2ocK9S4czPbKsPtz
         ySNRWdT9ve7V2FStFVRj6GJtI3GsO5QLdZltms855+mPxWEcF0y64BVbP3jeqDvlTRSC
         Q0SLO0cmgDLKr6f+MZ/VrWRqoygoePpVOM+o8yB+jCv00rDqDRMVdNenYkm3jQj9uL4k
         E4/MHhOextdkY9W69AUB008H67vZy/HWT7fbCa67+7KfpngwPIaSC4I9QxVoGvAnEL8B
         uHW/dfm/FieH/pIjg0HJFLHL4EoFbkdCY9X4ZyWcCPHq1gpKkT+6jn/WXPUZSeEosezu
         YVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffV9EXIvpsxi/zzat9M/mXqT6D2BowDOkY1JbwoxMOs=;
        b=cH13lef4KqU9SDKZFEgeZi63z4fNMgbh5vStQwK4sZYwt0zGaNyd+xgIjvffLYa86i
         0Z/k0kv7omqk/BZ5i5GsZQiZOw79OZNhkA8ltj4yiN3aq3RrcveSx1ivkoWhCoZgkV4m
         Pi7FtDAyzGTEBme4PgcxdR0R2Mz0hL3pc073bRbhoPyUNgHgXbCpSUkcIqWcbERnkqD8
         bItN3JaA14OBbtBkaOYdmk6TQywIobJqsMgBhqpbPs66ymRLAgvwgIXpVjaSD/XzacYh
         5QW1ZaUrTjXLLYMpbjkf2kkeQ0vdWw9YZZo5BvbXAy0U+JnwsIIECmYCRRjionPTRKFT
         CzAg==
X-Gm-Message-State: AOAM533ogEPwZoV8A2ysBtXBGXpegByQ9sSK/rZ8VQR9JBlVxuXqpLAg
        KPD0eb2Fp6/qamKsbE8v+GdYPvRjmVMlLPkcI80=
X-Google-Smtp-Source: ABdhPJzz49VguPSiC+Fo0EQ3C2KxuaRWGiHMMcfCON0rRU6wG0keaxKFCd23chpDIT1aQ64ecAbOb/mh29DzHZBz3N0=
X-Received: by 2002:a2e:a170:: with SMTP id u16mr12947954ljl.108.1634306084449;
 Fri, 15 Oct 2021 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211015132643.1621913-1-hch@lst.de> <20211015132643.1621913-20-hch@lst.de>
In-Reply-To: <20211015132643.1621913-20-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 15 Oct 2021 22:54:32 +0900
Message-ID: <CAKFNMokH0ZU-zxMe3Wm87hZwVgXPv3nRYBx2gXU98GekaeDFRw@mail.gmail.com>
Subject: Re: [PATCH 19/30] nilfs2: use bdev_nr_bytes instead of open coding it
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the proper helper to read the block device size.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
