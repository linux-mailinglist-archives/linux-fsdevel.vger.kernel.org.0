Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4B7A19D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjIOJBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjIOJBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:01:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077644A0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 01:58:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso654555166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694768230; x=1695373030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBIiaOHoOHrCk3LeEQNU7t+gT7xznMj52aOiRS+1hC4=;
        b=Omd8LNHO/TpEyR1D2FRKgBlsszWtWrz8cNDPH50EdQ+O4GGHmsBFoGC7jbxvQZQrop
         Sxe1ydVQ3hgGrGoPACkzHEiLeR8/YyQQWhhkbQYvyUY4EfGaHPyzdKIj7t1/mq/wkcOq
         77jscDTKNpU2lm+taEKQu91RkDbTtw0ejgIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768230; x=1695373030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBIiaOHoOHrCk3LeEQNU7t+gT7xznMj52aOiRS+1hC4=;
        b=Aos7pDqwNxWhNBh9q9NL84mhJ1j/64XvE10k8SUTzXFHomlABVeC8hCjL/yOIeuJG2
         irr14LatgY/8bu4XeuF7ibNOZrObOF21Dv/HVbuRUa9abgjyplySJUrHRl+WjcbM2Psd
         XXTJ58Ps7Pq2d64N/58odE1/8qqTH9wt99APZ/iv5d8DigXov6t9Gq5WrJoPuBAvyJRS
         liBDPmMu9MWbR39lbih/OCj1QF5bzw1WyeXFcQ0b+Lc1pPgWuIfAiO/ShpnHkTHzYoVp
         0ovGI2UpYO15iAnI1kAWcU58neF5CxvFx/FPGSjcUPaGAqZblnx8y+tBVPXEibGH8zmM
         i3kQ==
X-Gm-Message-State: AOJu0YzkIvqt7djgMG0R4Wj4LnT40hwg9WrKVPNPOorDKQhFHom+cujh
        XCl1YNwGp1fzM3qQ6F9bfBszUDwRH/k2bgbNO39ylw==
X-Google-Smtp-Source: AGHT+IG38zmA525fy/C/IrBaRcWlpOvf+szMKtBFzKIippNLUVWg1N/ro2hl/mnaBVvita3DyrmGNvsyitNfBphPSDM=
X-Received: by 2002:a17:907:9620:b0:9a1:c35b:9e09 with SMTP id
 gb32-20020a170907962000b009a1c35b9e09mr6450533ejc.8.1694768229999; Fri, 15
 Sep 2023 01:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
In-Reply-To: <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 Sep 2023 10:56:58 +0200
Message-ID: <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Sept 2023 at 17:27, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Sep 14, 2023 at 12:13:54PM +0200, Miklos Szeredi wrote:
> No worries, I think the discussion touching on this starts at:
> https://youtu.be/j3fp2MtRr2I?si=f-YBg6uWq80dV3VC&t=1603
> (with David talking quietly without a microphone for some parts
> unfortunately...)

(Thanks for digging that out.)

That discussion touched on two aspects of using a single call vs.
multiple calls:

 - atomicity
 - marshalling

Atomicity of getting a snapshot of the current mount tree with all of
its attributes was never guaranteed, although reading
/proc/self/mountinfo into a sufficiently large buffer would work that
way.   However, I don't see why mount trees would require stronger
guarantees than dentry trees (for which we have basically none).

Marshalling/demashalling of arbitrary structures is indeed ugly.  I
think what Linus suggested, and what this interface was based on is
much less than that.  Also see my suggestion below: it doesn't need
demashalling at all due to the fact that the kernel can fill in the
pointers.   And yes, this could be used for arbitrary structures
without compromising type safety, but at the cost of adding more
complexity to the kernel (at least ascii strings are just one type).

Even more type clean interface:

struct statmnt *statmnt(u64 mnt_id, u64 mask, void *buf, size_t
bufsize, unsigned int flags);

Kernel would return a fully initialized struct with the numeric as
well as string fields filled.  That part is trivial for userspace to
deal with.

For sizing the buffer and versioning the struct see discussion below.

> > What I'm thinking is making it even simpler for userspace:
> >
> > struct statmnt {
> >   ...
> >   char *mnt_root;
> >   char *mountpoint;
> >   char *fs_type;
> >   u32 num_opts;
> >   char *opts;
> > };
> >
> > I'd still just keep options nul delimited.
> >
> > Is there a good reason not to return pointers (pointing to within the
> > supplied buffer obviously) to userspace?
>
> It's really unpleasant to program with. Yes, I think you pointed out
> before that it often doesn't matter much as long as the system call is
> really only relevant to some special purpose userspace.
>
> But statmount() will be used pretty extensively pretty quickly for the
> purpose of finding out mount options on a mount (Querying a whole
> sequences of mounts via repeated listmount() + statmount() calls on the
> other hand will be rarer.).
>
> And there's just so many tools that need this: libmount, systemd, all
> kinds of container runtimes, path lookup libraries such as libpathrs,
> languages like go and rust that expose and wrap these calls and so on.
>
> Most of these tools don't need to know about filesystem mount options
> and if they do they can just query that through an extra system call. No
> harm in doing that.

Just pass sizeof(struct statmnt) as the buffer size, and it will work that way.

> The agreement we came to to split out listing submounts into a separate
> system call was exactly to avoid having to have a variable sized pointer
> at the end of the struct statmnt (That's also part of the video above
> btw.) and to make it as simple as possible.
>
> Plus, the format for how to return arbitrary filesystem mount options
> warrants a separate discussion imho as that's not really vfs level
> information.

Okay.   Let's take fs options out of this.

That leaves:

 - fs type and optionally subtype
 - root of mount within fs
 - mountpoint path

The type and subtype are naturally limited to sane sizes, those are
not an issue.

For paths the evolution of the relevant system/library calls was:

  char *getwd(char buf[PATH_MAX]);
  char *getcwd(char *buf, size_t size);
  char *get_current_dir_name(void);

It started out using a fixed size buffer, then a variable sized
buffer, then an automatically allocated buffer by the library, hiding
the need to resize on overflow.

The latest style is suitable for the statmnt() call as well, if we
worry about pleasantness of the API.

>
> > > This will also allow us to turn statmnt() into an extensible argument
> > > system call versioned by size just like we do any new system calls with
> > > struct arguments (e.g., mount_setattr(), clone3(), openat2() and so on).
> > > Which is how we should do things like that.
> >
> > The mask mechanism also allow versioning of the struct.
>
> Yes, but this is done with reserved space which just pushes away the
> problem and bloats the struct for the sake of an unknown future. If we
> were to use an extensible argument struct we would just version by size.
> The only requirement is that you extend by 64 bit (see struct
> clone_args) which had been extended.

No need for reserved space in fact.  Versioning would still work, as
long as userspace is strictly checking the return mask.  I.e. newly
added fields will come after the old buffer, as assumed by the kernel.
But the kernel will never set the mask bits for these fields, so
userspace should not ever look at them.  Note: the interface does have
a bufsize parameter, so no possibility of memory corruption in any
event.

I added the reserved space so that userspace would be protected from
rubbish at the end of the struct if the kernel was older.  A library
wrapper could work around that issue (move the variable part beyond
the end of the new struct), but it would require code update in the
wrapper, not just updating the struct.

But in fact it's much simpler to just add ample reserved space and be
done with it forever, no need to worry about versioning at all.

> > > numbers for sub types as well. So we don't need to use strings here.
> >
> > Ugh.
>
> Hm, idk. It's not that bad imho. We'll have to make some ugly tradeoffs.

Subtype is a fuse thing (e.g. sshfs would show up as  fuse.sshfs
/proc/self/mountinfo.  Forcing each fuse filesystem to invent a magic
number... please no.

Thanks,
Miklos
