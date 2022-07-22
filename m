Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D857E4FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGVRGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiGVRF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:05:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47A690DAD;
        Fri, 22 Jul 2022 10:05:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MH5WOt022921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658509534; bh=x5NY6/np9zWA3SHR+ZSZe4eQA0yfCvzZw1QpBj5Mtco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WAfkNlrXDf4aPxN7fFzehBI53ZqxFDXLOQTBMm9tlVxCimVyVcRdLp72BQwtNN8hq
         xnW7Cn8hAM7rBFQQoLd1JFmBNn1vV3bbmg6dvHuIqgvNRBTHWardQVG3KR44na1iUy
         Q5VNv0fFa36STPRhqqf5ChNgiaqZf+HeO6KmofCzQDjYEQGTAl9qIYCi1+CKGeMz83
         RLVWHW6SaKbQNBKNU8uM738coRNHusUs5825IxfbNZqH96qYWSQROkFt+Xv0wed+E/
         dvJv92G3yoPkPUTGnPPcR5fMowU+n0Lk23UxHZjySPIMB3xtC+vrIgDeExEtHVwMS7
         E35MQaRXt7ayg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 785D015C3EF7; Fri, 22 Jul 2022 13:05:32 -0400 (EDT)
Date:   Fri, 22 Jul 2022 13:05:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 4/9] ext4: support STATX_DIOALIGN
Message-ID: <YtrY3A/nC023v+/V@mit.edu>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-5-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:12:23AM -0700, Eric Biggers wrote:
> -static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
> +/*
> + * Returns %true if the given DIO request should be attempted with DIO, or
> + * %false if it should fall back to buffered I/O.
> + *
> + * DIO isn't well specified; when it's unsupported (either due to the request
> + * being misaligned, or due to the file not supporting DIO at all), filesystems
> + * either fall back to buffered I/O or return EINVAL.  For files that don't use
> + * any special features like encryption or verity, ext4 has traditionally
> + * returned EINVAL for misaligned DIO.  iomap_dio_rw() uses this convention too.
> + * In this case, we should attempt the DIO, *not* fall back to buffered I/O.
> + *
> + * In contrast, in cases where DIO is unsupported due to ext4 features, ext4
> + * traditionally falls back to buffered I/O.
> + *
> + * This function implements the traditional ext4 behavior in all these cases.

Heh.  I had been under the impression that misaligned I/O fell back to
buffered I/O for ext4, since that's what a lot of historical Unix
systems did.  Obviously, it's not something I've tested since "you
should never do that".

There's actually some interesting discussion about what Linux *should*
be doing in the futre in this discussion:

https://patchwork.ozlabs.org/project/linux-ext4/patch/1461472078-20104-1-git-send-email-tytso@mit.edu/

Including the following from Christoph Hellwig:

https://patchwork.ozlabs.org/project/linux-ext4/patch/1461472078-20104-1-git-send-email-tytso@mit.edu/#1335016

> I've been doing an audit of our direct I/O implementations, and most
> of them does some form of transparent fallback, including some that
> only pretend to support O_DIRECT, but do anything special for it at all,
> while at the same time we go through greast efforts to check a file
> system actualy supports direct I/O, leading to nasty no-op ->direct_IO
> implementations as we even got that abstraction wrong.
> 
> At this point I wonder if we should simply treat O_DIRECT as a hint
> and always allow it, and just let the file system optimize for it
> (skip buffering, require alignment, relaxed Posix atomicy requirements)
> if it is set.

The thread also mentioned XFS_IOC_DIOINFO and how We Really Should
have something with equivalent functionality to the VFS --- six years
ago.  :-)


Anyway, this change to ext4 looks good.

Acked-by: Theodore Ts'o <tytso@mit.edu>

							- Ted
