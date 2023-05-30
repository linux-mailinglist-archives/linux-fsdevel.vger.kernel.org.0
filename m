Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836A716015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjE3Ml3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjE3Ml0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C70133;
        Tue, 30 May 2023 05:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8B662F86;
        Tue, 30 May 2023 12:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4A6C433EF;
        Tue, 30 May 2023 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685450359;
        bh=TS1jJ1+J3AnhYCDxSoKKegrqTQJekZ2DPhjOmpAwbX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdkOXaeEgM+F3FBJgO2jS8dcT+yhIeR2jhBp4b+Mt6/CCiXJwhyOF9mFJJKclN+Ed
         TyeH7phT7HQvqz7Iwap+9YtGlv+9O1vssyfXtX92KZCssxuUSWY2wk9h5TEREfQd8u
         EQkJl4Z+2dcOrleyJ0PE3EzRjwAF+V8IVZKJqdmHFi8mUQWZkQ4QdFzNW6vIdt8nkQ
         Nz12PgnDL1VDHZZHxljteMZjyj8OXtrGj/AHZZdY6fu309DkkeYcAQeAN+AqL4zx8+
         3RsaIU9DhepU64I1ugFOxCfYysEFlCxxwbckxW7W99ooZ6IYg8BHmFd7TGM+3RILEX
         KxlHEX8QcnSug==
Date:   Tue, 30 May 2023 14:39:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
Message-ID: <20230530-anziehen-brokkoli-4c1365e888ea@brauner>
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
 <20230530-polytechnisch-besten-258f74577eff@brauner>
 <CAMZdPi_WE7eegcn3V+7tUsJL2GoGottz2fGY14tkmqG9Tgdbhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZdPi_WE7eegcn3V+7tUsJL2GoGottz2fGY14tkmqG9Tgdbhg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 01:23:50PM +0200, Loic Poulain wrote:
> Hi Christian,
> 
> On Tue, 30 May 2023 at 11:45, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, May 26, 2023 at 03:07:16PM +0200, Loic Poulain wrote:
> > > Add an optional timeout arg to 'rootwait' as the maximum time in
> > > seconds to wait for the root device to show up before attempting
> > > forced mount of the root filesystem.
> > >
> > > This can be helpful to force boot failure and restart in case the
> > > root device does not show up in time, allowing the bootloader to
> > > take any appropriate measures (e.g. recovery, A/B switch, retry...).
> > >
> > > In success case, mounting happens as soon as the root device is ready,
> > > contrary to the existing 'rootdelay' parameter (unconditional delay).
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > ---
> >
> > Not terribly opposed and not terribly convinced yet.
> > So, we have rootdelay= with a timeout parameter that allows to specify a
> > delay before attempting to mount the root device. And we have rootwait
> > currently as an indefinite wait. Adding a timeout for rootwait doesn't
> > seem crazy and is backwards compatible. But there's no mention of any
> > concrete users or use-case for this which is usually preferable. If this
> > is just "could be useful for someone eventually" it's way less desirable
> > to merge this than when it's "here's a/multiple user/users"... So I
> > would love to see a use-case described here.
> 
> I can integrate the following use case into a v2 if you think it makes sense:

Yes, please.
