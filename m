Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7A573BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiGMRRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMRRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:17:19 -0400
X-Greylist: delayed 104748 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 10:17:19 PDT
Received: from mail-relay232.hrz.tu-darmstadt.de (mail-relay232.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1610::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C572F035
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:17:18 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay232.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4Ljknl6YC7z43nv;
        Wed, 13 Jul 2022 19:17:15 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:8488:f081:d781:11f2] (unknown [IPv6:2001:41b8:810:20:8488:f081:d781:11f2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Ljknj6XRwz43VZ;
        Wed, 13 Jul 2022 19:17:13 +0200 (CEST)
Message-ID: <517917b7-a553-404a-c6d2-e674ddefca3e@tu-darmstadt.de>
Date:   Wed, 13 Jul 2022 19:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
To:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
In-Reply-To: <20220713064631.GC3600936@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: wltPcWKC8OOsswEez94eittb0lz+lsEV7//RYNbUGNdw6B3vyBAZH5LcC7m9zgMKiT1BHWzPU1R6JkWTldBzUwIPzg5nvNp/5+u6Ty
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> That's the bug in this code - the dedupe length EOF rounding needs
> to be more constrained as it's allowing an EOF block to be partially
> matched against any full filesystem block as long as the range from
> start to EOF in the block matches. That's the information leak right
> there, and it has nothing to do with permissions.
> 
> Hence if we restrict EOF block deduping to both the src and dst
> files having matching EOF offsets in their EOF blocks like so:
> 
> -	if (pos_in + count == size_in) {
> +	if (pos_in + count == size_in &&
> +	    (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
>                  bcount = ALIGN(size_in, bs) - pos_in;
>          } else {
>                  if (!IS_ALIGNED(count, bs))
>                          count = ALIGN_DOWN(count, bs);
>                  bcount = count;
> 	}
> 
> This should fix the bug that was reported as it prevents dedupe an
> EOF block against non-EOF blocks or even EOF blocks where EOF is at
> a different offset into the EOF block.
> 
> So, yeah, I think arguing about permissions and API and all that
> stuff is just going completely down the wrong track because it
> doesn't actually address the root cause of the information leak....

I am sorry, while I do agree about the patch, I strongly disagree 
regarding the permissions. Of course, this exact approach will not work 
anymore in practice, since up to 2^^(4096*8) tries would be needed to 
guess a single 4K block correctly.

Nevertheless it would be possible to guess the correct data for the 
whole block, since a comparison of data is still possible. So if I want 
to check whether a file contains a specific block (or one of a set) I 
can still do so, without having read access.

Whether to keep this behavior to not break backwards compatibility is 
not my decision, but the root problem of this leak is *not* about the 
minimum block size that can be deduplicated, or that it can be lowered 
by using the EOF behavior. It is about not needing read permissions to 
compare data from a file.

Best regards,
Ansgar


-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de
