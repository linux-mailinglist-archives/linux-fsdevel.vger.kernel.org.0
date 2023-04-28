Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D436F1149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjD1FYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 01:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbjD1FY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:24:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED01BFA
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 22:24:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a68d61579bso70561195ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 22:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682659466; x=1685251466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tT+FnXXVAfiL2lANfau8hR1k0QdF35mbhRvcLTl8f8=;
        b=tyZtkQYqVjHIc1EEnxVQCQG4Tldpi8hGhievTL1QX2Rkc71hGXqhO9HENHkeUSKGnc
         B61ELQorVwh5O7/rO7z5fQk8mrRW0cvfCtxYqgxvqsi5u0BxK6zAKnGpq5NAkGP/VD/V
         YcgarWZGxc2icbaGM3rZ5saUPcmMyaRB04AUDhEy+jo1UICcdQ8mgRmIalPW0J3ZEMDF
         mxLLYpUJsDW/xrgPFLUGzMg3fv13ONzzBYPG4W+dEZXJlh6fYHvFQEaM+tknxaB24AmI
         xmvwdHeqM776thiHX7JFp2Dxwaf7lEGabm8M7boBdeZJsFFkdhlrl0FkGUSvbHnrZO9G
         5nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682659466; x=1685251466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tT+FnXXVAfiL2lANfau8hR1k0QdF35mbhRvcLTl8f8=;
        b=HblnWsh8rLE97Z/Hk+9wINlfA1iyiZ4ii1tdloDZsM5hoCIHQdSNFuHtuDEaqrnbQk
         pjmxTXaTDIgpLl2jwlWc6+H2dDQxNK+iJp5gl+BUd405kkTO8Oipf1qVW5QfqFl7qHOQ
         bld/CRd7Ue7zMLMxPKtX5ZYIMRKz5Qm7Lihy9EcyNSdzNOgYZ+7BXCJ6lKm1hQg+nZrd
         nUcFn+QY81YHaRBIOgtTz0nOQULvzaNZMi44xaYKCz/qZGHRC5JTwXhtNSHGMYWmtrl2
         rcYnoTbT9MqLmCDMq7NhYmRyOF+zKlTLXBfAOQgWvHbUxGc5YTWYCzAJNFS/NmZ5W2c+
         P1Ng==
X-Gm-Message-State: AC+VfDzgFZLsj4DABE0OJ38gEV2fvF1lA2C+zwz9mc2PVgDcJNTi3jlH
        yWw4noGRhgFwkArKr6WaxAGGNAjA8PLtcO+YM64=
X-Google-Smtp-Source: ACHHUZ510rI5TRspLV3WEivPBLF6owNABSCj5GOJiTfryVmfvTBWvFbt5DnvD96jcRuz8RSV72EplQ==
X-Received: by 2002:a17:902:fb8f:b0:1a1:defc:30d8 with SMTP id lg15-20020a170902fb8f00b001a1defc30d8mr3489595plb.32.1682659465786;
        Thu, 27 Apr 2023 22:24:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902a50d00b001a64ce7b18dsm12476240plq.165.2023.04.27.22.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 22:24:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1psGak-008l7h-7i; Fri, 28 Apr 2023 15:24:22 +1000
Date:   Fri, 28 Apr 2023 15:24:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <dchinner@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <20230428052422.GB1969623@dread.disaster.area>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEsGQFN4Pd12r+Nt@rh>
 <ZEs1za7Q0U4bY08w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEs1za7Q0U4bY08w@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 03:56:13AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 28, 2023 at 09:33:20AM +1000, Dave Chinner wrote:
> > The block device needs to be shutting down the filesystem when it
> > has some sort of fatal, unrecoverable error like this (e.g. hot
> > unplug). We have the XFS_IOC_GOINGDOWN ioctl for telling the
> > filesystem it can't function anymore. This ioctl
> > (_IOR('X',125,__u32)) has also been replicated into ext4, f2fs and
> > CIFS and it gets exercised heavily by fstests. Hence this isn't XFS
> > specific functionality, nor is it untested functionality.
> > 
> > The ioctl should be lifted to the VFS as FS_IOC_SHUTDOWN and a
> > super_operations method added to trigger a filesystem shutdown.
> > That way the block device removal code could simply call
> > sb->s_ops->shutdown(sb, REASON) if it exists rather than
> > sync_filesystem(sb) if there's a superblock associated with the
> > block device. Then all these 
> 
> I think this is the wrong approach.  Not that I've had any time to
> work on my alternative approach:
> 
> https://www.infradead.org/~willy/banbury.html

While that looks interesting, I'm going to say straight out that
re-attaching a storage device that was hot-unplugged from under a
running filesystem and then resuming service as if nothing happened
is going to be both a filesystem corruption vector and a major
security hole.

The moment a mounted device is unexpectedly unplugged, it becomes an
untrusted device.  We cannot trust that it's contents when plugged
back in are identical to when it was unplugged.  I can't wait for
syzbot to learn that it can mount a filesystem, hot-unplug the
device, fuzz the image on the device and then plug it back in and
expect the filesystem to handle the in-memory vs on-disk
inconsistencies that result from the fuzzing. it's basically no
different to allowing someone to write to the block device while the
filesystem is mounted. You do that, you get to keep all the broken
bits to yourself.

Even without image tampering considerations, there's no guarantee
that the device caches are flushed properly when someone just pulls
the plug on a storage device. Hence even without tampering, we
cannot trust the image on the device to match what the in-memory
state of the filesystem expects it to be.

So, yeah, I just don't see this ever being something we'd support
with filesystems like XFS - there's just too much risk associated
with untrusted devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
