Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727C2A144B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgJaJCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgJaJCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D7C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PG0nI7edPosm36oEEbJMjxQzjtvR3xxB/F8bvCRxZaY=; b=A4OWaP5f0xdQ7mjBQmuYpNV/Bi
        WyLd8OXzXYao4XCbW86cV1UkceaMq6CZyb3tcXxHOFBH7dqypjuiaRhYuyzpyoJBRFq/hRFuAmQ6p
        p0w9DK0Jay3yaAVTd2wV4Txt3eIMG3NfmKu1MxDjpbFPFuDtGyor14d/JoMi7rUOBXzESTJ/9zu17
        l+EfkjZOGkAul4VRdAar75tLcxxzR49UnnttmuSI8lN6Eem2WpVZjvLBKQNkCciZKnS3a7s4eteHH
        C7l1EYMj/pvMC16VZTsJAwiWmXQGMYo0MiRQUJuxtSI0APKm97evRCTeyTHMWTJQW4cc4XtJGN1BU
        Gj0hp6ZQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmm6-0006xP-I6; Sat, 31 Oct 2020 09:02:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: clean up the generic pagecache read helpers
Date:   Sat, 31 Oct 2020 09:59:51 +0100
Message-Id: <20201031090004.452516-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

this series cleans up refactors our generic read from page cache helpers.
The recent usage of the gang lookups helped a fair amount compared to
the previous state, but left some of the old mess and actually introduced
some new rather odd calling conventions as well.

Matthew: I think this should actually help with your THP work even if it
means another rebase.  I was a bit surprised how quickly the gang lookups
went in as well.

Diffstat:
 fs/btrfs/file.c    |    2 
 include/linux/fs.h |    4 
 mm/filemap.c       |  337 ++++++++++++++++++++++-------------------------------
 3 files changed, 149 insertions(+), 194 deletions(-)
