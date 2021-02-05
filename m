Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A7310F77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBEQXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 11:23:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhBEQUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:20:15 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1578A205CF84;
        Fri,  5 Feb 2021 10:01:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1578A205CF84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612548115;
        bh=sG8c3V5j/GNMfkgLTSc6ef1pV212YYCAuyDQ9vNbitQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTJv5WEdDWXiv8DSub2T2iKWOi+ew0aC6UN8s5QsIqPWkvmYtKxOXfQuQE8G3CiOr
         OlGlTYH021e0UCSihAbUPmTHLnp15ETkiJnV3SnPAldNne5OXhCZcX6lCvBdEhddAJ
         q16xUifV5+fGOvx3S9QkRJLhHakg0iVshK0Q5rmc=
Date:   Fri, 5 Feb 2021 12:01:47 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-doc@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [RESEND PATCH v18 2/4] overlayfs: handle XATTR_NOSECURITY flag
 for get xattr method
Message-ID: <20210205180131.GA648953@sequoia>
References: <20201021151903.652827-1-salyzyn@android.com>
 <20201021151903.652827-3-salyzyn@android.com>
 <CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com>
 <2fd64e4f-c573-c841-abb6-ec0908f78cdd@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd64e4f-c573-c841-abb6-ec0908f78cdd@android.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-10-30 09:00:35, Mark Salyzyn wrote:
> On 10/30/20 8:07 AM, Miklos Szeredi wrote:
> > On Wed, Oct 21, 2020 at 5:19 PM Mark Salyzyn <salyzyn@android.com> wrote:
> > > Because of the overlayfs getxattr recursion, the incoming inode fails
> > > to update the selinux sid resulting in avc denials being reported
> > > against a target context of u:object_r:unlabeled:s0.
> > > 
> > > Solution is to respond to the XATTR_NOSECURITY flag in get xattr
> > > method that calls the __vfs_getxattr handler instead so that the
> > > context can be read in, rather than being denied with an -EACCES
> > > when vfs_getxattr handler is called.
> > > 
> > > For the use case where access is to be blocked by the security layer.
> > > 
> > > The path then would be security(dentry) ->
> > > __vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
> > > handler->get({dentry...XATTR_NOSECURITY}) ->
> > > __vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
> > > lower_handler->get({realdentry...XATTR_NOSECURITY}) which
> > > would report back through the chain data and success as expected,
> > > the logging security layer at the top would have the data to
> > > determine the access permissions and report back to the logs and
> > > the caller that the target context was blocked.
> > > 
> > > For selinux this would solve the cosmetic issue of the selinux log
> > > and allow audit2allow to correctly report the rule needed to address
> > > the access problem.
> > > 
> > > Check impure, opaque, origin & meta xattr with no sepolicy audit
> > > (using __vfs_getxattr) since these operations are internal to
> > > overlayfs operations and do not disclose any data.  This became
> > > an issue for credential override off since sys_admin would have
> > > been required by the caller; whereas would have been inherently
> > > present for the creator since it performed the mount.
> > > 
> > > This is a change in operations since we do not check in the new
> > > ovl_do_getxattr function if the credential override is off or not.
> > > Reasoning is that the sepolicy check is unnecessary overhead,
> > > especially since the check can be expensive.
> > > 
> > > Because for override credentials off, this affects _everyone_ that
> > > underneath performs private xattr calls without the appropriate
> > > sepolicy permissions and sys_admin capability.  Providing blanket
> > > support for sys_admin would be bad for all possible callers.
> > > 
> > > For the override credentials on, this will affect only the mounter,
> > > should it lack sepolicy permissions. Not considered a security
> > > problem since mounting by definition has sys_admin capabilities,
> > > but sepolicy contexts would still need to be crafted.
> > This would be a problem when unprivileged mounting of overlay is
> > introduced.  I'd really like to avoid weakening the current security
> > model.
> 
> The current security model does not deal with non-overlapping security
> contexts between init (which on android has MAC permissions only when
> necessary, only enough permissions to perform the mount and other mundane
> operations, missing exec and read permissions in key spots) and user calls.
> 
> We are only weakening (that is actually an incorrect statement, security is
> there, just not double security of both mounter and caller) the security
> around calls that retrieve the xattr for administrative and internal
> purposes. No data is exposed to the caller that it would not otherwise have
> permissions for.

We've ran into the same issues that Mark is trying to solve with this
series. I came across Mark's series while searching around before I
wrote up a similar patch to Mark's patch #3.

We have a confined process that sets up Overlayfs mounts, then that process
starts a service confined by another security context, then that service
may execute binaries that run under a third security context. In this
case, I'm talking about SELinux security contexts but it could be
AppArmor or anything else that you use to separate out
privileges/permissions at fine-grained detail.

We don't want to grant all the privileges/permissions required by the
service (and its helper utilities) to the process that sets up the
Overlayfs mounts because we've been very careful in separating them
apart with security policy. However, we want to make use of Overlayfs
and adding a mount option to bypass the check on the mounter's cred
seems like a safe way of using Overlayfs without violating our principle
of least privilege.

Tyler

> 
> This patch becomes necessary when matched with the PATCH v18 3/4 of the
> series which fixes the user space break introduced in ~4.6 that formerly
> used the callers credentials for all accesses in all places. Security is
> weakened already as-is in overlayfs with all the overriding of the
> credentials for internal accesses to overlayfs mechanics based on the
> mounter credentials. Using the mounter credentials as a wider security hole
> is the problem, at least with PATCH v18 3/4 of the series we go back
> optionally to only using the caller's credentials to perform the operations.
> Admittedly some of the internal operations like mknod are privileged, but at
> least in Android's use case we are not using them with callers without the
> necessary credentials.
> 
> Android does not give the mounter more credentials than the callers, there
> is very little overlap in the MAC security.
> 
> > The big API churn in the 1/4 patch also seems excessive considering
> > that this seems to be mostly a cosmetic issue for android.  Am I
> > missing something?
> 
> Breaks sepolicy, it no longer has access to the context data at the
> overlayfs security boundary.
> 
> unknown is a symptom of being denied based on the denial to xattr data from
> the underlying filesystem layer. Being denied the security context of the
> target is not a good thing within the sepolicy security layer.
> 
> > 
> > Thanks,
> > Miklos
> 
> 
