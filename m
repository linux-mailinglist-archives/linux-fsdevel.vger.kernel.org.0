Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158975703F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGQXJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 19:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGQXJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:09:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45791198
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 16:08:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a1e6022b93so3708389b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689635308; x=1692227308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hD4JEP1fqNjsd6/Thhkhf4NODGfDet8t60Eb54LdlhQ=;
        b=XQ+HW7KBLR6UyEEa71S7PBEisxabnkDtV8i4UE1k0Bf/lAGlMypNtUKMMkujySlgt+
         jSqgPMIxNi0lkjmbIRoznQ2gstweOycKyIjsItR97KYZpdIOhGmVbu1OClW89cfIEG9G
         ZpEgk9pZC/NoamEUmZjcXYdcFFMJMwRvyliAFXuWnIsIo2dwWhBZicWfKZAnCKtt7FsD
         KH2uLj01pTbDFddsxOUbj5IDOdsgkKAYR7nC8MVa2XqN+E2prq5d+zbbYjOQEMrfKWxN
         vdNvW4I3FN1Yi72np4Rwx8tsEpc0G7sTPWLtWBKq/FODMH9oIQ/6svnSK1GQ4p6gPZc4
         86sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689635308; x=1692227308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hD4JEP1fqNjsd6/Thhkhf4NODGfDet8t60Eb54LdlhQ=;
        b=U2ZimiC1CBDoRe6/3PgkMufhxZHipM/W9xR6D7Knj7vAjbUhMDhqpOtOdK19KTONEh
         /hYPb3g5DMJRt0yz4fzLI0ac2tujcmao3cCQ9lWXVcLSFW41HW2lzdQ3z5FRhULBzKJW
         cbrcih5EbivEzGPXcdtamR2JMuay51Rwz4nvK/T75Y1s6vFoxAHy4fUS8/bTTlsQyadZ
         tdWEU1F7JIxsdNKzvodtek/XZ/oLfQw9lgOFRocefOHRq3LBPybmNmLue964y1zqmWIT
         eBJAg1eV32GlOOW5gwCIhti1Dc2POre6zN6+qzAGHmCyauULGaNx6GgdOfbWI0vR2iEp
         gqPA==
X-Gm-Message-State: ABy/qLZlbh+YuusgOaKUJtQx7O/cy3so4r3PmZjGpVezDPaA69L8lcno
        GxGmETe/RXNN6DRUQy/qSFoNFA==
X-Google-Smtp-Source: APBJJlEboVbmgtnsM3AhS/78nKaTtrHt8yZ4sN8p5ee7PCLeyIx1Czk9YISH+fZrMmQEXiMtxBlvxA==
X-Received: by 2002:a05:6808:20aa:b0:3a1:eb0e:ddc6 with SMTP id s42-20020a05680820aa00b003a1eb0eddc6mr14001585oiw.29.1689635307772;
        Mon, 17 Jul 2023 16:08:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id x5-20020a63b205000000b005533c53f550sm317793pge.45.2023.07.17.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 16:08:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qLXKJ-007LR9-0R;
        Tue, 18 Jul 2023 09:08:23 +1000
Date:   Tue, 18 Jul 2023 09:08:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Leesoo Ahn <lsahn@ooseel.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
Message-ID: <ZLXJ53zUlOUiIsgq@dread.disaster.area>
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
 <ZLMtifV5ta5VTQ2e@dread.disaster.area>
 <c32d3a3d-c2a7-fd18-9e14-ea5d9e0abb88@wewakecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32d3a3d-c2a7-fd18-9e14-ea5d9e0abb88@wewakecorp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:08:07AM +0900, Leesoo Ahn wrote:
> 23. 7. 16. 08:36에 Dave Chinner 이(가) 쓴 글:
> > On Sat, Jul 15, 2023 at 05:22:04PM +0900, Leesoo Ahn wrote:
> >  > Return -EOPNOTSUPP instead of -EINVAL which has the meaning of
> >  > the argument is an inappropriate value. The current error code doesn't
> >  > make sense to represent that a file system doesn't support bmap
> > operation.
> >  >
> >  > Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> >  > ---
> >  > Changes since v1:
> >  > - Modify the comments of bmap()
> >  > - Modify subject and description requested by Markus Elfring
> >  >
> > https://lore.kernel.org/lkml/20230715060217.1469690-1-lsahn@wewakecorp.com/
> >  >
> >  > fs/inode.c | 4 ++--
> >  > 1 file changed, 2 insertions(+), 2 deletions(-)
> >  >
> >  > diff --git a/fs/inode.c b/fs/inode.c
> >  > index 8fefb69e1f84..697c51ed226a 100644
> >  > --- a/fs/inode.c
> >  > +++ b/fs/inode.c
> >  > @@ -1831,13 +1831,13 @@ EXPORT_SYMBOL(iput);
> >  > * 4 in ``*block``, with disk block relative to the disk start that
> > holds that
> >  > * block of the file.
> >  > *
> >  > - * Returns -EINVAL in case of error, 0 otherwise. If mapping falls
> > into a
> >  > + * Returns -EOPNOTSUPP in case of error, 0 otherwise. If mapping
> > falls into a
> >  > * hole, returns 0 and ``*block`` is also set to 0.
> >  > */
> >  > int bmap(struct inode *inode, sector_t *block)
> >  > {
> >  > if (!inode->i_mapping->a_ops->bmap)
> >  > - return -EINVAL;
> >  > + return -EOPNOTSUPP;
> >  >
> >  > *block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
> >  > return 0;
> > 
> > What about the CONFIG_BLOCK=n wrapper?
> How does it work? Could you explain that in details, pls?
> However, as far as I understand, bmap operation could be NULL even though
> CONFIG_BLOCK is enabled. It totally depends on the implementation of file
> systems.

That wrapper returns -EINVAL unconditionally. If CONFIG_BLOCK=n,
then by your reasoning it should return -EOPNOTSUPP, not -EINVAL,
so you need to fix that as well.

> > 
> > Also, all the in kernel consumers squash this error back to 0, -EIO
> > or -EINVAL, so this change only ever propagates out to userspace via
> > the return from ioctl(FIBMAP). Do we really need to change this and
> > risk breaking userspace that handles -EINVAL correctly but not
> > -EOPNOTSUPP?
> That's a consideration and we must carefully modify the APIs which
> communicate to users. But -EINVAL could be interpreted by two cases at this
> point that the first, for sure an argument from user to kernel is
> inappropriate, on the other hand, the second case would be that a file
> system doesn't support bmap operation. However, I don't think there is a
> proper way to know which one is right from user.

That doesn't matter a whole lot - what matters is if the change of
return value breaks existing userspace binaries. That's on you to
audit all known userspace users (e.g. via debian codesearch) to
determine that nothing in userspace using FIBMAP cares about the
change of return value.

> For me, the big problem is that user could get confused by these two cases
> with the same error code.

So you're talking about a theoretical problem, not an actual real
world issue that is causing an application to do the wrong thing?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
