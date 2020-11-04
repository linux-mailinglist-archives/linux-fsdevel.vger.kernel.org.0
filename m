Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F252A5F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKDI35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDI35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:29:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C8C0613D3;
        Wed,  4 Nov 2020 00:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bmdptjIF0lAau/p6uQt+rPSQHQfQ0uoI3u2UOTPClt0=; b=YILuwTbtH46kkbIeRhcozcPXiP
        btzB4KOm18QqR4S2s+hRlWsLB5xC5htsMVjOedL+71sEVit67LnwudPCjuTGBkZzQep9ujhnHQg2I
        K+rbWSmwvz7rfbZ4SFU4mUM6pGC6Pu8LiiCpP3bmkwmtRmLywbBOpZFQ2sPJe9aNLHoPd6ujS6hgR
        WyFmaTJrX4UIYYjIdLovXDXOQ/vRzvdM0O2Wr1urmKYVJCcS0ASf9ke5BZSAWIQlqts5etkDhkUpy
        5VKgRu0cXCmNFmKvSOGPrjc6rEOdua9CXlPIhilhWg/ZtwX261hZMgkz4EID0qVbKs7cJ7fgReISP
        3iKl9XZw==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaEAw-00048Q-MJ; Wed, 04 Nov 2020 08:29:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: support splice reads on seq_file based procfs files v2
Date:   Wed,  4 Nov 2020 09:27:32 +0100
Message-Id: <20201104082738.1054792-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Greg reported a problem due to the fact that Android tests use procfs
files to test splice, which stopped working with 5.10-rc1.  This series
adds read_iter support for seq_file, and uses those for various seq_files
in procfs to restore splice read support.

Chances since v1:
 - only switch a subset of proc files to use seq_read_iter
