Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878407D9E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfHALCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 07:02:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42776 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbfHALBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:01:44 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so10396076iob.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8p1xBR1158xbW7UpM2v3UIS0V1XEtP9FuX+Bx4DuDTA=;
        b=XhaK4Ig8AIGohl3p3pDHUFJnnjmN3mGWNxElHAJJHrj+sObqWM3V22wfWHtMjco5xS
         RlchtA/bx9bS0VhiCy37hSP8zL1OaLlJgSxR/CzfRPygmJj6gKcum3BVCkoZvIC1NlVG
         n3KUYn6fxuLO0dtS/kQ/Hx1lxjT2HyOToq5Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8p1xBR1158xbW7UpM2v3UIS0V1XEtP9FuX+Bx4DuDTA=;
        b=iQrQ5klRkcQQR8niFox/JjaGI4GFvkWvzu1n5t9d+D41GzHXFJ3z3xrvzt7Fuo1yBn
         H14DSTU+ztw04+I0mG+qHJ25/ipTBZJfa7KCPR5Kh8fgX0qhQkNSVV25KVhI4Rr9CrYb
         3tqjZ1iJzwv88n1LuWLaOmBFzq07L9DhKH9x3ge/GlotOgtixb/W4VCXfJOzS5pRV65F
         8WojAd0Wi8GXjVBw3lFK/n57FThpXs8nW8RMcAIpDRytHgdW2NfnKHGBBNt85YvRDnow
         vZk5wG8b5+ZcbtygyeXWJJBV2f5ALLDfzQ0djtK0+GypECPPGllA5FD77YZWZXJDwWdI
         Nleg==
X-Gm-Message-State: APjAAAXjy+ezYkeD1EfcmKz2o4BsnsMlBh0RVzYKAM0LhisjZh8wIM35
        SSlqHzRARjtc4805vsWQ81tvlGTo7cE+2UB6dRI=
X-Google-Smtp-Source: APXvYqxEC4RZeeYHpD8M7AhOaln11d6KDIp7P8XEQUgwnKRLxvY0440LeYW04L8JGzzXUj9c9N+MTEzeESzFvoBdMzU=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr20920741iok.252.1564657303963;
 Thu, 01 Aug 2019 04:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
In-Reply-To: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 13:01:33 +0200
Message-ID: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
Subject: Re: [PATCH] fuse: BUG_ON's correction in fuse_dev_splice_write()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 8:33 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> commit 963545357202 ("fuse: reduce allocation size for splice_write")
> changed size of bufs array, so first BUG_ON should be corrected too.
> Second BUG_ON become useless, first one also includes the second check:
> any unsigned nbuf value cannot be less than 0.

This patch seems broken: it assumes that pipe->nrbufs doesn't change.
Have you actually tested it?

Thanks,
Miklos
