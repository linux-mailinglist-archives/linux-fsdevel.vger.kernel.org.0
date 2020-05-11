Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9122B1CDAC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEKNGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:06:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F2C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 06:06:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id se13so1155334ejb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6rfSAq7VRiDOfN0G3BRn36tCGRPl0zkuCoZTRKLtCw=;
        b=ksZIGkW+yvvjbtaY2nNzmZwckBW1OR2ggJMaLYqFwgO5Iu+2GnXjxZzPNnrp3/IIke
         b7bHFtuIZmo6tmJXpcd5zp9vAqEnXB8ttdPhFUYu3lLj++m66sXLAKcO/urN46d+U5Uc
         k4gUgv8mKouRPRTiLfhwp/ZrB0tt3VukPk4do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6rfSAq7VRiDOfN0G3BRn36tCGRPl0zkuCoZTRKLtCw=;
        b=TLUS67mQl+FaALms7PvkM0044Lr4EQCBwQtBkfN/7Le2rrOT8WTGmY+OfOflYtmUZs
         Oc6aLDf6j5z2v+GSpFMa3ikkAB7f80twIgcTBL/jMWogXz80hAdERTwBvZyEIhgjMQxp
         rjGw0nDkMm8d9FPt+7nBxR1faOIcPJlM2Gki9zeMsZGaUB+4yMfTy/9uU347gEQt9u3v
         +EcntXtq6Ya5Ond8KJQ127+Tpo8xtIn2ownFI51QD+7c9iBbD4ZXzb0Nh1X+yHvMoZbF
         Mi+0KexgI+jPvOHs93mRh/gHBMYdZauJa7opFvDB5Uftyl0BfkOHZvzkfTEz9TT0PNMx
         275Q==
X-Gm-Message-State: AGi0PuYOfmrZyM3U9b9QDjS7aFNmWD/59ci692fFQ61OiNxDhvmI2y5w
        EGkUj64cttrf54aXc/dz/tMvBMpNrPySeDd5xa9fGCZBzXE=
X-Google-Smtp-Source: APiQypKugPfDJjEcYS+t5lrC9KAOo/Vh8NGq2JR6GWop8sjqsUcu4R10ctAD2NHWLfFk8QL34+2dCp0KbR8FWowmTw8=
X-Received: by 2002:a17:906:340a:: with SMTP id c10mr13601482ejb.218.1589202379428;
 Mon, 11 May 2020 06:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
In-Reply-To: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 May 2020 15:06:08 +0200
Message-ID: <CAJfpegsivYq68FjSxAGnszcPJBrJrYG5Gojsc8T+PKup0Cm8fw@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: invalidate inode attr in writeback cache mode
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 6, 2020 at 5:21 PM Eryu Guan <eguan@linux.alibaba.com> wrote:
>
> Under writeback mode, inode->i_blocks is not updated, making utils like
> du read st.blocks as 0.
>
> For example, when using virtiofs (cache=always & nondax mode) with
> writeback_cache enabled, writing a new file and check its disk usage
> with du, du reports 0 usage.

Hmm... invalidating the attribute might also yield the wrong result as
the server may not have received the WRITE request that modifies the
underlying file.

Invalidating attributes at the end of fuse_flush() definitely makes
sense, though.

If we wanted 100% correct behavior, we'd need to flush WRITE requests
before each GETATTR request.  That might be a performance bottleneck,
though.

So first I'd just try doing the invalidation from fuse_flush().

Thanks,
Miklos
