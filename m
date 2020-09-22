Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC1274B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVVZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:25:44 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D76C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 14:25:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e2so11176293vsr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gt2wzS9sg/tz5cTwzRf+vPp97870MYTgiWnXdUTamgQ=;
        b=jNhHjheUOCy785oD2xMVoxsi05N+xF6TFWxL7jirUwtONGtn2kO8429eMVRkzGJ4+3
         9uOKZS2u0GNeJzA4IR+plVV0tvUlFaOqtq34+Ysurek5jffGUM2yzh2WMbxR1GYJBuT3
         eoxa7xPFYYX3ehApjOvkzLMSLSOs4/bjsm3gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gt2wzS9sg/tz5cTwzRf+vPp97870MYTgiWnXdUTamgQ=;
        b=g4kH3k3754K8I9HHqNLEFIJJdMKoSFvoiIu3NfchBstBeFeCylAftLpQPaIri+Bz/x
         4eIFVMC0TINMEwVMS3DmIr5HvbRjtp8R5fjcJg3HRPPMrisT49QOcF6LDy2gqd2zD925
         0ANu7t4tobp9tyqa0LQmIPfuImsR4JtUoB87c2UonXd37FgR5XxoPnTY+Z2JlPGR8vsN
         cJtSRXEOb/hgdYH9/2qEeOORM7o64L+UkaRT0v447xSKfuvWkUgItQVsxVJny9ptHd20
         pyZuTazDRaNbqT1F32nwsg4BA9iIgjGrP/vhmqvwOaFd7pUc94XTontRr3ZvaQyGJelp
         eRoA==
X-Gm-Message-State: AOAM530PcP0EoTHDp7t+l9jMHoVr9IZ8GYNWgPfrTYGssW3VjGLlTn1l
        p32i0ebgYqkOOjO5J76mo+ci+2IJfj8uYdh7W88S4g==
X-Google-Smtp-Source: ABdhPJxbFWAGDYkP7GRABNsd8VWewt8LMtrndPDxkdm4WBk+4D1CTms1J5komPUZwzO2XosFGqBTpFbrpF2eT4s6sII=
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr5176954vsn.3.1600809941880;
 Tue, 22 Sep 2020 14:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200916161737.38028-1-vgoyal@redhat.com> <20200916161737.38028-5-vgoyal@redhat.com>
 <CAJfpegsncAteUfTAHAttwyVQmhGoK7FCeO_z+xcB_4QkYZEzsQ@mail.gmail.com> <20200922200840.GF57620@redhat.com>
In-Reply-To: <20200922200840.GF57620@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Sep 2020 23:25:30 +0200
Message-ID: <CAJfpegs3PO=OH_VDMByibCnQ3d8kZYC2BWvu05DxpdRjMuNjyg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fuse: Kill suid/sgid using ATTR_MODE if it is not truncate
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Sep 22, 2020 at 03:56:47PM +0200, Miklos Szeredi wrote:
> > On Wed, Sep 16, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > But if this is non-truncate setattr then server will not kill suid/sgid.
> > > So continue to send ATTR_MODE to kill suid/sgid for non-truncate setattr,
> > > even if ->handle_killpriv_v2 is enabled.
> >
> > Sending ATTR_MODE doesn't make sense, since that is racy.   The
> > refresh-recalculate makes the race window narrower, but it doesn't
> > eliminate it.
>
> Hi Miklos,
>
> Agreed that it does not eliminate that race.
>
> >
> > I think I suggested sending write synchronously if suid/sgid/caps are
> > set.  Do you see a problem with this?
>
> Sorry, I might have missed it. So you are saying that for the case of
> ->writeback_cache, force a synchronous WRITE if suid/sgid is set. But
> this will only work if client sees the suid/sgid bits. If client B
> set the suid/sgid which client A does not see then all the WRITEs
> will be cached in client A and not clear suid/sgid bits.

Unless the attributes are invalidated (either by timeout or
explicitly) there's no way that in that situation the suid/sgid bits
can be cleared.  That's true of your patch as well.

>
> Also another problem is that if client sees suid/sgid and we make
> WRITE synchronous, client's suid/sgid attrs are still cached till
> next refresh (both for ->writeback_cache and non writeback_cache
> case). So server is clearing suid/sgid bits but client still
> keeps them cached. I hope none of the code paths end up using
> this stale value and refresh attrs before using suid/sgid.
>
> Shall we refresh attrs after WRITE if suid/sgid is set and client
> expects it to clear after WRITE finishes to solve this problem. Or
> this is something which is actually not a real problem and I am
> overdesigning.

The fuse_perform_write() path already has the attribute invalidation,
which will trigger GETATTR from fuse_update_attributes() in the next
write.

So I think all that should work fine.

Thanks,
Miklos
