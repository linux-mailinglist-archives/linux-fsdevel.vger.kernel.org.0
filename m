Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A427BD141
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 01:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjJHXh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbjJHXh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:37:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1486DA2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 16:37:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69101022969so3566535b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696808275; x=1697413075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugb0tKKwENhwxws0wCM1fp+8N3X07t18Hh39dqaZxsY=;
        b=i6rflzQbi/038L6+lC+4cUcrEeXOp3kLrxxxQkkpm+XKiRmMlh2gDv9qAtq3W5cKVM
         0gWKbrrvMWiF2SRAClOcPd7sguDFRsqXBjEOI0SvOIYoAHdw6l15PTm9ElrFIifufYgU
         pbpS4v/zl1umpRnvfcXwCKln4XJfk+BbgmXzFpkdQdLXRcaW4Skkk56hgWlxy1m2yxHA
         aaSDWjBE92yKdOmQKLJPpef6qPZ+8cgXQxDnryUGP6QfrRhQk6a+TGaujSQ8AeMYGxnO
         utKIJZUKKNMV2AoUnX+YlfrMozbwMUHJOWSqHW9KFguBwMR2aKLQjtO8Wef1t1iNd2ol
         zGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696808275; x=1697413075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugb0tKKwENhwxws0wCM1fp+8N3X07t18Hh39dqaZxsY=;
        b=A+4aK1HQSj2hkfoavu6/1Cjha3XU7Jy7yECz5vi7gszMSZXUw3o1gMZ9yy08uAhoYP
         ZVNWFG5VEtWTREOw8q46qrOgOd5WbFReUWE8eVDUCbdRWvXm5CYYMVXa5PRag1dh0yF3
         K8G2HUAh4YCUeOtFkR4EABp3sCKTMrpm8fNkvKew+rm8dJn/i6eEEyd1LIvQs36z2Yp0
         nG0nMIVRPFmCv/A616pE7kCRPth7P87gc1GuVR6JFYskyCtovWg+yv0RZQqMVXANqmxF
         pLUzYcVcaHF3q+taD3GsdTT0f4wQk87MXGguhH6JVlUHKQoNIw/e4xZpFvSd9K1gOCi/
         P+3g==
X-Gm-Message-State: AOJu0YyhzD1QrvNTyqaE8yZEQAXpE1HmL9RCFgQAKazV/7SLV2PGpKMv
        lUoJlR3/8Q3ji13QeH8DE5Ehcg==
X-Google-Smtp-Source: AGHT+IGtSDlJuSlhM5b245J5Cmp3FU0as25Fi5QlSTltQv1K/y0QGdGqfOnc1SLtt6Qt6+3EetsZOQ==
X-Received: by 2002:a05:6a00:1912:b0:690:d2b0:1b37 with SMTP id y18-20020a056a00191200b00690d2b01b37mr18093157pfi.10.1696808275521;
        Sun, 08 Oct 2023 16:37:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b00693498a847fsm5047054pfi.137.2023.10.08.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:37:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdLM-00BI5X-0f;
        Mon, 09 Oct 2023 10:37:52 +1100
Date:   Mon, 9 Oct 2023 10:37:52 +1100
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
Subject: Re: [PATCH v8 3/5] loop: Add support for provision requests
Message-ID: <ZSM9UDMFNs0050pr@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-4-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-4-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:28:15PM -0700, Sarthak Kukreti wrote:
> Add support for provision requests to loopback devices.
> Loop devices will configure provision support based on
> whether the underlying block device/file can support
> the provision request and upon receiving a provision bio,
> will map it to the backing device/storage. For loop devices
> over files, a REQ_OP_PROVISION request will translate to
> an fallocate mode 0 call on the backing file.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>


Hmmmm.

This doesn't actually implement the required semantics of
REQ_PROVISION. Yes, it passes the command to the filesystem
fallocate() implementation, but fallocate() at the filesystem level
does not have the same semantics as REQ_PROVISION.

i.e. at the filesystem level, fallocate() only guarantees the next
write to the provisioned range will succeed without ENOSPC, it does
not guarantee *every* write to the range will succeed without
ENOSPC. If someone clones the loop file while it is in use (i.e.
snapshots it via cp --reflink) then all guarantees that the next
write to a provisioned LBA range will succeed without ENOSPC are
voided.

So while this will work for basic testing that the filesystem is
issuing REQ_PROVISION based IO correctly, it can't actually be used
for hosting production filesystems that need full REQ_PROVISION
guarantees when the loop device backing file is independently
shapshotted via FICLONE....

At minimuim, this set of implementation constraints needs tobe
documented somewhere...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
