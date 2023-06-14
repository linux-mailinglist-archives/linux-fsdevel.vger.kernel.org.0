Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8D73011F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbjFNODu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjFNODt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:03:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEFCD;
        Wed, 14 Jun 2023 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Dxv9yZH5Cq3a68CFMHSbxe2K3jCtV+ECrt+k1qx7EHA=; b=sG9nO9EBC4wDI7ERlLrcD9lQur
        FlaE1RloXVDpRiK4nl6U6eZlN7VOIy6qOoHr0nNLkhYCwN5mQ4UCBf2NaOvpJGcXv6YZlNvhuBYZy
        OLeU7PKHpcKPDmUK62QHCAsDlkwXMMiiULUHg2cVuW6oo0TgY06gNLibbC4oVXBAUEIxn8K+z67QE
        AmgLm/ZXn+j5w68/PaPlXvzoPgDBZifO1FZxOuP3vWRFQn29nXiZrVsaSnAfDziPk1Uyw02ZqhjKT
        o0OzQ8cgirNgNNHsAke4MRbYngh2gNykkp6L+CsioJLbv4J1DGuPsGgPQq0qbb9bVhkRY0huZALvB
        hxSmkpsA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R69-00Br8z-2T;
        Wed, 14 Jun 2023 14:03:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: dio / splice fixups
Date:   Wed, 14 Jun 2023 16:03:37 +0200
Message-Id: <20230614140341.521331-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series has a small fix and a bunch of cleanups on top of the
splice and direct I/O rework in the block tree.

 block/blk.h               |    2 --
 fs/splice.c               |   15 +++++++--------
 include/linux/bio.h       |    3 +--
 include/linux/blk_types.h |    1 -
 include/linux/uio.h       |    6 ------
 lib/iov_iter.c            |   35 +++++++----------------------------
 6 files changed, 15 insertions(+), 47 deletions(-)
