Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D715F74B5A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGGRVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGRVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD9125;
        Fri,  7 Jul 2023 10:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9175619D3;
        Fri,  7 Jul 2023 17:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E18C433C8;
        Fri,  7 Jul 2023 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688750508;
        bh=OrYfHqGh7Yg+DHkaVzcEIwqaXDgud0/nXirOe74xyjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ybzxb7rH812Lx5wUW0LUaiThsvzJbSvt6IM4/LcBRVK7YJMj4hw/0PHj8z6n8ShfR
         UssfSMBdAop0N7gcaUKk7wfk0n+wp4OWntJkeZCQWbmrHzUp4+BfsrmqFMhLza0eY2
         GZjTrZV2Fnv7UuVTDy0bIeZPKmAYPGWUcy1dzFrXwzeMSn+pkEGDvnj9Ht7ivDY0aD
         Mzh94jt6oEqJfHnxC5qMjHkD21T+7yGRI4H4ddYZAjSVkqz8r1H61bba1w/RxTUWzL
         4Py/9OFtKNGal/Kdt8i0UP/e28xCEugb/SKOTLfVBr61naGjWucgpqfKFk2+0LrDU9
         +1tDTMJGfGepQ==
Date:   Fri, 7 Jul 2023 19:21:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>, Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <20230707-konsens-ruckartig-211a4fb24e27@brauner>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:56:45PM -0700, Linus Torvalds wrote:
> On Mon, 26 Jun 2023 at 09:14, Ahelenia Ziemiańska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > And even if that was a working work-around, the fundamental problem of
> > ./spl>fifo excluding all other access to fifo is quite unfortunate too.
> 
> So I already sent an earlier broken version of this patch to Ahelenia
> and Christian, but here's an actually slightly tested version with the
> obvious bugs fixed.
> 
> The keyword here being "obvious". It's probably broken in many
> non-obvious ways, but I'm sending it out in case anybody wants to play
> around with it.
> 
> It boots for me. It even changes behavior of programs that splice()
> and used to keep the pipe lock over the IO and no longer do.
> 
> But it might do unspeakable things to your pets, so caveat emptor. It
> "feels" right to me. But it's a rather quick hack, and really needs
> more eyes and more thought. I mention O_NDELAY in the (preliminary)
> commit message, but there are probably other issues that need thinking
> about.

Forgot to say, fwiw, I've been running this through the LTP splice,
pipe, and ipc tests without issues. A hanging reader can be signaled
away cleanly with this.
