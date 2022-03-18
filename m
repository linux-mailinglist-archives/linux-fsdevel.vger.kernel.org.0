Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D24DD378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 04:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiCRDOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 23:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCRDOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:14:31 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BA160C3D
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 20:13:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id b188so7623925oia.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MqWuGyKH6iqelg4Vyv4vFILDv2MwkA5g0eFgkvoDiM=;
        b=S+JdU91orazTiiUcl2i4YkFYPgz+Nmx26zjXU5o8Mf9h/EgWcyZgnntNGrC0YYlk7U
         h7oPIKn2iRmfnmg4h+5z6+hd5yl3mrH3YRKLge3eOqOGSUGcR5xly1efu0EQurwW+GSK
         LoIR/OppmNMk44aihDc75Ol62g6kbD4EtZL49XEZAzgUMh4FUzsQnUhQC22vrikZNFKc
         PrvIl0jaWoVyj2L/xdnw8A5Eil3KpXsfigBkeboOoScKdZ2oGgjKqM20kISeBkGW8lAX
         WLXOBc0wLGDo0j98cvn3nfR8f4AKD1qENAQZmBzVNAnkUlI/PZHTSamZQtWWiWMD9NZA
         l1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MqWuGyKH6iqelg4Vyv4vFILDv2MwkA5g0eFgkvoDiM=;
        b=o84pEFxxPfidxWiHzFx98u/a6BcP5BTEV9wtXne3pIS99kxFUTAKKRYVlqljV92bYr
         9kklgX7HroOOmHJRQV0UhwMDZEAOzjMgH7sExZ17AXfq80Kjb78AAk+YRBUtmUeNv12s
         0LwiWOds2O/0UJv1PxWawN9g+bzNCPqam9+MoQeldcwyDL9DkPz94AukZ+FRRHpNXcul
         p+hXkI9aWYBi+9tQiCR5BNSkSg7Clx4gQbhIz2CpQM0nowbBDodGI95p8swKSF3rTTEq
         C8ECl7X32BWEMRAAQzhpgrI02LjUwm8LcOUusoBRBnyO1YUo/NCxAvY4/opBWde/FC9Y
         IVNQ==
X-Gm-Message-State: AOAM531IPv1HsSloIBJ8bmGHQ/cFk5tk+pJdgQJrItzeojfw+9ygjwGE
        HYABDMpRJ1OnUn877o+YQ19HukzDVsYNOl0y4CQ+9uDlWDk=
X-Google-Smtp-Source: ABdhPJxnBV4AU+132HGNwAq+x2eIpogD++GiNV8m1HGHHCxOn4WcZ4aMxpZY8zKbuczYyr+63AsGljl1jzJZgKcq59o=
X-Received: by 2002:a05:6808:994:b0:2ee:f9f3:99ec with SMTP id
 a20-20020a056808099400b002eef9f399ecmr4406212oic.98.1647573192873; Thu, 17
 Mar 2022 20:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
In-Reply-To: <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Mar 2022 05:13:01 +0200
Message-ID: <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 5:45 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 17-03-22 16:34:43, Jan Kara wrote:
> > On Mon 07-03-22 17:57:40, Amir Goldstein wrote:
> > > Similar to inotify's IN_MARK_CREATE, adding an fanotify mark with flag
> > > FAN_MARK_CREATE will fail with error EEXIST if an fanotify mark already
> > > exists on the object.
> > >
> > > Unlike inotify's IN_MARK_CREATE, FAN_MARK_CREATE has to supplied in
> > > combination with FAN_MARK_ADD (FAN_MARK_ADD is like inotify_add_watch()
> > > and the behavior of IN_MARK_ADD is the default for fanotify_mark()).
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > What I'm missing in this changelog is "why". Is it just about feature
> > parity with inotify? I don't find this feature particularly useful...
>
> OK, now I understand after reading patch 5/5. Hum, but I'm not quite happy
> about the limitation to non-existing mark as much as I understand why you
> need it. Let me think...
>

Sorry for not articulating the problem better.
Let me write up the problem and maybe someone can come up with a better
solution than I did.

The problem that I was trying to avoid with FAN_MARK_VOLATILE is similar
to an existing UAPI problem with FAN_MARK_IGNORED_SURV_MODIFY -
This flag can only be set and not cleared and when set it affects all the events
set in the mask prior to that time, leading to unpredictable results.

Let's say a user sets FAN_CLOSE in ignored mask without _SURV_MODIFY
and later sets FAN_OPEN  in ignored mask with _SURV_MODIFY.
Does the ignored mask now include FAN_CLOSE? That depends
whether or not FAN_MODIFY event took place between the two calls.

That is one of the reasons I was trying to get rid of _SURV_MODIFY with
new FAN_MARK_IGNORE flag. The trickery in FAN_MARK_CREATE is
that the problem is averted - if a mark property can only be set and never
cleared and if it affects all past and future changes to mask, allow to set
this property during mark creation time and only during mark creation time.

I don't think there is a real use case for changing the _SURV_MODIFY
nor _VOLATILE property of a mark and indeed with new FAN_MARK_IGNORE
semantics, we may only allow to set _SURV_MODIFY along with
FAN_MARK_CREATE, so there are two problems solved using this method.

The fact that FAN_MARK_CREATE has feature parity with inotify is not
the reason to add it, but it does help to swallow this somewhat awkward
solution. And it is certainly easy to document.

As the commit message implies, I was contemplating whether
FAN_MARK_CREATE should be an alternative to FAN_MARK_ADD
or an ORed flag.
Semantics-wise we could decide either way.
I chose the option that seemed easier to implement and document
the behavior of FAN_MARK_VOLATILE.
Using FAN_MARK_CREATE as an alternative to FAN_MARK_ADD may
be a bit more elegant for UAPI though.
We could use a macro to get UAPI elegance without compromising simplicity:

#define FAN_MARK_NEW (FAN_MARK_ADD | FAN_MARK_CREATE)

Thanks,
Amir.
