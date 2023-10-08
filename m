Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198AB7BD153
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbjJHXuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 19:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbjJHXuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:50:19 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E726A2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 16:50:18 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b5f0d658dso2412459eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696809018; x=1697413818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2nXJZN5gQs0HWJ4/hq5HXlGZoe48+E1mQuJOq50Cgo=;
        b=Qv1HcZ6NshubHwtj9ScreZmr08seV+3L7OYsOV452x64pvrSlOEYQzOx/VM7dCZS5Q
         rOoPlTtQQ0EOgKhQq4myGK024HPbVPGt4PVwVDxqlMoLQIffFsY9F18fZQm3EzgYRU8+
         01YwJ73c69/EV2ZIGoFhwkvIXMo8ErJMEGGOno4tomeg3/v60lXH+seyAkA1CkoHcXLA
         qlTrFQ8gHmK/qiqrw+cODqh90FVz4aZdLkRn0hFK3wD1S6SmAa03GKTk9oz4Qy9DHQD1
         3ffPqLBo/PZqGvi/E81Op6wnIOp98naKmEwfkRbcQHH/LHp+d30P1kJnj0gQvFwO2dtg
         mWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696809018; x=1697413818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2nXJZN5gQs0HWJ4/hq5HXlGZoe48+E1mQuJOq50Cgo=;
        b=Vm+xDAKV5eVWoGZpt+StIuteAqClOkobGLA7DnKKAxnQv6BDAqMBmRo4hxW0HKWjb9
         WZNDEd9lT30jIEEzLWUK0iZnwwg3E2FkO3SORjLSGE0BnfVDIzInY4NQL/AqpRJ8xT+V
         /gKvddtk8rghoZ0IgV6SDA2DrKZ+qcUtn5liug5TKzFi9P4QA/1WlvKaU8kGlLWKZrZM
         FyenspxUAjyUuahrY1VF9VJ5V8GPwI7Kc8FZNjg5pLQSUS8fVvsDiyrxQAn3H4Fq5WKF
         9uwEw8D8vfT0o8tbq+JJCn74B+6rc+TwqADE8Y6hfXf8i6GoHxMHSFdCwXsxM8Aen7RU
         cG9A==
X-Gm-Message-State: AOJu0YwI8YMimMg0d7LN8Ge8e5uzqDRcBvjsckyD18QPl934gWjVj8ed
        e9PDNQekDAQnlrDIShwvkarSHw==
X-Google-Smtp-Source: AGHT+IFfwMQn/LIz0fT9Fj7uLEIoUwAbkj1YKSVtQkmCaXkvkIj17Ot1p/KFHLEdYyOotJzHAl0xtw==
X-Received: by 2002:a05:6358:278c:b0:143:8084:e625 with SMTP id l12-20020a056358278c00b001438084e625mr14782727rwb.11.1696809017793;
        Sun, 08 Oct 2023 16:50:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a035500b002796494b98csm9815038pjf.37.2023.10.08.16.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:50:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdXK-00BIFK-0u;
        Mon, 09 Oct 2023 10:50:14 +1100
Date:   Mon, 9 Oct 2023 10:50:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 0/5] Introduce provisioning primitives
Message-ID: <ZSNANlreccIVXuo+@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:28:12PM -0700, Sarthak Kukreti wrote:
> Hi,
> 
> This patch series is version 8 of the patch series to introduce
> block-level provisioning mechanism (original [1]), which is useful for provisioning
> space across thinly provisioned storage architectures (loop devices
> backed by sparse files, dm-thin devices, virtio-blk). This series has
> minimal changes over v7[2].
> 
> This patch series is rebased from the linux-dm/dm-6.5-provision-support [1] on to
> (cac405a3bfa2 Merge tag 'for-6.6-rc3-tag'). In addition, there's an
> additional patch to allow passing through an unshare intent via REQ_OP_PROVISION
> (suggested by Darrick in [4]).

The XFS patches I just posted were smoke tested a while back against
loop devices and then forward ported to this patchset. Good for
testing that userspace driven file preallocation gets propagated by
the filesystem down to the backing device correctly and that
subsequent IO to the file then does the right thing (e.g. fio
testing using fallocate() to set up the files being written to)....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
