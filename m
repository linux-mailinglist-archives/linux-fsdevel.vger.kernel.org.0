Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305B55E01E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiF1MnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiF1MnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:43:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF910CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DA80B81C0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4606EC3411D;
        Tue, 28 Jun 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656420183;
        bh=RQ25zXmgYP2XUCECaslIo7NC2gio5DX12COR5jcXCmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meyFdgbrVk6OhG3aD6cjIkkY+/xPhd5tY1pveCT58Epm/wVZRH629mYSeQzH4qZ4l
         xOteGjKu6XHGtrQVJES4mcSJCpZ3RzIRnqXr730WuPyBvDEDdIvU7eNJgvIJrPkMwx
         rkYVeT5FNwqP5b/UH8w4UgxiRdtUI+LDlGjQ5eJLfxiypxJQKZ56EH5x22bYx3dfNz
         Wk6IAt1J9HG5C+XsZM3hh2SVFQVRrqB+RVMyJUHkH6ts2TYBdKbjIV5IZOaqgCPEJw
         7Q5Fl3SFC0ZiGAbEejzvLIy7SiOQ3Pp6+86yKEwWEpHDA9iAzhTU9ovygswU1DcXZp
         n4RvuZ+araFxQ==
Date:   Tue, 28 Jun 2022 14:42:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 12/44] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <20220628124258.panke76r6zd6jn47@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-12-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-12-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:20AM +0100, Al Viro wrote:
> Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> result in a short copy.  In that case we need to trim the unused
> buffers, as well as the length of partially filled one - it's not
> enough to set ->head, ->iov_offset and ->count to reflect how
> much had we copied.  Not hard to fix, fortunately...
> 
> I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> rather than iov_iter.c - it has nothing to do with iov_iter and
> having it will allow us to avoid an ugly kludge in fs/splice.c.
> We could put it into lib/iov_iter.c for now and move it later,
> but I don't see the point going that way...
> 
> Fixes: ca146f6f091e "lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Does that need a

CC: stable@kernel.org # 4.19+

or sm?

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
