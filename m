Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DBF5590C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 07:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFXEwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiFXEvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:51:10 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAF6B8DD;
        Thu, 23 Jun 2022 21:49:41 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t127so1282828vsb.8;
        Thu, 23 Jun 2022 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LHgNgAtnEuA7DCXWeLpPCmLAfMw4XcrPxE/RxanjDs=;
        b=EZBDemakqX+VOAUWpA5gHBAeykSH80Rs7LQgwAwZ31SomZmqj1oJVzs5BLvUybGOED
         Emc6tSghxNozOctTM8ae54DdnO9m9Xt4C7mmWLg7kb32vZfouY4RgfDTX4nSA8WbYwno
         enISRANxm5hDHHOyjuYiBj4mZNwdSwgyS+esT3P2Xmja4MFPxKV1ENoQPE26LTiWQlgA
         BW7f/DvjBvtg/BB3XyOAPsicxd2rwhwaTTN/fuPwOvMMcrs/cP624cNyLGgj9djf0PZH
         ccbpzcNj/GOry+BRRSUOc7lW7/s98VR77sX92Lt0pnG6i/HcG3zVtgjcRxLuE2oR2Nrj
         PniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LHgNgAtnEuA7DCXWeLpPCmLAfMw4XcrPxE/RxanjDs=;
        b=hUu60c4Clkt1q0j2uE/kf5khVO1aHFBW/Cl+c1qNu7MjKrkpK7XXoyGN+exIUaTjNu
         9bCQ0G0uY33dMJ8xsBtWTtrikOKuB8MMYU5Cz8TKEiAilapUirs65tE+RJ3VIfmZPwRR
         tG1mzC6Put9T1rG0tSt8Dl88PVI33H6qNDzW6X+Nt4IFuxWlk7sNMoUa2FEsOdDd0jyi
         jQ9T+QrGN7M16+ZDUvkCOFJoXtf4azrUYEbGfwD1Ac8ICxfbzz4Vz67IKdVDuNnOFF6b
         ryORq+w9nYS83fbl/qPRj/aYpdhYCkqFUs3QjaTgXftvS272eZQl0IbUf4xciAP9fhhB
         WXew==
X-Gm-Message-State: AJIora+/AiIMbge603/qnJbJt6SuwWG/uNLiKysteGM0rA9tnXzWVJun
        OvQVMcLx39BS8uGhK7FtWALfm7Go2iuhaPgfe8YXd6Iq2v8=
X-Google-Smtp-Source: AGRyM1vcHweCb81Qdwl5VjKHRlSt5eJqqfLJYGWdotlU4+v6jDPyKjl2jWAw5N1C7ywm/NW0fWkBZZT1UV05kMlL/3A=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr12831620vsq.2.1656046180381; Thu, 23 Jun
 2022 21:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com> <YrSrLgU1OIgaaxiB@magnolia>
In-Reply-To: <YrSrLgU1OIgaaxiB@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jun 2022 07:49:29 +0300
Message-ID: <CAOQ4uxjCUdzVdMUR9gj4xHfS-wHo5HsJnkTAAWjKeEwdVvX5iQ@mail.gmail.com>
Subject: Delegating fstests maintenance work (Was: Re: [PATCH 3/4]
 xfs/{422,517}: add missing killall to _cleanup())
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Tso <tytso@mit.edu>, Chris Mason <clm@fb.com>,
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

[+fsdevel]

>
> I swear I'll send all these some day, if I ever get caught up...
> Delegating LTS maintenance is a big help, but as it is I still can't
> stay abreast of all the mainline patchsets /and/ send my own stuff. :(

I have to repeat what I said in LSFMM about the LTP project and
what fstests could be like.

Companies put dedicated engineers to work as proactive LTP
maintainers. There is absolutely no reason that companies won't
do the same for fstests.

If only every large corp. that employs >10 fs developers will assign
a halftime engineer for fstests maintenance, their fs developer's
work would become so much more productive and their fs product
will become more reliable.

I think the fact that this is not happening is a failure on our part to
communicate that to our managers.

From my experience, if you had sent stuff like your fstests cleanups
to the LTP maintainers and ask for their help to land it, they would
thank you for the work you did and take care of all the testing
on all platforms and fixing all the code style and framework issues.

LTP maintainers constantly work on improving the framework and
providing more features to test writers as well as on converting old
tests to use new infrastructure.

Stuff like Dave's work on sorting up the cleanup mess or the groups
cleanup and groups speedup - all of those do not have to add load
to busy maintainers - life can be different!

Taking responsibility away from developers to deliver their own tests
is a slippery slope, but getting help and working together is essential
for offloading work from busy maintainers.

Thanks,
Amir.
