Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0054C732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiFOLMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFOLMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:12:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9304161A;
        Wed, 15 Jun 2022 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S4tHN8z3zg9zVifU+IuPkwjdnUTQJaa5ZCrsc8j8qqc=; b=mBby1Np3IUv0dcOkuekKdHgWn3
        jZ7FqheqinvmWSlL0QydGaSQ6ZQQ8vu0suRDsIQvhWLYpddnJ/890RoCZlyJMPHMyU3bggDWMqNdX
        lZKQbCU6j4VA0Z98EPNZDiKbTZgEeR9rGM9lhr3VegP+Tlgw18k7t7Ts/ntnbzf+FIg+wJ61v5HrA
        dKa+ofhAJDpN/avehssbwQU9dIlvmn/XtrnrS0GcUH8XYpspchJ6PzZj07El1Mf/YuO1zHf1sTabN
        n4qOHZIU37mj3VEulgFMABka7F/8Ur0E4uwl/iDmN4DnM7VOkTVFn5OPWJ3ldZgXrE6dYZfhnLvyn
        fI6si9hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1QwY-00E6Zd-EW; Wed, 15 Jun 2022 11:12:14 +0000
Date:   Wed, 15 Jun 2022 04:12:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <Yqm+jmkDA+um2+hd@infradead.org>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614180949.102914-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
> The IDR tree has hardcoded tag propagation logic to handle the
> internal IDR_FREE tag and ignore all others. Fix up the hardcoded
> logic to support additional tags.
> 
> This is specifically to support a new internal IDR_TGID radix tree
> tag used to improve search efficiency of pids with associated
> PIDTYPE_TGID tasks within a pid namespace.

Wouldn't it make sense to switch over to an xarray here rather
then adding new features to the radix tree?
