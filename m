Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C534210DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbhJDN7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 09:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238593AbhJDN7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633355834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iyWzaXPA7uZntCBGk8rDAII8rV1j7qwLPsi35Cy0yI=;
        b=cuSnkf/yv1EKQehFFjltfMtC2UOB7DLvhb4uuWU8GgVAbhVOyx7x0tqKo67V4SskSJaQ7m
        4i+Olyc6NeQOd+yFXmyuKGQfPunWHl4OAPSsecwB1nkQpBOzUDjTY46+vuTKTR/zZ7TEY+
        ET6bmQMBRLHDiBeLf0gnjmK/ClI/yB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-4dTg2-56MCCYRBfQHq4Qig-1; Mon, 04 Oct 2021 09:57:10 -0400
X-MC-Unique: 4dTg2-56MCCYRBfQHq4Qig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AAF9F92A;
        Mon,  4 Oct 2021 13:57:08 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C17D560C17;
        Mon,  4 Oct 2021 13:57:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0C074220BDB; Mon,  4 Oct 2021 09:57:00 -0400 (EDT)
Date:   Mon, 4 Oct 2021 09:56:59 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        casey@schaufler-ca.com, Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>, jlayton@kernel.org,
        idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, stephen.smalley.work@gmail.com
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
Message-ID: <YVsIK/I1/Wm7sela@redhat.com>
References: <YVYI/p1ipDFiQ5OR@redhat.com>
 <YVigrS1Bc8J8bO1Y@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVigrS1Bc8J8bO1Y@zeniv-ca.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 02, 2021 at 06:10:53PM +0000, Al Viro wrote:
> On Thu, Sep 30, 2021 at 02:59:10PM -0400, Vivek Goyal wrote:
> > Right now security_dentry_init_security() only supports single security
> > label and is used by SELinux only. There are two users of of this hook,
> > namely ceph and nfs.
> > 
> > NFS does not care about xattr name. Ceph hardcodes the xattr name to
> > security.selinux (XATTR_NAME_SELINUX).
> > 
> > I am making changes to fuse/virtiofs to send security label to virtiofsd
> > and I need to send xattr name as well. I also hardcoded the name of
> > xattr to security.selinux.
> > 
> > Stephen Smalley suggested that it probably is a good idea to modify
> > security_dentry_init_security() to also return name of xattr so that
> > we can avoid this hardcoding in the callers.
> > 
> > This patch adds a new parameter "const char **xattr_name" to
> > security_dentry_init_security() and LSM puts the name of xattr
> > too if caller asked for it (xattr_name != NULL).
> 
> Umm...  Why not return the damn thing on success and ERR_PTR(-E...)
> on failure, instead of breeding extra arguments?

Because of the way generic security hook infrastructure is written. There
seem to be only two kind of hooks. Either they return "int" or "void".
And this assumption is built into other helper functions. For example
call_int_hook() and call_void_hook().

So I think it much easier to just add additional parameter and stick
to existing convention of returning an "int", instead of trying to
return a "const char *".

Thanks
Vivek

