Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497B63B7512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhF2PWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 11:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234737AbhF2PWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624980012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Fkq8ISJodPGui8B5jJOFqU9Bg1udkwvRSG9eU74aiM=;
        b=gJjGzjTK/xwdSPEG6EC3Urqe+gr47WF02rdd/H1xnZ7fzUKYJjNWM0wasJt+2YHvH0/XJr
        0qkf82wpB7vkDiA1RjGfwHX9SMHcOc6bU69JUq+645zT6MfH8asEUoQPB4J3WdBXvsr25/
        YYP+B2JUx+OmhqEVsYdJCGVPzplqKUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-4agmsaUJMm22gB7tekRyFA-1; Tue, 29 Jun 2021 11:20:11 -0400
X-MC-Unique: 4agmsaUJMm22gB7tekRyFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B1A100CA88;
        Tue, 29 Jun 2021 15:20:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-194.rdu2.redhat.com [10.10.116.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71B4D5D6A1;
        Tue, 29 Jun 2021 15:20:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0C3BD22054F; Tue, 29 Jun 2021 11:20:08 -0400 (EDT)
Date:   Tue, 29 Jun 2021 11:20:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>, dwalsh@redhat.com,
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
Message-ID: <20210629152007.GC5231@redhat.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:

[..]
> >>>> User xattrs are less protected than security xattrs. You are exposing the
> >>>> security xattrs on the guest to the possible whims of a malicious, unprivileged
> >>>> actor on the host. All it needs is the right UID.
> >>> Yep, we realise that; but when you're mainly interested in making sure
> >>> the guest can't attack the host, that's less worrying.
> >> That's uncomfortable.
> > Why exactly?
> 
> If a mechanism is designed with a known vulnerability you
> fail your validation/evaluation efforts.

We are working with the constraint that shared directory should not be
accessible to unpriviliged users on host. And with that constraint, what
you are referring to is not a vulnerability.

> Your mechanism is
> less general because other potential use cases may not be
> as cavalier about the vulnerability.

Prefixing xattrs with "user.virtiofsd" is just one of the options.
virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
We have not chosen that because we don't want to give it CAP_SYS_ADMIN.

So other use cases which don't like prefixing "user.virtiofsd", can
give CAP_SYS_ADMIN and work with it.

> I think that you can
> approach this differently, get a solution that does everything
> you want, and avoid the known problem.

What's the solution? Are you referring to using "trusted.*" instead? But
that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.

Thanks
Vivek

