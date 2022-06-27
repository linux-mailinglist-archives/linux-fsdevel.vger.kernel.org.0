Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40B455CA31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiF0Pyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiF0Pyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FEE26D1;
        Mon, 27 Jun 2022 08:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9878F61614;
        Mon, 27 Jun 2022 15:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA58C3411D;
        Mon, 27 Jun 2022 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656345292;
        bh=tTXs91iRHI9lRtMG4RcqQbNNSvp+e/+A2/LA87t/swU=;
        h=From:To:Cc:Subject:Date:From;
        b=NdQmWWBCduXh40aieicVM8QFo5jkCmokeYDvymukS89iMzqHHZ6kLJPX3kzdxaWbe
         5ZNgR4t1kRzExD4ieHJiPeX3pAN9qXNILRspSbwTOK8PTA353TQ9rxAdbKLoY6d0CI
         v/+uUuvGmP3XxzJfet5sTMqJlymv42HvsP6tsDPcQq4CKIrJkYlqoymB2tV9hOkfiC
         W+oJOURlz1EzeEOfMTRg8PNNEk53sv4HRJF6opkiyug8nodFRvBr5QFBkvVIR8PSXz
         lOjCruVYMWKG1GP22PismwQhwm0Zv1RvvpDSDfbCdI1ky37YoturSHkFBb2OOeN6LO
         CYuS3MZ3ikN+A==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] libceph: add new iov_iter msg_data type and use it for reads
Date:   Mon, 27 Jun 2022 11:54:47 -0400
Message-Id: <20220627155449.383989-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2:
- make _next handler advance the iterator in preparation for coming
  changes to iov_iter_get_pages

This is an update to the patchset I sent back on June 9th. Since then,
Al informed me that he intends to change iov_iter_get_pages to advance
the iterator automatically. That changes the implementation a bit, in
that we now need to track how far the iov_iter leads the cursor at any
given time.

I've tested this with xfstests and it seems to behave. Cover letter
from the original posting follows.

------------------------8<-------------------------

This patchset was inspired by some earlier work that David Howells did
to add a similar type.

Currently, we take an iov_iter from the netfs layer, turn that into an
array of pages, and then pass that to the messenger which eventually
turns that back into an iov_iter before handing it back to the socket.

This patchset adds a new ceph_msg_data_type that uses an iov_iter
directly instead of requiring an array of pages or bvecs. This allows
us to avoid an extra allocation in the buffered read path, and should
make it easier to plumb in write helpers later.

For now, this is still just a slow, stupid implementation that hands
the socket layer a page at a time like the existing messenger does. It
doesn't yet attempt to pass through the iov_iter directly.

I have some patches that pass the cursor's iov_iter directly to the
socket in the receive path, but it requires some infrastructure that's
not in mainline yet (iov_iter_scan(), for instance). It should be
possible to something similar in the send path as well.

Jeff Layton (2):
  libceph: add new iov_iter-based ceph_msg_data_type and
    ceph_osd_data_type
  ceph: use osd_req_op_extent_osd_iter for netfs reads

 fs/ceph/addr.c                  | 18 +------
 include/linux/ceph/messenger.h  |  8 ++++
 include/linux/ceph/osd_client.h |  4 ++
 net/ceph/messenger.c            | 85 +++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c           | 27 +++++++++++
 5 files changed, 125 insertions(+), 17 deletions(-)

-- 
2.36.1

