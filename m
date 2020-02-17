Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38843161DA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBQXDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 18:03:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39988 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbgBQXDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:03:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EE5E08EE218;
        Mon, 17 Feb 2020 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581980633;
        bh=cKWeAR/GPO4WXEUP0uO66DaWo59eZHYqfr5lOCkqTw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SNq/G+RmQ1Xdi9BnqL2fWWSLDefAI1VgoY2q0pyyUJVpRcwLgFz0OBTnAwFy6s4EA
         rXmg9fCydpYYdXofbP/RCstUAYZNxT+P+EEwsOpEsRosTxEKhvql5Jk06fr2vuKjVF
         BUmW6/qL9sAZnwVMYLGQomCOBiT7nKPLXFNeH79Y=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1jDa1pxOAIGq; Mon, 17 Feb 2020 15:03:51 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4BF3F8EE0F5;
        Mon, 17 Feb 2020 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581980631;
        bh=cKWeAR/GPO4WXEUP0uO66DaWo59eZHYqfr5lOCkqTw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sw4oW0ZJ8ACH2AmNd5N/cNFH7INRk1B8q9b3pWPMEMCOWhUnzQl1OiL1aDhe5bmfc
         9e2tjZQpT5tIGmfyPcaIP+gbgXT2vcDOPGUkjTVkaiD7s6dKFErUBp/a2iugIEBo7Q
         Vn2NEY26FVaqs01HeiqukgbjRKMFT6P+d8P0DYQ0=
Message-ID: <1581980625.24289.30.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     =?ISO-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
Cc:     linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 17 Feb 2020 15:03:45 -0800
In-Reply-To: <CA+enf=vwd-dxzve87t7Mw1Z35RZqdLzVaKq=fZ4EGOpnES0f5w@mail.gmail.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
         <1581973919.24289.12.camel@HansenPartnership.com>
         <CA+enf=vwd-dxzve87t7Mw1Z35RZqdLzVaKq=fZ4EGOpnES0f5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-17 at 16:57 -0500, Stéphane Graber wrote:
> On Mon, Feb 17, 2020 at 4:12 PM James Bottomley <
> James.Bottomley@hansenpartnership.com> wrote:
> 
> > On Fri, 2020-02-14 at 19:35 +0100, Christian Brauner wrote:
> > [...]
> > > With this patch series we simply introduce the ability to create
> > > fsid mappings that are different from the id mappings of a user
> > > namespace. The whole feature set is placed under a config option
> > > that defaults to false.
> > > 
> > > In the usual case of running an unprivileged container we will
> > > have setup an id mapping, e.g. 0 100000 100000. The on-disk
> > > mapping will correspond to this id mapping, i.e. all files which
> > > we want to appear as 0:0 inside the user namespace will be
> > > chowned to 100000:100000 on the host. This works, because
> > > whenever the kernel needs to do a filesystem access it will
> > > lookup the corresponding uid and gid in the idmapping tables of
> > > the container.
> > > Now think about the case where we want to have an id mapping of 0
> > > 100000 100000 but an on-disk mapping of 0 300000 100000 which is
> > > needed to e.g. share a single on-disk mapping with multiple
> > > containers that all have different id mappings.
> > > This will be problematic. Whenever a filesystem access is
> > > requested, the kernel will now try to lookup a mapping for 300000
> > > in the id mapping tables of the user namespace but since there is
> > > none the files will appear to be owned by the overflow id, i.e.
> > > usually 65534:65534 or nobody:nogroup.
> > > 
> > > With fsid mappings we can solve this by writing an id mapping of
> > > 0 100000 100000 and an fsid mapping of 0 300000 100000. On
> > > filesystem access the kernel will now lookup the mapping for
> > > 300000 in the fsid mapping tables of the user namespace. And
> > > since such a mapping exists, the corresponding files will have
> > > correct ownership.
> > 
> > How do we parametrise this new fsid shift for the unprivileged use
> > case?  For newuidmap/newgidmap, it's easy because each user gets a
> > dedicated range and everything "just works (tm)".  However, for the
> > fsid mapping, assuming some newfsuid/newfsgid tool to help, that
> > tool has to know not only your allocated uid/gid chunk, but also
> > the offset map of the image.  The former is easy, but the latter is
> > going to vary by the actual image ... well unless we standardise
> > some accepted shift for images and it simply becomes a known static
> > offset.
> > 
> 
> For unprivileged runtimes, I would expect images to be unshifted and
> be unpacked from within a userns.

For images whose resting format is an archive like tar, I concur.

>  So your unprivileged user would be allowed a uid/gid range through
> /etc/subuid and /etc/subgid and allowed to use them through
> newuidmap/newgidmap.In that namespace, you can then pull
> and unpack any images/layers you may want and the resulting fs tree
> will look correct from within that namespace.
> 
> All that is possible today and is how for example unprivileged LXC
> works right now.

I do have a counter example, but it might be more esoteric: I do use
unprivileged architecture emulation containers to maintain actual
physical system boot environments.  These are stored as mountable disk
images, not as archives, so I do need a simple remapping ... however, I
think this use case is simple: it's a back shift along my owned uid/gid
range, so tools for allowing unprivileged use can easily cope with this
use case, so the use is either fsid identity or fsid back along
existing user_ns mapping.

> What this patchset then allows is for containers to have differing
> uid/gid maps while still being based off the same image or layers.
> In this scenario, you would carve a subset of your main uid/gid map
> for each container you run and run them in a child user namespace
> while setting up a fsuid/fsgid map such that their filesystem access
> do not follow their uid/gid map. This then results in proper
> isolation for processes, networks, ... as everything runs as
> different kuid/kgid but the VFS view will be the same in all
> containers.

Who owns the shifted range of the image ... all tenants or none?

> Shared storage between those otherwise isolated containers would also
> work just fine by simply bind-mounting the same path into two or more
> containers.
> 
> 
> Now one additional thing that would be safe for a setuid wrapper to
> allow would be for arbitrary mapping of any of the uid/gid that the
> user owns to be used within the fsuid/fsgid map. One potential use
> for this would be to create any number of user namespaces, each with
> their own mapping for uid 0 while still having all VFS access be
> mapped to the user that spawned them (say uid=1000, gid=1000).
> 
> 
> Note that in our case, the intended use for this is from a privileged
> runtime where our images would be unshifted as would be the container
> storage and any shared storage for containers. The security model
> effectively relying on properly configured filesystem permissions and
> mount namespaces such that the content of those paths can never be
> seen by anyone but root outside of those containers (and therefore
> avoids all the issues around setuid/setgid/fscaps).

Yes, I understand ... all orchestration systems are currently hugely
privileged.  However, there is interest in getting them down to only
"slightly privileged".

James


> We will then be able to allocate distinct, random, ranges of 65536
> uids/gids (or more) for each container without ever having to do any
> uid/gid shifting at the filesystem layer or run into issues when
> having to setup shared storage between containers or attaching
> external storage volumes to those containers.
