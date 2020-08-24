Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF06024F959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgHXJoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 05:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgHXInR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:43:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC245C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 01:43:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id md23so10063728ejb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxNG5RN2hoFSDN98UXNrt2eLopXcYkRuq6vbl8JTP4I=;
        b=jeOCjcqHWRuh7dVt6kyPIOd+XHEy3VxDLMtocFh13ZMnJ5/zRfWLBYn1bfd4wscvh6
         DO4SHEFwO8hrR4zZ1DAKLrjPVhRKtxp8EtTLsorHk7u+/8kLY25txny1BprFIBHMwB5D
         y0KmUJDK+krmyTuS3jaKwkZyWpXZk0Zq05QeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxNG5RN2hoFSDN98UXNrt2eLopXcYkRuq6vbl8JTP4I=;
        b=LnvCOZdfByCtDc6bmJYZWhmzXzFkrLHlH7XK6y4qeLmpQzlLKgJZtg/dufN22ppng2
         jruMo7AYLxi5IhfntyKsGIUARronKqNk9Lfq/fLXitbLzs16I8kzRip8QknapekDy41a
         d5mK3jk2KpuROprf9/6V8rEU1ssPZgBI0VBxnXn75F5gMZ7SSWh2vhnQj57nfYf5PI1y
         6IVtOhnKZ4y7a8/o/2ZRzoXx3+QeyajXEWdbP9t/cI9vt9SU3yEHwA5nHuB8gPN4h1zU
         SMaJ9Cw8AqWaTbd18fSseuxA1AiB45m6B11XG/3cBPR47QNnbyfMgWfau86e7XzzGjIe
         +7lA==
X-Gm-Message-State: AOAM532DVjRXanKs0/L/S4Ed9ymbm4HGy1GDqQ6Yza+sDjwrgikLFrD/
        fDPctwwpSqPlZAf7rXDnoDXEfpMhnJ6SdeLhwviL17umv/0G5g==
X-Google-Smtp-Source: ABdhPJw9o26G0YsKZS3UmpEnvM9KpfSBDfFEV4HWos7h8iNRiYue7TsjSdmD981vrSy4rLH6zR22tCwiSIWoNCqLmkQ=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr4348305ejb.511.1598258595639;
 Mon, 24 Aug 2020 01:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183812.19573-1-vgoyal@redhat.com> <CAJfpeguzG3tfjHkToikA+v4Pu7iEa7Y=RxaO+SnycZHxFHRLGg@mail.gmail.com>
 <20200821200232.GA905782@redhat.com>
In-Reply-To: <20200821200232.GA905782@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Aug 2020 10:43:04 +0200
Message-ID: <CAJfpegsMu+_bjg4iEBCr-pG4jsVg7DKs+aH+jNwicoMpWsM-tw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and
 enable SB_NOSEC
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> So how about, we instead implement a flag which tells fuse that
> file server is implementing a local filesystem and it does not
> expect anything to changed outside fuse. This will make sure
> distributed filesystems like gluster don't regress because
> of this change and a class of local filesystems can gain from
> this. Once we support sharing mode in virtiofs, then we will
> need to revisit it again and do it right for distributed
> filesystems (depending on their invalidation mechanism).

Okay, sounds good.

This flag can be set on "cache=always" in virtiofsd.

Thanks,
Miklos
