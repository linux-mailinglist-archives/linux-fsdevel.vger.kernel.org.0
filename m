Return-Path: <linux-fsdevel+bounces-2446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA977E5FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD34FB20EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20268374DB;
	Wed,  8 Nov 2023 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bboKZbfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228C374CA
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 21:29:36 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385471BE2
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 13:29:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54366784377so129840a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699478974; x=1700083774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QsX9YSXgqoPg+e0gigeut8dVFOIqYYd3vJcAhcwMV2g=;
        b=bboKZbfF0qYaU7p7jMpgNcpEVz4UDcnyqQHnAsWbrpcyKmc1RHMPS0eCIEQ3T2duMr
         KrVg3L89yjSp6MwFXKZhpdNxz34yaQDwoL0GYR5PZ3WYrzjK+np7aaMTjj2buI86eiOf
         ijg+ptCIBQx98Gr/ErjNGFi6RwEql4qOYdWoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478974; x=1700083774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsX9YSXgqoPg+e0gigeut8dVFOIqYYd3vJcAhcwMV2g=;
        b=KVJaOMUTYf0RfEkFHV2jYFMSnBUeCx7EYXOAML+PT+pIvb/H7AqingDxGjnWpENxiC
         5GGUoTc2A/b87N8LjwuWU6vUTNg7ePRjPg2VS4uJhYAiN4V/NTq1FEZDD0MIzWm6YEbi
         d9rtJ0RAUJsvCG3KcicrEf/Fns1MoTnQEijHEY9BeAx1hr8IeuYkd/fIPAR0jH2ltyqm
         /N0dBKZyRRKnB6n0zLb7AeZN3WRyvWNKwg59feJC2q82J3dG69iVrtFv8GnjSotUNAeU
         kDztCsrrtgxSKU/77726mYjOoQ1F7QbivbitlM5kAxbS5HInKmeBGLr7nL1aAyZJ4Djf
         NmCQ==
X-Gm-Message-State: AOJu0YzYbK9ihjsZr72ffVcRYlTXhEEXhJK2JZqs+ZWVJOKStZ4P7RcP
	6aLNbYZpXBqPWrlLAsZsC74arRQvShl7vSz8nnWy4g==
X-Google-Smtp-Source: AGHT+IFsdDjgUlppXgkb2lBz5YVuFVuy3RChsk8N8vUukkLUQxODU+q4VjdqwpHShXULSgcupmEZjA==
X-Received: by 2002:a50:d74e:0:b0:53f:a017:7526 with SMTP id i14-20020a50d74e000000b0053fa0177526mr2408926edj.40.1699478974252;
        Wed, 08 Nov 2023 13:29:34 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id t22-20020a50ab56000000b005407ac82f4csm7327533edc.97.2023.11.08.13.29.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 13:29:33 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso33556766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 13:29:33 -0800 (PST)
X-Received: by 2002:a17:907:97c8:b0:9da:f391:409a with SMTP id
 js8-20020a17090797c800b009daf391409amr3121344ejc.26.1699478973426; Wed, 08
 Nov 2023 13:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Nov 2023 13:29:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
Message-ID: <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 6.7
To: Chandan Babu R <chandanbabu@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: catherine.hoang@oracle.com, cheng.lin130@zte.com.cn, dchinner@redhat.com, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, osandov@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Nov 2023 at 02:19, Chandan Babu R <chandanbabu@kernel.org> wrote:
>
> I had performed a test merge with latest contents of torvalds/linux.git.
>
> This resulted in merge conflicts. The following diff should resolve the merge
> conflicts.

Well, your merge conflict resolution is the same as my initial
mindless one, but then when I look closer at it, it turns out that
it's wrong.

It's wrong not because the merge itself would be wrong, but because
the conflict made me look at the original, and it turns out that
commit 75d1e312bbbd ("xfs: convert to new timestamp accessors") was
buggy.

I'm actually surprised the compilers don't complain about it, because
the bug means that the new

        struct timespec64 ts;

temporary isn't actually initialized for the !XFS_DIFLAG_NEWRTBM case.

The code does

  xfs_rtpick_extent(..)
  ...
        struct timespec64 ts;
        ..
        if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
                mp->m_rbmip->i_diflags |= XFS_DIFLAG_NEWRTBM;
                seq = 0;
        } else {
        ...
        ts.tv_sec = (time64_t)seq + 1;
        inode_set_atime_to_ts(VFS_I(mp->m_rbmip), ts);

and notice how 'ts.tv_nsec' is never initialized. So we'll set the
nsec part of the atime to random garbage.

Oh, I'm sure it doesn't really *matter*, but it's most certainly wrong.

I am not very happy about the whole crazy XFS model where people cast
the 'struct timespec64' pointer to an 'uint64_t' pointer, and then say
'now it's a sequence number'. This is not the only place that
happened, ie we have similar disgusting code in at least
xfs_rtfree_extent() too.

That other place in xfs_rtfree_extent() didn't have this bug - it does
inode_get_atime() unconditionally and this keeps the nsec field as-is,
but that other place has the same really ugly code.

Doing that "cast struct timespec64 to an uint64_t' is not only ugly
and wrong, it's _stupid_. The only reason it works in the first place
is that 'struct timespec64' is

  struct timespec64 {
        time64_t        tv_sec;                 /* seconds */
        long            tv_nsec;                /* nanoseconds */
  };

so the first field is 'tv_sec', which is a 64-bit (signed) value.

So the cast is disgusting - and it's pointless. I don't know why it's
done that way. It would have been much cleaner to just use tv_sec, and
have a big comment about it being used as a sequence number here.

I _assume_ there's just a simple 32-bit history to this all, where at
one point it was a 32-bit tv_sec, and the cast basically used both
32-bit fields as a 64-bit sequence number.  I get it. But it's most
definitely wrong now.

End result: I ended up fixing that bug and removing the bogus casts in
my merge. I *think* I got it right, but apologies in advance if I
screwed up. I only did visual inspection and build testing, no actual
real testing.

Also, xfs people may obviously have other preferences for how to deal
with the whole "now using tv_sec in the VFS inode as a 64-bit sequence
number" thing, and maybe you prefer to then update my fix to this all.
But that horrid casts certainly wasn't the right way to do it.

Put another way: please do give my merge a closer look, and decide
amongst yourself if you then want to deal with this some other way.

              Linus

