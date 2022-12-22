Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93461653AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 04:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLVDYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 22:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLVDYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 22:24:41 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C75420BDA;
        Wed, 21 Dec 2022 19:24:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VXrYeJt_1671679475;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXrYeJt_1671679475)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 11:24:37 +0800
Date:   Thu, 22 Dec 2022 11:24:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-fscrypt@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>
Subject: Re: [RFC] fs-verity and encryption for EROFS
Message-ID: <Y6PN8vpE0xbppmpB@B-P7TQMD6M-0146.local>
Mail-Followup-To: linux-fscrypt@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Gao Xiang <xiang@kernel.org>
References: <Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

( + more lists )

On Wed, Dec 21, 2022 at 02:41:40PM +0800, Gao Xiang wrote:
> Hi folks,
> 
> (As Eric suggested, I post it on list now..)
> 
> In order to outline what we could do next to benefit various image-based
> distribution use cases (especially for signed+verified images and
> confidential computing), I'd like to discuss two potential new
> features for EROFS: verification and encryption.
> 
> - Verification
> 
> As we're known that currently dm-verity is mainly used for read-only
> devices to keep the image integrity.  However, if we consider an
> image-based system with lots of shared blobs (no matter they are
> device-based or file-based).  IMHO, it'd be better to have an in-band
> (rather than a device-mapper out-of-band) approach to verify such blobs.
> 
> In particular, currently in container image use cases, an EROFS image
> can consist of
> 
>   - one meta blob for metadata and filesystem tree;
> 
>   - several data-shared blobs with chunk-based de-duplicated data (in
>     layers to form the incremental update way; or some other ways like
>     one file-one blob)
> 
> Currently data blobs can be varied from (typically) dozen blobs to (in
> principle) 2^16 - 1 blobs.  dm-verity setup is much hard to cover such
> usage but that distribution form is more and more common with the
> revolution of containerization.
> 
> Also since we have EROFS over fscache infrastructure, file-based
> distribution makes dm-verity almost impossible as well. Generally we
> could enable underlayfs fs-verity I think, but considering on-demand
> lazy pulling from remote, such data may be incomplete before data is
> fully downloaded. (I think that is also almost like what Google did
> fs-verity for incfs.)  In addition, IMO it's not good if we rely on
> features of a random underlay fs with generated tree from random
> hashing algorithm and no original signing (by image creator).

random hashing algorithm, underlay block sizes, (maybe) new underlay
layout and no original signing, which impacts reproduction.

> 
> My preliminary thought for EROFS on verification is to have blob-based
> (or device-based) merkle trees but makes such image integrity
> self-contained so that Android, embedded, system rootfs, and container
> use cases can all benefit from it.. 
> 
> Also as a self-containerd verfication approaches as the other Linux
> filesystems, it makes bootloaders and individual EROFS image unpacker
> to support/check image integrity and signing easily...
> 
> It seems the current fs-verity codebase can almost be well-fitted for
> this with some minor modification.  If possible, we could go further
> in this way.
> 
> - Encryption
> 
> I also have some rough preliminary thought for EROFS encryption.
> (Although that is not quite in details as verification.)  Currently we
> have full-disk encryption and file-based encryption, However, in order
> to do finer data sharing between encrypted data (it seems hard to do
> finer data de-duplication with file-based encryption), we could also
> consider modified convergence encryption, especially for image-based
> offline data.
> 
> In order to prevent dictionary attack, the key itself may not directly be
> derived from its data hashing, but we could assign some random key
> relating to specific data as an encrypted chunk and find a way to share
> these keys and data in a trusted domain.
> 
> The similar thought was also shown in the presentation of AWS Lambda
> sparse filesystem, although they don't show much internal details:
> https://youtu.be/FTwsMYXWGB0
> 
> Anyway, for encryption, it's just a preliminary thought but we're happy
> to have a better encryption solution for data sharing for confidential
> container images... 
> 
> Thanks,
> Gao Xiang
