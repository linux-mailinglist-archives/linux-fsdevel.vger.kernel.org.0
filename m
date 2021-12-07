Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8D46BCCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhLGNs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:48:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbhLGNsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:48:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C286B81780;
        Tue,  7 Dec 2021 13:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E38C341C6;
        Tue,  7 Dec 2021 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638884693;
        bh=VWZwdejKx7PPrjk3lilaaf8u4BirAg/pTnuC00wRfug=;
        h=From:To:Cc:Subject:Date:From;
        b=qeYh5eWcsrhoIDck+1YGc/1MSQcR8gaF3DOKYSF3in08+C/zsH/UswXB3ZAkr7dd2
         c+R4EBSnHX/VscKSoUfPH0KP1U+MPuKzCRSo8Ah70BLrEZZPI6bOoBjZk8in67UySw
         DveG1w85q2pzcE5YI6zVGPW8tzlyeYpsZQ6oseYp1t4Oxju+XlM5zrlZ9XbaRNBtaa
         h91cFH2bkBHn98CTw2+m7/9p9qyfNYWCzL2Uf8jK0pABbeWHcch07qOuQPgcUqIIn+
         my3W2GZ+47Qd4KkBuCLod4UhWnBcz54a3ydmArhtMQfMnHOQLMgi19sawZqI7To3p7
         I1NKFjHFhODqA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-cachefs@redhat.com
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ceph: adapt ceph to the fscache rewrite
Date:   Tue,  7 Dec 2021 08:44:49 -0500
Message-Id: <20211207134451.66296-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2: address David's review comments
    remove ceph_fscache_list infrastructure

This is a follow-on set for David Howells' recent patchset to rewrite
the fscache and cachefiles infrastructure. This re-enables fscache read
support in the ceph driver (which is disabled by David's patchset), and
also adds support for writing to the cache as well.

Jeff Layton (2):
  ceph: conversion to new fscache API
  ceph: add fscache writeback support

 fs/ceph/Kconfig |   2 +-
 fs/ceph/addr.c  | 101 +++++++++++++++++-----
 fs/ceph/cache.c | 218 +++++++++++++-----------------------------------
 fs/ceph/cache.h |  97 ++++++++++++++-------
 fs/ceph/caps.c  |   3 +-
 fs/ceph/file.c  |  13 ++-
 fs/ceph/inode.c |  22 +++--
 fs/ceph/super.c |  10 +--
 fs/ceph/super.h |   3 +-
 9 files changed, 237 insertions(+), 232 deletions(-)

-- 
2.33.1

