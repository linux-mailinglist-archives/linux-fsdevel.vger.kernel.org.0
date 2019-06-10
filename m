Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D313BCC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfFJTYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:24:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53833 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388841AbfFJTYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:24:00 -0400
Received: by mail-it1-f196.google.com with SMTP id m187so915850ite.3;
        Mon, 10 Jun 2019 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9d9TchCmXOpazV5fGw/e5BwqVle7tBPHcq2VVRFHpjU=;
        b=kDv8DeKe18uzB/O3oige0/Tw1MRnkELqC/XXKTW98ZW/X4CEVRWZHqK7G8MWMSeibJ
         lVn21HnpNcyykNxfiMx5kNuNWUIUQTpmVg04RjLh9J8u5hRJp7JBvpsg5u23fPQ0QV+F
         ByEpcOixlXjWtQUWqquiRMNWPhQzt/aP/ccxHCzYiJyP6vYq/28LrXk128pUGX1OjXN/
         5r1Wfg57Pu/q+rgCTsfz39EUhhxK01GIu8L95r4B6RRl3R4gxlHc8DfntkK1HdWNvrx6
         QFxgqa+n0BwGOzerqzTLnGAXy9m3tUVyORZP9Xw9FCIMiKCfN+00JB/UqCKTJ8dYywQL
         Uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9d9TchCmXOpazV5fGw/e5BwqVle7tBPHcq2VVRFHpjU=;
        b=tw58biFs4gAfpEXVC3CWmDG7T9NFruUgjcMJ+ut2UclJbF6wj6H2CFIj9ISomTmg23
         tIbdrRouXgh8iHbBAypMxAFTTFRlwVikFrVlGgRsI1DGE7DC0h8phFEI4Wkif4ojjgjm
         HOxCP2BDNcT7ZZ+iEy5MSTO4V/W9cBkzxJaW6fKcWFtK2KgI/hBupq1bTsxJSmBEJWlU
         8fFwLGejy0H+LmonJKtiU1fdfBJXA3PR2k+Oi96nXR19MxRt3bDXLM4AAw2Z6MWCtqBw
         MOJFgtyD6PDhJWGuKsh7eBVQFhMA7i+R1m9APdG5nuR7XYoAF9bv+3EYPJ9Jcq31AeDv
         mJXw==
X-Gm-Message-State: APjAAAWW4+fRAi0Pfv+G/PTNBL1ogaYIFpaNq8hE+/udUxabBvZjGi7j
        uvtELIjHSlHiquj2d28hI7zk3+TUuQvQiPawrfw=
X-Google-Smtp-Source: APXvYqwjdtih55E8Hk2+rPXz2u8fESUhUXHzWKyv6dJ+dhUCVzUIFKDOb3//P6w+quG6CIgGD60Wjmf8e7MXD4mgzQE=
X-Received: by 2002:a24:b309:: with SMTP id e9mr878614itf.104.1560194639625;
 Mon, 10 Jun 2019 12:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190610174007.4818-1-amir73il@gmail.com>
In-Reply-To: <20190610174007.4818-1-amir73il@gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 10 Jun 2019 21:24:07 +0200
Message-ID: <CAOi1vP-ad+62U4hBkSetFq+8kxC2fhmCLzcHZ+=wYBqgTyyy7g@mail.gmail.com>
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and
 update timestamps
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        xfs <linux-xfs@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Because ceph doesn't hold destination inode lock throughout the copy,
> strip setuid bits before and after copy.
>
> The destination inode mtime is updated before and after the copy and the
> source inode atime is updated after the copy, similar to the filesystem
> ->read_iter() implementation.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Ilya,
>
> Please consider applying this patch to ceph branch after merging
> Darrick's copy-file-range-fixes branch from:
>         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>
> The series (including this patch) was tested on ceph by
> Luis Henriques using new copy_range xfstests.
>
> AFAIK, only fallback from ceph to generic_copy_file_range()
> implementation was tested and not the actual ceph clustered
> copy_file_range.

Zheng, Jeff, please take a look.

Thanks,

                Ilya
