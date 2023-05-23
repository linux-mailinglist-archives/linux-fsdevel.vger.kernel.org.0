Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1C70D37F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjEWGBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjEWGBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:01:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F511A;
        Mon, 22 May 2023 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qD1JCzzKcMkYRVAB5EtUpEHmyv161aerpNd3/MwitKs=; b=zdNc9vP2CYb6wXqcNWOWuXPoTb
        1MTtZ0V/LzQy6xS/97Axnac+xTUd1lTWlQTx0dapJ4gQ+5eNSq3RxpEalqBSeLJ/ssNvn5V0EtLEh
        mco0GPEUoR9CSN5b9ToRlBQ5BLQoRWJAEwRxurnVH0c6MCrlQCw1GXNWQeYKM4yCRZkuP2vBeN6Nz
        R6gtiaI9mYyEy0MI/YMMgtGRzFEFQafv+IEaStQdEEIsJrgeUHazg3/xBttTG/3kURZ5AseqHtuGG
        opsdWZZNP+Fpom2TNwztNg6H3HD58nk6VqhlDnBIBj+S7+H8XUrw/EeF/bbqeRc5ewHTu7pgVe6CL
        Lwed2a+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1L4s-0091rx-0y;
        Tue, 23 May 2023 06:00:58 +0000
Date:   Mon, 22 May 2023 23:00:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
Message-ID: <ZGxWmi77qH6g0Cwj@infradead.org>
References: <ZGXDQ4RGslszaIIk@infradead.org>
 <878rdkweay.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rdkweay.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:37:01PM +0530, Ritesh Harjani wrote:
> We ended up modifying the APIs in v5. The idea on v4 was we will keep
> iop_set_range() function which will be same for both uptodate and dirty.
> The caller can pass start_blk depending upon whether we dirty/uptodate
> needs to be marked.
> But I guess with the API changes, we don't need this low level helpers
> anymore. So If no one has any objection, I can kill this one liners.

Yes, the actually uptodate/dirty helper isolate the caller from the
API.  We don't really need another tiny wrapper here.

