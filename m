Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1D1DF594
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbgEWHaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgEWHaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29DC061A0E;
        Sat, 23 May 2020 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DzRxzluDDsZ20LRGt6NXZ0iLeHiTMHBFOjqtJkPHPXk=; b=mBllieRzoHCY0nwUHk45Tl+HRG
        FQ8i5BHRRDEAj7/ODzbsfxnmCTt1KnzeVdKdopHKKN9prz5SFJMcmzHS7M1/fPM//NBMlI02hnms6
        Q6xNRFxnflsGOrWYhD2cU+yD7HdWl3LudSsRFHqSidQuujjEhObdCwuI6e8DI6HSeXyP9TV6Ps6xd
        Y/kVBSy0GEjGD0c2PR7IP0kTpfNyiR4+C2iFiwIo2ooy74Edj4/FOKf41ZuPh1vaoEwauv82tskme
        euQ1f3JHVtahvYzw7njrXeGpFedm7BvzCCksoY8RBXQtU6ldPSe3ql+pJcK6ut30XDZbPftjI00D/
        nwfEbrGg==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcObr-0007pt-Hh; Sat, 23 May 2020 07:30:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: fiemap cleanups v4
Date:   Sat, 23 May 2020 09:30:07 +0200
Message-Id: <20200523073016.2944131-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series cleans up the fiemap support in ext4 and in general.

Ted or Al, can one of you pick this up?  It touches both ext4 and core
code, so either tree could work.


Changes since v3:
 - dropped the fixes that have been merged int mainline

Changes since v2:
 - commit message typo
 - doc updates
 - use d_inode in cifs
 - add a missing return statement in cifs
 - remove the filemap_write_and_wait call from ext4_ioctl_get_es_cache

Changes since v1:
 - rename fiemap_validate to fiemap_prep
 - lift FIEMAP_FLAG_SYNC handling to common code
 - add a new linux/fiemap.h header
 - remove __generic_block_fiemap
 - remove access_ok calls from fiemap and ext4
