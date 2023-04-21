Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520006EAFBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjDUQyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjDUQya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:54:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479015455
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 09:54:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-524c7deb811so148711a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682095990; x=1684687990;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJjBJGEfJiS7YGgszLHv/hYXIaig0UdlIIh45n7z4Z8=;
        b=YkNT/0z3eyfTjfi1ClB+GrZTvG8lz3E50RTQieg2h6pQib5FvEfO+Rh80h0qhgZx2/
         a5Ntw1wGohaRwn3IEcR4K8iYnLIAdv2Gfs1uXuQJy+yDHgbjwKTCq57vStBUyXInYyFT
         YHBU5QBIw3AW06BfzWjcE06gA30l6q/+mVMTqrpMvYiC9BYIX4IqWpDpGwtGL/y7Wl8k
         wLnRGOt+ePzZ4K5XpL4JV6+DPXHpbPtafcSix9dtkdzkoNJkxq2NLeXkUUkGGIzbawFT
         jhIG9k/QDXglDRgT2X0G4qEChhRtHc0Yy7TdjyiX8dunsulgVXv5c1n2nqxN0MSc07Wb
         4Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095990; x=1684687990;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJjBJGEfJiS7YGgszLHv/hYXIaig0UdlIIh45n7z4Z8=;
        b=bOlyCGD5LgjF7Qy2OvEViwp+r0cFwvDCDTpdSQNJ8MAMb1PH2jQpRc60woHPRo93/u
         lU5myA+ETZSAR4KUQCWc/mIWDOEonZGwPEhS9eU5dmcGDLCR6yVbq6HMBMVki9h8OMV1
         lLLLhs40ShSVSvTXsz2oRbEMXQmkUnm2Ihh+4FqUDFA6CDy2hCbzZtsxah7IKA3Qsk1E
         RGhsOZNdxhvckC+Q8D0gjgnQBRyLfowX6/Y+hvj75TYx1UHUA0XuMVqxCU0TQ/XRvy3U
         QbjAHi5GrDnFC6p7EV2KGg1207d6gFFn8i7+RCSmENr9aBHDNXuwSIXPir6eMf+ECUaZ
         KDag==
X-Gm-Message-State: AAQBX9c6qeMSLLaRfihPOeYiAky2tpAJ2t4K1DYtDFgZ7kzVCZg2BwuO
        XajQpzKpUvzs/HAMoLck0crxHd8WLpI+Jh8rqM0=
X-Google-Smtp-Source: AKy350ZTen2cUopOLeGpkkSB7i7dL41K6pa9Gw5ccAzPMa5fhhJBPhG5/WdzpHjTaRoYTRC+jJ3klA==
X-Received: by 2002:a17:903:2447:b0:1a6:b196:619d with SMTP id l7-20020a170903244700b001a6b196619dmr6815727pls.6.1682095989578;
        Fri, 21 Apr 2023 09:53:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c08500b001a92a5703e1sm2983337pld.53.2023.04.21.09.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:53:09 -0700 (PDT)
Message-ID: <f16053ea-d3b8-a8a2-0178-3981fea5a656@kernel.dk>
Date:   Fri, 21 Apr 2023 10:53:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Turn single vector imports into ITER_UBUF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This series turns singe vector imports into ITER_UBUF, rather than
ITER_IOVEC. The former is more trivial to iterate and advance, and hence
a bit more efficient. From some very unscientific testing, ~60% of all
iovec imports are single vector.

One fixup patch from Josh since this was last posted, fixing a UACCESS
complaint that was due to the compiler optimization gone wrong where it
moves user_access_begin() outside of copy_compat_iovec_from_user().

This has been in linux-next for about a month without any complaints,
outside of the above mentioned UACCESS warning.

Please pull for 6.4-rc1!


The following changes since commit 3a93e40326c8f470e71d20b4c42d36767450f38f:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2023-03-27 12:22:45 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/iter-ubuf.2-2023-04-21

for you to fetch changes up to 50f9a76ef127367847cf62999c79304e48018cfa:

  iov_iter: Mark copy_compat_iovec_from_user() noinline (2023-04-12 10:46:48 -0600)

----------------------------------------------------------------
iter-ubuf.2-2023-04-21

----------------------------------------------------------------
Jens Axboe (11):
      block: ensure bio_alloc_map_data() deals with ITER_UBUF correctly
      iov_iter: add iter_iovec() helper
      IB/hfi1: check for user backed iterator, not specific iterator type
      IB/qib: check for user backed iterator, not specific iterator type
      ALSA: pcm: check for user backed iterator, not specific iterator type
      iov_iter: add iter_iov_addr() and iter_iov_len() helpers
      iov_iter: remove iov_iter_iovec()
      iov_iter: set nr_segs = 1 for ITER_UBUF
      iov_iter: overlay struct iovec and ubuf/len
      iov_iter: convert import_single_range() to ITER_UBUF
      iov_iter: import single vector iovecs as ITER_UBUF

Josh Poimboeuf (1):
      iov_iter: Mark copy_compat_iovec_from_user() noinline

 block/blk-map.c                          |  7 +--
 drivers/infiniband/hw/hfi1/file_ops.c    | 10 ++--
 drivers/infiniband/hw/qib/qib_file_ops.c |  4 +-
 drivers/net/tun.c                        |  3 +-
 drivers/vhost/scsi.c                     |  2 +-
 fs/btrfs/file.c                          | 11 ++--
 fs/fuse/file.c                           |  2 +-
 fs/read_write.c                          | 11 ++--
 include/linux/uio.h                      | 57 ++++++++++++++------
 io_uring/net.c                           |  4 +-
 io_uring/rw.c                            | 35 ++++++-------
 lib/iov_iter.c                           | 89 +++++++++++++++++++++-----------
 mm/madvise.c                             |  9 ++--
 sound/core/pcm_native.c                  | 26 ++++++----
 14 files changed, 165 insertions(+), 105 deletions(-)

-- 
Jens Axboe

