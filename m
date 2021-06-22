Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC323B084D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFVPMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhFVPMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:12:34 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F4C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:10:16 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id j8so11437914vsd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6jYECB1uY4kERwbwvQK62eKjskNIcvHqO/SelbLP+4=;
        b=pAN82221DIsUtrhb0p19lThHLu2emVpyjnLMrwRYEYMDXMZmJmomO2VGncVefPqeLk
         PnDv1mRg1xC4M0pPQpPSCfRUjwORrNe8KO6RCkK4uVhwO535jnc00YuKndimXSYZwRrL
         1qYgII3/HAmV7OjzDGHqcVLo+eR9flvdOJ94w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6jYECB1uY4kERwbwvQK62eKjskNIcvHqO/SelbLP+4=;
        b=qN147L1Lh7zlx9P5ul9Fr2gS/ZJ6HPVtQF9P71s6NWsxY/CDPLNWgEteuKBSDruRLO
         ATawitbmNz5Fk57WnTCHqbSM53Iin3k60mUMASmgbfWUajzIBBEiSBIrz2Prfw45euPN
         3yR1AeOWXzzWyIHJl4A6fXTNCZwzqIXc8nu80Qosrie9O8oKFFwg5lqQKBV2XwRYGuNb
         sNQpAG0gXiEB9CcAuI1rKrJDAD5hLJPvlL8JGzyOUuH/xaMuPmOEQtQhmAbsfYaGDKd5
         1Ym/cUWcCQ57o7ldkHnrTtSTX4kXopV6f6ZqvnBI/XaMQrhVoeZg1g/goMOD0mLxxsCl
         m/8g==
X-Gm-Message-State: AOAM531jHhDA8swi48wmBL7slqOmKZiOpPGeoN1z8jX5fMusztv3v0Qn
        iKcjdPtoag3+/8aV3xabGV4esPwJTJJYp0WSJtKX1Q==
X-Google-Smtp-Source: ABdhPJzX7TH0X2nUVdZbCqZU8+z232mRwthdahvJ7HHQQYRERYGZF4uBl6yHl06y7O/o8Q4PJiqE+3iLP0fzGCmWnEM=
X-Received: by 2002:a67:bb14:: with SMTP id m20mr23694461vsn.0.1624374616050;
 Tue, 22 Jun 2021 08:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com> <d73a5789-d233-940a-dc19-558b890f9b21@amd.com>
In-Reply-To: <d73a5789-d233-940a-dc19-558b890f9b21@amd.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Jun 2021 17:10:05 +0200
Message-ID: <CAJfpegvTa9wnvCBP-vHumnDQ6f3XWb5vD6Fnpjbrj1V5N8QRig@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix mmap denywrite
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Jun 2021 at 14:43, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 22.06.21 um 14:30 schrieb Miklos Szeredi:
> > Overlayfs did not honor positive i_writecount on realfile for VM_DENYWR=
ITE
> > mappings.  Similarly negative i_mmap_writable counts were ignored for
> > VM_SHARED mappings.
> >
> > Fix by making vma_set_file() switch the temporary counts obtained and
> > released by mmap_region().
>
> Mhm, I don't fully understand the background but that looks like
> something specific to overlayfs to me.
>
> So why are you changing the common helper?

Need to hold the temporary counts until the final ones are obtained in
vma_link(), which is out of overlayfs' scope.

Thanks,
Miklos
