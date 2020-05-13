Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E51D094E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgEMG5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMG5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D21C061A0C;
        Tue, 12 May 2020 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OLeobDoK3cSodaOvhpXxRj41TUTb5dB2QsKr9Upwg1E=; b=i1/ludAPWoPD/7vlde8gjhEzPJ
        UGpXQOfEoZkrNj9JE/Ed2qP6j0F8Bbjow7TLTPtSKLCqrpC4f+aTZ4XxAVx7cuYtIKUePo5rGioan
        z7b0OchS8Hy+kmEu21uQKNW/fkcHVYsbs+P8rwVysWEhVCsOCaon18JuGLVyh37/DpeyR0hn0Y4Gr
        yG4rDV6dh+anzTzDpAyv3yIogor/Apc3ZZ/Jc9qxVAbdZQ4GssWNqx+hlDWjkAK1mI4fB6EWTIBXD
        iBh5VBO//ZcgP6tfERldIMAZdp+RndLNQ4zILLtdvnkosb2pHc+0ykuyQ/sHsL6WfYjriTRqNqc42
        tl+YxUQQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlK6-0003UK-6h; Wed, 13 May 2020 06:56:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: clean up kernel_{read,write} & friends v2
Date:   Wed, 13 May 2020 08:56:42 +0200
Message-Id: <20200513065656.2110441-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

this series fixes a few issues and cleans up the helpers that read from
or write to kernel space buffers, and ensures that we don't change the
address limit if we are using the ->read_iter and ->write_iter methods
that don't need the changed address limit.

Changes since v1:
 - __kernel_write must not take sb_writers
 - unexported __kernel_write
