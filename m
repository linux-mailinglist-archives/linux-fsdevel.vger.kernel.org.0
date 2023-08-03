Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474A76EC26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjHCOQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjHCOP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614A1723;
        Thu,  3 Aug 2023 07:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A58F61DBE;
        Thu,  3 Aug 2023 14:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B12C433C8;
        Thu,  3 Aug 2023 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691072148;
        bh=Lm8PKJ8BsqNaM2RoQstWok5V7en/KohpIijSZJ2qF44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZauymS7r7QE4V7r8ZupCG1iNiZ16l1BZ5Z6XhmTm4cEi48urCXXfb22mDNCMblz2
         29dNYzk0V9ZVlU9gRwC/IFNgshNCJ9OMpvrYJ0UXa4S6YtxAJbdW+HO77Nw3kNbk/b
         3pg0lo+m72U68JqNCeGmxGSm4TC2sldrdYdeQdqTZxijDEp+/H8CtgAE1ftiKHBkSR
         4qfqNtCOhmcoGyEWSIN90pPSrzyp0U6oJJorUkzM2xh835HaiBwjd6KX6W5OHg/nhN
         u3BXkBo9L3pjUM1292xFxayaJumr6bfsmRf9GDhV2O3uPmqfMLpgrQv7An51orfAID
         mtgxwwfhfc6rA==
Date:   Thu, 3 Aug 2023 16:15:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230803-segeln-hemmen-34df115b4914@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner>
 <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803095311.ijpvhx3fyrbkasul@f>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:53:11AM +0200, Mateusz Guzik wrote:
> On Mon, Jul 24, 2023 at 09:59:15AM -0700, Linus Torvalds wrote:
> > I really hate making the traditional unix single-threaded file
> > descriptor case take that lock.
> > 
> > Maybe it doesn't matter. Obviously it can't have contention, and your
> > patch in that sense is pretty benign.
> > 
> > But locking is just fundamentally expensive in the first place, and it
> > annoys me that I never realized that pidfd_getfd() did that thing that
> > I knew was broken for /proc.
> > 
> 
> So I got curious what the impact is and checked on quite a modern CPU
> (Sapphire Rapid), so nobody can claim it's some old yeller and atomics
> are nowhere near as expensive on modern uarchs.
> 
> I used read1_processes from will-it-scale -- it is doing 4KB reads at a
> time over a 1MB file and dodges refing the file, but it does not dodge
> the lock with the patch at hand.
> 
> In short, I got a drop of about 5% (~5778843 -> ~5500871 ops/s).
> 
> The kernel was patched with a toggle to force or elide the proposed
> mandatory locking, like so:
> @@ -1042,8 +1044,10 @@ unsigned long __fdget_pos(unsigned int fd)
>         struct file *file = (struct file *)(v & ~3);
> 
>         if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> -               v |= FDPUT_POS_UNLOCK;
> -               mutex_lock(&file->f_pos_lock);
> +               if (file_count(file) > 1 || fdget_pos_mutex) {
> +                       v |= FDPUT_POS_UNLOCK;
> +                       mutex_lock(&file->f_pos_lock);
> +               }
>         }
>         return v;
>  }
> 
> I got rather unstable single-threaded perf, going up and down several %
> between runs, I don't know yet what's that about. But toggling back and

We've had the whole lkp intel performance testsuite run on this for a
long time to see whether there any performance regressions that aren't
in the noise. This includes all of will-it-scale. Also with a focus on
single-thread performance. So I'm a little skeptical about the
reliability of manual performance runs in comparison.

If Linus thinks it matters then I think we should only take the
f_pos_lock unconditionally on directory fds as this is where it really
matters. For read/write we're only doing it because of posix anyway and
using pidfd_getfd() is squarely out of posix anyway. So we can document
that using pidfd_getfd() on a regular file descriptor outside of a
seccomp stopped task is not recommended.
