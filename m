Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F226F5DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjECSWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECSWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:22:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B44237;
        Wed,  3 May 2023 11:22:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9619095f479so690652466b.1;
        Wed, 03 May 2023 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138152; x=1685730152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MivZQORtXZom5DRv/MTAvXHMzAQ2BUh8yzvR+t6z2Rc=;
        b=VISFIxtaGXKBrc8qnl3QNY6SQZn2YdgHd8iZo4Py/hiwjEbZtjhoR6Wk0KBgC61Jnz
         ZzvZGKSQuqVsCczcB17c7jBcC/WzAF5ug1xrq+1cgK4tuVDr3feSCFqdkvhz22F4+3sM
         3ii21GhVMHR3rb8WfovAaf6aSUSUEQEuC/J9PvwkhVZsSCCW+HfvTsNz2ms3b9OXiqjl
         UiA2dOohQCU8K33Gs8qKdgvrnR6WZ+qjpdtslVqTh8idnciquAO8nH7GgDj9jGoR5shB
         4hJnyUooLGaxrxGsW6hMjrJM7uk9B4EDQOXVhKB82YunoabWlYtZTUwTMJoLd+db92gE
         BnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138152; x=1685730152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MivZQORtXZom5DRv/MTAvXHMzAQ2BUh8yzvR+t6z2Rc=;
        b=AWzZppTqStjiMy2fXQ0EKx3jUlHz1aA7ZBwAHyGnbp8CPJ2/vRj2q2zi1CdUgj6qnh
         colIMhWu08G2qFoRyQ9t29e8RkDJlCym5JKw5d74P1qOKqMimv2uXF67Yuh0lceOmYyF
         ZfDNT90S0tvpebmLwcl5WZGQqe28Ikp94NmKvzTMbqhjWPHRkzlDWw5WxXAUCyxId8BP
         pOsUK1ClZXd8JjgTHBiGEMo6jKLMTayIwULLqnAbh8O7JyHwp3FkwyJOwbsTAocg24DK
         medrutk5wewAL4YXM6qTPuyf3oZCEn845Nfjz8eQ1MCuR9AbLJWWYNtDfRw2uJwY1rTY
         8xvQ==
X-Gm-Message-State: AC+VfDyU124xF9/yZHDcRXIPWEhA7S9kCyBKmKXGwV/1AhWTJMw8omMo
        KRSHf7S7tzKW66HGBHzZS01BQKOBqx2FBg9ZTgSGFwVZeUk=
X-Google-Smtp-Source: ACHHUZ66MaUyiVV/Qxkxg6GxUCRyCaYiv4Ylz22U/+CpzapClmEpSbbAzv9FE9bzbHsLD0ocKGfuhHC7RhpzpZeua1s=
X-Received: by 2002:a17:907:72d4:b0:94f:80d6:b825 with SMTP id
 du20-20020a17090772d400b0094f80d6b825mr5025713ejc.19.1683138151736; Wed, 03
 May 2023 11:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-29-drosen@google.com>
 <CAEf4Bzb+suNcvM_tXBmYMzG0j9EH9kPW4F_x1s6ZEM118=tAAw@mail.gmail.com> <CA+PiJmTQ-mpSywa-P6aW5VSUQu-49XtxNDMZP4Ks84UtVjDsNA@mail.gmail.com>
In-Reply-To: <CA+PiJmTQ-mpSywa-P6aW5VSUQu-49XtxNDMZP4Ks84UtVjDsNA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 May 2023 11:22:19 -0700
Message-ID: <CAEf4BzaAHoV3XnJ-o25s6uZ4Mv_TpZQXL0xSxbwhaj3Wx4t02Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 28/37] WIP: bpf: Add fuse_ops struct_op programs
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 6:53=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> On Wed, Apr 26, 2023 at 9:18=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Have you considered grouping this huge amount of callbacks into a
> > smaller set of more generic callbacks where each callback would get
> > enum argument specifying what sort of operation it is called for? This
> > has many advantages, starting from not having to deal with struct_ops
> > limits, ending with not needing to instantiate dozens of individual
> > BPF programs.
> >
> > E.g., for a lot of operations the difference between pre- and
> > post-filter is in having in argument as read-only and maybe having
> > extra out argument for post-filter. One way to unify such post/pre
> > filters into one callback would be to record whether in has to be
> > read-only  or read-write and not allow to create r/w dynptr for the
> > former case. Pass bool or enum specifying if it's post or pre filter.
> > For that optional out argument, you can simulate effectively the same
> > by always supplying it, but making sure that out parameter is
> > read-only and zero-sized, for example.
> >
> > That would cut the number of callbacks in two, which I'd say still is
> > not great :) I think it would be better still to have even larger
> > groups of callbacks for whole families of operations with the same (or
> > "unifiable") interface (domain experts like you would need to do an
> > analysis here to see what makes sense to group, of course).
> >
> > We'll probably touch on that tomorrow at BPF office hours, but I
> > wanted to point this out beforehand, so that you have time to think
> > about it.
> >
>
> The meta info struct we pass in includes the opcode which contains
> whether it is a prefilter or postfilter, although I guess that may be
> less accessible to the verifier than a separate bool. In the v1
> version, we handled all op codes in a single program, although I think
> we were running into some slowdowns when we had every opcode in a
> giant switch statement, plus we were incurring the cost of the bpf
> program even when we didn't need to do anything in it. The struct_op
> version lets us entirely skip calling the bpf for opcodes we don't
> need to handle.
>
> Many of the arguments we pass currently are structs. If they were all
> dynptrs, we could set the output related ones to empty/readonly, but
> that removes one of the other strengths of the struct_op setup, where
> we can actually label the inputs as the structs they are instead of a
> void* equivalent. There are definitely some cases where we could
> easily merge opcode callbacks, like FUSE_FSYNCDIR/FUSE_FSYNC and
> FUSE_OPEN/FUSE_OPENDIR. I set them up as separate since it's easy to
> assign the same program to both callbacks in the case where you want
> both to be handled the same, while maintaining flexibility to handle
> them separately.

If combining hooks doesn't bring any value and simplification, I think
it's fine to keep it as is. I was mostly probing if there is an
equally convenient, but more succinct API that could be exposed
through struct_ops. If there is none, then it's fine.

>
> > +void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dyn=
ptr_kern *dynptr__uninit, u64 size, bool copy)
> >
> > not clear why size is passed from outside instead of instantiating
> > dynptr with buffer->size? See [0] for bpf_dynptr_adjust and
> > bpf_dynptr_clone that allow you to adjust buffer as necessary.
> >
> > As for the copy parameter, can you elaborate on the idea behind it?
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D741=
584&state=3D*
> >
>
> We're storing these buffers as fuse_buffers initially because of the
> additional metadata we're carrying. Some fields have variable lengths,
> or are backed by const data. For instance, names. If you wanted to
> alter the name we use on the lower filesystem, you cannot change it
> directly since it's being backed by the dentry name. If you wanted to
> adjust something, like perhaps adding an extension, you would pass
> bpf_fuse_get_rw_dynptr the size you'd want for the new buffer, and
> copy=3Dtrue to get the preexisting data. Fuse_buffer tracks that data
> was allocated so Fuse can clean up after the call. Additionally, say
> you wanted to trim half the data returned by an xattr for some reason.
> You would give it a size less than the buffer size to inform fuse that
> it should ignore the second half of the data. That part could be
> handled by bpf_dynptr_adjust if we didn't also need to handle the
> allocation case.

Interesting point about allocations and needing to realloc names. But
I wonder if it makes more sense to split the copy/reallocation part
and do it with separate kfunc. And leave dynptr only as means to work
with that data. So you'd do something like below for read/write case:

bpf_fuse_buf_clone(&buffer, new_size);
bpf_fuse_dynptr_from_buf_rw(&buffer, &dynptr);

But would skip bpf_fuse_buf_clone() if you only ever read:

bpf_fuse_dynptr_from_buf_ro(&buffer, &dynptr);

If fuse_buffer was never cloned/realloced, then
bpf_fuse_dynptr_from_buf_rw() should just fail and return invalid
dynptr.


> Say you wanted to have the lower file name be the hash of the one you
> created. In that case, you could get bpf_fuse_get_ro_dynptr to get
> access to compute the hash, and then bpf_fuse_get_rw_dynptr to get a
> buffer to write the hash to. Since the data is not directly related to
> the original data, there would be no benefit to getting a copy.
>
> I initially intended for bpf_fuse_get_ro_dynptr/bpf_fuse_get_rw_dynptr
> to be called at most once for each field, but that may be too
> restrictive. At the moment, if you make two calls that require
> reallocating, any pointers to the old buffer would be invalid. This is
> not the case for the original name, as we aren't touching the original
> source. There are two possible approaches here. I could either
> refcount the buffer and have a put kfunc, or I could invalidate old
> dynpointers when bpf_fuse_get_rw_dynptr is called, similar to what
> skb/xdp do. I'm leaning towards the latter to disallow having many
> allocations active at once by calling bpf_fuse_get_rw_dynptr for
> increasing sizes, though I could also just disallow reallocating a
> buffer that already was reallocated.

Yes, invalidating dynptrs sounds like a way to go. But I think instead
of bundling all that into dynptr constructor for fuse_buffer, it's
better to have a separate kfunc that would be doing realloc/cloning
*and* invalidating. Other than that, neither from_buf_rw nor
from_buf_ro should be doing invalidation, because they can't cause
realloc. WDYT?

>
> The new dynptr helpers are pretty exciting since they'll make it much
> easier to deal with chunks of data, which we may end up doing in
> read/write filters. I haven't fully set those up since I was waiting
> to see what the dynptr helpers ended up looking like.
>

Great, let us know how it goes in practice to start using them.

>
> > > +void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct=
 bpf_dynptr_kern *dynptr__uninit)
> >
> > these kfuncs probably should be more consistently named as
> > bpf_dynptr_from_fuse_buffer_{ro,rw}() ?
> >
> Yeah, that fits in much better with the skb/xdp functions.

great

>
> > > +
> > > +uint32_t bpf_fuse_return_len(struct fuse_buffer *buffer)
> > > +{
> > > +       return buffer->size;
> >
> > you should be able to get this with bpf_dynptr_size() (once you create
> > it from fuse_buffer).
> >
>
> Yes, this might be unnecessary. I added it while testing kfuncs, and
> had intended to use it with a fuse_buffer strncmp before I saw that
> there's now a bpf_strncmp :) I had tried using it with
> bpf_dynptr_slice, but that requires a known constant at verification
> time, which may make using it in real cases a bit difficult...
> bpf_strncmp also has some restrictions around the second string being
> a fixed map, or something like that.

right, we might need a more flexible strncmp version working with two
dynptrs and not assuming a fixed string. We didn't have dynptr
abstraction for working with variable-sized memory when we were adding
bpf_strncmp.

>
> >
> > you probably should be fine with just using bpf_tracing_func_proto as i=
s
> >
> > > +       .is_valid_access        =3D bpf_fuse_is_valid_access,
> >
> > similarly, why custom no-op callback?
> >
>
> Those are largely carried over from iterations when I was less sure
> what I would need. A lot of the work I was doing in the v1 code is
> handled by default with the struct_op setup now, or is otherwise
> unnecessary. This area in particular needs a lot of cleanup.
>

ok

> > > +static int bpf_fuse_init(struct btf *btf)
> > > +{
> > > +       s32 type_id;
> > > +
> > > +       type_id =3D btf_find_by_name_kind(btf, "fuse_buffer", BTF_KIN=
D_STRUCT);
> > > +       if (type_id < 0)
> > > +               return -EINVAL;
> > > +       fuse_buffer_struct_type =3D btf_type_by_id(btf, type_id);
> > > +
> >
> > see BTF_ID and BTF_ID_LIST uses for how to get ID for your custom
> > well-known type
> >
> Thanks, I'll look into those.
