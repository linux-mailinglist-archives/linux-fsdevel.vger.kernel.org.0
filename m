Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53C4AE6DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiBICk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiBIBKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:10:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C26C061576;
        Tue,  8 Feb 2022 17:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25BA9CE1B70;
        Wed,  9 Feb 2022 01:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1738FC004E1;
        Wed,  9 Feb 2022 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644369005;
        bh=G5uU/wOKKaUc/jSB9K/5/TwossD5zIXWmIxvGuOzgDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g64r5u3/yYniiCa/eGal3suK3t2qCPO5J8yjTr+WXAz7eV8KGckCF1qJnGp4mlxhX
         crxCbvMqVjF5t9z3Kuu1yHICd1AwKVPz3WqXQnJYZ0PF+coVPc/INbvPtR92OX3HcR
         dBCA8/tfnlboHQALxTmSwSdkdK+N8WfRFJWOuNK5Nm6AgMGyFPkClxPMB/1pE7ZC4C
         5PKfXBrFi/q2I57lmvcg+8rUmLtSyDlaEf77EXpbYqh+gGIXMnDUHQ7qAwldeiiq88
         +CJL66sz2DcUB4BxmkrZ2zXSjF4uhel4U7JdVSe6+TycxOaMGjw/YzGUBLNnxgJY0o
         R3TY12fL2xvBA==
Date:   Tue, 8 Feb 2022 17:10:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YgMUa2Cdr/QoMTPh@sol.localdomain>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
 <Yenm1Ipx87JAlyXg@sol.localdomain>
 <20220120235755.GI59729@dread.disaster.area>
 <20220121023603.GH13563@magnolia>
 <20220123230332.GL59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220123230332.GL59729@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:03:32AM +1100, Dave Chinner wrote:
> > 
> > 	/* 0xa0 */
> > 
> > 	/* File range alignment needed for best performance, in bytes. */
> > 	__u32	stx_dio_fpos_align_opt;
> 
> This is a common property of both DIO and buffered IO, so no need
> for it to be dio-only property.
> 
> 	__u32	stx_offset_align_optimal;
> 

Looking at this more closely: will stx_offset_align_optimal actually be useful,
given that st[x]_blksize already exists?

From the stat(2) and statx(2) man pages:

	st_blksize
		This field  gives  the  "preferred"  block  size  for  efficient
		filesystem I/O.

	stx_blksize
		The "preferred" block size for efficient filesystem I/O.  (Writ‐
		ing  to  a file in smaller chunks may cause an inefficient read-
		modify-rewrite.)

File offsets aren't explicitly mentioned, but I think it's implied they should
be a multiple of st[x]_blksize, just like the I/O size.  Otherwise, the I/O
would obviously require reading/writing partial blocks.

So, the proposed stx_offset_align_optimal field sounds like the same thing to
me.  Is there anything I'm misunderstanding?

Putting stx_offset_align_optimal behind the STATX_DIRECTIO flag would also be
confusing if it would apply to both direct and buffered I/O.

- Eric
