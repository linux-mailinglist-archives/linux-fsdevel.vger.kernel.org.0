Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39B21BAC34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgD0SUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgD0SUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA43C03C1A7;
        Mon, 27 Apr 2020 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NNJuTRmE6ZELTE88A2jaK/hIThaWq/UwG4YZi48dQqQ=; b=lkxwbRGpEnW2Cv8IHKwyIrTdzC
        mSpj6MhQZn67Q23rMCw7lzs7Vuop1jswbJnm41NijXqbHLCbWATF/oDmV5rtUghGRCRak3nicUQ1P
        vk5UO3zz/awtw+7o4lIwcRZnpHSaxJjy2M8m1PDZ0gMwEBbjD4DYsYfjw7sGbgY/u8gz7PYqSwpAk
        eRggWnunkz2wnZamMZPKzfVz+iBP438h4YuMImhKN2rIP2LApsF00GhC7NOgkxzhTRDyusw/yJSsJ
        tgYyoAcuJrj5MWlQxH3K4oplXKSxITPUS5m0D7ybUyjttObUo+YOwQy0T2X7X8QzbAyks5lksDIA8
        0m9xqIwA==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8MJ-00025C-6Q; Mon, 27 Apr 2020 18:19:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: fix fiemap for ext4 bitmap files (+ cleanups) v2
Date:   Mon, 27 Apr 2020 20:19:46 +0200
Message-Id: <20200427181957.1606257-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
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

Changes since v1:
 - rename fiemap_validate to fiemap_prep
 - lift FIEMAP_FLAG_SYNC handling to common code
 - add a new linux/fiemap.h header
 - remove __generic_block_fiemap
 - remove access_ok calls from fiemap and ext4
