Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73516F563B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjECKbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjECKbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 06:31:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF934EC9;
        Wed,  3 May 2023 03:31:30 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CF251EC0691;
        Wed,  3 May 2023 12:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683109889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y99VkdVeSo9ELb0eveqnrxLTnOl5aHHav/scgPvIOtM=;
        b=ouXeturJBz5ifBkVBBhldgieqd8FYUQCI77ZvbbfE9SLgn89VNIIgLYv0fO/Yk86K3AgNy
        Pxq6jm6FAYD5LkAXSgiatQwdsjHQtG5vWjtHqTSXYwVT3EsaesKguGSma2544s5DCf0Ch9
        3rjcgLcDMCJ4RjZtdRS316g+z8+zLh0=
Date:   Wed, 3 May 2023 12:31:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+401145a9a237779feb26@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@suse.de>, stable <stable@vger.kernel.org>,
        almaz.alexandrovich@paragon-software.com, clm@fb.com,
        djwong@kernel.org, dsterba@suse.com, hch@infradead.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] [xfs?] BUG: unable to handle kernel paging request in
 clear_user_rep_good
Message-ID: <20230503103128.GAZFI4AEyPcP4bCemf@fat_crate.local>
References: <000000000000de34bd05f3c6fe19@google.com>
 <0000000000001ec6ce05fa9a4bf7@google.com>
 <CAHk-=whWUZyiFvHpkC35DXo713GKFjqCWwY1uCs3tbMJ6QXeWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whWUZyiFvHpkC35DXo713GKFjqCWwY1uCs3tbMJ6QXeWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 11:49:55AM -0700, Linus Torvalds wrote:
> The bug goes back to commit 0db7058e8e23 ("x86/clear_user: Make it
> faster") from about a year ago, which made it into v6.1.

Gah, sorry about that. :-\

> It only affects old hardware that doesn't have the ERMS capability
> flag, which *probably* means that it's mostly only triggerable in
> virtualization (since pretty much any CPU from the last decade has
> ERMS, afaik).
> 
> Borislav - opinions? This needs fixing for v6.1..v6.3, and the options are:
> 
>  (1) just fix up the exception entry. I think this is literally this
> one-liner, but somebody should double-check me. I did *not* actually
> test this:
> 
>     --- a/arch/x86/lib/clear_page_64.S
>     +++ b/arch/x86/lib/clear_page_64.S
>     @@ -142,8 +142,8 @@ SYM_FUNC_START(clear_user_rep_good)
>             and $7, %edx
>             jz .Lrep_good_exit
> 
>     -.Lrep_good_bytes:
>             mov %edx, %ecx
>     +.Lrep_good_bytes:
>             rep stosb
> 
>      .Lrep_good_exit:
> 
>    because the only use of '.Lrep_good_bytes' is that exception table entry.
> 
>  (2) backport just that one commit for clear_user
> 
>      In this case we should probably do commit e046fe5a36a9 ("x86: set
> FSRS automatically on AMD CPUs that have FSRM") too, since that commit
> changes the decision to use 'rep stosb' to check FSRS.
> 
>  (3) backport the entire series of commits:
> 
>         git log --oneline v6.3..034ff37d3407
> 
> Or we could even revert that commit 0db7058e8e23, but it seems silly
> to revert when we have so many ways to fix it, including a one-line
> code movement.
> 
> Borislav / stable people? Opinions?

So right now I feel like (3) would be the right thing to do. Because
then stable and upstream will be on the same "level" wrt user-accessing
primitives. And it's not like your series depend on anything from
mainline (that I know of) so backporting them should be relatively easy.

But (1) is definitely a lot easier for stable people modulo the fact
that it won't be an upstream commit but a special stable-only fix.

So yeah, in that order.

I guess I'd let stable people decide here what they wanna do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
