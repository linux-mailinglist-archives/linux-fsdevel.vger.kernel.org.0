Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9321B5560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgDWHPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266FC02C444;
        Thu, 23 Apr 2020 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gGIezwoY+wPfofEZ1lSEnumbrPybt4TeEDGCmleYRVk=; b=cjCHEJXrRAidHBgUlrzxZC/fle
        6aRF/LQkYXWyhYn+xnvtY8jr0dBUsFP2ZQlUR3lkW77YbBZZBY4T768OzPWq492BOMwnY/25ACE/O
        OeMIP5IJxDCCym6J6FGH7EfUcX4c6i3WSXYMoe4MG7G2h/lAkKSYra2V3Xr4jOxBsJkRtN6zVJSFq
        Xshmruu+Geep+v60XY/1RJLLcAe06HYEigmPwDyMdsSsn0W+Xk3mYwI9gj5xe7xw8tDMNc7Qiehko
        gVZn3gHgTOq6DkEeIjaPW/LYlfVCUzE8I3B9xmwmuKV0gKBPjjT8Ilm3957M2BCoBBqygmk0rwvHH
        TyclIpmw==;
Received: from 089144193245.atnat0002.highway.a1.net ([89.144.193.245] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4D-0008RO-GU; Thu, 23 Apr 2020 07:14:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: stop using ioctl_by_bdev for file system access to CDROMs
Date:   Thu, 23 Apr 2020 09:12:17 +0200
Message-Id: <20200423071224.500849-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

except for the DASD case under discussion the last users of ioctl_by_bdev
are the file system drivers that want to query CDROM information using
ioctls.  This series switches them to use function calls directly into
the CDROM midlayer instead, which implies:

 - adding a cdrom_device_info pointer to the gendisk, so that file systems
   can find it without going to the low-level driver first
 - ensuring that the CDROM midlayer (which isn't a lot of code) is built
   in if the file systems are built in so that they can actually call the
   exported functions
