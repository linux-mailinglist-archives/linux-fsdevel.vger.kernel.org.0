Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5D72DECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbjFMKMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFMKM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:12:29 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D92EE6;
        Tue, 13 Jun 2023 03:12:28 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 029085E916;
        Tue, 13 Jun 2023 13:12:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1686651146;
        bh=JCHZt/RMowuGTByB3i6nzG7sEtmRHmsCzYrBdaBijZI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Ldg8lEVWEws8TO7hjHusUvJGlpUZa8S+jCqgCPdO4Ys98qGhfGY4Gguib1I/paiaw
         aI+LM2y3S+e5E1AKlmTBkgQttAfdnEfCoW/RYJAQSfMC7Ra9y/jCXBj6sEXL4nDuww
         izMq3hnu3F0AmcoOxz1yhvFZA2QV7w6kGHy1Tf0Hrl5e+Lvm9oy22RabvLHV+GYVuG
         HTGHY8jK2T/VxTJx9hhCa0cuwLgradoJ2LVFvmjSAu/y+V2n+cEH/s+USGmZrsp14h
         ZFR4NLvZAOxmijJ9IHtvvXtiJbY1gjpF+xxAXwo5WskeyUG2gilkLLRWaPFJiIS4pU
         4UHRowkWky1cQ==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 13 Jun
 2023 12:12:24 +0200
Message-ID: <20a5802d-424d-588a-c497-1d1236c52880@veeam.com>
Date:   Tue, 13 Jun 2023 12:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 00/11] blksnap - block devices snapshots module
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux@weissschuh.net" <linux@weissschuh.net>,
        "jack@suse.cz" <jack@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612161911.GA1200@sol.localdomain>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <20230612161911.GA1200@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D766B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/12/23 18:19, Eric Biggers wrote:
> This is the first time you've received an email from this sender 
> ebiggers@kernel.org, please exercise caution when clicking on links or opening 
> attachments.
> 
> 
> On Mon, Jun 12, 2023 at 03:52:17PM +0200, Sergei Shtepa wrote:
>  > Hi all.
>  >
>  > I am happy to offer a improved version of the Block Devices Snapshots
>  > Module. It allows to create non-persistent snapshots of any block devices.
>  > The main purpose of such snapshots is to provide backups of block devices.
>  > See more in Documentation/block/blksnap.rst.
> 
> How does blksnap interact with blk-crypto?
> 
> I.e., what happens if a bio with a ->bi_crypt_context set is submitted to a
> block device that has blksnap active?
> 
> If you are unfamiliar with blk-crypto, please read
> Documentation/block/inline-encryption.rst

Thank you, this is an important point. Yes, that's right.
The current version of blksnap can cause blk-crypto to malfunction while
holding a snapshot. When handling bios from the file system, the
->bi_crypt_context is preserved. But the bio requests serving the snapshot
are executed without context. I think that the snapshot will be unreadable.

But I don't see any obstacles in the way of blksnap and blk-crypto
compatibility. If DM implements support for blk-crypto, then the same
principle can be applied for blksnap. I think that the integration of
blksnap with blk-crypto may be one of the stages of further development.

The dm-crypto should work properly. 

It is noteworthy that in 7 years of using the out-of-tree module to take
a snapshot, I have not encountered cases of such problems.
But incompatibility with blk-crypto is possible, this is already a pain
for some users. I will request this information from our support team.

> 
> It looks like blksnap hooks into the block layer directly, via the new
> "blkfilter" mechanism. I'm concerned that it might ignore ->bi_crypt_context
> and write data to the disk in plaintext, when it is supposed to be encrypted.

No. The "blkfilter" mechanism should not affect the operation of blk-crypto.
It does not change the bio.
Only a module that has been attached and provides its own filtering algorithm,
such as blksnap, can violate the logic of blk-crypto.
Therefore, until the blksnap module is loaded, blk-crypto should work as before.
