Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D44EC902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348489AbiC3QCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiC3QCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:02:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3626FD1B
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o9j/f4oljGO16wa+5/GZhIMo16Gm+WFFx5nvho8Nyho=; b=rwxvSK/8vyoRJnxU1BS6PZatyp
        hRrYabww25ZhLsx23wGAyIsONKYpVm+ao5w07sU4WHlK/MFxV1WmTnm2XxLC+iTHd0OtZVQ2idFbR
        cDHTGCSY3NkKsr4nr/z/IHBY0wK1Tf0qextO2fC9tzuJXScIIv0PjtE//eaUIN6JiTWMZvuDX6lpg
        nZQM0GatUDxZY/iFSfxy3OapIxsrgWfHm/U2wZpH0jLQ0chO2BwGyWIK/Hrp1Zz4VSXgdDyiaalyj
        43dDNEKTc3CBpk3bQKWSAYRva61IZWEL2GjAKoLavLev95ozlaCi/ECvTo6UM+7r8xRio1q3KeZiv
        gNIRX3WA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZak9-001NR3-T1; Wed, 30 Mar 2022 16:00:21 +0000
Date:   Wed, 30 Mar 2022 17:00:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] iomap: Simplify is_partially_uptodate a little
Message-ID: <YkR+lYvqcsFzkC4X@casper.infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-4-willy@infradead.org>
 <YkRum3GLyIrYdSgX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRum3GLyIrYdSgX@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 07:52:11AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 03:49:21PM +0100, Matthew Wilcox (Oracle) wrote:
> > Remove the unnecessary variable 'len' and fix a comment to refer to
> > the folio instead of the page.
> 
> I'd rather keep the len name instead of count, but either way this looks
> ok:

Heh, that was the way I did it first.  But block_is_partially_uptodate()
uses 'count', include/linux/fs.h calls it 'count' and one of the two
callers in mm/filemap.c calls it 'count', so I thought it was probably
best to not call it len.
