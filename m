Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EEA52331A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiEKM2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiEKM2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 08:28:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76691FC7CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 05:28:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id be20so2289507edb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFb+oOKVfdSFM1Ynmw5DXLEBb4aXz2rTDwsxTr/WZTY=;
        b=NMCM6+TD98zvp/GBsWlY0VX5iKuGvLvXshRG/+mChWR+yPtiyUxxkqNbNdNQwQy9GP
         PN3IUiJhfvNF/g3HU9LTgvzYpKgbXg6bGECeapdUNYAeGRYouWfhaasrBhujsqaUi26v
         DkvNhaWJwMwbVG3NJnmWRoCCsPgXwQBw1SwCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFb+oOKVfdSFM1Ynmw5DXLEBb4aXz2rTDwsxTr/WZTY=;
        b=XY7XG0jwgzZBvzHOxYI0D0PZFBsptr1jtBYYDXf6gPOsJqBIyHH8njqOZWVpw99dQf
         //aL7OWKHJkt9bgRnlZcyuEWWDJNIDjp6goiuO8PubaAJmEM1UU/zmgNucWM0Hem6rK+
         EBjBedmXM/egZp8CD07OxSK8LhcXxQ4yWpkqFNfxKzTNa3Pp6tQB5XElySRKHUzIyB5T
         A71Lvv8sCjG5jhiY6vXimcAfelgtYz088jvYhzo9CtNZyyLvk1gtcYxlLXptz/gKCPKg
         UBAjyC4/DxegnsBwlT4LPCXZ+bw60cu/hZDbQ2Ws0jLS+FqNJRB0a854PMeuSq/AX0zA
         na+Q==
X-Gm-Message-State: AOAM533SBqv2gI2L8PUuLGSKYkK5cKPVXytQdPc1zL0/rRgzgFZiX2sa
        vefS0QB1LzfvdFmFvewiGlFp5CnngWId+dVCAXQgEJETI+AdOg==
X-Google-Smtp-Source: ABdhPJxWwXgnhSYbvRQaaYX1wNi+xzJf+PXffIjqvgi6cI+87AjF12g3Yk81vqxwbS8t9950B4c6Nykxk7whoJ/HDX0=
X-Received: by 2002:aa7:cb18:0:b0:428:af6e:a2a0 with SMTP id
 s24-20020aa7cb18000000b00428af6ea2a0mr10254026edt.154.1652272126351; Wed, 11
 May 2022 05:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
 <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com> <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
In-Reply-To: <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 14:28:34 +0200
Message-ID: <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 May 2022 at 13:19, Daniil Lunev <dlunev@chromium.org> wrote:
>
> > At a glance it's a gross hack.   I can think of more than one way in
> > which this could be achieved without adding a new field to struct
> > super_block.
> Can you advise what would be a better way to achieve that?

I think it would be easiest to remove the super block from the
type->fs_supers list.

Thanks,
Miklos
