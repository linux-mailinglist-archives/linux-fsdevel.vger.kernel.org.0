Return-Path: <linux-fsdevel+bounces-28897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE329701E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 13:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1425D1C21D14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C2158A33;
	Sat,  7 Sep 2024 11:18:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19D5C613;
	Sat,  7 Sep 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707913; cv=none; b=FqwFGUIRixgQ8GCCQgyDb9843zMrmNqs48FJeLGIoYfEKfT9wRd72QB7tOTCJ6QZJPHQDqeMW1B+VeYNU5JDckRvkqQBD3RN5gJqvrLgPAdYFwFaTA6CwoG6jhWn3vRIyp0+9UU+rncYbXJoq+gIu6/EK1+raWJN2W/hhspgQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707913; c=relaxed/simple;
	bh=A3KMUToUykNDn6esv4UjJlbKyw5zyI5aB/Jj+tSJ1oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj+De4Zgd7PnYnfXU91a7MAyN+RbN21fk0tPqZnXJAguMwpOPfO1HEu86onry2ufLxjyhqxluOU8lpszj7DE5qvII0l2Ne3jG716lLJEidVtrdhVHorvxczo7N70h2wg8QEuEnz+tGjtrftuR+EEqiDUq4qf36T8l1f9FCRCFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b747f2e2b7so26714957b3.3;
        Sat, 07 Sep 2024 04:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707909; x=1726312709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6SmI0kw/UU4CCmm+LsNCRNktuIT78Ing7KTK4T4n0M=;
        b=f0I+6qiMDirfzdWsrAKBMdCcfmWEZLc8gjAi6HkdW7kP/u+oGDFVybroO/3Wl/Yr/1
         w/Ith6ZBNt0OmIOr1y6diDc80o9G1ixtW72lxEPhT1Sbs9+obAn9SUo53mUNkVAuvLu6
         e6LeEvNb7uppC6iMTI73XZvKLkVw9mUOAY9zNGZHratFGepXvovLdEsEysYlgdf2PvOi
         D86LPu3uteu83ApyP48BrAtCmpZlnO60b0SQ12QM/gyF3EoHnBvW+WWE9SHQIPffY380
         j6c3xXelTbgwolgpUrpZjrVwuPqGHvldwFupjIOqOGm/1+mlV+t5nuDPAm9+UZoj0RAM
         9VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbubVn6rM2us5JMjzr8WlUVG2ZPxC2qKA0Tj+3j2kkcMBJk9H423/o9+CK59U0iuoYr0RA+ibNQOwms0L@vger.kernel.org, AJvYcCWHJC4T4fgJ6vLC4q6+G4VxvGBqnds817Zc8H0P9OQzde7TnWrWsOSvCECFRxCxhXad8OvBx3l7NjSSxSLnKQ==@vger.kernel.org, AJvYcCWn+a0WWtgSsuKgryIkyGeLKMX8duDSuhlFcApU9zRoxbdSjKm0Os3GM97/6qPBCwyI1DGw/pIjyfzbLjhPcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBGBgGZ1Xjvtb1r6d6FNSvttn4qx64MBuGhZ0PtctFmhhWa/7
	Chz8qd0dl0/e/ZiSCPVh6CZ54obLSXiK2aR07LTCc3/nv/cQa9LlGNCvqhGY
X-Google-Smtp-Source: AGHT+IEfAjUcw6MQbReAK8n0hiJ/d86vtLoJ+a0uoqDdYCp0UHqvkr+KBNtPHJe/38EcIo7NEz8koA==
X-Received: by 2002:a05:690c:ec6:b0:6db:31f6:a812 with SMTP id 00721157ae682-6db44d6249amr74402647b3.4.1725707909279;
        Sat, 07 Sep 2024 04:18:29 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db5c11b583sm1962257b3.0.2024.09.07.04.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 04:18:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b5b65b1b9fso23445377b3.2;
        Sat, 07 Sep 2024 04:18:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKX4K6+eGmEg8Ak2GL+Y+cjrgGUHv/RIXEyUwgsCvUtrCZ9CfzgYSx0me1d9akQXmJojKm5F/LRT2NHW+zDg==@vger.kernel.org, AJvYcCV+GwQxHsl8/w+iGOQ+9H3kmxcDeCbZdt6DjFFq8Zakx5kzewOPXzX6egQ83on+o/oyVvhaZQ7cFxUqX0DM@vger.kernel.org, AJvYcCWX8XT73NzYYtRVYkFPJ1VV9gN9yuXDcfwfozgHwbV4x2CK/FIZLZGD0bGAjc+dWj47HdLb01ScYn81WBay6w==@vger.kernel.org
X-Received: by 2002:a05:690c:dc5:b0:62f:a250:632b with SMTP id
 00721157ae682-6db44d62e57mr62184897b3.8.1725707907681; Sat, 07 Sep 2024
 04:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com> <fvk7vjfz4f2c2x5hxjajiwz5doxeg54owgpzob2kskkftshcoo@5sl5lu6nenyu>
In-Reply-To: <fvk7vjfz4f2c2x5hxjajiwz5doxeg54owgpzob2kskkftshcoo@5sl5lu6nenyu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 7 Sep 2024 13:18:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVVz34NBT7aBeupZvgJNEC3oE_np-ZcZMbFT00KyVP6Q@mail.gmail.com>
Message-ID: <CAMuHMdVVVz34NBT7aBeupZvgJNEC3oE_np-ZcZMbFT00KyVP6Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Wed, Sep 4, 2024 at 8:55=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Sep 03, 2024 at 03:53:56PM GMT, Geert Uytterhoeven wrote:
> > Replying here, as there is (again) no patch email to reply to to report=
 issues.
> >
> > noreply@ellerman.id.au is reporting several build failures[1] in linux-=
next:

[...]

> > The failure is due to commit 4e7795eda4459bf3 ("bcachefs:
> > bch2_sb_member_alloc()"), which is nowhere to be found on
> > lore.kernel.org.  Please stop committing private unreviewed patches
> > to linux-next, as several people have asked before.
>
> They're still in git; I'd suggest just doing a git send-email and
> tweaking the output if you want to start a review on a patch you find.
>
> There's been some discussions in filesystem land about how/when we want
> patches to hit the list - I'm not a huge fan of the patch bombs that
> drown everything else out on the list, which is what it would be if I
> did mail everything.
>
> But if the email workflow is really what you want, and if it's going to
> be generating useful review (list activity is growing...), I could be
> convinced...
>
> We're getting past the "just fix all the stupid shit" phase, and my
> output is (I hope) trending toward something more stustainable, with a
> stream of more _interesting_ patches to talk about, so - yeah, it's
> starting to sound more reasonable, if that's what people want.
>
> My priority is just going to be on fostering _useful_ technical
> discussion. If the only reason you're wanting patches on the list is
> because of trivial shit automated tests can and do catch - that's not a
> win, to me. If I start posting patch series and we seem to be learning
> from it, I'll stick with it.

Please follow the standard procedure. Posting patches is actually a
requirement for your branch being part of linux-next:

    You will need to ensure that the patches/commits in your tree/series ha=
ve
    been:
         * submitted under GPL v2 (or later) and include the Contributor's
            Signed-off-by,
         * posted to the relevant mailing list,
         * reviewed by you (or another maintainer of your subsystem tree),
         * successfully unit tested, and
         * destined for the current or next Linux merge window.

     https://lore.kernel.org/all/20240807080423.45efb506@canb.auug.org.au/

noreply@ellerman.id.au told me you broke 32-bit builds (again):

    ERROR: modpost: "__udivdi3" [fs/bcachefs/bcachefs.ko] undefined!
    http://kisskb.ellerman.id.au/kisskb/buildresult/15230339/
    http://kisskb.ellerman.id.au/kisskb/buildresult/15230439/

I have bisected this to commit 7abab864a198fbb6 ("bcachefs: Progress
indicator for extents_to_backpointers"), which was not posted to
a public mailing list archived by lore (again), and does a plain
64-by-size_t division, which should use div64_ul() instead.

--- a/fs/bcachefs/backpointers.c
+++ b/fs/bcachefs/backpointers.c
@@ -810,7 +810,7 @@ static inline void progress_init(struct
progress_indicator_state *s,

                u64 v;
                bch2_accounting_mem_read(c,
disk_accounting_pos_to_bpos(&acc), &v, 1);
-               s->nodes_total +=3D v / btree_sectors(c);
+               s->nodes_total +=3D div64_ul(v, btree_sectors(c));

        }
 }

Thanks for complying!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

