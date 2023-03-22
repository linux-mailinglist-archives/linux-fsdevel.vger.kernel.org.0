Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A36C4CEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCVOGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCVOGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:06:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AEC5CEE4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 07:05:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e71so21162328ybc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679493950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu9ylOLyEEUljLbJanTyH5TjxDHfMP7bFUbUHPkgu20=;
        b=Ncfhn81yYigZZ5L7fp6Ojm4/iM9hNwnvT2Y3/OR2PMO6MV57bA8wj4uQQHFTlMfQ9b
         EIxwloVA8tp1uJPGRty+5W4oy3de3PMKEJEwGXOf2u3fu98/EGkkVyzUKMRZBClY973K
         FE2ssXKyRh85hcp16b69hXcNheDkrhWHXe55nO7u67lKGPY+jOgTBaaede+norCVOKQY
         3wyj2hhZoRwdagrLh7YiYoCHhLLPvy+teYGRhIxd2XgJ1J21g7l4/I0O2Mbny9LGjdK1
         BuX5vW2syhgZugPGVUgAdrOyAHAe/s3Ot4w4SDI0QlQM4fxr+nbCerVGWaNy0s9fdE27
         xpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu9ylOLyEEUljLbJanTyH5TjxDHfMP7bFUbUHPkgu20=;
        b=FMYgyHH12uTMJhy5qmn8FOlwNuwlSXNFPqOsbT7qKrb1eVsIFn/LQH2Do0T5n9IXK5
         lxvWE6gRNFJDZGxM1z6S5AKfCagVX35Omrgl9eCnl5ixFx7XKaokRis4VRs3ne9gUXut
         PiHZswslthmSxC8zf79PWAPulF9oxEKL6KPBfkDPwKAJDyVlrLkSgYI1s41q0KNasNDu
         02DhYK12DsrRadUpDSGiAJG2gLMPGErCeor8thmuYnnScg9adO15gk1u6e9WjCdsLG4S
         WJ/+rXvSTt+jaiE98uBs0nmTYHgWp4cS0RxKD9QMKhJ8RiaeUE7BjABcaWxG/u8S21b7
         9lIA==
X-Gm-Message-State: AAQBX9csKL53JA8qrnIlSp+rytcPYivHjv4jUtayl5w90x1BCu8HfMLY
        aHdDyee73hm+on9roDqbQjRtX1CgngESmLrEj3vO
X-Google-Smtp-Source: AKy350YWJvvf7gP83H4sr4YJ3tFloH7yuJ9q4GscPsWMfRCZOFosCJVgg6V7XrhMh+WWlY5XAdl8Qa9ox2lEuo3exxY=
X-Received: by 2002:a05:6902:1890:b0:b72:fff0:2f7f with SMTP id
 cj16-20020a056902189000b00b72fff02f7fmr1397709ybb.4.1679493950107; Wed, 22
 Mar 2023 07:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
 <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
 <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
 <YitWOqzIRjnP1lok@redhat.com> <CAHC9VhQ+x3ko+=oU-P+w4ssqyyskRxaKsBGJLnXtP_NzWNuxHg@mail.gmail.com>
 <20230322072850.GA18056@suse.de>
In-Reply-To: <20230322072850.GA18056@suse.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Mar 2023 10:05:39 -0400
Message-ID: <CAHC9VhTgbCUAT914f66p15HXP-91aAfNrkxHpS9fFoyPLhzj8A@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Johannes Segitz <jsegitz@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:28=E2=80=AFAM Johannes Segitz <jsegitz@suse.com> =
wrote:
> On Fri, Mar 11, 2022 at 03:52:54PM -0500, Paul Moore wrote:
> > On Fri, Mar 11, 2022 at 9:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > Agreed. After going through the patch set, I was wondering what's the
> > > overall security model and how to visualize that.
> > >
> > > So probably there needs to be a documentation patch which explains
> > > what's the new security model and how does it work.
> >
> > Yes, of course.  I'll be sure to add a section to the existing docs.
> >
> > > Also think both in terms of DAC and MAC. (Instead of just focussing t=
oo
> > > hard on SELinux).
> >
> > Definitely.  Most of what I've been thinking about the past day or so
> > has been how to properly handle some of the DAC/capability issues; I
> > have yet to start playing with the code, but for the most part I think
> > the MAC/SELinux bits are already working properly.
> >
> > > My understanding is that in current model, some of the overlayfs
> > > operations require priviliges. So mounter is supposed to be privilige=
d
> > > and does the operation on underlying layers.
> > >
> > > Now in this new model, there will be two levels of check. Both overla=
y
> > > level and underlying layer checks will happen in the context of task
> > > which is doing the operation. So first of all, all tasks will need
> > > to have enough priviliges to be able to perform various operations
> > > on lower layer.
> > >
> > > If we do checks at both the levels in with the creds of calling task,
> > > I guess that probably is fine. (But will require a closer code inspec=
tion
> > > to make sure there is no privilege escalation both for mounter as wel=
l
> > > calling task).
> >
> > I have thoughts on this, but I don't think I'm yet in a position to
> > debate this in depth just yet; I still need to finish poking around
> > the code and playing with a few things :)
> >
> > It may take some time before I'm back with patches, but I appreciate
> > all of the tips and insight - thank you!
>
> Let me resurrect this discussion. With
> https://github.com/fedora-selinux/selinux-policy/commit/1e8688ea694393c9d=
918939322b72dfb44a01792
> the Fedora policy changed kernel_t to a confined domain. This means that
> many overlayfs setups that are created in initrd will now run into issues=
,
> as it will have kernel_t as part of the saved credentials.

Regardless of any overlayfs cred work, it seems like it would also be
worth spending some time to see if the kernel_t mounter creds
situation can also be improved.  I'm guessing this is due to mounts
happening before the SELinux policy is loaded?  Has anyone looked into
mounting the SELinux policy even earlier in these cases (may not be
possible) and/or umount/mount/remounting the affected overlayfs-based
filesystems after the policy has been loaded?

I can't say I'm the best person to comment on how the Fedora SELinux
policy is structured, but I do know a *little* about SELinux and I
think that accepting kernel_t as an overlayfs mounter cred is a
mistake.

> So while the
> original use case that inspired the patch set was probably not very commo=
n
> that now changed.
>
> It's tricky to work around this. Loading a policy in initrd causes a lot =
of
> issues now that kernel_t isn't unconfined anymore. Once the policy is
> loaded by systemd changing the mounts is tough since we use it for /etc a=
nd
> at this time systemd already has open file handles for policy files in
> /etc.

It's been a while since I worked on this, but I pretty much had to
give up on the read-write case, the overlayfs copy-up/work-dir
approach made this impractical, or at least I couldn't think of a sane
way to handle this without some sort of credential override.  However,
I did have a quick-and-dirty prototype that appeared to work well in
the read-only/no-work-dir case; I think I still have it in a
development branch somewhere, I can dig it back up and get it ported
to a modern kernel if there is any interest.

However, when discussing the prototype with Christian Brauner off-list
(added to the CC line) he still objected to the no-cred-override
approach and said it wasn't something he could support, so I dropped
it and focused on the other piles of fire lying about my desk (my
apologies to Christian if I'm mis-remembering/understanding the
conversation).  I still think there is value in supporting a
no-creds-override option, and if there is basic support for getting
this upstream I'm happy to pick the work back up, but I can't invest a
lot more time in this if there isn't an agreement from the
overlayfs/VFS maintainers that this is something that would consider.

--
paul-moore.com
