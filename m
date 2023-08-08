Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88D77466D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHHS4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjHHS4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078AD1C122;
        Tue,  8 Aug 2023 10:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E25B61E42;
        Tue,  8 Aug 2023 17:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28981C433C8;
        Tue,  8 Aug 2023 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691514942;
        bh=apH+qiOqeJxeLyzLUA1K3dhP4vFknmtuzAyxBWPTK78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1UIpkOREea/yXthnkn0ZhGKna3EmHQip+e51Y2RIFBHQlaw3PlwrENAdo2ZOG8qN
         c4a7Of73LfzyNTSBMNNsA+XEyREePVmCNzyBlpt48/LOrc9BCtFrYBo8d4W/OlkR3T
         r993gJS3hdcTT4GkUMLf1TE0aW9zeFlGE2KSZUlYWAzmuH5Z3CwqiESuK9kKdaqJ4P
         d01GxW3UBF27EmHhYDPmv+pWgNBfSspDwjrTyseVKEi/ez4CiF2P/HSy9mYLaRXlRg
         HIhaQ1Lv7V5a0v3/3mSWOGIGlUw3uTcJvDrR/cS7kJodwyvjfz6dslC3BcNeXwBAWB
         xS4CEK+aPCrUw==
Date:   Tue, 8 Aug 2023 19:15:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
Message-ID: <20230808-jacken-feigen-46727b8d37ad@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:57:04AM -0700, Linus Torvalds wrote:
> On Mon, 7 Aug 2023 at 22:57, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Taking a quick look at the history it appears that fput was always
> > synchronous [..]
> 
> Indeed. Synchronous used to be the only case.
> 
> The reason it's async now is because several drivers etc do the final
> close from nasty contexts, so 'fput()' needed to be async for the
> general case.
> 
> > All 3 issues taken together says that a synchronous fput is a
> > loaded foot gun that must be used very carefully.   That said
> > close(2) does seem to be a reliably safe place to be synchronous.
> 
> Yes.
> 
> That said, I detest Mateusz' patch. I hate these kinds of "do
> different things based on flags" interfaces. Particularly when it
> spreads out like this.
> 
> So I do like having close() be synchronous, because we actually do
> have correctness issues wrt the close having completed properly by the
> time we return to user space, so we have that "task_work_add()" there
> that will force the synchronization anyway before we return.
> 
> So the system call case is indeed a special case. Arguably
> close_range() could be too, but honestly, once you start doing ranges
> of file descriptors, you are (a) doint something fairly unusual, and
> (b) the "queue them up on the task work" might actually be a *good*
> thing.
> 
> It's definitely not a good thing for the single-fd-close case, though.
> 
> But even if we want to do this - and I have absolutely no objections
> to it conceptually as per above - we need to be a lot more surgical
> about it, and not pass stupid flags around.
> 
> Here's a TOTALLY UNTESTED(!) patch that I think effectively does what
> Mateusz wants done, but does it all within just fs/open.c and only for
> the obvious context of the close() system call itself.
> 
> All it needs is to just split out the "flush" part from filp_close(),
> and we already had all the other infrastructure for this operation.
> 
> Mateusz, two questions:
> 
>  (a) does this patch work for you?
> 
>  (b) do you have numbers for this all?

I really would like to have good ways of testing the impact of such
things because I'm a little scared of endless optimization patches that
overall either complicate or uglify our code. Maybe I'm paranoid, maybe
that's dumb but it worries me.

> 
> and if it all looks good I have no problems with this kind of much
> more targeted and obvious patch.
> 
> Again: TOTALLY UNTESTED. It looks completely obvious, but mistakes happen.

I think you're at least missing the removal of the PF_KTHREAD check in

  void __fput_sync(struct file *file)
  {
          if (atomic_long_dec_and_test(&file->f_count)) {
-                  struct task_struct *task = current;
-                 BUG_ON(!(task->flags & PF_KTHREAD));
                  __fput(file);
          }
  }

so right now we'd BUG_ON(). It'd be neat to leave that in so
__fput_sync() doesn't get proliferated to non PF_KTHREAD without us
noticing. So maybe we just need a tiny primitive.
