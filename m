Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E43B6792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhF1RZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232742AbhF1RZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624900967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mapazr28tYo+knARgLEMLecpSAwW9lTeDrNh/ti3ErI=;
        b=K0QMtrXEb7716x0/ezYz2DB4smOzz36YN/vJvynykSZF/xxIlSrdDMVynFddx3xdQhIMrT
        kOGyLTeWtKenCRsUXklKo3r29316hqzG+B3AY4L40AfCGhse2ixBSH3sxsHuPUYnO1GFiZ
        KrKA74EQUEStrKMRyDIrcqMH9AnsNmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-iBBGcVNKP-S4y3NcbYfiVw-1; Mon, 28 Jun 2021 13:22:45 -0400
X-MC-Unique: iBBGcVNKP-S4y3NcbYfiVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9B5101C8B3;
        Mon, 28 Jun 2021 17:22:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-225.rdu2.redhat.com [10.10.115.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC175C1D0;
        Mon, 28 Jun 2021 17:22:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1398022054F; Mon, 28 Jun 2021 13:22:40 -0400 (EDT)
Date:   Mon, 28 Jun 2021 13:22:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dwalsh@redhat.com, "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <20210628172240.GE1803896@redhat.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:04:40AM -0700, Casey Schaufler wrote:

[..]
> > on a host without SELinux support but the VM has SELinux enabled, then virtiofsd needs CAP_SYS_ADMIN.  It would be much more secure if it only needed CAP_SYS_RESOURCE.
> 
> I don't know, so I'm asking. Does virtiofsd really get run with limited capabilities,
> or does it get run as root like most system daemons? If it runs as root the argument
> has no legs.

It runs as root but we give it a set of minimum required capabilities by
default and want to avoid giving it CAP_SYS_ADMIN.

> 
> >   If the host has SELinux enabled then it can run without CAP_SYS_ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write labels that the host system understands, any label not understood will be blocked. Not only this, but the label that is running virtiofsd pretty much has to run as unconfined, since it could be writing any SELinux label.
> 
> You could fix that easily enough by teaching SELinux about the proper
> use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
> going to happen, and why it would be considered philosophically repugnant
> in the SELinux community. 
> 
> >
> > If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can run with a confined SELinux label only allowing it to sexattr on the content in the designated directory, make the container/vm much more secure.
> >
> User xattrs are less protected than security xattrs. You are exposing the
> security xattrs on the guest to the possible whims of a malicious, unprivileged
> actor on the host. All it needs is the right UID.

One of the security tenets of virtiofs is that this shared directory should
be hidden from unprivliged users. Otherwise guest can drop setuid root
binaries in shared directory and unprivliged user on host executes it and
gets control of the host.

So unpriviliged actor on host having access to these shared directory
contents is wrong configuration.

> 
> We have unused xattr namespaces. Would using the "trusted" namespace
> work for your purposes?

That requires giving CAP_SYS_ADMIN to daemon and one of the goals is
to give as little capabilities as possible to virtiofsd. In fact people
have been asking for the capablities to run virtiofsd unpriviliged
as well as run inside a user namespace etc.

Anyway, remapping LSM xattrs to "trusted.*" space should work as long
as virtiofsd has CAP_SYS_ADMIN.

Thanks
Vivek

