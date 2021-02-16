Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A742931C632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 06:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBPFXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 00:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBPFXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 00:23:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77060C061574;
        Mon, 15 Feb 2021 21:22:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d3so13911574lfg.10;
        Mon, 15 Feb 2021 21:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7yF3z7ORk4Hs+lXeZICPrDRsFJoinna0ZNMygBvUq4=;
        b=TJGb4pg5/3nrFTftQGz/Z1+ruTsxgkng2tDMWmd2HnufWq/j3+ZEwfRb6KTJoNk0E0
         fK7ZpQYejDCARUgqpiCFIQM2nK+AxdIDiQkU/cC6g1gDRMwCt3YZMbQlvl7rofEQfTC7
         MIics0Dfz3qpW8GVc6HTEv0ttKfYFB3WRvo4e8+4YQ3uQbQ8PRwd8kMVmTmQdmqEnPwy
         CVYArxPC2Qpndro6LBALYqXMeGdf34550EoY0hSkM2zHuJDz2EA4SuvklCe2GiBDKXGF
         f8lyVZy8YKFcNLxrl3fTPlRWbL/B4meelbrH/mtAN+UC+Q53aYoVM0RCQDyxLcu1DZ+p
         F6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7yF3z7ORk4Hs+lXeZICPrDRsFJoinna0ZNMygBvUq4=;
        b=W7YEllRTVY3UGdgDU5X6HKdX+GbpW9urYESnwRCyZ2SikvsRp8T6udrcoD1sDyZBgz
         icRwGkmVc5JThPX8x6KJuJkpsNl8BgCfkAGRsdPalEA+n6O9kKZnOypgps2YwJUNVhPS
         Z5NBepWHtzpKZmkyF+0ImXj7uxoAh5B0O4gGUzP7LAakIGwQpaDd3w1Ovt8AhDBTy7qw
         RlmH2y6KNMrUsaX0jwCWi8nNzADpeEHvv/4Kaftla+cFqEXcr9msoKlwYAokGjToQYAR
         APOQaAh9O8jTxyD9YfJKehdaLqjB7T/BBOaoZYWwxvu7tpgv7jlEV+JDTi61Jzd6DJM3
         7HUA==
X-Gm-Message-State: AOAM530xx1ag70YrGt20OJRNLVfUfBnpIX3JMrkCS9aSdg7WLBO4dH4k
        OznlB8Rt2PQOm6XwvcHTXhWoWqMzjPvJ6pjkqOA=
X-Google-Smtp-Source: ABdhPJytw/XzbIWleKkW+UNIXt86HNGxwpyD+NXYNCrONiCZVl2ZgbD2MAcasnzpl4KhIL873RGx/GWBBwdp2/0yqbw=
X-Received: by 2002:a19:80d1:: with SMTP id b200mr11220680lfd.184.1613452951921;
 Mon, 15 Feb 2021 21:22:31 -0800 (PST)
MIME-Version: 1.0
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
 <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com> <20210216021015.GH2858050@casper.infradead.org>
In-Reply-To: <20210216021015.GH2858050@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 15 Feb 2021 23:22:20 -0600
Message-ID: <CAH2r5mv+AdiODH1TSL+SOQ5qpZ25n7Ysrp+iYxauX9sD8ehhVQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver #3]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 15, 2021 at 06:40:27PM -0600, Steve French wrote:
> > It could be good if netfs simplifies the problem experienced by
> > network filesystems on Linux with readahead on large sequential reads
> > - where we don't get as much parallelism due to only having one
> > readahead request at a time (thus in many cases there is 'dead time'
> > on either the network or the file server while waiting for the next
> > readpages request to be issued).   This can be a significant
> > performance problem for current readpages when network latency is long
> > (or e.g. in cases when network encryption is enabled, and hardware
> > offload not available so time consuming on the server or client to
> > encrypt the packet).
> >
> > Do you see netfs much faster than currentreadpages for ceph?
> >
> > Have you been able to get much benefit from throttling readahead with
> > ceph from the current netfs approach for clamping i/o?
>
> The switch from readpages to readahead does help in a couple of corner
> cases.  For example, if you have two processes reading the same file at
> the same time, one will now block on the other (due to the page lock)
> rather than submitting a mess of overlapping and partial reads.

Do you have a simple repro example of this we could try (fio, dbench, iozone
etc) to get some objective perf data?

My biggest worry is making sure that the switch to netfs doesn't degrade
performance (which might be a low bar now since current network file copy
perf seems to signifcantly lag at least Windows), and in some easy to understand
scenarios want to make sure it actually helps perf.

-- 
Thanks,

Steve
