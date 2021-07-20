Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535C3CFAB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhGTMzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhGTMxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:53:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D81EC061766;
        Tue, 20 Jul 2021 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/YSXDjhGODR214XoG8Dqm+Gle88zt3vzZxqK1pkRIcg=; b=Vr67rb3umPYmY6fb0PW7/1h7vl
        /Wfa1z7/ClLU6vBrIaeO4SfL7fkMpEQ7FQPHLjOOzyEIoiSV65cepasWUPVmheXVxUkj9STXKSkJG
        JbPL+IlctHkBdrIoqoWoeMtOmVLtfWbgh/63Yf78sru8rPcz3Cc93jwxtA75V+SfT7XbYbNOK0EMY
        xH4uSqXF4oQVaEtPW9auIOiukZybBJOFCFQUD+rQvXMp/faJB4AvsGYuEwBrkDw7majQqa4N6wKvX
        jMoYSc/0gnPs343vBUV1Ewi6v0TWxXUSyhYPwp6Z96ufp++BO0xX8fKbY2bvdQ3kOusnQGsXpapaa
        ykooqfjA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5psV-0089E9-3x; Tue, 20 Jul 2021 13:33:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove generic_block_fiemap
Date:   Tue, 20 Jul 2021 15:33:37 +0200
Message-Id: <20210720133341.405438-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes the get_block-based generic_block_fiemap helper
by switching the last two users to use the iomap version instead.

The ext2 version has been tested using xfstests, but the hpfs one
is only compile tested due to the lack of easy to run tests.

diffstat:
 fs/ext2/inode.c        |   15 +--
 fs/hpfs/file.c         |   51 ++++++++++++
 fs/ioctl.c             |  203 -------------------------------------------------
 include/linux/fiemap.h |    4 
 4 files changed, 58 insertions(+), 215 deletions(-)
