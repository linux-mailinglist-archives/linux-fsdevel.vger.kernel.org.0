Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA949D613
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 00:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiAZXQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 18:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiAZXQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:16:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4313CC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 15:16:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id h7so1921208ejf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkXvE+VWQRHehg+eZZyr8tjYUURIjuYZso1v1m3GLe0=;
        b=XrmCyEat4NQTFpSScp48kHRNOERJGru+9B4A4HYOuMy3ofRi+svGeFbhKMPvN3Qj2B
         GG4r+3LGcHVq9QV6ZdYgVMglLnLOCtQJWZL1le/8fmhU98nWv99OVI1l1q1gK/X3Lz2e
         kYZ6PiHpbX3XD/2NNvJLVF77BU5K9YovBDNr43rR1HlFf7InWkg6iAC7y2o8vkQKtUS0
         cJQqgk+S2TmhNQK3nrGZe3+E3frYxu246HvBOaSi00tYSHO5gQ7AUU5OYtXtxqPYLDKE
         ZWgtI5h/MD31S+sDGKJeMpHFrgPltlzo7yvcJ5gofpYG1EeJMhUohUE1mmRT3iUzF36N
         KSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkXvE+VWQRHehg+eZZyr8tjYUURIjuYZso1v1m3GLe0=;
        b=pvvU/BkWQZFUjkIkziHq70HjN+0I6uJ3ubA5r1UE2F1Bm49eOpQYh9nAgjpHfRtWQW
         5S4X55exWnB38V5Y99GDsVsADp/7/L2YjjpF6mseEfBxfn4Lh5IFuhndQUDc0BVCKTxQ
         XPJcUJXgZFFOOSXipH1SXQVUwFz7S/jvdyuj29ecsU3kpGqv9ufdzqfqsvKT9UGB9VUK
         y7PHXm1Vt2Rw71Jo9hq23Jnw/0/YUTwkvyDN+jalwErPAm8ii8yoIKNDASAopze9ISQJ
         UNBfDcGoHZYN880c1QYsCrANei1QdEWjBtVVlR7+p2RGIa3iSNCZUC/PDtZsX4Wv0i/L
         A5IA==
X-Gm-Message-State: AOAM530FE+ENFY6JBpvetadAX/BJ7fZKCnf6XZ2bfoobSwPRXGJJ14LJ
        ecm6O4MG03SqI8HT1GENIsjSUsEl6vIkFKcOy7eW+8+CsDG98A==
X-Google-Smtp-Source: ABdhPJwVPI5xRSamTks0d/aUBiTBbfDE747olZVnXP1khXh5QUMlqKbcFijkrvyAqrtWNJc6p1/2MBRGSgj70CCjkXg=
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr845542ejc.240.1643238980846;
 Wed, 26 Jan 2022 15:16:20 -0800 (PST)
MIME-Version: 1.0
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
 <YfC5vuwQyxoMfWLP@casper.infradead.org> <CABVffEPReS0d1dN2eKCry_k6K0LCGNNjGf04O3c7-h6P1Q_9zg@mail.gmail.com>
 <YfHH5HsynuMuFJse@casper.infradead.org>
In-Reply-To: <YfHH5HsynuMuFJse@casper.infradead.org>
From:   Daniel Black <daniel@mariadb.org>
Date:   Thu, 27 Jan 2022 10:16:09 +1100
Message-ID: <CABVffEOQL7rXGufHESgP1snV+=UjiJ1gaD-+59c3NLuNgQPt=g@mail.gmail.com>
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:15 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 27, 2022 at 09:03:36AM +1100, Daniel Black wrote:

> > Is it going to be reasonable to expect fcntl(fd, F_SETFL, O_DIRECT) to
> > return EINVAL if O_DIRECT isn't supported?
>
> That is a reasonable expectation.  I can't guarantee that we won't have
> bugs, of course ...

Ha, sure.

I've begun to https://kernelci.org/ options to try to catch at least
some of them
pre-release.

> > My problem it seems, I'll see what I can do to get back to using real
> > filesystems more.
>
> Heh.  I know Hugh is looking at "supporting" O_DIRECT on tmpfs, at least
> for his internal testing.  Not sure what his plans are for merging
> that support.

I'd be happy to see it in that it will remove a long standing cludge
bit of weakly
commented user space code in the fullness of supported kernel lifespans, but
no great urgency.

Thanks Matthew.
