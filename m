Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92DF439994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJYPGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:06:18 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34311 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhJYPGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:06:17 -0400
Received: by mail-ed1-f53.google.com with SMTP id g10so639197edj.1;
        Mon, 25 Oct 2021 08:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzBIoeOifARtzlM/P1F6nuzN/BEpSFNhUwVbX96EjJQ=;
        b=ZZaz0Cq0tkJgUFtwmPDnC3C2RWxLRNovPkMy7L0UcZNjnyXfQwFqKbjga4wtKNvm8V
         FlgynD1Us0cCp9SM9r4XsDwzEk2WKQk9320cZOh4uey8OXnoDNN7+LIKtdCho0v+xanV
         //YKgPekRK+OYxDeFWxRPkviHaAmVms6kOQOCmp2rMEnj5Lx2MYp0N2zqH5EfSPI3TXk
         flnr0IBq/2aD8Ab4HQ/rf10TFAUmHwkn1yoDitPOgnOtBPp2b8Taop5ILr9qvA6QiewZ
         KP7/rVoI9UDajiQVcG7iZKjhCJlrV4yELW1f5021/h8XzaWvo2yEUcpHOpw7n9TJtPgh
         iMjQ==
X-Gm-Message-State: AOAM5306Y+nv5Yas5XHmETPs9OjBWzzgKar1KaXutTsKYk6O3FEy47Rp
        v5Hv3/bSmDf3izrlFCT4RLc=
X-Google-Smtp-Source: ABdhPJzAPclHOdCs8TGK9y//K5TYr7tyh/pAD9g5HQNGIk69ckb13Ts14qqt4C7a73m08tJvIkaIVQ==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr23065569ejc.247.1635174155105;
        Mon, 25 Oct 2021 08:02:35 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-34-175.eurotel.cz. [85.160.34.175])
        by smtp.gmail.com with ESMTPSA id u23sm9098221edr.97.2021.10.25.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:02:33 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] extend vmalloc support for constrained allocations
Date:   Mon, 25 Oct 2021 17:02:19 +0200
Message-Id: <20211025150223.13621-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
this has been posted as a RFC previously [1] and it seems there was no
fundamental disagreement about the approach so I am dropping RFC and I
have also integrated some feedback from that discussion.

Based on a recent discussion with Dave and Neil [2] I have tried to
implement NOFS, NOIO, NOFAIL support for the vmalloc to make
life of kvmalloc users easier.


A requirement for NOFAIL support for kvmalloc was new to me but this
seems to be really needed by the xfs code.

NOFS/NOIO was a known and a long term problem which was hoped to be
handled by the scope API. Those scope should have been used at the
reclaim recursion boundaries both to document them and also to remove
the necessity of NOFS/NOIO constrains for all allocations within that
scope. Instead workarounds were developed to wrap a single allocation
instead (like ceph_kvmalloc).

First patch implements NOFS/NOIO support for vmalloc. The second one
adds NOFAIL support and the third one bundles all together into kvmalloc
and drops ceph_kvmalloc which can use kvmalloc directly now.

Please note that this is RFC and I haven't done any testing on this yet.
I hope I haven't missed anything in the vmalloc allocator. It would be
really great if Christoph and Uladzislau could have a look.

Thanks!

[1] http://lkml.kernel.org/r/20211018114712.9802-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown


