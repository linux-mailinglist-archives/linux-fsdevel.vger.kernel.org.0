Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC97CAE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfGaRuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:50:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45618 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGaRuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:50:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so49928006qkj.12;
        Wed, 31 Jul 2019 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8H1qmZWnyPRY1VP8ewZtm5ftowSE/cfi+74EH6RJgIU=;
        b=lWngceu52u6EsMIytANCj8jbbUIjRuFtqtH35VoHpcMzbcUQhwb2HrkU+q0Py520fw
         +aoc6Hl03liHWCq4/TPU7obfd0ky5jqklVnQ3YKO+ysumg2xfTr8b8Qk9LsLrhTBxRVi
         Xq8qF+8r6xB25OpFWkep5ToA9kmXNHIAVYJOj5giCO6iXz6MByx0K0FOgqvc7gE7lbrA
         AmMw4sO+KQ0DeBBcCTqBVy9lyhNVkOsnPjxPMZ2NuQvJ9OBLdLtC+TqonTq7sVdG3oRE
         ZJ/f8/2V36jG2uGESFH3VcNUJokeiZsFa8ZWgzcG4KhmTWRAVHbsSDKYa2K+T//pDUO6
         isrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8H1qmZWnyPRY1VP8ewZtm5ftowSE/cfi+74EH6RJgIU=;
        b=RIDo2Wze0bu/tnpLTiLTOJtwof/SZvyc73vUasPBsRJEJY+Px19KAeP5/xQcOnIEdT
         QBVbK0zxfY7Zo4itc9Uy11IE3axCT9t5dzGsaEn+FzOYFEBHv7IWa2wQbtfyfrPmzPpN
         LUo8c+fNpESgKb9hPlQffK8297MNUdclnnWMfGesVJ+ejb6/ZioKKAVE3s0NONYbf17K
         th1LAZjzGKk8Fs/B8cp25AoAqe9S68dd35khEwI7ZeItAZkCJP5QbV7tK1yQ8A7Sqo/s
         yR0TBSV1o7foywqcKLfrFYJe5rjpyxrJelOGi0ZkBcLBaL2DhXRVKK+if9TQEctG7h8C
         LWJg==
X-Gm-Message-State: APjAAAWwwxc/DNGRsRO4nijmyuXHH+VOWCxv35GZkZr4/pdc4JfFguWD
        U/GJ5ur08/0xcPgCWN+V8wOvpHGE5FLRbyOM3Ps=
X-Google-Smtp-Source: APXvYqx1vdp6YaEEtVMI7ZbVbZcRwnEweHxRBRbt4MX2JVrJxeici/yUQ1j9FXzOgHJZd/Br9Zv7MLoRACzXLUpuwEc=
X-Received: by 2002:a37:a854:: with SMTP id r81mr82915593qke.378.1564595451187;
 Wed, 31 Jul 2019 10:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190731171734.21601-1-willy@infradead.org>
In-Reply-To: <20190731171734.21601-1-willy@infradead.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 10:50:40 -0700
Message-ID: <CAPhsuW66e=7g+rPhi3NU8jQRGqQEz0oQ5XJerg6ds=oxMz8U1g@mail.gmail.com>
Subject: Re: [RFC 0/2] iomap & xfs support for large pages
To:     Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Christoph sent me a patch a few months ago called "XFS THP wip".
> I've redone it based on current linus tree, plus the page_size() /
> compound_nr() / page_shift() patches currently found in -mm.  I fixed
> the logic bugs that I noticed in his patch and may have introduced some
> of my own.  I have only compile tested this code.

Would Bill's set work on XFS with this set?

Thanks,
Song

>
> Matthew Wilcox (Oracle) (2):
>   iomap: Support large pages
>   xfs: Support large pages
>
>  fs/iomap/buffered-io.c | 82 ++++++++++++++++++++++++++----------------
>  fs/xfs/xfs_aops.c      | 37 +++++++++----------
>  include/linux/iomap.h  |  2 +-
>  3 files changed, 72 insertions(+), 49 deletions(-)
>
> --
> 2.20.1
>
