Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082F1F974C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgFOMxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgFOMxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2BC05BD43;
        Mon, 15 Jun 2020 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BbLzIVFa4A6zUaNf1L0nDn8DbczZnfgkEyA73ztXvCw=; b=eHfpexpJTLJHg1CM2SZriyfffr
        qH+XQnvHEPvo2L2p3Nn+0V0EaaIwExHSpbbphZW3JHBWMFhCv5EUgC7DnMn2qRvVrRoKyIOmAgbGe
        t6M6WhcCqMRYYCyUrfRRC3RUYTatpj1SKtOszQLRmzMy+FPk/laJymS71GfYVKBDWI1wz4vr2xJID
        MwI58dESnvKWx9BvhFlBTZT4ncZl4GSfTDWWmLNbQKJ+gvpRy50tlp5cBrVL6g3u3mtt9loUkRE2l
        Y0rHbnO0vZxxQso6tuxh1Ym7McZADkKv+ALZsbv9f3rFYCyzTEaTgJ1IqhDqHhIghLeHjbHPwjsjW
        WnL7oGMg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkoc9-0000hi-OW; Mon, 15 Jun 2020 12:53:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: decruft the early init / initrd / initramfs code
Date:   Mon, 15 Jun 2020 14:53:07 +0200
Message-Id: <20200615125323.930983-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series starts to move the early init code away from requiring
KERNEL_DS to be implicitly set during early startup.  It does so by
first removing legacy unused cruft, and the switches away the code
from struct file based APIs to our more usual in-kernel APIs.
