Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37C19F576
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDFMDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:03:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgDFMDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=M3PudfTDfMbp/kyNfADOICHhe3xiV05PupFz4zJKaGo=; b=Z3LfP/8tdTqyZ1tf4vGA2UZVTm
        T+V+JRjTgn8R2yztuK/gSGSNmlfMRk2U6xJTog/RRxYAJ0wsq2hYTXjwqXN+swW1ykR7Nc80++ZzP
        UTnkhAr+rivlk1bW1WqNpoalE1es8EdQQ1Sfh/zQKliNjkTmsBFzdf2LZn4XH9+F2o1/ffwTo4YFk
        LV6p3LUF+9TFaK8yhfTK8xLp6peJQ+QaH+PtVTk8rs+Dv9EKdad4OuNOtegec0fIwsrTTYtp0gi42
        BS4wWWRV9xOBBaG/ZlJTC5Iv65EBLi8C9oTBcQ5loGeVJRZ6Evb8gGIAxjV9JKTLTGh3XE0217U+E
        2pdCuCtw==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQTC-0003JP-17; Mon, 06 Apr 2020 12:03:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the exec and coredump code
Date:   Mon,  6 Apr 2020 14:03:06 +0200
Message-Id: <20200406120312.1150405-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series gets rid of playing with the address limit in the exec and
coredump code.  Most of this was fairly trivial, the biggest changes are
those to the spufs coredump code.
