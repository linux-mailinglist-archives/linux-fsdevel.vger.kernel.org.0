Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F746B10D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCHSO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCHSO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:14:26 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A9CE979;
        Wed,  8 Mar 2023 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678299229;
        bh=Vys5iYK/+fJyyDZ24nlbuNfT76U1kxqNE2Ur4f5ljdI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f6KOEdDfPn1EKPig7w/2em9x5iNEmBMrbX78lJYFRv3Nna47sj6me8EaVXh4cn2Kg
         DpTCaWuiGoHMrDJ6jxvQV2k/tcaAiQFYCVZyDvj3JxNehArnYFKwQ8v022Ba6vJ4PF
         swzPF9w1bLS1LFiX54KL8cm0FaXeQfXAbkxHVsZo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5364D1286368;
        Wed,  8 Mar 2023 13:13:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XLXb23XoE1Wf; Wed,  8 Mar 2023 13:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678299229;
        bh=Vys5iYK/+fJyyDZ24nlbuNfT76U1kxqNE2Ur4f5ljdI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f6KOEdDfPn1EKPig7w/2em9x5iNEmBMrbX78lJYFRv3Nna47sj6me8EaVXh4cn2Kg
         DpTCaWuiGoHMrDJ6jxvQV2k/tcaAiQFYCVZyDvj3JxNehArnYFKwQ8v022Ba6vJ4PF
         swzPF9w1bLS1LFiX54KL8cm0FaXeQfXAbkxHVsZo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1917B1286361;
        Wed,  8 Mar 2023 13:13:48 -0500 (EST)
Message-ID: <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Wed, 08 Mar 2023 13:13:45 -0500
In-Reply-To: <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
References: <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
         <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
         <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
         <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
         <ZAN2HYXDI+hIsf6W@casper.infradead.org>
         <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
         <ZAOF3p+vqA6pd7px@casper.infradead.org>
         <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
         <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
         <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 17:53 +0000, Matthew Wilcox wrote:
> On Mon, Mar 06, 2023 at 11:12:14AM -0500, Theodore Ts'o wrote:
> > What HDD vendors want is to be able to have 32k or even 64k
> > *physical* sector sizes.  This allows for much more efficient
> > erasure codes, so it will increase their byte capacity now that
> > it's no longer easier to get capacity boosts by squeezing the
> > tracks closer and closer, and their have been various engineering
> > tradeoffs with SMR, HAMR, and MAMR.  HDD vendors have been asking
> > for this at LSF/MM, and in othervenues for ***years***.
> 
> I've been reminded by a friend who works on the drive side that a
> motivation for the SSD vendors is (essentially) the size of sector_t.
> Once the drive needs to support more than 2/4 billion sectors, they
> need to move to a 64-bit sector size, so the amount of memory
> consumed by the FTL doubles, the CPU data cache becomes half as
> effective, etc. That significantly increases the BOM for the drive,
> and so they have to charge more.  With a 512-byte LBA, that's 2TB;
> with a 4096-byte LBA, it's at 16TB and with a 64k LBA, they can keep
> using 32-bit LBA numbers all the way up to 256TB.

I thought the FTL operated on physical sectors and the logical to
physical was done as a RMW through the FTL?  In which case sector_t
shouldn't matter to the SSD vendors for FTL management because they can
keep the logical sector size while increasing the physical one. 
Obviously if physical size goes above the FS block size, the drives
will behave suboptimally with RMWs, which is why 4k physical is the max
currently.

James

