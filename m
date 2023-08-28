Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F79C78B0D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjH1MoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjH1Mnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62216102;
        Mon, 28 Aug 2023 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TsFi+LT4Qr3fdEmg7eYjFMLcbwzzaEtW5T4DspxXo3Y=; b=JmfjPCvLqUIc/Duz/C2/B7zoov
        JyEFmXUwodGfPRb++kNw9kB71sJ+//scqia6MKkEwo78dk3FFrjGchHUk5ADMG9iQHROBGCNn/1uE
        9uJjFd751QBd+Pd4W+FvBYZnGCNBullGb0kYA0EZleImzaJA0etPCI31nSAniL+4Oo4RaCPdvPFPo
        TaRgY8fmuz9IRDvjmZx3dWBhYPfddqvApvN3jMIjzM8I18KF4VMc+8FO+KzZo7uzCbzdWY3OkSq4q
        wnOep8HVZ7jbS2m/NQr7/czfsB/AinGtqO4Icpn9Pl0lNv0wOJoaGDYHZ8Pb+UVY0Oeomn5aPFwQP
        XJ1ShoTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qabag-000Jd9-5F; Mon, 28 Aug 2023 12:43:34 +0000
Date:   Mon, 28 Aug 2023 13:43:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Message-ID: <ZOyWduPg9dR3AVT0@casper.infradead.org>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
 <ZOyMZO2i3rKS/4tU@infradead.org>
 <3283678e-1855-ed05-a9f2-44935bb806df@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3283678e-1855-ed05-a9f2-44935bb806df@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:17:52PM +0800, Kemeng Shi wrote:
> on 8/28/2023 8:00 PM, Christoph Hellwig wrote:
> > On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> >> use helpers for calling f_op->{read,write}_iter() in read_write.c
> >>
> > 
> > Why?  We really should just remove the completely pointless wrappers
> > instead.
> > 
> This patch is intended to uniform how we call {read,write}_iter()...
> Would it be good to opencode all call_{read,write}_iter. But I'm not sure
> if these wrappers are really needless...

All three, call_read_iter(), call_write_iter(), call_mmap()
should go.  Miklos dumped them into the tree without any discussion
that I noticed.
