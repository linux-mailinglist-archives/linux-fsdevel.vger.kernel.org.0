Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079883A5CC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhFNGRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhFNGR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:17:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF2C061574;
        Sun, 13 Jun 2021 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FXVYdvmSKUggvYaaBTd1y43Qacyvt4oXQKZ6ZIvT5PA=; b=eIQSEerKZAsZdpBCpTE5uwx+0J
        A/qoYiZQ2FDuz6Uboaxw4Sd8uZVosTov2zTxyAJC9hBJDYe9R+8FZ5ePyBSmQ5fDXcuLJ9aeK4nfL
        WJxxsH13fqA6txjkZvfubz2jW9O+/K62a767n5boAmnmpXpf3QRmQEcKpH77WNv5w+KwswMe5AwjJ
        Hz2s5fwlKJqXE+zH/kjVHJma03DHOaywhrajTbdcAHYFZfNjCgCaAHM9TkJWKEuioxOXMmBaY5WUx
        nrzna8kpJCdor4W5QOWTYr7U97uFSkowLfKahB6x2xEm8BdtaSeYw2NO8t7yZoLYPzMjW8U743p+S
        6JAMDa6A==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfsQ-00Ch4Y-DY; Mon, 14 Jun 2021 06:15:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove the implicit .set_page_dirty default
Date:   Mon, 14 Jun 2021 08:15:09 +0200
Message-Id: <20210614061512.3966143-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up a few lose ends around ->set_page_dirty, most
importantly removes the default to the buffer head based on if no
method is wired up.
