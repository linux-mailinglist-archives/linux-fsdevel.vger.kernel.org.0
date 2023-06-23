Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246BF73AEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFWDCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 23:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFWDCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:02:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE612139
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 20:02:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39ec83d1702so109908b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687489350; x=1690081350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5fdBvjILHHICNW7kAOU9EXiJCvCCVnIlFnMKbSYAiM=;
        b=yaf9GK50fZBGu3Vp+jaMjwYLHKC4DeSXGu2PbA8Z/JT7Kv3yYF30fLaaYiUgKSveJ6
         U4bJhxp6peE0ASmAi9ZHN+4qm6tcRY9njhrp4i8rbtsZefY6kn0fRsGCmcqh8pRBv8e2
         EO7XpuQNAjyWzIE216y5PVV1M3Ht6LesS/WMNeI7dQcwADmcxMYstBj5YSnFc6ysfqEm
         NT6XfMW87hOToXsjtTgzM72s3mi5LHJnGAxEv+yafkq7VZ3p/xPjShv3R6eM2XfiuRZF
         Mc/ZfxXwbWyoUMpzlWZ93GwFBK5sQZg2yisXn867MeyRyfxoqqhXth4JhWF9lEHTyvC5
         PmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687489350; x=1690081350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5fdBvjILHHICNW7kAOU9EXiJCvCCVnIlFnMKbSYAiM=;
        b=V7YkXssdNXs395O340pHaM+3EgNvkC0w9L7s+NBys9ubfQ8LNaZd2afh5B7oRl9PA/
         +q/3F2cTx3QyBcBT4FDBPHlmoULDpA6BYshF5NRNJykKCscRukvIUosinKZ+H7zfNOpL
         RCUex4Dn0R3mTC2nxP2H1ytrfpHwv9fEpcEogeL8XPnv8GIHbndaZPdeJZrGFyXwUjmr
         mILCI+n3rr+cTDrgOuksbJ4qCeEgzfprlJolYt6L1IaQtWWZk4OR46m6iQcqzHNUTTBN
         xptP20X57ooGjkCUXibW3CIX7h8eAjlnrMo9U6558G8ZUvo+zxKruhG/QsbeNsoCyoyl
         HQVg==
X-Gm-Message-State: AC+VfDyrJJF7jrrju0UouCfCAU2gjFBIDgRI0NfOy6/n4zv57UVtGqhJ
        4V8HxmQy3iqL4CS7rrhlKbZ7Pw==
X-Google-Smtp-Source: ACHHUZ5hTJ2gl14yoQsjZ0I630ZkU6qbc2Cl4ARJt1w1LSqQu74jX9pP3VMdbkCzCsxnq2e8k1Eo+Q==
X-Received: by 2002:a05:6808:1188:b0:39c:532b:fe43 with SMTP id j8-20020a056808118800b0039c532bfe43mr24083970oil.21.1687489350102;
        Thu, 22 Jun 2023 20:02:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a541500b0025695b06decsm377276pjh.31.2023.06.22.20.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 20:02:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCX46-00F5Rj-1u;
        Fri, 23 Jun 2023 13:02:26 +1000
Date:   Fri, 23 Jun 2023 13:02:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jeremy Bongio <bongiojp@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJULQjTpcRdEUHY8@dread.disaster.area>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
 <20230623023233.GC34229@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623023233.GC34229@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:32:33PM -0400, Theodore Ts'o wrote:
> On Thu, Jun 22, 2023 at 09:59:29AM +1000, Dave Chinner wrote:
> > Ah, you are testing pure overwrites, which means for ext4 the only
> > thing it needs to care about is cached mappings. What happens when
> > you add O_DSYNC here?
> 
> I think you mean O_SYNC, right?

No, I *explicitly* meant O_DSYNC.

> In a pure overwrite case, where all
> of the extents are initialized and where the Oracle or DB2 server is
> doing writes to preallocated, pre-initialized space in the tablespace
> file followed by fdatasync(), there *are* no post-I/O data integrity
> operations which are required.

Wrong: O_DSYNC DIO write IO requires the data to be on stable
storage at IO completion. This means the pure overwrite IO must be
either issued as a REQ_FUA write or as a normal write followed by a
device cache flush.

That device cache flush is a post-I/O data integrity operation and
that is handled by iomap_dio_complete() -> generic_write_sync() -> 
vfs_fsync_range()....

> If the file is opened O_SYNC or if the blocks were not
> preallocated using fallocate(2) and not initialized ahead of time,
> then sure, we can't use this optimization.

Well, yes. That's the whole point of the IOMAP_F_DIRTY flag - if
that is set, we don't attempt any pure overwrite optimisations
because it's not a pure overwrite and metadata needs flushing to the
journal. Hence we need to call generic_write_sync().

> What we might to do is to let the file system tell the iomap layer
> via a flag whether or not there are no post-I/O metadata
> operations required, and then *if* that flag is set, and *if* the
> inode has no pages in the page cache (so there are no invalidate
> operations necessary), it should be safe to skip using
> queue_work().  That way, the file system has to affirmatively
> state that it is safe to skip the workqueue, so it shouldn't do
> any harm to other file systems using the iomap DIO layer.
> 
> What am I missing?

You didn't read my followup email. IOMAP_F_DIRTY is the flag
you describe, and it already exists.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
