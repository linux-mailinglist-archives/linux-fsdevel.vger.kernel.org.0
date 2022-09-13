Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DA5B799A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiIMSb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiIMSbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:31:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698C6EF27;
        Tue, 13 Sep 2022 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uENaF8Aeuw2AlPXswf2tmsAc80uie0EF9ocI5lWSah4=; b=h7s9WaOqvv/tQn2jfoY5egIZOW
        PrrDUAkHI0zCIxU3oWP+jOBvWIY0JN/z7I1vi2K81QlyuGOVZkswMUBOwY9Ppnk9D4+vF6OQMmgP/
        1wrgWV3lycre6hB5fzg6vA//ecQ8V3oFAWzRedmQRfYziH++Ev3WkQzhPv3cAZfuPu79s8PTe0dj6
        Td7IdApw72FnjQ9Aidplf58ckjrsGfDRKvY7iW8v+/bSm3NitCQJw6BaPP5dZQnThPAhtiPh57tQr
        Yqldtxr6/BVfcADvQJ9CMor9HgsyXFGgALLlEEblsQEn4m43zju2EZlZYOZsBvopdp8RU1Xt73P9o
        ItoPkeoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYA0z-00FvQm-2L;
        Tue, 13 Sep 2022 17:48:05 +0000
Date:   Tue, 13 Sep 2022 18:48:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: d_path() races with do_move_mount() on ->mnt_ns, leading to
 use-after-free
Message-ID: <YyDCVSaA2Kjnz/a5@ZenIV>
References: <CAG48ez2dS04ONb-EVQGOtmeU6vTpKLe4J0W1yqa+Q9j+Hg3hFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2dS04ONb-EVQGOtmeU6vTpKLe4J0W1yqa+Q9j+Hg3hFw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 07:14:56PM +0200, Jann Horn wrote:
> As the subject says, there's a race between d_path() (specifically
> __prepend_path()) looking at mnt->mnt_ns with is_anon_ns(), and
> do_move_mount() switching out the ->mnt_ns and freeing the old one.
> This can theoretically lead to a use-after-free read, but it doesn't
> seem to be very interesting from a security perspective, since all it
> gets you is a comparison of a value in freed memory with zero.

... with d_absolute_path() being the only caller that might even
theoretically care.

	Anyway, shouldn't be hard to deal with - adding rcu_head to
struct mnt_namespace (anon-unioned with e.g. ->list) and turning kfree()
in free_mnt_ns() into kfree_rcu() ought to do it...
