Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84C7BD129
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 01:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbjJHX1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 19:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbjJHX1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:27:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EC8AB
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 16:27:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27760c31056so2269424a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696807652; x=1697412452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aS5wnORfWJ02Ic4UlNgXgG7erca/6rPk7A+dIWgu1xE=;
        b=ar+F8kCJJYhocpH7678ttAXERmoI3yDavLymH+R8n+35dyDP58p8hJzK8gVAcQnWwh
         RirkN49+Qt+O1zUgU1OfDzkBhTeE7796uHFvZHa0gFv1zP8QKIuNAFcbsljod+Gb60La
         MiIgpSGI49duQ1w0jRtwOZUBq8c/h1RdDsSXqtVptZrGgUVqObEK4jKbEN+3G+hlm0ml
         ePJVD+GKPlQoTH1agTEdIi2/BnJZj1h1L0HyVx2nEp9mWs0vsmmgb5Sk3UHSkc6v7D73
         BYJ099PQo8RtsN0oxQog8POX7NVf/yv46dlGYNpDNeCGi8L0E4fi7PhSIhNw4HyeN8f9
         AY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696807652; x=1697412452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS5wnORfWJ02Ic4UlNgXgG7erca/6rPk7A+dIWgu1xE=;
        b=bRObF2Rm7JlgCVGrXyg1hnPIvIAPOPQIWmEuMIgv+3V0/DgoQgD/t4/fAiGhyMc3dr
         dc6VJz3tCgMgI1lCbxnsIpirVvLtzVGl/5nqjCSdc8Pv0SnAhUMVXaRlNL7fUQf2LYzU
         jeMl5SrkGdvUDpfbUxICK6SAO24OgvgQu/hvw659yjocozTz4ap9dCdVAJaLONmVYcO5
         oHi5adtjVTXbA+BezhhGjSPdMhK8IDvGo1RLdUIFI1JdctUjWEEUBxmIGFtf8KPL/+8Z
         PM+sHEDnNzMBF7i4SxXTfYDNPrUw9/um5GO50bWL39V1n83QnxlwogByExI+9OXDusoj
         qtbQ==
X-Gm-Message-State: AOJu0YymNxmB201d7J+neB0bS0Fvg7CiexdmPqXvLr5M/ChQcegky/7j
        W90Yplm+WlRMArvFFMURr7idMg==
X-Google-Smtp-Source: AGHT+IGc6rajtNnnrMTfh5c1WN82wupHs7ltG+HbFIhM8I8+f4cQIL9QXxrn5Dk/ibag1JxJfP4QTg==
X-Received: by 2002:a17:90b:4b06:b0:273:e689:8dfc with SMTP id lx6-20020a17090b4b0600b00273e6898dfcmr11740281pjb.32.1696807652373;
        Sun, 08 Oct 2023 16:27:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id az12-20020a17090b028c00b0026d4100e0e8sm6954450pjb.10.2023.10.08.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:27:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdBI-00BHvI-0p;
        Mon, 09 Oct 2023 10:27:28 +1100
Date:   Mon, 9 Oct 2023 10:27:28 +1100
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
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
Message-ID: <ZSM64EOTVyKNkc/X@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-6-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> annotate unshare requests to underlying layers. Layers that support
> FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> fallocate() mode to use.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-lib.c           |  6 +++++-
>  block/fops.c              |  6 ++++--
>  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
>  include/linux/blk_types.h |  3 +++
>  include/linux/blkdev.h    |  3 ++-
>  5 files changed, 43 insertions(+), 10 deletions(-)

I have no idea how filesystems (or even userspace applications, for
that matter) are supposed to use this - they have no idea if the
underlying block device has shared blocks for LBA ranges it already
has allocated and provisioned. IOWs, I don't know waht the semantics
of this function is, it is not documented anywhere, and there is no
use case present that tells me how it might get used.

Yes, unshare at the file level means the filesystem tries to break
internal data extent sharing, but if the block layers or backing
devices are doing deduplication and sharing unknown to the
application or filesystem, how do they ever know that this operation
might need to be performed? In what cases do we need to be able to
unshare block device ranges, and how is that different to the
guarantees that REQ_PROVISION is already supposed to give for
provisioned ranges that are then subsequently shared by the block
device (e.g. by snapshots)?

Also, from an API perspective, this is an "unshare" data operation,
not a "provision" operation. Hence I'd suggest that the API should
be blkdev_issue_unshare() rather than optional behaviour to
_provision() which - before this patch - had clear and well defined
meaning....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
