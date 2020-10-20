Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049B7294114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395141AbgJTRIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389936AbgJTRIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:08:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE877C0613CE;
        Tue, 20 Oct 2020 10:08:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d24so3029072lfa.8;
        Tue, 20 Oct 2020 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5KBFJ16+yiu/KCls0reGAouhQdS/mqbPKY0iYtitxw=;
        b=uldXtsgwR5acYsbuvz3WREl3ulSvzxPxjHH6WG+nVg6d3SmJv9CcgV/30TxwMmiYcC
         nFUi6qpt5CQ+6wOty/fKqHsARbcTZvxyAsn2blczoQmmCW5kSrdtNvyQSJUSGKiss5Co
         JGkLzzk7lCfeClIlIx8pB30OSTLWUmd62WDwfbBt+ELdQ9iJUvcr5Yo5QP7C4EBCax+z
         zpFTC85qeolepCVHADfvwEhXKWwmYmkptEEC2oVsz1ym7bJjqTzn8MzfEs2BkckEd7CE
         0RP3De+lwUvl+igFvmgc506inqLiQw0y3gxIsmaj4cPrufWQBjA8/3N5LI6Kk+EQZeFv
         mEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5KBFJ16+yiu/KCls0reGAouhQdS/mqbPKY0iYtitxw=;
        b=mYmEhY9/n+nFHt6XHxxQxSIL0uteDcVNF6z+NqgX796KB2LEwfW2puRJhNc9Mivy2t
         8eDQ+vqwkz1JzDbcK99722I/8XaYJ7thYnJGusDXkFwbq8opdN/ivwrwiZOUHynLrxx0
         J2/6MB0WNmsGbLPuAxaiRV/kJqN4t6I9f9ec5/5f1HWPUoH+wRTZN8DUeIrmIk3dOlb6
         0L3ePtzuE8k/9bzKRifR/VBA67seHbURlJILL72AB5mOAL8sktfvj+lx6uxxo2OlRiwd
         hykONOb+gLWqmbKF/zzz/tRZOWI5JT6Gf1SdaP1+P7klbBb1qPLjae0XgKR2ej8LcZQ7
         q9Mw==
X-Gm-Message-State: AOAM530b/BjBvpdvKZfQ5FPtQPyggVUqUWVnokzZo0BiIp2FuRds6CAl
        yodbOM2lJLS5Ma2tmSbHEs42P/YDPw9KG/IJ+ElpZK4z61g+HA==
X-Google-Smtp-Source: ABdhPJxVr/P8EhydPvYWLxqL+p8JaCUz3aZ3OXjUj5UaQCT6y2Dp6WTv21jNaHDgINEW63FUj8iThaB5zips6imOq6s=
X-Received: by 2002:a19:c112:: with SMTP id r18mr1288210lff.208.1603213727192;
 Tue, 20 Oct 2020 10:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201019185911.2909471-1-kent.overstreet@gmail.com> <20201020075813.GA18793@infradead.org>
In-Reply-To: <20201020075813.GA18793@infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 20 Oct 2020 12:08:36 -0500
Message-ID: <CAH2r5msRkzeCQTQTvP9uNSgobVO86S+O76fw=7-kkihXFF+-2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: convert to add_to_page_cache()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other than the unnecessary split line which Christoph pointed out, looks fine.

You can add my Reviewed--by: Steve French <stfrench@microsoft.com>

On Tue, Oct 20, 2020 at 5:10 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     rc = add_to_page_cache(page, mapping,
> > +                            page->index, gfp);
>
> This trivially fits onto a single line.



-- 
Thanks,

Steve
