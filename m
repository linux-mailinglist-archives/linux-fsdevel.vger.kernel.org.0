Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4139021F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhEYNZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhEYNZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 09:25:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A163C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 06:23:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a8so23388516ioa.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aH2S9cb5inSSXBHPiUpQ/ZDpNgEfTJ6VQ9x2Zk3ZvFE=;
        b=GyR3qHtLe+EvuvrEEqAyP1CpPTbg3gkx3/Sir2MW9cCGBW+N5IGbt4bX27z05WigXi
         zpvaCEWJuNZnM8fRPFv38Q+eYYwbMQRPdTly+6kmiQB2XBybb6WTF9SCbVvx3G18ONvJ
         FRa8jgPcJVmRTgOOy+4xeDOK/5R8JSJ4o/tr0tvHFgtrPKvvh7ZSuH3RCPdbL7SQXNCd
         1MzOkvk0POAu2rSar9Xuv0SXhbn2aUGw70hHO0RxTCeacsFnM8v7OKYnmy5qNZra0wF8
         iAoWFw/SXTsvZWsWh1OaG5jxvqIcp/yKQ//ef6NDGnK78QJPBBiQ5Ah1h5J9ity1A1P+
         igdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aH2S9cb5inSSXBHPiUpQ/ZDpNgEfTJ6VQ9x2Zk3ZvFE=;
        b=l8mcjbx0MDHtsVPI3HykY1gxQ2zYC5XM1ksMkdvrYmcYG8fA8TwxMoVQr8UnfMk/Fx
         y4CrVRGDjdG65W+wyfPBq7Vpni8GFhtTAa1amMIBZDtEvzyVDzGXtwNLDQPGwH93W0dm
         0rlfsjdc0YdaGwjYHzDxrvxykZd6l/a7hETycxLMNzBHfUMkttWGkoBdwM1OTn4nIGn2
         eueYNT3Lh9qhDp2vIIpisbMaV9rwVh3oHSZ7qzKAjEwcz+kCdOOzRRMIt6SMYxhPZmAq
         oDs0GX49JwCFklN1Ba9z3zWU0V7AxwhwEnCMiwXCmn+AYyRh973BsFwPfVhUlMYxWH5J
         t5oA==
X-Gm-Message-State: AOAM533kHybQjOvxO2PfNLhFo8mTAWqUBm0gx9Q57KeUYt8nqccjLu6p
        TzP3xJRQnhuXkwUn18Wrp9kFP8exO7E7/b6EN5BmJS5TW78=
X-Google-Smtp-Source: ABdhPJxbHuPs5/JFDTsDMe/rQ55yCf4zywT4HUtUBZu9xUbLclrve7lpqTg7/gNboTVnXaRHZ+TgCIUBbz+HnufxNTw=
X-Received: by 2002:a6b:6b11:: with SMTP id g17mr19644156ioc.72.1621949016616;
 Tue, 25 May 2021 06:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210524135321.2190062-1-amir73il@gmail.com> <20210525101505.rspv2c6kajzswvwn@wittgenstein>
In-Reply-To: <20210525101505.rspv2c6kajzswvwn@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 25 May 2021 16:23:25 +0300
Message-ID: <CAOQ4uxhqkF7J06FCY6phoK1nY=1COo=swT8Ffg3vrU1koGs0wA@mail.gmail.com>
Subject: Re: [PATCH][v2] fanotify: fix permission model of unprivileged group
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 1:15 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, May 24, 2021 at 04:53:21PM +0300, Amir Goldstein wrote:
> > Reporting event->pid should depend on the privileges of the user that
> > initialized the group, not the privileges of the user reading the
> > events.
>
> I think it's in general a good permission model to not have the result
> depend as little on the reader as possible post-open/init. So this makes
> a lot of sense to me and I'm a bit surprised it wasn't like that right
> away. :)
>

You are right. We got lot there.
The fact that pid_vnr() may not report pid depending on the caller's ns
contributed to the confusion for making it depend in the caller's creds,
but namespace and credentials behave differently.

Thanks for the review,
Amir.
