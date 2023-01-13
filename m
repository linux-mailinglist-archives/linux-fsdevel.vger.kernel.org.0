Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC29668BA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjAMFm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjAMFmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:42:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E059309;
        Thu, 12 Jan 2023 21:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=z5SFGnAK1U04ZK1706GHRqYQOYnTl0hLVwN6OVNhlyo=; b=GZVI5BTcjhDYQev/12ZXt+nCfF
        09ycBcmRjsuy3LAhO3kMDBN/DvWDbtKnVRN4y44iQadvVMtlZgdMXuEfv7CjCh8wg7AVYDa1NmKNa
        QVpHu1dkhXmRRCISTQOesx5mZXwXF3HPnKanx2r6uNvNc75h3rS7AAiBhiai5h7atcUXbCHdr+jp4
        HyXR7OA7PGl6ONMmri736yLWq3XY3njyQ2pv37gtwV8B4I4LOx4V4k4rhBVlIC6JqCFmrBeA3RCv0
        UbpOw9Bda6MkTGHMlJ74+3WrcDWeJTMhMl49jeD+KLFKkPxy88LLSaqAECri8fABegu6TVeGB9sSN
        ALb0LUgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCpH-000YZW-KI; Fri, 13 Jan 2023 05:42:03 +0000
Date:   Thu, 12 Jan 2023 21:42:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Should we orphan JFS?
Message-ID: <Y8DvK281ii6yPRcW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

A while ago we've deprecated reiserfs and scheduled it for removal.
Looking into the hairy metapage code in JFS I wonder if we should do
the same.  While JFS isn't anywhere as complicated as reiserfs, it's
also way less used and never made it to be the default file system
in any major distribution.  It's also looking pretty horrible in
xfstests, and with all the ongoing folio work and hopeful eventual
phaseout of buffer head based I/O path it's going to be a bit of a drag.
(Which also can be said for many other file system, most of them being
a bit simpler, though).
