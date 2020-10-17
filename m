Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0182914B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439499AbgJQV0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439424AbgJQV0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:26:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5DFC061755
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2020 14:26:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id de3so2659719qvb.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2020 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgqP4vHnc4YDiTlhc+DyGim3+aRVm74aNzyLcpYY0fw=;
        b=PZmuaj6kYiBeitep5A8CWeHOTvYXeyFJAyRaHVdMV6bMV1LzBS3KK2jii9zU5COWH+
         8cwF7adReOhXYx0Bxl9H4v0itgBHLPXt4q7reYVavQs4IRM9nOX9723LdDHJzev+TmOP
         vN+0YJaSNCoCUksvcqkDQ42wt43VAScBFy17g/L4BP0s0/GMT4FOCWtDgUExuFOk+XHX
         cgA0MFCyn+MRxd+KsBNe0yf+Jy5kR/dfqIjq4kpIM77W9+rduK7cJlkoSJwaCKZOBijH
         au4D6VH8qgWzTdrA3xdrEsl+WmUJgqn8XTNYFvGQFiffDbOf+/RnjvLTLcJUmfQ3Nerh
         8rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgqP4vHnc4YDiTlhc+DyGim3+aRVm74aNzyLcpYY0fw=;
        b=hP87bAF8T+xv9Uhd2o1yJMTZjbxtoz2bJI77tD/LDh/KHuFgIMKeqWqlsH1bIV7Dsz
         Ic8fQnfW3bVa051A7JwHtLOJ85+cF8iDy61ynGZ1TaAGLBlrQ9Hu0jn7EQH3rQ0o3cBH
         UQbIxvV15wcCa1LZKsUclILctAXQYY1cHh/WrShdWspiLlIJ0PI8HQMjFLUuki+WnAQ1
         axDuNii0DQdyPeBue6ZE85nYAmhoIeXjBizKFosnGePVFjdjgkd5xmNrDB8PrQG2Wk58
         gbHH3fBHeki2tEO5C+yWuEQaquMgvaqsICg8caoQXh7+6yzGi9g8nRLe2YbG4268pbv7
         0Djw==
X-Gm-Message-State: AOAM533OoU7uHEdJX79QDd9UBeMvujQ2EDWIL+2FlBTs3rhQBCavAyBL
        zrfg8bQ5grU628VChbNRJaUnxxpNSF8mdQCwXlJ8tI6/
X-Google-Smtp-Source: ABdhPJzHMIlaE7BBQEDZ0mFISjyYxthNy4f6eo3fsalZEZoMEKWY+bdZrehWAQ36IvGeOLV3Ot51vto2zJ2e6FBQFyM=
X-Received: by 2002:a0c:8064:: with SMTP id 91mr10454087qva.34.1602970011343;
 Sat, 17 Oct 2020 14:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200805024935.12331-1-rdunlap@infradead.org> <62f3156d-a720-437e-d859-3b1c203a0653@infradead.org>
In-Reply-To: <62f3156d-a720-437e-d859-3b1c203a0653@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 17 Oct 2020 23:26:40 +0200
Message-ID: <CAFLxGvzwka1SBSXiEeDXP+awab+4e4heOczsRPh713scCvQwyQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: delete duplicated words + other fixes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 7:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> ping.
>
> On 8/4/20 7:49 PM, Randy Dunlap wrote:
> > Delete repeated words in fs/ubifs/.
> > {negative, is, of, and, one, it}
> > where "it it" was changed to "if it".

Applied to 5.11 queue. Thanks for fixing!

-- 
Thanks,
//richard
