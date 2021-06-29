Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D583B7688
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhF2Qhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 12:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233309AbhF2Qhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624984510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFtEvrlVui7BaqyBqVH/Nri0P4QA4rILRLxREoawxLs=;
        b=i1yzkV2ahLGwgP5jLL+/NrIaTV1nZ9FVeGuAbYGlQkU3BHFuD/EVMrzW7Ffwe8tj/j7AlD
        CdaJqi3XBH0MznOeexczCKVTxS6HDKyQ7ANR735DFL1LVLuGX/QvUA7/AGD/VFS+PYhn8j
        Jm9k5h6s+tKCpQ+wq/PKihN4NrMMKHY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-mg-sPB8kP4-taoHORMMZRQ-1; Tue, 29 Jun 2021 12:35:06 -0400
X-MC-Unique: mg-sPB8kP4-taoHORMMZRQ-1
Received: by mail-wr1-f72.google.com with SMTP id x8-20020a5d54c80000b029012583535285so2392805wrv.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 09:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFtEvrlVui7BaqyBqVH/Nri0P4QA4rILRLxREoawxLs=;
        b=UZ0xtLVK9KB6Tsoz6Zopw419XvHmLrxS2dOypI71VIg45afENI1RSZJ46Aiz8O/dbK
         ZcL9c2Ea1mhkwmOr/wwZUR3bUtdCYwX7apzyC2tNhp1nlmLBu3QR1h23fdQ/D3WCZxdZ
         H8Zr8w9uwIWjcjpc+tZVOOtIChn6merM408ZdkAUmnXHr6RRmNHuy0O443ADeYXxOc/B
         ZoPE+omqUSDU6vk8zeImQDYu7t03YyftjAevy7Xmylam3WlG/3L9x8IHp3kif9CrBFDB
         V0I0V2Q+8UNZxiwsSqqDP5Nm7ejHGBtATPY+VCDZ1t1eLZrDMdQmJfA804nATe0o98Ll
         6Ipg==
X-Gm-Message-State: AOAM531v4D6lRPHok7v+o2/cjw7JhOZ+g3pByKGldP/LHOeBWTtSFq+J
        atgL/Q3ROdERBHYQUo3Kvdr90e6HF+QDLa8RLjib2gCmBzgB4OgGzXIW1R2Ml1XWzyXzR1OZmNA
        xp72IHEDO0EekzjMt4Bfvjypk4w==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr6664207wml.46.1624984505138;
        Tue, 29 Jun 2021 09:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbXpe6YhaxmyBREWJcgIymhFJ1te792D2kTWPT4Yam7vgoBla33uYBYbd6hpfHa5vYENMtew==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr6664187wml.46.1624984504942;
        Tue, 29 Jun 2021 09:35:04 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id f2sm9166880wrd.64.2021.06.29.09.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:35:04 -0700 (PDT)
Date:   Tue, 29 Jun 2021 17:35:02 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, dwalsh@redhat.com,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNtLtkkDMWye485A@work-vm>
References: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Casey Schaufler (casey@schaufler-ca.com) wrote:
> On 6/29/2021 8:20 AM, Vivek Goyal wrote:
> > On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
> >
> > [..]
> >>>>>> User xattrs are less protected than security xattrs. You are exposing the
> >>>>>> security xattrs on the guest to the possible whims of a malicious, unprivileged
> >>>>>> actor on the host. All it needs is the right UID.
> >>>>> Yep, we realise that; but when you're mainly interested in making sure
> >>>>> the guest can't attack the host, that's less worrying.
> >>>> That's uncomfortable.
> >>> Why exactly?
> >> If a mechanism is designed with a known vulnerability you
> >> fail your validation/evaluation efforts.
> > We are working with the constraint that shared directory should not be
> > accessible to unpriviliged users on host. And with that constraint, what
> > you are referring to is not a vulnerability.
> 
> Sure, that's quite reasonable for your use case. It doesn't mean
> that the vulnerability doesn't exist, it means you've mitigated it. 
> 
> 
> >> Your mechanism is
> >> less general because other potential use cases may not be
> >> as cavalier about the vulnerability.
> > Prefixing xattrs with "user.virtiofsd" is just one of the options.
> > virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
> > We have not chosen that because we don't want to give it CAP_SYS_ADMIN.
> >
> > So other use cases which don't like prefixing "user.virtiofsd", can
> > give CAP_SYS_ADMIN and work with it.
> >
> >> I think that you can
> >> approach this differently, get a solution that does everything
> >> you want, and avoid the known problem.
> > What's the solution? Are you referring to using "trusted.*" instead? But
> > that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.
> 
> I'm coming to the conclusion that xattr namespaces, analogous
> to user namespaces, are the correct solution. They generalize
> for multiple filesystem and LSM use cases. The use of namespaces
> is well understood, especially in the container community. It
> looks to me as if it would address your use case swimmingly.

Yeh; although the details of getting the semantics right is tricky;
in particular, the stuff which clears capabilitiies/setuid/etc on writes
- should it clear xattrs that represent capabilities?  If the host
  performs a write, should it clear mapped xattrs capabilities?  If the
namespace performs a write should it clear just the mapped ones or the
host ones as well?  Our virtiofsd code performs acrobatics to make
sure they get cleared on write that are painful.

Dave

> >
> > Thanks
> > Vivek
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

