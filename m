Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF37B2C0353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKWKb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 05:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgKWKb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606127484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2z/wTVqHabYzS0sinajYT9PD1Lj3hHjwZuxraPE9e4=;
        b=enyh4iQOpzFiIFPtPhyFzYHR4JUoVIDzCS0fH+vK7poMHXedRJpc6IWr/jz9PQcEBpfsXa
        0nhazYyhAIlFbQjjhJFvLazep06kDuoGx1mJv7pXbOxZIfNYYm8AwFmctJAbC7zN0O6WJm
        VvcIU+ZK9oJTfO+7eCtv2IPYb3IYd9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-vQc1ymdZO6SkDI75tMfuEg-1; Mon, 23 Nov 2020 05:31:20 -0500
X-MC-Unique: vQc1ymdZO6SkDI75tMfuEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D17051DD;
        Mon, 23 Nov 2020 10:31:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB3256086F;
        Mon, 23 Nov 2020 10:31:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201123080506.GA30578@infradead.org>
References: <20201123080506.GA30578@infradead.org> <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <516983.1606127474.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Nov 2020 10:31:14 +0000
Message-ID: <516984.1606127474@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Please run performance tests.  I think the indirect calls could totally
> wreck things like high performance direct I/O, especially using io_uring
> on x86.

Here's an initial test using fio and null_blk.  I left null_blk in its def=
ault
configuration and used the following command line:

fio --ioengine=3Dlibaio --direct=3D1 --gtod_reduce=3D1 --name=3Dreadtest -=
-filename=3D/dev/nullb0 --bs=3D4k --iodepth=3D128 --time_based --runtime=3D=
120 --readwrite=3Drandread --iodepth_low=3D96 --iodepth_batch=3D16 --numjo=
bs=3D4

I borrowed some of the parameters from an email I found online, so I'm not
sure if they're that useful.

I tried three different sets of patches: none, just the first (which adds =
the
jump table without getting rid of the conditional branches), and all of th=
em.

I'm not sure which stats are of particular interest here, so I took the tw=
o
summary stats from the output of fio and also added together the "issued r=
wts:
total=3Da,b,c,d" from each test thread (only the first of which is non-zer=
o).

The CPU is an Intel(R) Core(TM) i3-4170 CPU @ 3.70GHz, so 4 single-thread
cores, and 16G of RAM.  No virtualisation is involved.

Unpatched:

   READ: bw=3D4109MiB/s (4308MB/s), 1025MiB/s-1029MiB/s (1074MB/s-1079MB/s=
), io=3D482GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4097MiB/s (4296MB/s), 1020MiB/s-1029MiB/s (1070MB/s-1079MB/s=
), io=3D480GiB (516GB), run=3D120001-120001msec
   READ: bw=3D4113MiB/s (4312MB/s), 1025MiB/s-1031MiB/s (1075MB/s-1082MB/s=
), io=3D482GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4125MiB/s (4325MB/s), 1028MiB/s-1033MiB/s (1078MB/s-1084MB/s=
), io=3D483GiB (519GB), run=3D120001-120001msec

  nullb0: ios=3D126017326/0, merge=3D53/0, ticks=3D3538817/0, in_queue=3D3=
538817, util=3D100.00%
  nullb0: ios=3D125655193/0, merge=3D55/0, ticks=3D3548157/0, in_queue=3D3=
548157, util=3D100.00%
  nullb0: ios=3D126133014/0, merge=3D58/0, ticks=3D3545621/0, in_queue=3D3=
545621, util=3D100.00%
  nullb0: ios=3D126512562/0, merge=3D57/0, ticks=3D3531600/0, in_queue=3D3=
531600, util=3D100.00%

  sum issued rwts =3D 126224632
  sum issued rwts =3D 125861368
  sum issued rwts =3D 126340344
  sum issued rwts =3D 126718648

Just first patch:

   READ: bw=3D4106MiB/s (4306MB/s), 1023MiB/s-1030MiB/s (1073MB/s-1080MB/s=
), io=3D481GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4126MiB/s (4327MB/s), 1029MiB/s-1034MiB/s (1079MB/s-1084MB/s=
), io=3D484GiB (519GB), run=3D120001-120001msec
   READ: bw=3D4109MiB/s (4308MB/s), 1025MiB/s-1029MiB/s (1075MB/s-1079MB/s=
), io=3D481GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4097MiB/s (4296MB/s), 1023MiB/s-1025MiB/s (1073MB/s-1074MB/s=
), io=3D480GiB (516GB), run=3D120001-120001msec

  nullb0: ios=3D125939152/0, merge=3D62/0, ticks=3D3534917/0, in_queue=3D3=
534917, util=3D100.00%
  nullb0: ios=3D126554181/0, merge=3D61/0, ticks=3D3532067/0, in_queue=3D3=
532067, util=3D100.00%
  nullb0: ios=3D126012346/0, merge=3D54/0, ticks=3D3530504/0, in_queue=3D3=
530504, util=3D100.00%
  nullb0: ios=3D125653775/0, merge=3D54/0, ticks=3D3537438/0, in_queue=3D3=
537438, util=3D100.00%

  sum issued rwts =3D 126144952
  sum issued rwts =3D 126765368
  sum issued rwts =3D 126215928
  sum issued rwts =3D 125864120

All patches:
  nullb0: ios=3D10477062/0, merge=3D2/0, ticks=3D284992/0, in_queue=3D2849=
92, util=3D95.87%
  nullb0: ios=3D10405246/0, merge=3D2/0, ticks=3D291886/0, in_queue=3D2918=
86, util=3D99.82%
  nullb0: ios=3D10425583/0, merge=3D1/0, ticks=3D291699/0, in_queue=3D2916=
99, util=3D99.22%
  nullb0: ios=3D10438845/0, merge=3D3/0, ticks=3D292445/0, in_queue=3D2924=
45, util=3D99.31%

   READ: bw=3D4118MiB/s (4318MB/s), 1028MiB/s-1032MiB/s (1078MB/s-1082MB/s=
), io=3D483GiB (518GB), run=3D120001-120001msec
   READ: bw=3D4109MiB/s (4308MB/s), 1024MiB/s-1030MiB/s (1073MB/s-1080MB/s=
), io=3D481GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4108MiB/s (4308MB/s), 1026MiB/s-1029MiB/s (1076MB/s-1079MB/s=
), io=3D481GiB (517GB), run=3D120001-120001msec
   READ: bw=3D4112MiB/s (4312MB/s), 1025MiB/s-1031MiB/s (1075MB/s-1081MB/s=
), io=3D482GiB (517GB), run=3D120001-120001msec

  nullb0: ios=3D126282410/0, merge=3D58/0, ticks=3D3557384/0, in_queue=3D3=
557384, util=3D100.00%
  nullb0: ios=3D126004837/0, merge=3D67/0, ticks=3D3565235/0, in_queue=3D3=
565235, util=3D100.00%
  nullb0: ios=3D125988876/0, merge=3D59/0, ticks=3D3563026/0, in_queue=3D3=
563026, util=3D100.00%
  nullb0: ios=3D126118279/0, merge=3D57/0, ticks=3D3566122/0, in_queue=3D3=
566122, util=3D100.00%

  sum issued rwts =3D 126494904
  sum issued rwts =3D 126214200
  sum issued rwts =3D 126198200
  sum issued rwts =3D 126328312


David

