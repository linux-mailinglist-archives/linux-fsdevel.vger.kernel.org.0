Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C982E55D600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiF0MOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiF0MOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:14:37 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02165DEB2;
        Mon, 27 Jun 2022 05:14:36 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id bb7so4359428vkb.9;
        Mon, 27 Jun 2022 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqLCeUbb+uyxakkaKkkGOaJ00ya2HJiaIO8DBaSMIDg=;
        b=k78ndlGWMWUmu3rXbHiOGGGyWsOWtl1HnGdDA7PDgFPUlc55BFSbIXVKEfYM2rp2kR
         aJEwpxfvQs+yYaAA/In2gTM5cV5dbxAWT3Spg072VzRAI+iQUzXxCzv6geqVI09ejyxT
         6Y64+RW6/k6IcQPUPJ8WmXh3lF+pBxHUzL4gf7lF8BdUs2Yc20+uI1jqwTMkZ9gSv3oT
         awpw8kVHxgupGqV7SHhrNO+kOWJpCQmNC0vYGGQuzELc1BtED/G63j6MjpUsemCEfcIa
         giHEZcfn6LgFScsvrGq334xfXwt9kf+Jjv2LS3jrUp4riOak+O6zvAFk2FKn2FVc737L
         XPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqLCeUbb+uyxakkaKkkGOaJ00ya2HJiaIO8DBaSMIDg=;
        b=HdCAgNUfhLmlksXrEkCPTxGmdvGqwzogRtlyAoqGnVa/3n/+ey73WHPBfcDKOQ44qz
         6ojtiwf6M0twpWwuj2OONkz/Txw+9ZvMEOUFcOLvgGA65vZFeqMjUWA7NfE4jKEEbePE
         y3BN6L+4SlvhJk0ZvoWhUquen9ooceZ0DWp9AeE+aN/yDu//VcAbR347mL4GY1ULQT+U
         V2riJLdKk7MKS3Tfy7j9TRmcb3RxiYzJQgO/isT530MUGoIlhPhp6GtyzcWJaYPGIe3m
         g1v18wRl2nsMVY1rk1+7nxTYkUzVl24uwRLNSLBPoVEPkd3MaSvHN1cYzyHkQH5lBUfL
         RK8Q==
X-Gm-Message-State: AJIora/u9qaecJsT3OqEc9byUFnW4e1Jut5qEAL2b76GqBC7lvQPIB1L
        mQ4/Drqwk0hFgQls1uOqfAFRXCJfoUGSENfa6y8=
X-Google-Smtp-Source: AGRyM1vfGzbnwQCUG5a4gwEqieY8Xo3HNsktLu0yRCuC9VpwBTvuY/Rhtx/IJkCtwSMBB0VfkD9wctMd6iEAFrL1m90=
X-Received: by 2002:a1f:a094:0:b0:36c:e403:52eb with SMTP id
 j142-20020a1fa094000000b0036ce40352ebmr4143889vke.36.1656332075098; Mon, 27
 Jun 2022 05:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143538.2500990-1-amir73il@gmail.com> <20220624143538.2500990-2-amir73il@gmail.com>
 <CAOQ4uxjRzu_Y8eE=C=PnKjzCiDK5k5NBM1dxYttd8yfoy2DnUg@mail.gmail.com> <20220627113224.kr2725conevh53u4@quack3.lan>
In-Reply-To: <20220627113224.kr2725conevh53u4@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 Jun 2022 15:14:23 +0300
Message-ID: <CAOQ4uxjuNcSEm_DwW_A90pZyFMsE9zoBG55K9gg=MHiTjJ-Nzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fanotify: prepare for setting event flags in
 ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
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

On Mon, Jun 27, 2022 at 2:32 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 26-06-22 10:57:46, Amir Goldstein wrote:
> > On Fri, Jun 24, 2022 at 5:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > > ignore mask is always implicitly applied to events on directories.
> > >
> > > Define a mark flag that replaces this legacy behavior with logic of
> > > applying the ignore mask according to event flags in ignore mask.
> > >
> > > Implement the new logic to prepare for supporting an ignore mask that
> > > ignores events on children and ignore mask that does not ignore events
> > > on directories.
> > >
> > > To emphasize the change in terminology, also rename ignored_mask mark
> > > member to ignore_mask and use accessors to get only the effective
> > > ignored events or the ignored events and flags.
> > >
> > > This change in terminology finally aligns with the "ignore mask"
> > > language in man pages and in most of the comments.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> >
> > [...]
> >
> > > @@ -336,7 +337,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
> > >                 fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> > >                         if (!(mark->flags &
> > >                               FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
> > > -                               mark->ignored_mask = 0;
> > > +                               mark->ignore_mask = 0;
> > >                 }
> > >         }
> >
> > Doh! I missed (again) the case of:
> > !FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY && !FS_EVENT_ON_CHILD
> >
> > I was starting to look at a fix, but then I stopped to think about the
> > justification
> > for FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY on a directory.
> >
> > The man page does say:
> > "... the ignore mask is cleared when a modify event occurs for the ignored file
> >      or directory."
> > But ignore mask on a parent never really worked when this man page was
> > written and there is no such thing as a "modify event" on the directory itself.
> >
> > Furthermore, let's look at the motivation for IGNORED_SURV_MODIFY -
> > it is meant (I think) to suppress open/access permission events on a file
> > whose content was already scanned for malware until the content of that
> > file is modified - an important use case.
> >
> > But can that use case be extended to all files in a directory?
> > In theory, anti-malware software could scan a directory and call it "clean"
> > until any of the files therein is modified. However, an infected file can also
> > be moved into the "clean" directory, so unless we introduce a flag
> > IGNORED_DOES_NOT_SURV_MOVED_TO, supporting
> > !IGNORED_SURV_MODIFY on a directory seems useless.
> >
> > That leads me to suggest the thing I like most - deprecate.
> > Until someone comes up with a case to justify !IGNORED_SURV_MODIFY
> > on a directory, trying to set FAN_MARK_IGNORE on a directory without
> > IGNORED_SURV_MODIFY will return EISDIR.
> >
> > We could also say that IGNORED_SURV_MODIFY is implied on
> > a directory, but I think the EISDIR option is cleaner and easier to
> > document - especially for the case of "upgrading" a directory mark
> > from FAN_MARK_IGNORED_MASK to new FAN_MARK_IGNORE.
> >
> > We could limit that behavior to an ignore mask with EVENT_ON_CHILD
> > but that will just complicate things for no good reason.
>
> I think all of the above was reflected in your proposal in another email
> and I agree.
>
> > Semi-related, we recently did:
> > ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> > We could have also disallowed FAN_ONDIR and FAN_EVENT_ON_CHILD
> > on non-dir inode. Too bad I didn't see it.
> > Do you think that we can/should "fix" FAN_REPORT_TARGET_FID to include
> > those restrictions?
>
> Yes, I think we could still amend the behavior. It isn't upstream for long

Yeh and not in any LTS either.

> and the combination is non-sensical in the first place... In the worst case
> we can revert without too much harm here.
>

Good, because I did add this restriction to FAN_MARK_IGNORE
best if at least those behaviors are matching for these 2 configs.

> > I would certainly like to disallow dirent events and the extra dir flags
> > for setting FAN_MARK_IGNORE on a non-dir inode.
> >
> > I am going to be on two weeks vacation v5.19-rc5..v5.19-rc7,
> > so unless we have clear answers about the API questions above
> > early this week, FAN_MARK_IGNORE will probably have to wait
> > another cycle.
>
> I'm on vacation next week as well. Let's see whether we'll be able to get
> things into shape for the merge window...

I'll start with the FIxes: patch, so at least we can get that one
to 5.19.

Thanks,
Amir.
