Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01D3F8905
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhHZNd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 09:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhHZNd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629984761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42GBp2+p1MzG9+g0Z/rUgzwv7wnwZranM3FCN/5SFn4=;
        b=W+RP12ZevWrXhz9umQkJRFp1hDBFuoS064QgDZXhdz14zwPvbp5FxHkrSqYIqJ9n8X9kmm
        c2lBXBgtTcSZ8q1hrZHVvBaVOMnX5y0rAyZMMURvx8GY3UwQ8m/N4JBkssthfqsp4byIUk
        UyFqHzT0pf8i0rOd5IuiWiYD9XvmI/o=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-vCKux_7XP4WoezLohieMJQ-1; Thu, 26 Aug 2021 09:32:38 -0400
X-MC-Unique: vCKux_7XP4WoezLohieMJQ-1
Received: by mail-il1-f198.google.com with SMTP id d4-20020a923604000000b0022a2b065b0aso1976355ila.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42GBp2+p1MzG9+g0Z/rUgzwv7wnwZranM3FCN/5SFn4=;
        b=LEEKIcoopkcB22g/xE65qp8911IQlZW+YtUeqie5QwstHzgQJLpfdLyABdoOKUtmQH
         fzZi6r9EbQoB7UvAveWNwFkI+04U89Xv/wip32e5JJ60hFK5KV6vPEmAbuFcmL0OyN5/
         Ef0SXmyIAXxB+M+mSp0Zz9Ym2hYjKZZ5ZiiSU4tdSH4OWINqQrYBZmOcQQbKicUNvmOH
         zvD8V72D5cSYwokEiHHht7814hZmGq5GtxOKHAsJdr/QLv88v1tGd6SlS65Wk5Bc9KTd
         pDPxwcjLOwnvLA9djfdM38k1F3OKQEQ1kHjLoLQZe1HEgSOn00kCgihnTdyIydpKM6xP
         E/mQ==
X-Gm-Message-State: AOAM532KvLoGvHbBimCssKi52A132+Eg+3d67hGBRNPSGnOMUriDf3Xj
        ulEF3cIyMMaIrqhBc9K4tpnoMvjUFb6ML5a4tGVHKAw1DBAGGWn3zLHu2Dzbgmt04On7kLawGZX
        sTHfWJeP1EZdYmwJOAOq898JujnhIFqmvOW2W7PIkGg==
X-Received: by 2002:a05:6e02:12a2:: with SMTP id f2mr2671615ilr.222.1629984757757;
        Thu, 26 Aug 2021 06:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2p55VXj46ProdqwqK1zaLVY3n1ruM5FvkX9TNvtt7LUM0oltyzQk2tsQKZneTIUOyxex29rSr9y2TB1Xgk0o=
X-Received: by 2002:a05:6e02:12a2:: with SMTP id f2mr2671599ilr.222.1629984757488;
 Thu, 26 Aug 2021 06:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210721113057.993344-1-rbergant@redhat.com> <YSeNNnNBW7ceLuh+@casper.infradead.org>
 <a5873099-a803-3cfa-118f-0615e7a65130@sandeen.net>
In-Reply-To: <a5873099-a803-3cfa-118f-0615e7a65130@sandeen.net>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Thu, 26 Aug 2021 15:32:26 +0200
Message-ID: <CACWnjLxtQOcpLGES1bX1cN8E4PYSx-EVk0=akMUss1pXuk1Q7A@mail.gmail.com>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 3:13 PM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> On 8/26/21 7:46 AM, Matthew Wilcox wrote:
> > On Wed, Jul 21, 2021 at 01:30:57PM +0200, Roberto Bergantinos Corpas wrote:
> >> With addition of fs_context support, options string is parsed
> >> sequentially, if 'sloppy' option is not leftmost one, we may
> >> return ENOPARAM to userland if a non-valid option preceeds sloopy
> >> and mount will fail :
> >>
> >> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> >> mount.nfs: an incorrect mount option was specified
> >> host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> >
> > It isn't clear to me that this is incorrect behaviour.  Perhaps the user
> > actually wants the options to the left parsed strictly and the options
> > to the right parsed sloppily?
>
> I don't think mount options have ever been order-dependent, at least not
> intentionally so, have they?
>
> And what matters most here is surely "how did it work before the mount
> API change?"
>> And it seems to me that previously, invalid options were noted, and whether the
> mount would fail was left to the end, depending on whether sloppy was seen
> anywhere in the mount options string.  This is the old option parsing:
>
>          while ((p = strsep(&raw, ",")) != NULL) {
> ...
>                  switch (token) {
> ...
>                  case Opt_sloppy:
>                          sloppy = 1;
>                          dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
>                          break;
> ...
>                  default:
>                          invalid_option = 1;
>                          dfprintk(MOUNT, "NFS:   unrecognized mount option "
>                                          "'%s'\n", p);
>                  }
>          }
>
>          if (!sloppy && invalid_option)
>                  return 0;

 Agree, that's my main point. I think that breaks from previous
behaviour and indeed causes issues on the field.
My understanding too is that there's no order-dependency.

roberto

>
> -Eric
>

