Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76559C1E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiHVOuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiHVOun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:50:43 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0B37F85;
        Mon, 22 Aug 2022 07:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661179794; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=YQAijLv/Lbe14OzPr0mzRNLoZDvTRpLfUEXGcqbBRD0kKEJpxanXVquWrV+UG5BzCpVTbdpPoAfaViDmO9Thws5J0c/C/ZmEqZR8VtXXLZFdpiPT5dhkCNxH5RYO6XpSVtnLc61mL2bJv9t5T0ojwqy6+HcfHjsM4Hrol7pNWKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661179794; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1/As8HiBTtKLJWHkLMxaHWVm4vefy+krh2lK8/Fqr0c=; 
        b=TLge55SnZLPUoGrT3ldSzWOlKutcuTsQAYnfBs7JCAqCgRV1wbWsTQUWKWM2pSJutvr96D9XHXfRvsNBunzD/gwaGQw9XZPpTekvU/4of0P9v/757osBcs+OCLxj80qJGA/FKe7vf8XyjzTJbGH+JMP9NFVu75rk74NoZl1FK48=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661179794;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=1/As8HiBTtKLJWHkLMxaHWVm4vefy+krh2lK8/Fqr0c=;
        b=tdihgEUStPOrWmTSRI9/Urp0AQkosKaE04zWb59kO++QUug9D9Dh7yg7ZAdWlIwi
        Z5wK8l4x9vv1rdJ8J/S4ap7hYq8nBhqYIhipepmCZujkrMcN+P2bDtN5kMtxSN9YAj3
        fqrA3hGM7sj5i5bEjtHU5fIST9eXwUm9KONh4Naw=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1661179783103133.49004819986476; Mon, 22 Aug 2022 20:19:43 +0530 (IST)
Date:   Mon, 22 Aug 2022 20:19:43 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "david" <david@fromorbit.com>, "djwong" <djwong@kernel.org>,
        "fgheet255t" <fgheet255t@gmail.com>, "hch" <hch@infradead.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>,
        "riteshh" <riteshh@linux.ibm.com>,
        "syzbot+a8e049cd3abd342936b6" 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <182c607e79a.820e4a7012709.6365464609772129416@siddh.me>
In-Reply-To: <YwOWiDKhVxm7m0fa@casper.infradead.org>
References: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
 <20220821114816.24193-1-code@siddh.me> <YwOWiDKhVxm7m0fa@casper.infradead.org>
Subject: Re: [syzbot] WARNING in iomap_iter
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Aug 2022 20:15:28 +0530  Matthew Wilcox  wrote:
> On Sun, Aug 21, 2022 at 05:18:16PM +0530, Siddh Raman Pant wrote:
> > @@ -979,9 +979,15 @@ loop_set_status_from_info(struct loop_device *lo,
> >  
> >       lo->lo_offset = info->lo_offset;
> >       lo->lo_sizelimit = info->lo_sizelimit;
> > +     lo->lo_flags = info->lo_flags;
> > +
> > +     /* loff_t/int vars are assigned __u64/__u32 vars (respectively) */
> > +     if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)
> > +             return -EOVERFLOW;
> 
> Why would you check lo_flags?  That really, really should be an unsigned
> type.

I agree, but the loop_device struct has (see line 54 of loop.c):
        int             lo_flags;

Thus, I checked for it, as we are not changing any types.

Thanks,
Siddh
