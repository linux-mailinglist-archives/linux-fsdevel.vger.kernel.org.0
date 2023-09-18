Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0077A4FD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIRQwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIRQwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:52:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336194;
        Mon, 18 Sep 2023 09:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E73EC43395;
        Mon, 18 Sep 2023 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695042924;
        bh=B2Z7T8LT/KHu4fjIJu2XTIV1K3twZvXKKL9jWjCUPr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VO3TLmmySMnwuMVuniejwXPmJjVyP/IQC18RMI1nHieQ+YekRqByy8d28h57caXNg
         si+z6M4apdCfETZgODfNRUprTGG14lbQuht5Mn1yd/spKrKbT28RYePW3xKPL76rd7
         KGS4F7c5e6S8LKLdxsgB06uC8FJ3r+Ktr+UC2ou/NPZtSW7aawNjszXR+0fVi55n3t
         37DXQ0fYdV+u8KAksngHR4RtJiI6nfR/3yBRhLUXOuYHl5qU3ALOS7PiNR9HeNtdm7
         5FWDRfXVU4PCJVbZ6HTUC8zeZ/+wagP5tw+2jpXaEiZ3056F14x1zN3jP4vhyagdUY
         z2dIY9HFXr1Sw==
Date:   Mon, 18 Sep 2023 15:15:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
Message-ID: <20230918-einblick-klaut-0a010e0abc70@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com>
 <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 17, 2023 at 04:32:04PM +0200, Miklos Szeredi wrote:
> On Sun, Sep 17, 2023 at 2:54 AM Matthew House <mattlloydhouse@gmail.com> wrote:
> 
> > > +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> > > +               if (!capable(CAP_SYS_ADMIN) &&


> Good point.  That issue was nagging at the back of my mind.  Having an
> explicit flag nicely solves the issue.

Ideally we avoid multiple capable(CAP_SYS_ADMIN) calls by only doing it
once and saving the return value. capable() call's aren't that cheap.
Plus, we should decide whether this should trigger an audit event or
not: capable(CAP_SYS_ADMIN) triggers an audit event,
ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN) wouldn't. 
