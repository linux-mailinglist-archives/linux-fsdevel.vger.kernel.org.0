Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE32C493A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 21:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgKYUon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgKYUon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:44:43 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 12:44:30 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id r9so586945vkf.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul7l8NTuGyp3MPqaSRmckdYGCH2RD65M+GA28ibecYo=;
        b=bZp8t3mlmVlKUf+27Fr2mLeI6FfPLIu/o9LyNnM9kV27HgQX2QIk0++Eo1+hicCLMY
         qFS5UAN7drXTl/G5iUESSLM4fHF6JTHfeydKM52AHPFxbO++BHrXv8X61O7uaL0Lzf5q
         JvuUbfyl8EuDOd305QPGWj6rS0sNtxI1Oow90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul7l8NTuGyp3MPqaSRmckdYGCH2RD65M+GA28ibecYo=;
        b=INn+mUCrtqo124/4e8ziwWK39Iw9KfWwx8DrsT/dew/1QgPpQ+hlgTJvQaeW0LK1SP
         +Rt1VtFFFMjgpdkaXlpxC6LbijbjzkqSXpjSsyQNBDvBYT15PD2AapN3BTu6AKjqeouT
         ufjWoT3o9BcbVCPL1eI7zPMm16b0Kkl2Wf6Qxxj+4sSHOF+2iWaAqOQMp9tLr5dAe8C0
         L+sniyhayp6OX5PEQEb1L+PZp1r4SYsbi9zLV/5mT3C2pmF80nn88aqrxhpp6hdHIjHx
         3LEDSFdHFhefP+jG4E4uRw2e6sPU2vWb+mourb0MtIEXSetqkOKx/OecpZF5J8LWYhrN
         k2Ug==
X-Gm-Message-State: AOAM532rnRcihWLFmk6JB+biZHdZr/sUF964Q4UMbRCrlWbGWDlQLbby
        ZduM2ydHU28VsUKAyeESjuv3fE2gfY5ciSqWoOtNCw==
X-Google-Smtp-Source: ABdhPJyTsN2QPlJo3E7rh6Rj2Y9Fl1tgPcRvuT2xqkIEM5W16CZEJ4PykDdQOQJ6DbBdB9V7zbYpyHdFD+O7GIdeWnc=
X-Received: by 2002:a1f:e7c2:: with SMTP id e185mr3732205vkh.23.1606337069449;
 Wed, 25 Nov 2020 12:44:29 -0800 (PST)
MIME-Version: 1.0
References: <1927370.1606323014@warthog.procyon.org.uk> <fdf89cef-1350-e387-4d59-e6951255dbf0@redhat.com>
In-Reply-To: <fdf89cef-1350-e387-4d59-e6951255dbf0@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Nov 2020 21:44:18 +0100
Message-ID: <CAJfpegtL=T1mc6TDZdM1PaTUwv9Z8UyR8p171TK0d-0VS_E1hQ@mail.gmail.com>
Subject: Re: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Related to this, nothing sets STATX_ATTR_DAX into statx->attributes_mask,
> anywhere in the kernel.
>
> The flag is set into statx->attributes in vfs_getattr_nosec(), but that
> does not know whether the particular filesystem under query supports dax
> or not.
>
> This is related to my other email about exactly what attributes_mask
> means, so should STATX_ATTR_DAX be set in statx->attributes_mask only
> in the filesystems that support dax?
>
> (And should that be done only if CONFIG_DAX is turned on, etc?)

I think the mask/flag combinations should mean:

mask:off, flag:off -> value unknown
mask:off, flag:on -> N/A
mask:on, flag:off -> value is off
mask:on, flag:on -> value is on

So mask should be off iff STATX_ATTR_DAX will not be set even if DAX
is enabled on a particular inode (such as on an old kernel not
supporting STATX_ATTR_DAX).

Thanks,
Miklos
