Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB521D0D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgGMHsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgGMHsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F78C061755;
        Mon, 13 Jul 2020 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=O4RkM4L4v1uhacdo+mwWkqTommwnEKP8IOylxP5CiHY=; b=dqXtaVODQtunzwGbeWrghLtHSf
        fs+Sfkplja9BdIX4aw+kn4Z0IVAD0+pDfQjQol+4hhlN8ZVGgRBQ6SfNxIYAjsimdaIfxSsmA484v
        syal7xxqYgpTBMBTtXAPvqiUt8A1BR9FZ6TgNnlqwzqiybvHB5/heOaLeoqFAHenD4DwUe3Bv+Ar8
        q5d3TydO+ejePk96Y+yq0zmaorz9Z1Jlq4rlFZICXWbj3tYVAnDEe1BFIWqyEqayQsLokJlmp6HVz
        5g/+jnwo3aquic/b0fhXipa1LhbIK5rWa5I9fuHwUkySqkYMLygyHKUZxrBcrAr0ePGVOugC6WTWh
        lcrul8ZA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jutCf-00018J-0F; Mon, 13 Jul 2020 07:48:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: RFC: iomap write invalidation
Date:   Mon, 13 Jul 2020 09:46:31 +0200
Message-Id: <20200713074633.875946-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series has two parts:  the first one picks up Dave's patch to avoid
invalidation entierly for reads, picked up deep down from the btrfs iomap
thread.  The second one falls back to buffered writes if invalidation fails
instead of leaving a stale cache around.  Let me know what you think about
this approch.
