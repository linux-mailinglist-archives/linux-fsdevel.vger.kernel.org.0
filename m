Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16A159C1F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiHVOwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiHVOwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:52:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF737FBA;
        Mon, 22 Aug 2022 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q5YRa5+mq/HwCfXcY5+pkEQiG+nbfa6Rah54AG40jI4=; b=stK85MZ2ZxRVqduD/jsKgbVjWq
        fxMI/8GkUln+m14de7UQl6oqrfyJlcAbjEBU+Ju5VOzsMUAFKdFU+o/OCf8xV5pG7f0gi4e6AKFbu
        fLngfUjXEEadukEUN6o25JzDGxhapPVbWcOkBC1XafjYjesERaDmOEDN9s8PIwc4vVuA25DiW2NMF
        i70XuESPmNsqviWsqxnjtiSjnLl/wpg3rO/kudU/n4GVcV1Ry30WsLsOYr9NuJBW7d3LKPbAAgtRi
        BhhkPorelqKALGQ2pALVgEwTWVwkFe/23vbOJqj6U4SNgd7UKyEs62d8LxCNcZSxkkZbj4/86avey
        1J2sLZ5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ8n2-00EN3D-GF; Mon, 22 Aug 2022 14:52:32 +0000
Date:   Mon, 22 Aug 2022 15:52:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     david <david@fromorbit.com>, djwong <djwong@kernel.org>,
        fgheet255t <fgheet255t@gmail.com>, hch <hch@infradead.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        riteshh <riteshh@linux.ibm.com>,
        syzbot+a8e049cd3abd342936b6 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <YwOYMJrvBuoVye7R@casper.infradead.org>
References: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
 <20220821114816.24193-1-code@siddh.me>
 <YwOWiDKhVxm7m0fa@casper.infradead.org>
 <182c607e79a.820e4a7012709.6365464609772129416@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182c607e79a.820e4a7012709.6365464609772129416@siddh.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:19:43PM +0530, Siddh Raman Pant wrote:
> On Mon, 22 Aug 2022 20:15:28 +0530  Matthew Wilcox  wrote:
> > On Sun, Aug 21, 2022 at 05:18:16PM +0530, Siddh Raman Pant wrote:
> > > @@ -979,9 +979,15 @@ loop_set_status_from_info(struct loop_device *lo,
> > >  
> > >       lo->lo_offset = info->lo_offset;
> > >       lo->lo_sizelimit = info->lo_sizelimit;
> > > +     lo->lo_flags = info->lo_flags;
> > > +
> > > +     /* loff_t/int vars are assigned __u64/__u32 vars (respectively) */
> > > +     if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)
> > > +             return -EOVERFLOW;
> > 
> > Why would you check lo_flags?  That really, really should be an unsigned
> > type.
> 
> I agree, but the loop_device struct has (see line 54 of loop.c):
>         int             lo_flags;
> 
> Thus, I checked for it, as we are not changing any types.

But it's not an integer.  It's a bitfield.  Nobody checks lo_flags for
"is it less than zero".  That makes it very different from lo_offset.
