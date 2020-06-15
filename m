Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B911F961B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgFOMNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgFOMNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD0C05BD43;
        Mon, 15 Jun 2020 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xzGnO7Qbq58zCNVikkUAnPHV2G1FQXlUBEIRLHKX6/A=; b=S0z4zwQ92IVio5atTm9Y+oOJ5/
        26d+snthIC1QQ/kE7ld2lOMKR8h8b7ewu7JU/OuuXAPRdGFSboIvp7fPDsl6uQSUdFR51KBspgaBj
        fu32ZCqFZAcmtWwbuDS5P913Qreza3Id2RSmi4q7jImfp8n9PIsdIJCdtCDCTK3rVoPQ+8xPNTGIA
        tjhka44LxeFefkUcEaxDnMXX7Wo0QvOwIgtdAibrTZXa2yUaM1B4NCmbsPo2h48A2DJ2QraRgGNBu
        s18IL5cmNnWZcO1/8zqcnHZLQwmGzl6dNyuDfYs3nyEiF6uTbJGXzRjWEPKLwRm+4DYkuzusvBHUy
        6pZiB8NQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknz2-0006z0-1J; Mon, 15 Jun 2020 12:13:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: clean up kernel_{read,write} & friends v4
Date:   Mon, 15 Jun 2020 14:12:44 +0200
Message-Id: <20200615121257.798894-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

this series fixes a few issues and cleans up the helpers that read from
or write to kernel space buffers, and ensures that we don't change the
address limit if we are using the ->read_iter and ->write_iter methods
that don't need the changed address limit.

I did not add your suggested comments on the instances using
uaccess_kernel as all of them already have comments.  If you have
anything better in mind feel free to throw in additional comments.


Changes since v3:
 - keep call_read_iter/call_write_iter for now
 - don't modify an existing long line
 - update a change log

Changes since v2:
 - picked up a few ACKs

Changes since v1:
 - __kernel_write must not take sb_writers
 - unexport __kernel_write
