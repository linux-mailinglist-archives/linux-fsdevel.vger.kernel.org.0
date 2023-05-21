Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF71470ABD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 02:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEUA7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjEUA7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 20:59:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CDF2;
        Sat, 20 May 2023 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGF+5n+zGC+VJsIT165uNKucP04skdka4hVpPSRITvE=; b=m6tcSMqloHbOCFl56LFmGfDsWi
        RN3BTNRSEKFME8IUcD3ULEeRFR7WYP9zoR1MnSOMvXS3//oFRvy4saNSST2OboGkv/mhP8YK/UT1p
        ZS4NjLz7dyTzeLNJ2dyW6wspHOsaV+u7+735ovhmF+IuBcz+QwSU8jGcr3xkzOyrhRUjiYjiBTxs7
        CmVWv4W3jxo7PItHj24YEdMQ0Ha1cPgLFDO591pL1D//DnJ6djlgC1scIWTeHyMPuls8ZkASyrGio
        X3rIQJTQDQ3VujB1Uy/IHBX3wvcQMtY/MWTOo6Bz6OBXugTh+qTMIARtJ4vCGpw579ct0PrLXdQNm
        Q3VnIe/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0XQ3-007pSQ-KP; Sun, 21 May 2023 00:59:31 +0000
Date:   Sun, 21 May 2023 01:59:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/3] Create large folios in iomap buffered write path
Message-ID: <ZGls826bw3WeVG7L@casper.infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
 <20230521084952.0BCC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521084952.0BCC.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 21, 2023 at 08:49:53AM +0800, Wang Yugui wrote:
> Hi,
> 
> > Wang Yugui has a workload which would be improved by using large folios.
> > Until now, we've only created large folios in the readahead path,
> > but this workload writes without reading.  The decision of what size
> > folio to create is based purely on the size of the write() call (unlike
> > readahead where we keep history and can choose to create larger folios
> > based on that history even if individual reads are small).
> > 
> > The third patch looks like it's an optional extra but is actually needed
> > for the first two patches to work in the write path, otherwise it limits
> > the length that iomap_get_folio() sees to PAGE_SIZE.
> 
> very good test result on 6.4.0-rc2. 
> # just drop ';' in 'if (bytes > folio_size(folio) - offset);' of [PATCH 3/3].
> 
> fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1
> -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4
> -directory=/mnt/test
> fio WRITE: bw=7655MiB/s (8027MB/s).
> 
> Now it is the same as 5.15.y

Great!  How close is that to saturating the theoretical write bandwidth
of your storage?
