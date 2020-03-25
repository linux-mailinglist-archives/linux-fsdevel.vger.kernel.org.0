Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAD192859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCYM24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:28:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgCYM2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ajDoCWrNrQy4SbrNkUXgQzxrcdJV8ZRIIVmz0mrQdAU=; b=Vv9eLgcN5cr+lGE0M1R4IcEO0i
        e2CwpydyHZUjmPNIHQZVTBoc0v/3VuTBh9AWQc0Q2jtjmsd7VbLtyR36ojryyfs9M7/xcXXP2xSft
        j6voVbCt9y/RHP1bIa5091ziwiT2U4pnjIl3oO3htdIDuyL/E9XkEaMAMN4XPjxrkTUk33HIB36YF
        pesifJYGY8bihV+a1KE/A3keFRk5gVNTZsRa6gTM2staCWt+vjLzCBOZi9xnuQzxa1qlK+nt6FyKg
        eUrNuFIsbcRN0cnZNKdWBlW0cJjigvHCr6q6iimKKazfjorKvr6FH1YDK+kbF5bXySJloPoW7KdPG
        cD3XeF6w==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH591-0003Fx-4q; Wed, 25 Mar 2020 12:28:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: lazytime fixes
Date:   Wed, 25 Mar 2020 13:28:21 +0100
Message-Id: <20200325122825.1086872-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this is my take on Teds take on Erics bug report about ext4 inodes
beeing kept dirty after sync.  After looking into the area I found
a few other loose ends, so the series has grown a bit.
