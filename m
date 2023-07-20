Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7689075A7A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGTHTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjGTHTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D02127
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689837532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYGtszuU5wIRpPGldAIwvzXGaeXBUQT3e9Yc1Tmh1Tk=;
        b=VfWerjhVrq3SqJPb78ypstiUCvDKGFZN6+DRfG3QZS+m22Krf/A86latEQkHRBzi6gL/x0
        Wd5LsBdxoQrmkzCVaEgpzYVtEaPIgcNuuuBXKj62f5ekEybYv08JATL5myzq8Em+PFksEH
        MY+QFxj4X7EXO/CNwlF4pHZAF2GHWsM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-6WmLs9flM2m1QODpNvqj-A-1; Thu, 20 Jul 2023 03:18:50 -0400
X-MC-Unique: 6WmLs9flM2m1QODpNvqj-A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-639ae879810so1457986d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 00:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837530; x=1690442330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYGtszuU5wIRpPGldAIwvzXGaeXBUQT3e9Yc1Tmh1Tk=;
        b=HaUz7nPC/e0HbhQJ9yy5YhE4C48455VglUIkkEAfJF20TN2lGd9nQlQvVp4QwBW1+A
         +LCrLMofaO008NGBgjUwZMYJr8fZrs5KFNjwnkc/dRAxO4dlmu9w0N///gUN4Me5wuBw
         ORUOO1r7ysZF/WLjRorIXQtffP9Gl4TMvnmy1pByUu79bqscx7Ri1jJG4Ur1gUdfKdD9
         lp31MgNVHO4XSytixmR8kGQnlQb24CQkeZbvqnKSiQDW2wQxcUlBVIZjB9Rt4CVPwqox
         uuXZekQh2LQf+TOSYEsjljRZqE+IGLGvHU3YBLsu9269XYZK4liBxmEAg30umcX3qeU2
         8B+w==
X-Gm-Message-State: ABy/qLbaMPCY0b4SLLWZmP5R1zF8s7cwQbU6xn1We1FpGXTLdVlNiyHV
        Pbw1sKJmRrjVTwErcZiKYI0G5uD3PZowT1athhDx+6rS0Jc02eqcE87NuCsLvEInxa7hYsIhma+
        z6KfQa1MQhV/KzbNPMyGHzhRW6w==
X-Received: by 2002:a05:6214:762:b0:616:870c:96b8 with SMTP id f2-20020a056214076200b00616870c96b8mr17420019qvz.3.1689837530203;
        Thu, 20 Jul 2023 00:18:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNH0y5bvIQeSocI2GpS8aKw2ULselhDKyztO/OsqWZvlAvU9rCW8Bzkmb5n6WaEJyCUMCrhw==
X-Received: by 2002:a05:6214:762:b0:616:870c:96b8 with SMTP id f2-20020a056214076200b00616870c96b8mr17419995qvz.3.1689837529948;
        Thu, 20 Jul 2023 00:18:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id n14-20020a0ce48e000000b0062b76c29978sm154802qvl.6.2023.07.20.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:18:49 -0700 (PDT)
Message-ID: <e6d1bf573d535612c2be1f45e7197affe92df639.camel@redhat.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS
 too low! (2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
        dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com,
        clm@fb.com, davem@davemloft.net, dsahern@kernel.org,
        dsterba@suse.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        josef@toxicpanda.com, kadlec@netfilter.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Date:   Thu, 20 Jul 2023 09:18:44 +0200
In-Reply-To: <20230719203030.1296596a@kernel.org>
References: <20230719170446.GR20457@twin.jikos.cz>
         <00000000000042a3ac0600da1f69@google.com>
         <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
         <20230719231207.GF32192@breakpoint.cc> <20230719203030.1296596a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-19 at 20:30 -0700, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 01:12:07 +0200 Florian Westphal wrote:
> > I don't see any netfilter involvement here.
> >=20
> > The repro just creates a massive amount of team devices.
> >=20
> > At the time it hits the LOCKDEP limits on my test vm it has
> > created ~2k team devices, system load is at +14 because udev
> > is also busy spawing hotplug scripts for the new devices.
> >=20
> > After reboot and suspending the running reproducer after about 1500
> > devices (before hitting lockdep limits), followed by 'ip link del' for
> > the team devices gets the lockdep entries down to ~8k (from 40k),
> > which is in the range that it has on this VM after a fresh boot.
> >=20
> > So as far as I can see this workload is just pushing lockdep
> > past what it can handle with the configured settings and is
> > not triggering any actual bug.
>=20
> The lockdep splat because of netdevice stacking is one of our top
> reports from syzbot. Is anyone else feeling like we should add=20
> an artificial but very high limit on netdev stacking? :(

We already have a similar limit for xmit: XMIT_RECURSION_LIMIT. I guess
stacking more then such devices will be quite useless/non functional.
We could use such value to limit the device stacking, too.

Cheers,

Paolo

