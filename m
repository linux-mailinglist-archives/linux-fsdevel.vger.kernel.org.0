Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD9D618D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 01:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKDALS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 20:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDALR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:11:17 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF071E714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:11:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s206so3742409oie.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CfzRp3MLVkYQLRLuL81/8WT50owPWMsjEowD7zBOxaQ=;
        b=Wjj6zr15+eQJLiP6SIosw01pvjWqbCk+GHiefC16PR0RoeE3c9nV7CCG4z/jwNaN2G
         TMUPtsbXYfe3/AjgfRuPSPngPM09WhVcdbR3yFliJKPKxxmTOtVrj131eEbu4NgLu4Sr
         q6r3BPuWfMe+dQds6SE9Mr6KOyVvWcUuon47jicCvc99qUnov7qnQ+4va/nQ/DzDg415
         m0b+E+px0h8oSskHD44felHsY257YToHMBjind8uGi/p8oW91monOTnM8Dxh94CzwMEJ
         KF5ftBR4/Q/HmtSgdByXDkBkvS/vqHWgLYA0DvJQcpLHpGaJsdFC4NYheUYsJM8rjDG9
         dqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfzRp3MLVkYQLRLuL81/8WT50owPWMsjEowD7zBOxaQ=;
        b=FcdX5Dzp+iYL3cslR6VBUUWpiiqij80LDUyG3sUf/CKZqIiJE1G3ceI4EKHKt30Rrw
         a3Ju1hCyflktABVIrVSaEm8kBnlZ95ctlT26N5Hd2eAq0a1zJ22etU+gNQ88YvddDJ4Z
         q7OAGeFpw7AyuLEOSLe1guEpP4buSilGg+sKOJbF9Pj8YwzPMsNV84vx2QNSFXbaMQK5
         TqaBYLHIcpQGBwxY+g7Dacmlc1mVZTrqpvezcJXw6n0UkEhnHa4wEVTjLkNE86BaAAIp
         LU1Y0HBe6fMjyWkRzCkgokX8fbEyE48WCUksVBTAz1X2XTi0pRayoGNv7y0ST+jsLnP5
         uYHA==
X-Gm-Message-State: ACrzQf2QP+WlnhiwrYFqrobg35OwEu0c/acX+rtU4iXo7vSRfY+TFJRd
        m/5ZG9NxDgwO2Zi9KgGDpwtUA0KNR1MEisTtQ48ndg==
X-Google-Smtp-Source: AMsMyM688GlEslWmm5iNwbqzsSzU2mAVcbZ94GW2VckvN3to/iaSIm6mqyLTMeDq/c23PNU1FmCiuyZlgKsELDW4Ah4=
X-Received: by 2002:a05:6808:1184:b0:350:f681:8c9a with SMTP id
 j4-20020a056808118400b00350f6818c9amr17972547oil.282.1667520675336; Thu, 03
 Nov 2022 17:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QR0EDvq7p9i1xw@nvidia.com> <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com>
In-Reply-To: <Y2QfkszbNaI297nl@nvidia.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Nov 2022 17:11:04 -0700
Message-ID: <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
Subject: Re: xarray, fault injection and syzkaller
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Nov 2022 at 13:07, 'Jason Gunthorpe' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, Nov 03, 2022 at 08:00:25PM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 03, 2022 at 04:09:04PM -0300, Jason Gunthorpe wrote:
> > > Hi All,
> > >
> > > I wonder if anyone has some thoughts on this - I have spent some time
> > > setting up syzkaller for a new subsystem and I've noticed that nth
> > > fault injection does not reliably cause things like xa_store() to
> > > fail.

Hi Jason, Matthew,

Interesting. Where exactly is that kmalloc sequence? xa_store() itself
does not have any allocations:
https://elixir.bootlin.com/linux/v6.1-rc3/source/lib/xarray.c#L1577

Do we know how common/useful such an allocation pattern is?
If it's common/useful, then it can be turned into a single kmalloc()
with some special flag that will try both allocation modes at once.

Potentially fail-nth interface can be extended to accept a set of
sites, e.g. "5,7" or, "5-100".
Though, not sure what the systematic enumeration should be then if we
go beyond "every single site on its own"... but I guess we can figure
it out.



> > > It seems the basic reason is that xarray will usually do two
> > > allocations, one in an atomic context which fault injection does
> > > reliably fail, but then it almost always follows up with a second
> > > allocation in a non-atomic context that doesn't fail because nth has
> > > become 0.
> >
> > Hahaha.  I didn't intentionally set out to thwart memory allocation
> > fault injection.  Realistically, do we want it to fail though?
> > GFP_KERNEL allocations of small sizes are supposed to never fail.
> > (for those not aware, node allocations are 576 bytes; typically the slab
> > allocator bundles 28 of them into an order-2 allocation).

I hear this statement periodically. But I can't understand its status.
We discussed it recently here:
https://lore.kernel.org/all/CACT4Y+Y_kg1J00iBL=sMr5AP7U4RXuBizusvQG52few2NcJ6dg@mail.gmail.com/

Likely/unlikely is not what matters, right? It's only: can it fail at
all or not?
If some allocation can't fail 100% and we want to rely on this in
future (not just a current implementation detail), then I think we
need to (1) make fault injection to not fail them, add a BUG_ON in the
allocation to panic if they do fail, (3) maybe start removing error
handling code (since having buggy/untested/confusing code is not
useful).


> I don't know, I have code to handle these failures, I want to test it
> :)
>
> > I think a simple solution if we really do want to make allocations fail
> > is to switch error injection from "fail one allocation per N" to "fail
> > M allocations per N".  eg, 7 allocations succeed, 3 allocations fail,
> > 7 succeed, 3 fail, ...  It's more realistic because you do tend to see
> > memory allocation failures come in bursts.
>
> The systemic testing I've setup just walks nth through the entire
> range until it no longer triggers. This hits every injection point and
> checks the failure path of it. This is also what syzkaller does
> automatically from what I can tell
>
> If we make it probabilistic it is harder to reliably trigger these
> fault points.
