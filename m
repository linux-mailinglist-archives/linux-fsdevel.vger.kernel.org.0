Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5616B41AF62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbhI1Mv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 08:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240718AbhI1MvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632833385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OjzlHChlIdua6HzkwK7TEsS1WcbBvZpzeOjaECmbAg=;
        b=D0mggH5MdIM19QYAEC58VOnVh7rqcSxJNnTLc/mno0iTalHU5dUbdoUWLu+9Nx9cidGamY
        1iM52yZ4NYTg3Pr9L5OBs95QSUI6f5LtYf6qD4zzcISvU1XDQ8TOtwCGfJpPYRTNyL9GoY
        v5GSRMHpdP5PdKApw2H1kvkUyF9QXbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-Jet5eLGWNp-ibvWKpVhIQA-1; Tue, 28 Sep 2021 08:49:44 -0400
X-MC-Unique: Jet5eLGWNp-ibvWKpVhIQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671C91B2C984;
        Tue, 28 Sep 2021 12:49:42 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A07C1F478;
        Tue, 28 Sep 2021 12:49:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A8F44220B02; Tue, 28 Sep 2021 08:49:36 -0400 (EDT)
Date:   Tue, 28 Sep 2021 08:49:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        chirantan@chromium.org, Miklos Szeredi <miklos@szeredi.hu>,
        stephen.smalley.work@gmail.com, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
Message-ID: <YVMPYIKL2aUBIasK@redhat.com>
References: <YU5gF9xDhj4g+0Oe@redhat.com>
 <8a46efbf-354c-db20-c24a-ee73d9bbe9d6@schaufler-ca.com>
 <YVHPxYRnZvs/dH7N@redhat.com>
 <753b1417-3a9c-3129-1225-ca68583acc32@schaufler-ca.com>
 <YVHpxiguEsjIHTjJ@redhat.com>
 <67e49606-f365-fded-6572-b8c637af01c5@schaufler-ca.com>
 <YVIZfHhS4X+5BNCS@redhat.com>
 <2e00fbff-b868-3a4f-ecc4-e5f1945834b8@schaufler-ca.com>
 <YVItb/GctH7PpL0f@redhat.com>
 <5d6230dc-bba5-a5c1-2c54-da5e6ecfbf2e@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6230dc-bba5-a5c1-2c54-da5e6ecfbf2e@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 02:45:13PM -0700, Casey Schaufler wrote:
[..]
> >>> I see that NFS and ceph are supporting single security label at
> >>> the time of file creation and I added support for the same for
> >>> fuse.
> >> NFS took that course because the IETF refused for a very long time
> >> to accept a name+value pair in the protocol. The implementation
> >> was a compromise.
> >>
> >>> You seem to want to have capability to send multiple "name,value,len"
> >>> tuples so that you can support multiple xattrs/labels down the
> >>> line.
> >> No, so I can do it now. Smack keeps multiple xattrs on filesystem objects.
> >> 	security.SMACK64		- the "security label"
> >> 	security.SMACK64EXEC		- the Smack label to run the program with
> >> 	security.SMACK64TRANSMUTE	- controls labeling on files created
> >>
> >> There has been discussion about using additional attributes for things
> >> like socket labeling.
> >>
> >> This isn't hypothetical. It's real today. 
> > It is real from SMACK point of view but it is not real from 
> > security_dentry_init_security() hook point of view. What's equivalent
> > of that hook to support SMACK and multiple labels?
> 
> When multiple security modules support this hook they will
> each get called. So where today security_dentry_init_security()
> calls selinux_dentry_init_security(), in the future it will
> also call any other <lsm>_dentry_init_security() hook that
> is registered. No LSM infrastructure change required.

I don't think security_dentry_init_security() can handle multiple
security labels without change.

int security_dentry_init_security(struct dentry *dentry, int mode,
                                        const struct qstr *name, void **ctx,
                                        u32 *ctxlen)
{
        return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
                                name, ctx, ctxlen);
}

It can reutrn only one security context. So most likely you will have
to add another hook to return multiple security context and slowly
deprecate this one.

IOW, as of today security_dentry_init_security() can't return multiple
security labels. In fact it does not even tell the caller what's the
name of the xattr. So caller has no idea if this security label came
from SELinux or some other LSM. So for all practical purposes this
is a hook for getting SELinux label and does not scale to support
other LSMs.

> 
> 
> >>> Even if I do that, I am not sure what to do with those xattrs at
> >>> the other end. I am using /proc/thread-self/attr/fscreate to
> >>> set the security attribute of file.
> >> Either you don't realize that attr/fscreate is SELinux specific, or
> >> you don't care, or possibly (and sadly) both.
> > I do realize that it is SELinux specific and that's why I have raised
> > the concern that it does not work with SMACK.
> >
> > What's the "fscreate" equivalent for SMACK so that I file server can
> > set it before creation of file and get correct context file?
> 
> The Smack attribute will be inherited from the creating process.
> There is no way to generally change the attribute of a file on
> creation. The appropriateness of such a facility has been debated
> long and loud over the years. SELinux, which implements so varied
> a set of "security" controls opted for it. Smack, which sticks much
> more closely to an access control model, considers it too dangerous.
> You can change the Smack label with setxattr(1) if you have
> CAP_MAC_ADMIN.

Ok, calling setxattr() after file creation will make the operation
non-atomic. Will be good if it continues to be atomic.

> If you really want the file created with a particular
> Smack label you can change the process Smack label by writing to
> /proc/self/attr/smack/current on newer kernels and /proc/self/attr/current
> on older ones.

I guess /proc/thread-self/attr/smack/current is the way to go in this
context, when one wants to support SMACK.

> 
> 
> >>> https://listman.redhat.com/archives/virtio-fs/2021-September/msg00100.html
> >>>
> >>> How will this work with multiple labels. I think you will have to
> >>> extend fscreate or create new interface to be able to deal with it.
> >> Yeah. That thread didn't go to the LSM mail list. It was essentially
> >> kept within the RedHat SELinux community. It's no wonder everyone
> >> involved thought that your approach is swell. No one who would get
> >> goobsmacked by it was on the thread.
> > My goal is to support SELinux at this point of time. If you goal is
> > to support SMACK, feel free to send patches on top to support that.
> 
> It helps to know what's going on before it becomes a major overhaul.

Fair enough.

> 
> > I sent kernel patches to LSM list to make it plenty clear that this
> > interface only supports single label which is SELinux. So there is
> > no hiding here. And when I am supporting only SELinux, making use
> > of fscreate makes perfect sense to me.
> 
> I bet it does.
> 
> >>> That's why I think that it seems premature that fuse interface be
> >>> written to deal with multiple labels when rest of the infrastructure
> >>> is not ready. It should be other way, instead. First rest of the
> >>> infrastructure should be written and then all the users make use
> >>> of new infra.
> >> Today the LSM infrastructure allows a security module to use as many
> >> xattrs as it likes. Again, Smack uses multiple security.* xattrs today.
> > security_dentry_init_security() can handle that? If not, what's the
> > equivalent.
> 
> Yes, it can.

How? How will security_dentry_init_security() return multiple lables?
It has parameters "u32 *ctxlen" and you can return only one. If you
try to return multiple labels and return total length in "ctxlen",
that does not help as you need to know length of individiual labels.
So you need to know the names of xattrs too. Without that its not
going to work.

So no, security_dentry_init_security() can not handle multiple 
security labels (and associated names). 

Vivek

