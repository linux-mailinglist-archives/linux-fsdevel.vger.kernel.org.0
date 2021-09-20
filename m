Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E281412B81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 04:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbhIUCTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhIUBq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:46:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97AAC0613BA;
        Mon, 20 Sep 2021 14:23:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v5so65315658edc.2;
        Mon, 20 Sep 2021 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3jJn/Tl6ib6kn61j+6hy2vKI8Q4Xoscp7/NxeTF+GE=;
        b=aAG3f+E3kiBw7BL8MPLoKamnR5Dis0MyF3EGZDUA55rrJXX5EoWsZa195ABUghueCb
         71CQ5mJ6qXc934jwEVRDCUJVmUMeLuHvTKNsGpTOkGoKyt+LxUjedOJ7mdngdwLT2QaV
         OSddfmsNndIvAPfPMSNhRiffyFHLdYRKNcaqcFpdiSRY0vWJ8IfFG5hiFz529fqINa6m
         hYHICZKEwdPMp47fVnqQuYSEOyr0tMoApNsY86I+el7KFpA/7/1nAacKsiNSscEs2xMX
         D2hfA3edgheNGdBuMTZ7bjHgFpCJhp5eBkoIxAgOe03SpCqEF1wyWD7TrUUx8Ieu1BwZ
         OGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3jJn/Tl6ib6kn61j+6hy2vKI8Q4Xoscp7/NxeTF+GE=;
        b=NNAYYHsqJiLfvOI1Q5N4FgUGBVRCqZRZpyrXzE3veh+1QAFCffkpB3+iqvP6AMiBfz
         i9xRLjkVMIclsVmXIV4bh4d7RmTYd7Da3al7pWV5YLcBg9M1Olh2/TJeDIo+1mAwam9p
         QgXaQ6NIN7shhFuxvd3puAgACdm+P2qC681k/NETQFjOiDLIZ0dNc+yzQSkR7Ns0LbmW
         GsE4PnD7H0HLlYeHrkw6ekWgztm6ZgRMuh1064UCyZi1CoBPwSM7tIRlKthATOirDCRF
         rBSLAdo+xd3RtRNr2BW4HOKysjqhXph1zSEnAkG71hnoDOaw2pIhOBWMCRd9qXIWJVGG
         OtJw==
X-Gm-Message-State: AOAM533em34HMnz5pr3njGmQsXEr3/lkp+1u4OUWbweDwDu14AzThL/R
        XdMi9u2Qfbhz2njT3A8BzMl9ApDpuJv3ILODUMo=
X-Google-Smtp-Source: ABdhPJwacLHpwsVUe7dIFhlLnB/9jckDDoV4UJ05h/K8GDUSmKKNgLqWG93R9ecwGn636303ugmv+quxiOKPzejhSo4=
X-Received: by 2002:a50:e044:: with SMTP id g4mr464867edl.46.1632173033180;
 Mon, 20 Sep 2021 14:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com> <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org>
In-Reply-To: <YUdL3lFLFHzC80Wt@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 20 Sep 2021 14:23:41 -0700
Message-ID: <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        song@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 19, 2021 at 7:41 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > > The debugging showed the page passed to invalidatepage is a huge page
> > > and the length is the size of huge page instead of single page due to
> > > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > > the size is greater than single page.
>
> Things have already gone wrong before we get to this point.  See
> do_dentry_open().  You aren't supposed to be able to get a writable file
> descriptor on a file which has had huge pages added to the page cache
> without the filesystem's knowledge.  That's the problem that needs to
> be fixed.

I don't quite understand your point here. Do you mean do_dentry_open()
should fail for such cases instead of truncating the page cache?
