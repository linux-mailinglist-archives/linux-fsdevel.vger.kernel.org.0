Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B92F35B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406406AbhALQ12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406271AbhALQ11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:27:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68974C061786;
        Tue, 12 Jan 2021 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZwKEtPEU/UKzTlUIIO3YOAJ+rNX25Kt6pbGT6DGsrqs=; b=Cimrf1SQHo64UmlBpE4df8oS9z
        +7Bo4m7vz7EZam92u8JZEJhyeYR+B0dmSJ3jFac6CQj9AJIW2AKjkOaZuQth6OiO94cpe0BPiUVfe
        mmv3VvBjtvJoRgrjur5ZKFXT2VcS+Q8flyKHDWXEpZpjFyPmkG5C9N0WuqMA+8ylDA8LWSmxfBgnU
        XyzyWNweW3VD8Zx1yKufKLSYBekLqffZW0xPDBM4NGA9JPa4t5J4AUYCA8QXH30+FqpgtRPVhO2YN
        o/30ub19UKzmZnV9yYCcDoGvLCDwDafsS1SxTELjIjOiP5UfdHIKdq6XVn4MN3LGspg/1ZQvHBkQ6
        WuW1lnlQ==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMUs-00529y-M6; Tue, 12 Jan 2021 16:26:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [RFC] another attempt to reduce sub-block DIO serialisation
Date:   Tue, 12 Jan 2021 17:26:06 +0100
Message-Id: <20210112162616.2003366-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This takes the approach from Dave, but adds a new noalloc flag
instead of the nowait one, and keeps a simpler calling convention
for iomap_dio_rw.

Only lightly tested so far.
