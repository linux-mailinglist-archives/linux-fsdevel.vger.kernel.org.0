Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDD6FD05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfGVJub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:50:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfGVJub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HG9+HD8BoJ0/A6yxTNaU7c8B6tpTr5YDR7LElaVu3Bc=; b=Sjv+cJza7h7ZVvCgGriJ6L3wT
        MM26/nfI3M7x85PK5ENZ0e0GZLMMZexxUsJbb+VAnLVuLsOOJhFEsKuS7uLpDhy2KPAquZwNKpz0c
        ZHRqOPNSXZ7SVKNCBKnPAeVkX6SrE7rASAnzW6oezm58JJormD6l45FJ6R/UhkqoIwLt1GEHB+Tkp
        Mq7HlzZUmU/f2LlgkVchtzT2p6GFd1oYf4xGxDFtKK1+msIbgGo9llpEBxN4ql+P+omc8UiBf3Oif
        faVELLleNzvsf72BAPAZp8CiKRqJVxJFEeTDobX7kJQ6PTLXhPGmFiXI5umGJYutilnPL6zo6JsO6
        0ET/St2pQ==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUxe-0005Sq-ON; Mon, 22 Jul 2019 09:50:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lift the xfs writepage code into iomap v3
Date:   Mon, 22 Jul 2019 11:50:12 +0200
Message-Id: <20190722095024.19075-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up the xfs writepage code and then lifts it to
fs/iomap.c so that it could be use by other file system.  I've been
wanting to this for a while so that I could eventually convert gfs2
over to it, but I never got to it.  Now Damien has a new zonefs
file system for semi-raw access to zoned block devices that would
like to use the iomap code instead of reinventing it, so I finally
had to do the work.


Changes since v2:
 - rebased to v5.3-rc1
 - folded in a few changes from the gfs2 enablement series

Changes since v1:
 - rebased to the latest xfs for-next tree
 - keep the preallocated transactions for size updates
 - rename list_pop to list_pop_entry and related cleanups
 - better document the nofs context handling
 - document that the iomap tracepoints are not a stable API
