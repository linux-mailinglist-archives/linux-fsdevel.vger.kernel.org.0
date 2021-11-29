Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A7462127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbhK2T7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348799AbhK2T5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:57:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26529C07CA27;
        Mon, 29 Nov 2021 08:29:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2DC7B80E60;
        Mon, 29 Nov 2021 16:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4036C53FC7;
        Mon, 29 Nov 2021 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638203349;
        bh=+1M+cQu0R0D7PANew6bW+Happ/3HJm87Usu6RHYEbxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S1t4BNFH67qHwnVm+sjniIVq1RaDe3TTZr8ez6AXKqI5wu5WrN8KDCs9rdqgCXANd
         Rp5I9lYN0h74XQBuvaS6kEab3oMlagyIPZaNyusvzeEWSGCeecaALelHDPg5mwXWoE
         mKnLncafwkwQd8i3260eejvQVItkoEA7uwjkMwitxtne3Sq+f/1IihBicRB5EBc/zC
         DmbOmick3gBnm1OVoO2ucmTLndu7rf3uAsGowy12RrUlBAFEHmpz+sr2a4TW9XKnvX
         k8Ob3RElkpX39f5s+GnaeK+ZTQBwyefG9tvajU4jn1fwCn+fokYmx9Ga/UZrySgKwj
         Uiad1IByDmhSA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ceph: adapt ceph to the fscache rewrite
Date:   Mon, 29 Nov 2021 11:29:05 -0500
Message-Id: <20211129162907.149445-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a follow-on set for David Howells' recent patchset to rewrite
the fscache and cachefiles infrastructure. This re-enables fscache read
support in the ceph driver, and also adds support for writing to the
cache as well.

What's the best way to handle these, going forward? David, would it be
easier for you to carry these in your tree along with the rest of your
series?

Jeff Layton (2):
  ceph: conversion to new fscache API
  ceph: add fscache writeback support

 fs/ceph/Kconfig |   2 +-
 fs/ceph/addr.c  |  99 +++++++++++++++++++------
 fs/ceph/cache.c | 188 ++++++++++++++++++++----------------------------
 fs/ceph/cache.h |  98 +++++++++++++++++--------
 fs/ceph/caps.c  |   3 +-
 fs/ceph/file.c  |  13 +++-
 fs/ceph/inode.c |  22 ++++--
 fs/ceph/super.c |  10 +--
 fs/ceph/super.h |   2 +-
 9 files changed, 255 insertions(+), 182 deletions(-)

-- 
2.33.1

