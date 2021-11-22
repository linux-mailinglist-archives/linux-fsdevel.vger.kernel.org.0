Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD1459175
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhKVPf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:35:59 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38616 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbhKVPf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:35:56 -0500
Received: by mail-ed1-f49.google.com with SMTP id x6so66752581edr.5;
        Mon, 22 Nov 2021 07:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTRfBSk+x9LO50sRJgq8tyBDTsu/Q0sC1r5n7ejGQ9w=;
        b=Pm2bnE+JleZhetBTjB8KDMpOXkw6WQg6R4DVB9r8/dIe3I/lAS8dutEpALoJUBhQ30
         zvcRYA0vXBWSOK2s1biXgdlWfiZrOEp1l83bMfgAJpT0KcK+2zqWq3d3u4V3d/o0mlsj
         BuKbyzo4u5uP+i4ljzYpdtja5grzkgCoJyYA+QnNRzzp46h5FpVfPaERGvyNIlItZavk
         OjhU3876xBCeCQXbWW3m99XVxdTrMri0dmnt7fwSBKwVIUoDWM5GsHsaYPV/50+9+Nwo
         ztYYO8KFFbuCWt6ipRjIxyXyber1BQ8GcrKq7GDZghU+YFdLLmCMHXQgayBp3RzqlTWW
         sEjg==
X-Gm-Message-State: AOAM5321VEcck2NXKH2jIn5eGDQ/CfC2wa7tv7mZZ1157kWyCUIo6uCH
        g+bp6GnYbm5iWEaBL/ij5oE=
X-Google-Smtp-Source: ABdhPJwJZkSVFEgg5tE8x0mlYyjDL3+ku2hYq0MzK6qWENaRtGhDk0A9C0hK/js2yyKnw5GMHZbADA==
X-Received: by 2002:a17:907:9612:: with SMTP id gb18mr41889123ejc.205.1637595165141;
        Mon, 22 Nov 2021 07:32:45 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id q7sm4247757edr.9.2021.11.22.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:32:44 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Date:   Mon, 22 Nov 2021 16:32:29 +0100
Message-Id: <20211122153233.9924-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
The previous version has been posted here [1] 

I hope I have addressed all the feedback. There were some suggestions
for further improvements but I would rather make this smaller as I
cannot really invest more time and I believe further changes can be done
on top.

This version is a rebase on top of the current Linus tree. Except for
the review feedback and conflicting changes in the area there is only
one change to filter out __GFP_NOFAIL from the bulk allocator. This is
not necessary strictly speaking AFAICS but I found it less confusing
because vmalloc has its fallback strategy and the bulk allocator is
meant only for the fast path.

Original cover:
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

I hope I haven't missed anything in the vmalloc allocator.

Thanks!

[1] http://lkml.kernel.org/r/20211025150223.13621-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown


