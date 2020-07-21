Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01C22820A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgGUOXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUOXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C3C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 07:23:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so21789029eja.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAystsUrInZeIyvgRCsT3l9cU39g2GRQq1EYFX9E4bg=;
        b=S4+t+rbjdOqBhu/c2PKCReBBiCDKjC8SDuFsSpoO9iJO8s57ckBcaGRgGLeEi61rnU
         j2pMUWya4frGQvlqFU83oJtS5W0Cd1VtRd5RG5yEIYt2JCXDToWXlUn1b11n8OQAj+O+
         4VOQp70DZVK4Fl51pJOzSGaZcSB0BF+zojZFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAystsUrInZeIyvgRCsT3l9cU39g2GRQq1EYFX9E4bg=;
        b=l+xdhfcdkY/uAVcFXzDBGp79nYKHgZ7LXBAa+3MAD99wV+TDmBTE0tXf7ocEAUl/SR
         QD2ftCl3AeFAuyGgHUwZ9/lryTyeSeCRaxqQeJngZHexS+Q/FqLrTesxh6LaFy30QG6m
         iwuVfWKSZXYQIrDvO4qrxWF1t7n9Ctlicodwbn7FsUK0JvvXwqOY9oHcHG959Ln2BCbD
         yaHfxoccxiy9wVBgjv5A7TdNpz7JlRgD3k5V6YfRzZ8fEVPEpdXG0oZgj22QItBVe4Ca
         i2/tIZHAg+VUWSNcdsNe3ib6IY/GFYbzBy3KRWObOozvRfIKkuNPChbwRdC2LiyZ0qjH
         kXSw==
X-Gm-Message-State: AOAM5311KS7pv0rPCk7CnFgWzzWLBtaWFsTRK6Uci8LKP0XmSIHkPIYP
        BloEhwiB0vAbDwmv0Egl1pq4aIDp3AzhAF8V+Bs0eQ==
X-Google-Smtp-Source: ABdhPJwhsPVjJBJf0GIyY1/zAjKTlJqN3kQzLQs1De7Dus430CTOt/7DPy5NIT2mnlQBQ4rsIiw49/D5G/AYXha7NIc=
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr24508137ejc.511.1595341415652;
 Tue, 21 Jul 2020 07:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200713090921.312962-1-chirantan@chromium.org>
 <20200713095700.350234-1-chirantan@chromium.org> <20200713095700.350234-2-chirantan@chromium.org>
 <CAJFHJrqEU=k2dLkKAD-SsKwkVeQ3KPf5wveph9u86BxdbM7q8w@mail.gmail.com>
In-Reply-To: <CAJFHJrqEU=k2dLkKAD-SsKwkVeQ3KPf5wveph9u86BxdbM7q8w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Jul 2020 16:23:24 +0200
Message-ID: <CAJfpegsOgZfWAoe6x4vH+NoWbyEys2ruRYRRhJhhwwxS2brweQ@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] fuse: Call security hooks on new inodes
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:07 AM Chirantan Ekbote
<chirantan@chromium.org> wrote:
>
> On Mon, Jul 13, 2020 at 6:57 PM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > Add a new `init_security` field to `fuse_conn` that controls whether we
> > initialize security when a new inode is created.  Set this to true when
> > the `flags` field of the fuse_init_out struct contains
> > FUSE_SECURITY_CTX.
> >
> > When set to true, get the security context for a newly created inode via
> > `security_dentry_init_security` and append it to the create, mkdir,
> > mknod, and symlink requests.
> >
>
> Are there any other concerns with this patch? Or can I expect that it
> will get merged eventually?

Looks good to me.  Can you resend with the security/selinux folks in the CC?

Thanks,
Miklos
