Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC274D3EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiCJBpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 20:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiCJBpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:45:04 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59935C67E;
        Wed,  9 Mar 2022 17:44:04 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v189so3337336qkd.2;
        Wed, 09 Mar 2022 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YOWNP2zzHTw3dbeG4llG6qXcH9VHij0L+WFqzm7D9SM=;
        b=AJ8XdpRUAnJ7Xh3ExRleoa/RVBd0HMYY2LRizbSA+8DMbitvCXWiu2crllKJnCVM+Q
         VTt6bqDlC6cgKJO9DrQwfnDoA6iztmY38K54LD7EIuZleMJvphxpBp6HYDgRa6Us3CW9
         qgQ++09XF6pNKYOyNxSRYo2kDJbsPI4AdVfeQnLeTSzwKE1/kk8Ed8S8tHnG3KMCesea
         l7ybev1as7tWJNegVR07djyOy/C/MkaTPUCdMUATGVWqMfYDmYFAhDij3v7SNSN7T1O1
         KWZZSWXiWPSPv2PG5UKFPxs3MvOnEJ6F84AvQqE/jqTb+RH2FQ3+KQdxGzIKkGKy3ds4
         7XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YOWNP2zzHTw3dbeG4llG6qXcH9VHij0L+WFqzm7D9SM=;
        b=MROw2spRztqtTEOCKcCBtCXnHYQWVOlN/qnDz2ZHi3t2Nb6gy7HZJUM+oy4426LtLD
         Uiorq/drXdwKO9o+8otqtu8CRZT+ht9vhaOu1JUb6vngudsBRkywEggiQ9YmG14bBMsd
         xI2cSaQDTUYCJYpbHdkofWq56MdKTbGSMYn9A2mRo2IjZ3Wt0jmgfvqF1XCdf5T/CnKM
         JmhUMk6jaqmbdDJKAyhN07vFTVRptxhTxCac6ujzuejLavv9G/cDE8s9t7CIKbhDPDM8
         849vRieBXql71iuYlqxGAm14LUFmyG3Hq5XkRdSOIalXKnMp8EKHLxmjGsOxcux6TbCK
         7u+Q==
X-Gm-Message-State: AOAM530oRoBvljEueb1qR2R4QIAXoQQnw1mQtGVMfVNKLFipcPOW3G0d
        9hjLhn/qDaOKUhbJ1ScQLrkWg4C1zg==
X-Google-Smtp-Source: ABdhPJwyBzx3gVtRc5ghy6630MXm7ah9PqoE5Zyxyd2HzMrgC1vlUeAYo89jMZGvE4tM6NnKLAmjkg==
X-Received: by 2002:a05:620a:1181:b0:60d:f3ab:595f with SMTP id b1-20020a05620a118100b0060df3ab595fmr1675397qkk.275.1646876643372;
        Wed, 09 Mar 2022 17:44:03 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j20-20020a37a014000000b0067b3a0c7d89sm1693037qke.38.2022.03.09.17.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:44:02 -0800 (PST)
Date:   Wed, 9 Mar 2022 20:44:00 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Significant brokenness in DIO loopback path
Message-ID: <YilX4PHgulMi3vhb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I'm testing bcachefs with the loopback driver in dio mode, and noticing
_significant_ brokenness in the bio_iov_iter_get_pages() path and elsewhere.

1) We don't check that we're not asking for more pages than we're in the
original bio

Noticed this because of another bug:

2) the loopback driver appears to never look at the underlying filesystem's
block size, meaning if the filesystem advertises a block size of 4k the loopback
device's blocksize will still be 512, and we'll end up issuing IOs the DIO path
shouldn't allow due to alignment.

3) iov_iter_bvec_advance() looks like utter nonsense. We're synthesizing a fake
bvec_iter and never using or even looking at one from the original bio, looking
at the construction in iov_iter_bvec().

This is broken; you're assuming you're never going to see bios with partially
completed bvec_iters, or things are going to explode.

Try putting a md raid0 on top of two loopback devices with a sub page block
size, things are just going to explode.

iov_iter_bvec() needs to be changed to take a bio, not a bvec array, and
iov_iter_bvec_advance() should probably just call bio_advance() - and
bio_iov_bvec_set() needs to be changed to just copy bi_iter from the original
bio into the dest bio. You guys made this way more complicated than it needed to
be.
