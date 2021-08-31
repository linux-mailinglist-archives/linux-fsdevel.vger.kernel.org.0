Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767273FC8DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhHaNyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhHaNyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:54:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53220C0613D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 06:53:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n11so26884872edv.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KsdRco5g3Rxsur7HnzmWia1aqV1LswyiZ+q0x+vuSY=;
        b=HQ7YjqNn+GvyrMyaEw4Ts6k7wU5aPcFPAWZ/MvIgnb/b3nJTG/bZDiK6JU5Urc0OGw
         eYdX1ndiXPm2WmlL+IK4/u/BaFz6AbYdNIgxPmK/jtKVgAB4AXg1YnEwThk50eDSwxKa
         5zamzfT+Mw9ZsLCNbbSg/KnigE4n5pxUzOD+A/0pPF9mh4JO0EwgAg6tp4mjPp+2ybhC
         LKwkjJVc1hih9nB2NRvpLDKH15CvIzCDRkybcb8PHSW6J2tGC65jUPq2wh7pHwEv7mh1
         GGntJW/v2BIHeuezNaO8q8z3cKspObfYA7MpK111176yeraZmzPIIb/SJwoe9ailV5zQ
         GIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KsdRco5g3Rxsur7HnzmWia1aqV1LswyiZ+q0x+vuSY=;
        b=BsFNG4HdZg2ZOPpw9xKYIDtLGUHqsjqBE9jPynI3FaQcNV6DAVxA7qswucLQ8Vb3g3
         dFx8aEpKvLu+Jnm3i2EAkhdYPo6uIFl1r/e94gd+WHXOqXLtH7f6KA9DC0/uvuRCwsQi
         fQj7q9FF4loM4OabpgREo9mzSedAgxE4KWBleP5XFWcWK9hbKuXCkaFr07hy3o8gAPXT
         YwB/0NM0BUSCyHxOX2KQINNOI+y9iUcdDCDMs4YAF2v3bYosmsLexpAsFKQmerT034wp
         dveAhqSPNPrgjMh4bG91rxGr00UTLIup5kQoLn8EhZTd55DC5HEZiwgFeoQQN9aYidbw
         ibAw==
X-Gm-Message-State: AOAM5330Y6hDpg4AUBWAeAmD/8ZXSkTejaaJkJeMtw5WrvjQTvZv7tPX
        3xPwahygj2T/Q50JlJjipGjcFxPO2YKuOtoLYn0I
X-Google-Smtp-Source: ABdhPJws3lszVbtjZiLZOptaWsbrL101boZlKAvA+uSpyGqWqgyhydVacfD22Otuw8Ioe1qUU+ZoAgTEh8gbHZtS+70=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr30419950edw.269.1630418020725;
 Tue, 31 Aug 2021 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
 <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
In-Reply-To: <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 09:53:29 -0400
Message-ID: <CAHC9VhTGECM2p+Q8n48aSdfJzY6XrpXQ5tcFurjWc4A3n8Qxjg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        X86 ML <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 5:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Jun 19, 2021 at 12:18 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 2acc6173da36..c1747b6555c7 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
> > >         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> > >                 return false;
> > >
> > > -       if (security_locked_down(LOCKDOWN_NONE))
> > > +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...however that usage looks wrong. The expectation is that if kernel
> > integrity protections are enabled then raw command access should be
> > disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
> > in terms of the command capabilities to filter.
>
> Yes, the LOCKDOWN_NONE seems wrong here... but it's a pre-existing bug
> and I didn't want to go down yet another rabbit hole trying to fix it.
> I'll look at this again once this patch is settled - it may indeed be
> as simple as replacing LOCKDOWN_NONE with LOCKDOWN_PCI_ACCESS.

At this point you should be well aware of my distaste for merging
patches that have known bugs in them.  Yes, this is a pre-existing
condition, but it seems well within the scope of this work to address
it as well.

This isn't something that is going to get merged while the merge
window is open, so at the very least you've got almost two weeks to
sort this out - please do that.

-- 
paul moore
www.paul-moore.com
