Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49E4317E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhJRLtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:49 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37552 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhJRLti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:38 -0400
Received: by mail-ed1-f49.google.com with SMTP id y12so71691924eda.4;
        Mon, 18 Oct 2021 04:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2Caj50fH5C8evqIQEUe2oy5AoVdzAaa+Xkp8NzJGwQ=;
        b=oBOVQL7NCSgZBbfndjOtUMW4xhCymInXqxCbSXM5Fjo2ogG9uP7eAfkQ+6hNdAAgpm
         wJawMAYr5zGht9cOzU04MCgp7QljEh5Ctb+VKHUxVKOB+iLPIaRh47exv4zQ42gafep+
         duyGAR7mPXoYoT3S5LAaEPqjShD3QCC6TG+IHo28G0KuVbZOLj2nV43HB9/exy8+jmb7
         P677808+WK494CDpWwMxOM4R6EMnbhmM8tXb1Md8sEXumOduzzk4GtqmPz+gsI8zsmME
         wObGp/VY4UHYUDwagOczxaBFYnf9AYnmVTzsuRlGarbLCXFvy5lAccWI3Ya+x015bhFj
         nIDg==
X-Gm-Message-State: AOAM531TifbWZOU9u8pIzAAwmlbAcRjzX7TxLrSpNBp8ksUbxZ5RNkZT
        oHHrvreu3JWKAUkE7OsFo4miOVcIPRE=
X-Google-Smtp-Source: ABdhPJxE+GzNWreIYMvEQ3Fwjp2wm2GTvRFJhQ+CYaGY86q9R2fwFjTfhgtA8KkCi9+Tbj4vZ84H4Q==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr5470110edd.332.1634557645946;
        Mon, 18 Oct 2021 04:47:25 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-35-99.eurotel.cz. [85.160.35.99])
        by smtp.gmail.com with ESMTPSA id b2sm9587458edv.73.2021.10.18.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:47:25 -0700 (PDT)
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
Subject: [RFC 0/3] extend vmalloc support for constrained allocations
Date:   Mon, 18 Oct 2021 13:47:09 +0200
Message-Id: <20211018114712.9802-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
based on a recent discussion with Dave and Neil [1] I have tried to
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

[1] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown


