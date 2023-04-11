Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C36DD2BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjDKGZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKGZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:25:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60961722;
        Mon, 10 Apr 2023 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V634ZR1sb91RRkxCjl933s0IREyHzeo5FH6izyocIFg=; b=I4hUZE36z0qp7Vq7v0DCCE0ozw
        uS/2ANsUXeehHb+Nl63FEeLgnTlp7jntuJk4QAyhO76S9KvodfcKhdM9+1IRBdu3dw0ujjoL69xae
        M6QqmipKYTwwKYn8wh69UPeqPCR7RvtvoRIRckZ0MqmohdAx1/f1aFswe8p8prSaCs76AV0FfkSoL
        2lOC+cHqH0MUYUPXN7III+hikiyH4JZt92jbqm+qlN/2vnNR/bTJ8alULl5MvtCYTYA8vFshmgwyI
        /qJ0pLMn66MoVI4y5hMT0JHpbzG5y+/dnpbLfE/FlnENhUNa8fp5xvf+ibGmGp/oCkWN8Iy+KiIc+
        rmx3jR7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm7R8-00GZdX-0B;
        Tue, 11 Apr 2023 06:25:02 +0000
Date:   Mon, 10 Apr 2023 23:25:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Message-ID: <ZDT9PjLeQgjVA16P@infradead.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
 <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 08, 2023 at 05:30:19PM +0200, Donald Buczek wrote:
> Maybe detach the old filter and attach the new one instead? An atomic replace might be usefull and it wouldn't complicate the code to do that instead. If its the same filter, maybe just return success and don't go through ops->detach and ops->attach?

I don't think a replace makes any sense.  We might want multiple
filters eventually, but unless we have a good use case for even just
more than a single driver we can deal with that once needed.  The
interface is prepared to support multiple attached filters already.
