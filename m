Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02A716700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjE3P2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjE3P2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:28:48 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26442F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:28:03 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6261a61b38cso14350516d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685460482; x=1688052482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YR3Dr4CMzNNzM1c3LGHePU3pSGMOwf2n9BmkTIJqoZY=;
        b=FF6oR374aNkaI1JwmCriJdpBB4Eqrub1vceJJwEA9iFDIk/hJWeKtFDvyxVqEpBgwW
         I/xNyyJNuIkvYihHVHmy41FpYbMS9gailLZ/5M4+Sw3ro5Vj9YrORHU2GV12cIvjoDbg
         P3WiZr6e/k+ebT05GJLHW7+w7LRTP1Z1yABONecFwvzh2PId8FjVFt1QOXv69t6x2eDB
         5YjQLFd55TyT9YbA39GaXSMsxMoayHxL59MYgGeBUzfGqjY/t5gpcKrH7w0YBiIdhquK
         xNaA/hSVtAoSt2bIvB0cY5d1VSq2PYxTr9FarUoThR25OQjhgOYVQ1o8FY32O27E/gXs
         VRpw==
X-Gm-Message-State: AC+VfDztTAvd/d0YhKZuAoz43sMyk1lgVr15mSib/tF5CfZiWiBdThIv
        UZ+scY0fdAi4EFoUuYyhvK3O
X-Google-Smtp-Source: ACHHUZ55tRVn6w2eePAhc6/qm8CJME6WENqz9zraKI3ZQacG7/5mnhJynvxY+ok00f1xtu5eZcDZQA==
X-Received: by 2002:ad4:5ae4:0:b0:625:aa1a:9384 with SMTP id c4-20020ad45ae4000000b00625aa1a9384mr2941055qvh.64.1685460482224;
        Tue, 30 May 2023 08:28:02 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a15cc00b0074d489e517csm4106298qkm.24.2023.05.30.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:28:01 -0700 (PDT)
Date:   Tue, 30 May 2023 11:28:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Joe Thornber <thornber@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHYWAGmKhwwmTjW/@redhat.com>
References: <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30 2023 at 10:55P -0400,
Joe Thornber <thornber@redhat.com> wrote:

> On Tue, May 30, 2023 at 3:02 PM Mike Snitzer <snitzer@kernel.org> wrote:
> 
> >
> > Also Joe, for you proposed dm-thinp design where you distinquish
> > between "provision" and "reserve": Would it make sense for REQ_META
> > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > more freedom to just reserve the length of blocks? (e.g. for XFS
> > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > reserve space to accomodate it).
> >
> 
> My proposal only involves 'reserve'.  Provisioning will be done as part of
> the usual io path.

OK, I think we'd do well to pin down the top-level block interfaces in
question. Because this patchset's block interface patch (2/5) header
says:

"This patch also adds the capability to call fallocate() in mode 0
on block devices, which will send REQ_OP_PROVISION to the block
device for the specified range,"

So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
user of XFS could then use fallocate() for user data -- which would
cause thinp's reserve to _not_ be used for critical metadata.

The only way to distinquish the caller (between on-behalf of user data
vs XFS metadata) would be REQ_META?

So should dm-thinp have a REQ_META-based distinction? Or just treat
all REQ_OP_PROVISION the same?

Mike
