Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0875B6C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjGTSaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjGTSaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:30:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFDE44;
        Thu, 20 Jul 2023 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yi1OQndfSAKROqv7J0RkOh857pRhe/ujJHjrZQ98YWs=; b=u1872vr6m+1g/EyQr5YbAPgIXi
        8iuoeRHRChMThcfhq3UY4wdI2nXNzWYwgSIa+3FDugCI22X9Bm1XyJGiHJIu6D5kJQ9V0G5MO4iSE
        OCY/rnMGrX1oQMmEiQ6EuF5nDQiX+ItXKTRxJ9DE/fIzrL9ODNmxrh9E1IxReSdEhLdvD66Ms/603
        blSaDFm4qvspOBzeZCxfkeVeDnuHwotDQpz6ndikocgFBQUi1Ogq9+0S6tu/LSy8MI/j+CE58dhM4
        SRty9xES0AVwyKdaUEC6HK5PTRUFutpUlznQI77UF5EffHqLSujOGKQT1cY/f22YqEvy8xv5GJ1j3
        qxNb+hRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMYPb-00Bu2n-0Y;
        Thu, 20 Jul 2023 18:30:03 +0000
Date:   Thu, 20 Jul 2023 11:30:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Leah Rumancik <lrumancik@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Fred Lawler <fred@cloudflare.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to
 stale cached iomap
Message-ID: <ZLl9K7jODHNYybTY@bombadil.infradead.org>
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org>
 <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
 <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
 <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
 <CAOQ4uxju10zrQhVDA5WS+vTSbuW17vOD6EGBBJUmZg8c95vsrA@mail.gmail.com>
 <20230630151657.GJ11441@frogsfrogsfrogs>
 <CALrw=nFv82aODZ0URzknqnZavyjCxV1vKOP9oYijfSdyaYEQ3g@mail.gmail.com>
 <CAOQ4uxgvawD4=4g8BaRiNvyvKN1oreuov_ie6sK6arq3bf8fxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgvawD4=4g8BaRiNvyvKN1oreuov_ie6sK6arq3bf8fxw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:45:14AM +0300, Amir Goldstein wrote:
> On Wed, Jul 19, 2023 at 11:37 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > Circling back on this. So far it seems that the patchset in question
> > does fix the issues of rocksdb corruption as we haven't seen them for
> > some time on our test group. We're happy to dedicate some efforts now
> > to get them officially backported to 6.1 according to the process. We
> > did try basic things with kdevops and would like to learn more. Fred
> > (cc-ed here) is happy to drive the effort and be the primary contact
> > on this. Could you, please, guide us/him on the process?
> >
> 
> Hi Fred,
> 
> I'd love to help you get started with kdevops and xfs testing.
> However, I am going on vacation tomorrow for three weeks,
> so I'll just drop a few pointers and let the others help you out.
> 
> Luis (@mcgrof) is your best point of contact for kdevops.

I'm happy to help.

> Chandan should be able to help you with xfs backporting questions.
> 
> Better yet, use the discord channel:
>   https://bit.ly/linux-kdevops-chat
> 
> Someone is almost always available to answer questions there.

Indeed and also on irc.oftc.net on #kdevops too if you prefer IRC.
But discord seems to be more happening for kdevops these days.

> TESTING:
> --------------
> The most challenging part of running fstests with kdevops is
> establishing the baseline (which tests pass in current 6.1.y per xfs config),
> but the baseline for that has already been established and committed
> in kdevops repo.
> 
> There is a little quirk, that the baseline is associated only with exact
> kernel version, hence commits like:
> * c4e3de1 bootlinux: add expunge link for v6.1.39

Indeed so our latest baseline is in

workflows/fstests/expunges/6.1.39/xfs/unassigned/

> Make sure that you test your patches against one of those tags
> or add new symlinks to other tags.
> Start by running a sanity test without your patches, because different
> running environments and kdevops configs may disagree on the baseline.

You want to first run at least one loop to confirm your setup is fine
and that you don't find any other failures other than the ones above.

> You can use kdevops to either run local VMs with libvirt or launch
> cloud VMs with terraform - you need to configure this and more
> during the 'make menuconfig' step.
> Attaching my kdevops config (for libvirt guests) as a reference.

Please read:

https://github.com/linux-kdevops/kdevops
https://github.com/linux-kdevops/kdevops/blob/master/docs/requirements.md
https://github.com/linux-kdevops/kdevops/blob/master/docs/kdevops-first-run.md
https://github.com/linux-kdevops/kdevops/blob/master/docs/kdevops-mirror.md

And the video demonstrations. Then I'm happy to schedule some time to
cover anything the docs didn't cover, in particular to help you test new
patches you wish to backport for a stable kernel and the testing
criteria for that.

  Luis
