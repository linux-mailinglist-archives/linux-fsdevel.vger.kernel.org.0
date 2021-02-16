Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0A31C62C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 06:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBPFS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 00:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhBPFS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 00:18:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFEC061574;
        Mon, 15 Feb 2021 21:18:16 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so13947785lfg.5;
        Mon, 15 Feb 2021 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wujt3rEkfz1gBVeqiGJuebMiBQ6EXLfMvV1N3ToSLEg=;
        b=G1pqEFCRklKjZBFj6/WMCJvTupO2n0FY8ZdI0lPq/s4scqtvILGzYRjptwygMdmpRa
         M+KeFCamCX7+3s612uofPbUoy+TvLFU2pQ6phK0LV2NAzy93/pvgpyeDNCKXu1m3TIsR
         /JRe1NQ7zecm8IoIWOnai/+Mb1HWXFbRLmwpW94ujHQvIiP4qK1vE9bzvHL3luJjXbCX
         v/3dxDs4i1sCs7N3E+GWC4A0+6hExVYA1awT07sNClmS58kanpx9GZxOEdpkTmEh67Sn
         MWdV18swd+PP8ozVqBEaOcsJb8YvbLp79/4tz2d3bqmg33RlROI3BkfhaKA8qUFbErCF
         pzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wujt3rEkfz1gBVeqiGJuebMiBQ6EXLfMvV1N3ToSLEg=;
        b=HaxoWwEzd2haGhf8WEgaD26LbRxadAJfj+3esbwlQYraaaB1y2k/CmmYv7faH21do1
         IYhDJ6oC2Tfbzbc5m+bF6QC6hOQhGR6SpMSXU2WE9OVUmeDdMGZMVwjw6W8sTkPQ86jQ
         62avNgVY3d1CSLNZ9Vn6aQ0Pprxmusl4AOI0TiDtIXvY5fsZOdIhtPE8QsS4ZH+fETLs
         mnla/1lBTthfYPSM5D0UIhp1ggkMVsWFcLTp+gw9Bcy1UFKrP+XoLb8qSYPpnk/v2ELx
         0WrRVkk6Vhfgtj+7hlVSEe0YHGxAElKqEFpd+fC0gezITBBOFp4hCtSSz6dU8uAubS9p
         DMiA==
X-Gm-Message-State: AOAM531Seymk39Qwfw8O1JuhOsPatOK5MJYa19UuDvWCm8igFviiRWqx
        38PqUNxou5tuZPKe4T2ARl2jqxHwf1q5aYv3NxY=
X-Google-Smtp-Source: ABdhPJy9H3EXUc8XuYPIQKDxwM3oPFRhR4c+QWVWNLoFZd2YMqS0S6y9PDhVsr2YqLR65ivGiOSLLFSUYk3dT5a6PGE=
X-Received: by 2002:a05:6512:2118:: with SMTP id q24mr4994475lfr.133.1613452693694;
 Mon, 15 Feb 2021 21:18:13 -0800 (PST)
MIME-Version: 1.0
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
 <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com> <20210216021015.GH2858050@casper.infradead.org>
In-Reply-To: <20210216021015.GH2858050@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 15 Feb 2021 23:18:02 -0600
Message-ID: <CAH2r5mv=PZk_wn2=b0VQcaom9TEw1MGLz+qB_Ktxxm2bnV9Nig@mail.gmail.com>
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
>
> We're not there yet on having multiple outstanding reads.  Bill and I
> had a chat recently about how to make the readahead code detect that
> it is in a "long fat pipe" situation (as opposed to just dealing with
> a slow device), and submit extra readahead requests to make best use of
> the bandwidth and minimise blocking of the application.
>
> That's not something for the netfs code to do though; we can get into
> that situation with highly parallel SSDs.

This (readahead behavior improvements in Linux, on single large file sequential
read workloads like cp or grep) gets particularly interesting
with SMB3 as multichannel becomes more common.  With one channel having
one readahead request pending on the network is suboptimal - but not as bad as
when multichannel is negotiated. Interestingly in most cases two
network connections
to the same server (different TCP sockets,but the same mount, even in
cases where
only network adapter) can achieve better performance - but still significantly
lags Windows (and probably other clients) as in Linux we don't keep
multiple I/Os
in flight at one time (unless different files are being read at the same time
by different threads).   As network adapters are added and removed from the
server (other client typically poll to detect interface changes, and SMB3
also leverages the "witness protocol" to get notification of adapter additions
or removals) - it would be helpful to change the maximum number of
readahead requests in flight.  In addition, as the server throttles back
(reducing the number of 'credits' granted to the client) it will be important
to give hints to the readahead logic about reducing the number of
read ahead requests in flight.   Keeping multiple readahead requests
is easier to imagine when multiple processes are copying or reading
files, but there are many scenarios where we could do better with parallelizing
a single process doing copy by ensuring that there is no 'dead time' on
the network.


-- 
Thanks,

Steve
