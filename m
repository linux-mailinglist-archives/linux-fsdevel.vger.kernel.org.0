Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4C659C66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiL3VN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:13:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBF1C40D;
        Fri, 30 Dec 2022 13:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 849AC61C1A;
        Fri, 30 Dec 2022 21:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81276C433D2;
        Fri, 30 Dec 2022 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672434831;
        bh=K8Be9B7MZ1FBqjy0IqxfebJV0CPskx6ZPtnR4uccYco=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=EA2Yrb54u88yl5wFtp/iGxl7jW+s4otHjUiIw49mC4zYu7GO1K8HJf1fI1py+rymR
         jkFv5NkA7lxpZlLjOqrRZguDwLvcGF3voyHEpIKaITsnjxBx/VFm6hZunH8velDZzn
         88EtFQyIztL9gF8/Y8TahDpqU9vFYeLAH9I4MT1oJ+QAYjkCiydBfoM4NBh63JP+/I
         SBB/T5qRWGXRu33scOJ7cHHEnSitj4WiLFB/pj9gdH6VowQ0HczyWgRMMtI6OTC23Q
         O1+XoaQAmdq81Jw8rPdgE/tnFVA8Ksv9xpqSEcsIE3OxH3hHxPJnEE/M8386Zo68rt
         a8BaF2I7lUWyg==
Date:   Fri, 30 Dec 2022 13:13:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>
Subject: Re: [RFC] fs-verity and encryption for EROFS
Message-ID: <Y69UjZP4dNYdbXW0@sol.localdomain>
References: <Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local>
 <Y6PN8vpE0xbppmpB@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6PN8vpE0xbppmpB@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gao,

On Thu, Dec 22, 2022 at 11:24:34AM +0800, Gao Xiang wrote:
> ( + more lists )
> 
> On Wed, Dec 21, 2022 at 02:41:40PM +0800, Gao Xiang wrote:
> > Hi folks,
> > 
> > (As Eric suggested, I post it on list now..)
> > 
> > In order to outline what we could do next to benefit various image-based
> > distribution use cases (especially for signed+verified images and
> > confidential computing), I'd like to discuss two potential new
> > features for EROFS: verification and encryption.
> > 
> > - Verification
> > 
> > As we're known that currently dm-verity is mainly used for read-only
> > devices to keep the image integrity.  However, if we consider an
> > image-based system with lots of shared blobs (no matter they are
> > device-based or file-based).  IMHO, it'd be better to have an in-band
> > (rather than a device-mapper out-of-band) approach to verify such blobs.
> > 
> > In particular, currently in container image use cases, an EROFS image
> > can consist of
> > 
> >   - one meta blob for metadata and filesystem tree;
> > 
> >   - several data-shared blobs with chunk-based de-duplicated data (in
> >     layers to form the incremental update way; or some other ways like
> >     one file-one blob)
> > 
> > Currently data blobs can be varied from (typically) dozen blobs to (in
> > principle) 2^16 - 1 blobs.  dm-verity setup is much hard to cover such
> > usage but that distribution form is more and more common with the
> > revolution of containerization.
> > 
> > Also since we have EROFS over fscache infrastructure, file-based
> > distribution makes dm-verity almost impossible as well. Generally we
> > could enable underlayfs fs-verity I think, but considering on-demand
> > lazy pulling from remote, such data may be incomplete before data is
> > fully downloaded. (I think that is also almost like what Google did
> > fs-verity for incfs.)  In addition, IMO it's not good if we rely on
> > features of a random underlay fs with generated tree from random
> > hashing algorithm and no original signing (by image creator).
> 
> random hashing algorithm, underlay block sizes, (maybe) new underlay
> layout and no original signing, which impacts reproduction.
> 
> > 
> > My preliminary thought for EROFS on verification is to have blob-based
> > (or device-based) merkle trees but makes such image integrity
> > self-contained so that Android, embedded, system rootfs, and container
> > use cases can all benefit from it.. 
> > 
> > Also as a self-containerd verfication approaches as the other Linux
> > filesystems, it makes bootloaders and individual EROFS image unpacker
> > to support/check image integrity and signing easily...
> > 
> > It seems the current fs-verity codebase can almost be well-fitted for
> > this with some minor modification.  If possible, we could go further
> > in this way.

More details and background information would be really appreciated here.  I
thought that EROFS is a simple block-device based filesystem.  It sounds like
that's fundamentally changed.  How does it work now?

Part of the issue is that crazy proposals involving fsverity are a dime a dozen;
recent examples are
https://lore.kernel.org/r/20211112124411.1948809-6-roberto.sassu@huawei.com
https://lore.kernel.org/r/D3AF9D1E-12E1-434F-AEA4-5892E8BC66AB@gmail.com and
https://lore.kernel.org/r/cover.1669631086.git.alexl@redhat.com.
It's hard to know which ones to pay attention to, and they tend to just go away
on their own anyway.

You haven't provided enough details for me to properly understand your proposal,
but to me it sounds similar to the Composefs proposal
(https://lore.kernel.org/r/cover.1669631086.git.alexl@redhat.com).  That
proposal made some amount of sense, and it came with documentation and code.
IIUC, in Composefs (a) all filesystem metadata is trusted and provided at mount
time, and (b) all file contents are untrusted and are retrieved from external
backing files.  So to authenticate a file's contents, the filesystem metadata
just needs to include a cryptographic hash of that file's contents, and the
filesystem just needs to compare the actual hash to that expected hash.  Of
course, one way to implement that is to use fsverity file digests and to enforce
that the backing file has fsverity enabled with the correct digest.

It sounds like what you are proposing in EROFS is similar, but differs in that
you want block-level data deduplication as well.  That presumably means that
EROFS will represent file contents as a list of deduplicated data blocks, each
of which is fairly small and not randomly accessible.

In that case a Merkle tree over each block would not make sense.  There should
just be a standard cryptographic hash for each block.

So I don't see how fsverity would be relevant at all.

Does that sound right to you?

> > - Encryption
> > 
> > I also have some rough preliminary thought for EROFS encryption.
> > (Although that is not quite in details as verification.)  Currently we
> > have full-disk encryption and file-based encryption, However, in order
> > to do finer data sharing between encrypted data (it seems hard to do
> > finer data de-duplication with file-based encryption), we could also
> > consider modified convergence encryption, especially for image-based
> > offline data.
> > 
> > In order to prevent dictionary attack, the key itself may not directly be
> > derived from its data hashing, but we could assign some random key
> > relating to specific data as an encrypted chunk and find a way to share
> > these keys and data in a trusted domain.
> > 
> > The similar thought was also shown in the presentation of AWS Lambda
> > sparse filesystem, although they don't show much internal details:
> > https://youtu.be/FTwsMYXWGB0
> > 
> > Anyway, for encryption, it's just a preliminary thought but we're happy
> > to have a better encryption solution for data sharing for confidential
> > container images... 

How would this compare to the old-school approach (commonly used by backup
software) of just encrypting the deduplicated data blocks with the user's key?
That leaks information about the plaintext, but it's usually considered an
acceptable tradeoff.

- Eric
