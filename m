Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCDA6932
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfICNDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:03:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICNDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lG/RehJLtxGv7aGgAnzqIyR3HiGn5znk8fnu1OiIaW8=; b=FXHY8RkGYklZuelJSJMA9Z8ni
        Bsfi6fSSr8mQcHRjsRorq9x77w+JgSl3/p4yIJmTeWQZrQpvp+e7F+OnrsFFEkYwOiCJ4Xm5MNgig
        0lDtn0q2AoaNrlS0xDWJ/CZOWcjH9DSPSInAoclSRmWCEqOWN5lpB5FXkH8JVR48NnhB5CA5BXSVr
        7gYpG/PihJs4O3xx6AlTSAMl5kfd2CEhHn+nmDnr2QCmfxBhjiFykzW7zQVhQo76aG8pbGtITfLcX
        BbJswDuQon0q1cA4MAmTNnlXecJITxLaSArQple6+GT/bhDiEfObVE1v+I3FRJ+AZksax7o5aYVNq
        bPECO9pbw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58T2-0003sr-Sa; Tue, 03 Sep 2019 13:03:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: iomap_dio_rw ->end_io improvements
Date:   Tue,  3 Sep 2019 15:03:25 +0200
Message-Id: <20190903130327.6023-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series contains two updates to the end_io handling for the iomap
direct I/O code.  The first patch is from Matthew and passes the size and
error separately, and has been taken from his series to convert ext4 to
use iomap for direct I/O.  The second one moves the end_io handler into a
separate ops structure.  This should help with Goldwyns series to use the
iomap code in btrfs, but as-is already ensures that we don't store a
function pointer in a mutable data structure.
