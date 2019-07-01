Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201C55C533
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGAVyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGAVyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jUXV+9Am0lafAQM2Xh/BLm9nT4mqaa+fGtIKeFlBAzI=; b=F/d2udAGSziQdw1cB6q1TqCFc
        J+vPGA6i9goMucdspM6yFZWOBz6OFrgDF5B621haiMwtYC0NZIs3ox+sN0g8TX6sAUdbCtHPNW02O
        58abFVVQxk4RpnA1B9RceZRybC05PPjJIQqp244Y5/LXhuWHcXsN4uPYU1AoIkJirX8q4nCX1cJTK
        SBwu4jRZBwCwIF0B0QY62bGO5lDhCzD04aCnb8Fxta5Az12mfVUtnL/xizJLKMDHzNJkQUZ3Z0zfY
        v/SodJ5cFbBkIvnlQnL7zk8Sp2CBXD2VMu/RWv23HKM29VF2DMFjTsKjuwAioEm1j4HqyhLxK87gW
        yN7KXgl5A==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4G6-0000VM-IE; Mon, 01 Jul 2019 21:54:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: RFC: use the iomap writepage path in gfs2
Date:   Mon,  1 Jul 2019 23:54:24 +0200
Message-Id: <20190701215439.19162-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

in this straight from the jetplane edition I present the series to
convert gfs2 to full iomap usage for the ordered and writeback mode,
that is we use iomap_page everywhere and entirely get rid of
buffer_heads in the data path.  This has only seen basic testing
which ensured neither 4k or 1k blocksize in ordered mode regressed
vs the xfstests baseline, although that baseline tends to look
pretty bleak.

The series is to be applied on top of my "lift the xfs writepage code
into iomap v2" series.
