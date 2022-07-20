Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788C57BD50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGTSAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGTSAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:00:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF89255B5;
        Wed, 20 Jul 2022 11:00:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KI0Q6R031583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 14:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658340027; bh=LcIDMM196v1O0Vu2AIjCOIneCxRQW31lP+K7zkUlg6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GCzFD5F2Hq66UNmt59r+kDnSVe548Xmd0J3CxH99DQcTBVpdpBlnvgelOJUXg8ZPJ
         6jGxs1saONG8zwkQBfQGsARcDNuocZguT/EJRCwoyWnlO/YPqfUyHTGN4UgLiLi+cK
         WTmaQV0ffwDsGlyDm6HS8bBv/cnwpaRBFoRkk3l6LPddef9cj5p7HKpiC7Xtd2Yff2
         j9CFZ5xO3gVK1sqS8YlUIDq9H+vsaALPqBtXsNa2sKvg9hhQiAjak0+DRc5P0ZJoEj
         q0+VgQM4MXGk5RH+AmxpIsjzKMDdqQoAeEh/lDMwWnbxEZgx6WUWNxqrR0ijw8OzGW
         pqD2kwoUQMAXQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D2DD515C3EBF; Wed, 20 Jul 2022 14:00:25 -0400 (EDT)
Date:   Wed, 20 Jul 2022 14:00:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YthCucuMk/SAL0qN@mit.edu>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
 <YtgNCfMcuX7DGg7z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtgNCfMcuX7DGg7z@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> Uhhh.  So what are the semantics of len?  That is, on SET, what does
> a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> usually uses 16 bytes?  What does the same filesystem do if userspace
> offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> userspace discover what size of volume ID is acceptable to a particular
> filesystem?
> 
> And then, on GET, does 'len' just mean "here's the length of the buffer,
> put however much will fit into it"?  Should filesystems update it to
> inform userspace how much was transferred?

What I'd suggest is that for GET, the length field when called should
be the length of the buffer, and if the length is too small, we should
return some error --- probably EINVAL or ENOSPC.  If the buffer size
length is larger than what is needed, having the file system update it
with the size of the UUID that was returned.

And this would be how the userspace can discover size of the UUID.  In
practice, though, the human user is going to be suppliyng the UUID,
which means the *human* is going to have to understand that "oh, this
is a VFAT file system, so I need to give 32-bit UUID formatted as
DEAD-BEAF" or "oh, this is a ntfs file system, so I need to enter into
the command line a UUID formatted as the text string
A24E62F14E62BDA3".  (The user might also end up having to ntfs or vfat
specific uuid changing tool; that's unclear at this point.)

As far as Jeremy's patch is concerned, I don't think we need to change
anything forthe SET ioctl, but for the GET util, it would be better in
the extremely unlikely case where the user pass in a length larger
than 16 bytes (say, 32), that we return the 16 byte UUID, and update
the length field to be 16 bytes.

I don't think it's strictly necessary, since in practice there is no
reason why a file system's volume identifier would ever be larger than
16 bytes --- the chances that we might need an extra 240 bytes to
specify a multiverse identifier seems.... unlikely.  :-)

				- Ted
