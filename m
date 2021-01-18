Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923B2FAA57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393981AbhARTi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393791AbhARTiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:38:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA66C061574;
        Mon, 18 Jan 2021 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=X4ueV9xOGs98yyzz8XiW2OzPN/doBO5wUrXXLivagUM=; b=RjRh+HwsDu6OUbVuoNrdL+xQuT
        BMx+fY+zi7vuK7ckwsfgYMwk5E/wvqfQ4CZ1WMuVQbeX2Le5x+1Iq2tBKdHAaZNieaqmFJMfd6G24
        K4ltloxZ1Om/J8Dgm3nwRiHHOOdyQdiwibrlABCYKlY6bsGVJh0Ff2E2XetllSqNFp2kLQZSC1YW9
        adAdyKImkAXErTWm/4GMGYutGJfb+9IrT6VEUhOOKSeVJb4UGuRjpbMSkNuYCM8OV00RsgGpZjWRm
        kbLRnysK/aFsIQLQ2LewCi1mP4xQw3uPBTs/Hsjha7UQmKnCbF+uw2cD4OHfPppTwi8zbc7GTU7fu
        FeQRHoQg==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aLB-00DIvN-GA; Mon, 18 Jan 2021 19:37:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: reduce sub-block DIO serialisation v2
Date:   Mon, 18 Jan 2021 20:35:05 +0100
Message-Id: <20210118193516.2915706-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This takes the approach from Dave, but adds a new flag instead of abusing
the nowait one, and keeps a simpler calling convention for iomap_dio_rw.

Changes since v2:
 - rename the new flags
 - add an EOF check for subblock I/O
 - minor cleanups
