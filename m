Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2C1C5BE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgEEPnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgEEPna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B0C061A0F;
        Tue,  5 May 2020 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kE1QN5CpddlIzejqrV6uBZwikbIlszGwNuIcuIFnBgY=; b=CZwudL8M/p/3X1V8M5/wCJc4+M
        i7jsfxBiHEannSQkukG84F0KQUzDbEpuY5/vcvnjhW8sDIyln9UnCQR7fpo86PSRAIQGHH1lsJnFh
        6cH/QgI+1rTJBglLxUGaHdPkf6Q76IoPWqKhPGTWf1PBl+mGGYs8kCQVZ3zwRvtkNHkNBBdpW4FoU
        B/iH4grODM2+xCPb0/H7l8SSHtZb0hKdlS2+8Vw6qt2WbO5b40CfUmPacSQqrsV4N/VoLBVv36Gau
        VUmhC5+LwivxYWUYj8YbROycLD5l0o+m/NGg42q9hnr39fGJviPCbVOlNcRyiQyi8gopS9dzAalhZ
        svIoe8dg==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjE-0003y2-SJ; Tue, 05 May 2020 15:43:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: fix fiemap for ext4 bitmap files (+ cleanups) v3
Date:   Tue,  5 May 2020 17:43:13 +0200
Message-Id: <20200505154324.3226743-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

the first two patches should fix the issue where ext4 doesn't
properly check the max file size for bitmap files in fiemap.

The rest cleans up the fiemap support in ext4 and in general.

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
