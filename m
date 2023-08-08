Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E985D773E79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHHQbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjHHQ3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:29:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B267C9;
        Tue,  8 Aug 2023 08:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7869362465;
        Tue,  8 Aug 2023 08:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ACAC433C7;
        Tue,  8 Aug 2023 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691484061;
        bh=RjjLIZx13CGvW7yRw5fcqlfFcSXMiUPH+D4rU4Q5+yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJws1KGbdsfqt5t/8dMXBjYgLaYDm3LH6+rT5yxV2F9sPa6RnrvPRJHd9ec77cSFN
         U6s96DlFfpOIHxAwaDZRg2oZs311bmSJMW3Liu7KACwt1cvy6oDd4KnHBXyL2JtCBv
         EGbgv55m9VJ88VoICbQWsGjDy+VIARxqvq0wrfawShr4jrmSozzhRxZcBA/TGegKfF
         GYeCBVjP4OR6dHXFtonstOfp3/aZ7EniKB0dqYfbF5KZ1ZP4dp1Dx5J5Vll0DYSjtD
         VxnVed8sRrJPOV1ewTxARGkKKE2DNw0ZuKs3JXljsys75qypPSmKsPMHC/jsLWWREt
         c6YAJn8Hj+0nQ==
Date:   Tue, 8 Aug 2023 10:40:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
Message-ID: <20230808-unsensibel-scham-c61a71622ae7@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner>
 <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > And making filp_close() fully sync again is also really not great.
> 
> The patch is not doing it.

No, but you were referencing the proposed patch as an alternative in
your commit message.

> > Yes, we just did re-added the f_pos optimization because it may have had
> > an impact. And that makes more sense because that was something we had
> > changed just a few days/weeks before.
> >
> 
> I don't think perf tax on something becomes more sensible the longer
> it is there.

One does need to answer the question why it does suddenly become
relevant after all these years though.

The original discussion was triggered by fifo ordering in task work
which led to a noticable regression and why it was ultimately reverted.
The sync proposal for fput() was an orthogonal proposal and the
conclusion was that it wasn't safe generally
https://lore.kernel.org/all/20150905051915.GC22011@ZenIV.linux.org.uk
even though it wasn't a direct response to the patch you linked.

Sure, for f_pos it was obvious when and how that happend. Here? It needs
a bit more justification.

If you care about it enough send a patch that just makes close(2) go
sync. We'll stuff it in a branch and we'll see what LKP has to say about
it or whether this gets lost in noise. I really don't think letting
micro-benchmarks become a decisive factor for code churn is a good
idea.

And fwiw, yes, maybe the difference between close(2) and other parts
doesn't matter for you but for use mortals that maintain a bunch more
then just a few lines of code in file.c if you have a tiny collection of
differences in behavior everywhere it adds up. The fact that you think
it's irrelevant doesn't mean we have that luxury.

That's not to say your patches haven't been useful. Not at all. The
close_range() tweak was very much appreciated and that f_pos thing was
good to fix as well.
