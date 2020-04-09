Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38631A3B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgDIUEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 16:04:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35802 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIUEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:04:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r26so61813wmh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDzglqZlZcxrIEiGaCL876u0tJXo/b3LCDiUPke6hM8=;
        b=kE2dlQbAMbxEph/+OiWhvyA2TElid9qcNZ9MipQGEbkPmNmME0oWP6Qeyy+4+m8DjY
         Bzl8br1FY05eY895V9BGKO0RGgmtQ0dU3lZjg6dn6zyPs/Dz9un44sS2qR1abZq1bF/4
         4/ZkOlf3VMtAy462g4DrAo/3LvWxmEcahtAa2/z6FIGV072KBOOgJIJk1pdX+i7z0jz/
         AY26jAQRRnv/7PNSWOc4z15UCesUJAC/VrvfCs/PiE5/g34utB0jXuEl9b65MXwXhkao
         dAYCHj+t4ZqNfz/hQrkiSRyHkyXz/NqmgKFSVgBk86gdEwOOP1hvEIinZxG+zCBOJkbH
         6EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDzglqZlZcxrIEiGaCL876u0tJXo/b3LCDiUPke6hM8=;
        b=UAIA/mPGB3lnLE8Xv8MOCNjutfs3jNgPh6amwNtKi4a4rCR8XavdnCy0DQ35SnQ3UZ
         P3Oy05e3+bbp2cTmjYz4SnvgDx+qlH2mv3AsD98m751uzuToFeOc0HaG8fQNAGCNpv16
         U9OERM69ssXgzw2BJRngabuBYBtZPJE4nQY6emeZvb2dmlpfPaXgtZnyNOWUQ/m4NXnK
         /hKv5PzoWXfX4+00t7EpYoQLzgv32uRQVoqoS/t9MN5j18xQZvKWqKlJG6ghX2kME1fV
         fzljx1lLwZJQAM6B/nzlvTz1XXOk7/DLk1ZzhGojF9gKOkjhUNpQQnk3s0/oeJRmz1pi
         hS+A==
X-Gm-Message-State: AGi0PuZM+8UQ87J7YMzbkIPHZITM9dpWCzeRnUXNJ1G1niYf8thNQN5s
        GnUN6t+NJY/jK2AJkvRI6sfW92e28KVOUVwWXa7DCQ==
X-Google-Smtp-Source: APiQypIcxF55PCob3T7OJxlGddq8VbpK2dOAPx9ekIsXVMhJIBfxd3KBkrxn+QUgv+BxWPQtP+u9KmtE4swbJT8Ouc4=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr1700238wmc.68.1586462652947;
 Thu, 09 Apr 2020 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409113305.1604965-1-hch@lst.de>
In-Reply-To: <20200409113305.1604965-1-hch@lst.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 9 Apr 2020 22:04:01 +0200
Message-ID: <CAFLxGvxXxR29R77nQKsYSpxviARk4AhWrzwfMPc1FECDLxh_sg@mail.gmail.com>
Subject: Re: [PATCH] ubifs: remove broken lazytime support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 1:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduced atime
> support to ubifs, it also added lazytime support.  As far as I can tell
> the lazytime support is terminally broken, as it causes
> mark_inode_dirty_sync to be called from __writeback_single_inode, which
> will then trigger the locking assert in ubifs_dirty_inode.  Just remove
> the broken lazytime support for now, it can be added back later,
> especially as some infrastructure changes should make that easier soon.
>
> Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for pointing this out.
Patch applied.

-- 
Thanks,
//richard
