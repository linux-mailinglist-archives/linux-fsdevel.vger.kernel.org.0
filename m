Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E64884DF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiAHRMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 12:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiAHRMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:12:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD8C06173F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 09:12:12 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m2so9474861qkd.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jan 2022 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=t41nCcRW40hAnWsU2w7VvrxcvVZUg0/7Gh4k0FEwDO4=;
        b=pb+PQxSx1RHENyde2/ssNljQpAQPmR6pSdsUQkqcVXWqN3xhc9Sn/sFu2ZW5QY1ss0
         nRooUkMhU8TNN2UWlOYs3FPL0KvWyzArPSo1s/nssHn8O/DwalMPd+oj/3amK0PLHusz
         GxRpz/yFlgbPP1hrIQXd2jwYvXB8KBA7hfrl4+SVlMNP0AJd9NXm+lpHw2J5glvEhnyq
         CNXtIbgI7YdUuMl0usvZVVdohVxaSPI6jcV+QXaTjVIenBvBe/gQpbG/sS8a6tUk+eWK
         DdR60jAbZxRT0ImyVs6gfaBEFjddGcQvtbZYybl9jn8rxmJDXSl3XOsA/Ri0BoUXNh6q
         cURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=t41nCcRW40hAnWsU2w7VvrxcvVZUg0/7Gh4k0FEwDO4=;
        b=ELk1uLPLn0D+KVErfPPZej8wkjB0bC7FPwU8D3YKBNz1NL1CMX7A+37eA5nixdYuz0
         KkgQTYmdAPp7oUgtgLsQHcUoX9qP+lICbkcMXWDa0UZwEuskw1dHYFYk0Y5y2hVH49rF
         xDgkyCKn1h5ZrlPQLwhDVo9wcLa7wd15uJ5CmIqY37mDBbz0eJEtVH9HsGG4/LcdKSw7
         yKek5cy+qMra2b0k8ae0q8dYEo3cphH4n5EN++cb7JfeqaWmgLXhmD/6oiqjnRHwYLvF
         P347kjDUZtxKs34k7XAmbo+uwAH3euuFY2xZ450N0R62vs0AP69ljQ0bPy/mdTPQ3As/
         vDyw==
X-Gm-Message-State: AOAM530ed+apR+SNDONU/mfE5qDb1UzT5P4NEULGCjUNzIiy41y748f3
        v2HYQP6nibTiExvJ8wr5Cz57yQ==
X-Google-Smtp-Source: ABdhPJzMcmtBisftZrEOjqRx34Y5GwMuBK36vPIvQLj7Ao9wDoCPybB2vkWqW+Z3RsY6J7pRVKm6EA==
X-Received: by 2002:a05:620a:e0e:: with SMTP id y14mr46632016qkm.760.1641661930605;
        Sat, 08 Jan 2022 09:12:10 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f4sm1327545qkp.14.2022.01.08.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:12:09 -0800 (PST)
Date:   Sat, 8 Jan 2022 09:12:08 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 2/3] shmem: Fix data loss when folio truncated
In-Reply-To: <Ydhh39A92g7Xe1df@casper.infradead.org>
Message-ID: <54faec38-f3f9-a326-65e2-cba91a40ccca@google.com>
References: <24d53dac-d58d-6bb9-82af-c472922e4a31@google.com> <Ydhh39A92g7Xe1df@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Jan 2022, Matthew Wilcox wrote:
> On Sun, Jan 02, 2022 at 05:34:05PM -0800, Hugh Dickins wrote:
> > xfstests generic 098 214 263 286 412 used to pass on huge tmpfs (well,
> > three of those _require_odirect, enabled by a shmem_direct_IO() stub),
> > but still fail even with the partial_end fix.
> > 
> > generic/098 output mismatch shows actual data loss:
> >     --- tests/generic/098.out
> >     +++ /home/hughd/xfstests/results//generic/098.out.bad
> >     @@ -4,9 +4,7 @@
> >      wrote 32768/32768 bytes at offset 262144
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      File content after remount:
> >     -0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> >     -*
> >     -0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >     +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >     ...
> 
> generic/098 is passing for me ;-(  I'm using 'always' for THPs.
> I'll have to try harder.  Regardless, I think your fix is good ...

Worrying that the test behaves differently.  Your 'always':
you have '-o huge=always' in the exported TMPFS_MOUNT_OPTIONS?
That should be enough, but I admit to belt and braces by also
echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled

Hugh
I also back up with
