Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D301524248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 04:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiELCEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 22:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiELCED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 22:04:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F66004D;
        Wed, 11 May 2022 19:04:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i20so3353915qti.11;
        Wed, 11 May 2022 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKj8jxm3PJ1HqAeGJYpiNS9EwKRD2eKy/LFheqZP3ac=;
        b=faGP9WAoksFwotSiYEUmnlpq6avsHibD2TyMrneAdFu6WBXrrNx3wKqImB3xBlNajM
         Xze1dUZ97pZMxskl6RxwGwtni1zfiU+LqZvkSVkBPm/mpCf8fMMouWm7tKSkGXyDZLhf
         IxNIV1fKET+PmvenjZi8jN7WcxdtSXQR9FvcE/PVl8dUND2h1NFfe8ANG1opCBgt2H7x
         Eb78u8AJkvI4TEuCt2Ib2ojeZdwYT6Dhs77khR860i+Q7I9cwiBxxaD8yvWPpfqSlwpq
         sjHLypYC0vQfRNeATkSaZ8e2Ubb0wJG2ZUaUTYMefLwz3XZST2KtAdp9jlIwaJvWAM0I
         zDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKj8jxm3PJ1HqAeGJYpiNS9EwKRD2eKy/LFheqZP3ac=;
        b=1eYlHIVd+Owmyn2dHuQqaRPuv2pmjACbW7VOQmxcAIFlfaSr5X+8tggFN+LAK2x6dh
         LQp67IOKgw3MRKmnI427yHXdxo25wzNpEap/GFA93Kb6DlYkyzL0AF07YAghR/l16pWP
         1SA9IGKnXM3zCnBEzQvlnBuylGkVoFnDe+s/G2YXdTLRkJXDzMyuwc3JeUKDyIt9wy/K
         tZnIP8WMDEGqiKVPhFPmiRI1CE3W/UMwKMVnob8t1vxjqdlM7U8/6ZIMcThLxf71j/oP
         rn4dDNZFwjr9J2gFfnglYMyo3QWlk2+Jl/80DGmh2ZfDio9XcuS/CeE87ATzPikrp3mC
         pabA==
X-Gm-Message-State: AOAM531Gq9fYKRuxM08iuP4+0yWSovFz/IkeoFXrOOn9LskUSYCOo4HV
        JtpOvLuiruMHurPBUSpEazoAt+Czl+aiuKLQQsQ=
X-Google-Smtp-Source: ABdhPJwIsbYoZPpeisV04Xj/xUlru5weoOQq84uwSEf+EVi1KxdMcxbxFZ41GBSgGDYthyoDrfOamMudkWv3rsMItrI=
X-Received: by 2002:ac8:5b06:0:b0:2f3:d6c1:e5df with SMTP id
 m6-20020ac85b06000000b002f3d6c1e5dfmr18413172qtw.535.1652321040586; Wed, 11
 May 2022 19:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220511154503.28365-1-cgxu519@mykernel.net> <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com> <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
In-Reply-To: <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 May 2022 19:03:49 -0700
Message-ID: <CAADnVQ+tcrDQxb769yMYvyzPHcgZXozqYq0uj4QHi+kjzBYTvQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: move fdput() to right place in ksys_sync_file_range()
To:     Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        Brian Vazquez <brianvv@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 2:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [bpf folks Cc'd]
>
> On Wed, May 11, 2022 at 07:01:34PM +0000, Eric Biggers wrote:
> > On Wed, May 11, 2022 at 04:51:34PM +0100, Matthew Wilcox wrote:
> > > On Wed, May 11, 2022 at 11:45:03AM -0400, Chengguang Xu wrote:
> > > > Move fdput() to right place in ksys_sync_file_range() to
> > > > avoid fdput() after failed fdget().
> > >
> > > Why?  fdput() is already conditional on FDPUT_FPUT so you're ...
> > > optimising the failure case?
> >
> > "fdput() after failed fdget()" has confused people before, so IMO it's worth
> > cleaning this up.  But the commit message should make clear that it's a cleanup,
> > not a bug fix.  Also I recommend using an early return:
> >
> >       f = fdget(fd);
> >       if (!f.file)
> >               return -EBADF;
> >       ret = sync_file_range(f.file, offset, nbytes, flags);
> >       fdput(f);
> >       return ret;
>
> FWIW, fdput() after failed fdget() is rare, but there's no fundamental reasons
> why it would be wrong.  No objections against that patch, anyway.
>
> Out of curiousity, I've just looked at the existing users.  In mainline we have
> 203 callers of fdput()/fdput_pos(); all but 7 never get reached with NULL ->file.
>
> 1) There's ksys_sync_file_range(), kernel_read_file_from_fd() and ksys_readahead() -
> all with similar pattern.  I'm not sure that for readahead(2) "not opened for
> read" should yield the same error as "bad descriptor", but since it's been a part
> of userland ABI for a while...
>
> 2) two callers in perf_event_open(2) are playing silly buggers with explicit
>         struct fd group = {NULL, 0};
> and rely upon "fdput() is a no-op if we hadn't touched that" (note that if
> we try to touch it and get NULL ->file from fdget(), we do not hit those fdput()
> at all).
>
> 3) ovl_aio_put() is hard to follow (and some of the callers are poking
> where they shouldn't), no idea if it's correct.  struct fd is manually
> constructed there, anyway.
>
> 4) bpf generic_map_update_batch() is really asking for trouble.  The comment in
> there is wrong:
>         f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
> *NOTHING* we'd done earlier can guarantee that.  We might have a descriptor
> table shared with another thread, and it might have very well done dup2() since
> the last time we'd looked things up.  IOW, this fdget() is racy - the function
> assumes it refers to the same thing that gave us map back in bpf_map_do_batch(),
> but it's not guaranteed at all.
>
> I hadn't put together a reproducer, but that code is very suspicious.  As a general
> rule, you should treat descriptor table as shared object, modifiable by other
> threads.  It can be explicitly locked and it can be explicitly unshared, but
> short of that doing a lookup for the same descriptor twice in a row can yield
> different results.
>
> What's going on there?  Do you really want the same struct file you've got back in
> bpf_map_do_batch() (i.e. the one you've got the map from)?  What should happen
> if the descriptor changes its meaning during (or after) the operation?

Interesting.
If I got this right... in the following:

f = fdget(ufd);
map = __bpf_map_get(f);
if (IS_ERR(map))
   return PTR_ERR(map);
...
f = fdget(ufd);
here there are no guarantees that 'f' is valid and points
to the same map.
Argh. In hindsight that makes sense.

generic_map_update_batch calls bpf_map_update_value.
That could use 'f' for prog_array, fd_array and hash_of_maps
types of maps.
The first two types don't' define .map_update_batch callback.
So BPF_DO_BATCH(map->ops->map_update_batch); will error out
with -ENOTSUPP since that callback is NULL for that map type.

The hash_of_maps does seem to support it, but
that's an odd one to use with batch access.

Anyhow we certainly need to clean this up.

Brian,
do you mind fixing it up, since you've added that
secondary fdget() in the first place?

Thanks!
