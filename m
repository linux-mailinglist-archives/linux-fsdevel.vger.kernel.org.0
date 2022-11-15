Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF2629349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiKOIc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiKOIc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:32:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192B9FEE;
        Tue, 15 Nov 2022 00:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NnY5p1xOYjM7bMvvUw0agfjUUHQQ1Q8SuaFovfwu0BE=; b=V9jF/3RhcKYu0n0LBavowmgMFR
        jjaslwXKc7wExS/2eGcQ9kvMex6Ojr12mnoeQT2j8tCO9IkhvCj5PF3Ys8y/tkAgexoFHhyxMzyCH
        V2OBl18ILwkVqi86ybZHfuH6QBTTe5vX3swd10paC598PNXVo5ucy0cUO7DUR6marDi5Dh9y4tU1C
        RawsAiWGwolC9dmJ30HbDVQwL6VeWcbCDkdJV4UyzcH79AY4PkLD5rCQl/8DRSUEiCVzNQKKI98PY
        oY5+jNg5tjGyn9Inoo3yBHxBvZehVoWE+TrbdZPsVZxufRufBDzQVveZXQOnfBZbF9r986AqT6q8f
        zRMcLXqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourNF-008xpR-CG; Tue, 15 Nov 2022 08:32:53 +0000
Date:   Tue, 15 Nov 2022 00:32:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [PATCH 04/14] xfs: buffered write failure should not truncate
 the page cache
Message-ID: <Y3NOtbLO+QaTtYP8@infradead.org>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
 <166801776726.3992140.478044755009071447.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166801776726.3992140.478044755009071447.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:16:07AM -0800, Darrick J. Wong wrote:
>  mm/filemap.c       |    1 

These new exports are another really good indicator that the
punch out delalloc code really should live in iomap and not in
the file system.
