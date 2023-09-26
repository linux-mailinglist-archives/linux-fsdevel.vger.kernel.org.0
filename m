Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09C27AEEFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjIZOhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZOhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:37:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC9101;
        Tue, 26 Sep 2023 07:37:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02376C433C8;
        Tue, 26 Sep 2023 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695739026;
        bh=2NvGlKjGPmS59w7M/PVsQ0zOobsxsCNxbWVuC18Xz+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0A5OdboYGi/BMVyBFZlepKCiGKAKAHP0O8iO/FE+rDWXdPJoD7t3JkIMi3pQeC9W
         mgUPJswwYx47wSPqtYNYj6Q/K/Dbg6i72lxgC0WOyyQYGApXCeztrhIv3XTI7wQ2yg
         4LNNKreUN5GNfkMlJJGbIS1vd/i5p294BsIReAtMmEn5IvMqBIR2e/MYgCs3ncBXZk
         NmdgMgHynsRs9x7NI5FEq3iaYllJGm7udNH7Ft81u/6nj8aA6QMG1tUWEhPVXb3w09
         lbcD+Y2hNdkxpUdiEmkoXttiwkC1CosYk/f0DKRcER8M6iBqVqqU2i5085rBM8VZuA
         /6QKrj0bLlmRg==
Date:   Tue, 26 Sep 2023 16:36:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230926-parolen-gebohrt-bcb01adc1aae@brauner>
References: <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <871qeloxj0.fsf@oldenburg.str.redhat.com>
 <CAJfpegupTzdG4=UwguL02c08ZaoX+UK7+=9XQ9D1G4wLMxuqFA@mail.gmail.com>
 <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> With an opaque, pointer-carrying struct, copying out the data is not
> possible in a generic fashion.  Only the parts that the application
> knows about can be copied out.  So I think it's desirable to have a
> fairly exact allocation.

This could easily be added if we added size parameters like I originally
suggested for the variable sized mnt_root and mnt_point records into
struct statmount.

If the user specified that they want to retrieve the mnt_root and
mnt_mountpoint in @mask and the size for the relevant field is zero then
we fill in the required size for the relevant field. If they aren't zero
we just try to copy in the data in the relevant pointer field.

I prefer this interface as it allows for both strategies:

* users that don't care about exact allocation size can just pass a
  guesstimated buffer usually PATH_MAX/2 or sm
* users that care about exact allocation size can query the kernel
