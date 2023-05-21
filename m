Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2870ABF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 04:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjEUCH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjEUCHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 22:07:02 -0400
Received: from out28-54.mail.aliyun.com (out28-54.mail.aliyun.com [115.124.28.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482DB99;
        Sat, 20 May 2023 19:04:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05420242|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0333237-0.000184064-0.966492;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.T7shLS9_1684634674;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.T7shLS9_1684634674)
          by smtp.aliyun-inc.com;
          Sun, 21 May 2023 10:04:35 +0800
Date:   Sun, 21 May 2023 10:04:35 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large folios
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
In-Reply-To: <ZGl6UZ0a+fIAPmn5@casper.infradead.org>
References: <20230521090235.4860.409509F4@e16-tech.com> <ZGl6UZ0a+fIAPmn5@casper.infradead.org>
Message-Id: <20230521100434.716E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Sun, May 21, 2023 at 09:02:36AM +0800, Wang Yugui wrote:
> > > +static inline unsigned fgp_order(size_t size)
> > > +{
> > > +	unsigned int shift = ilog2(size);
> > > +
> > > +	if (shift <= PAGE_SHIFT)
> > > +		return 0;
> > > +	return (shift - PAGE_SHIFT) << 26;
> > 
> > int overflow will happen when size > 0.5M(2**19)?
> 
> I don't see it?
> 
> size == 1 << 20;
> 
> shift = 20;
> return (20 - 12) << 26;
> 
> Looks like about 1 << 29 to me.

sorry that I wrongly
1) wrongly conside PAGE_SHIFT as 13 from arch/alpha/include/asm/page.h
it should be 12 from arch/x86/include/asm/page_types.h.

2) wrongly conside
	(20 - 12) << 26
as
	1<< (20 - 12) << 26

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/21


