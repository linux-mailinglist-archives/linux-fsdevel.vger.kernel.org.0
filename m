Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF924D7F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHUPFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:05:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA273C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:05:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w14so1196010eds.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFHd1R652j9IVdzjEHHv8CJFVu6cveWEKM1K8aqJjrQ=;
        b=haDU8LPcBr5xa7coersCLI6x4maLKVPLvitqPKOHCnpauOP1/pvLs2510Iwf64iV+d
         D+53HDw8XmunesV1pTwDVXIgCrdaYMnyO/HfzsTpcCMtw+Xa5D+8K9cL3wttaGffuJia
         4/C/t5tGfNpqjjoRqnQB2flfHY7xWltIH+JZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFHd1R652j9IVdzjEHHv8CJFVu6cveWEKM1K8aqJjrQ=;
        b=rZWrNipLH9ZwiTxtFb8rYf4q4hDgewiRkWubcrP1GHBhjDZioIiL++hSWMnL383RYe
         raTHSc8bYTcV/OGTWhyjq1LMKx3DfJq3IFG8Q7ie/XEU5CkItWPzBN0UjYVbGXi8Vqih
         33tubclHEYrEgMCNhR+m/rUTXSfEkGdxm3IgHM9jUlCXxhRNvaWG0SjODJO09Q1/DHb5
         tA5peud9B9PHKW688gNglIxkaVFWEYDzAAH5nXr1n0zYBHVzqyIOmicAvx97fM/CnhLa
         N4FjJEQ448GaGvxfMqXQqXiSJooHgjpAW6VxkP1hiCfU84LHo/Oisredw8DoJEDJgcmo
         4Uww==
X-Gm-Message-State: AOAM5333cAb8qSD+uhbQVqns1PwRrIMMnW/0je9okNHoRgvhp9c1R5QB
        xSBgbdyHQmEQ8ID06rmMhtGVBTQmD/jKuFfEfeeqNwPPhws8ISut
X-Google-Smtp-Source: ABdhPJzcr037VNbPOD+6hlghFKR1xaVqFxy5gzUmjYnygmJoe5HQAhd6z/LEYzkTlFf//1/HZWjWUOomMzEwW21dSEw=
X-Received: by 2002:a05:6402:1bc5:: with SMTP id ch5mr3141317edb.364.1598022327613;
 Fri, 21 Aug 2020 08:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183812.19573-1-vgoyal@redhat.com> <20200724183812.19573-5-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-5-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 17:05:16 +0200
Message-ID: <CAJfpegu0HKSbY53GBMWSYRYc7NJab+9NAXmfp9ekzU_QCiDCQg@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: For sending setattr in case of open(O_TRUNC)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> open(O_TRUNC) will not kill suid/sgid on server and fuse_open_in does not
> have information if caller has CAP_FSETID or not.
>
> So force sending setattr() which is called after open(O_TRUNC) so that
> server clears setuid/setgid.

I don't really like the fact that we lose atomicity if
handle_killpriv_v2 is enabled.

Let's just add a new flag to open as well.  If a filesystem doesn't
want to add the complexity of handling that it can still just disable
atomic_o_trunc.

Thanks,
Miklos
