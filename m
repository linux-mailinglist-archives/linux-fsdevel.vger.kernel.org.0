Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3792A093A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgJ3PH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:07:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44515 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgJ3PH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:07:56 -0400
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kYW0P-0001sb-IC
        for linux-fsdevel@vger.kernel.org; Fri, 30 Oct 2020 15:07:53 +0000
Received: by mail-yb1-f197.google.com with SMTP id w4so6312161ybq.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 08:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xa7Ya7WFCD66IO3n4EspVdAVBWL69bn4xyiCQC0MCNc=;
        b=fOpAW8XukPLXchhCQusKGsVuuIBAet8SexABfA9q+IZPHF0MYkK+4V3M+7Aoi1bf6q
         zDXIWIc4a4giBeKUPCgXE19mhnn3IcWKZXxiMFiPdbGV9FDySg3iO73MroGHvWSQ21ZS
         Z6UyOTs/kmoflmJ4IiSrjI3oz4U4A/BaGwLYUK9W//lZWQNHadCbk4EMH0XyElKOeKVy
         kc0PFbfOtpTdPFciXlRutKitxqQjPojZjMLbFj3OOAuswmhPnGQlV+ii3BHXrgVJnVm6
         xFrGSF0oQZ+X04DoTKpG4Ul9L1ozp11Rdu3333GHsDNdkSR0g7Ai/NrWlqtzc4MZICgC
         lmqA==
X-Gm-Message-State: AOAM533uQ+MY65Pk2fg1X0cDpNAYg5acZS7LzJG12E/f8tqj03Cot0Vm
        3bXJ02fCDO9Yj4H57gfyOzEIo0Tspt1jy5bsAdX/0sVnEtoEorVdjG4k8iwM7SlPJClH4eLjJ68
        J8jgIHG765RQvEdtECgY4pf2pCt/L3Kf3OGTVE1GpzgI=
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr2120430otp.231.1604070472476;
        Fri, 30 Oct 2020 08:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrwanxbYDDJUUK4/p/rI4RmYyrOvYEAiYYd5ZsrwMuhegPWsvTXQZPd/YkhjdWXy2r86N00Q==
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr2120406otp.231.1604070472204;
        Fri, 30 Oct 2020 08:07:52 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:f03a:863:709:f18c])
        by smtp.gmail.com with ESMTPSA id d22sm1412368oij.53.2020.10.30.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:07:49 -0700 (PDT)
Date:   Fri, 30 Oct 2020 10:07:48 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201030150748.GA176340@ubuntu-x1>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
 <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
 <87361xdm4c.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87361xdm4c.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:37:23AM -0500, Eric W. Biederman wrote:
> First and foremost: A uid shift on write to a filesystem is a security
> bug waiting to happen.  This is especially in the context of facilities
> like iouring, that play very agressive games with how process context
> makes it to  system calls.
> 
> The only reason containers were not immediately exploitable when iouring
> was introduced is because the mechanisms are built so that even if
> something escapes containment the security properties still apply.
> Changes to the uid when writing to the filesystem does not have that
> property.  The tiniest slip in containment will be a security issue.
> 
> This is not even the least bit theoretical.  I have seem reports of how
> shitfs+overlayfs created a situation where anyone could read
> /etc/shadow.

This bug was the result of a complex interaction with several
contributing factors. It's fair to say that one component was overlayfs
writing through an id-shifted mount, but the primary cause was related
to how copy-up was done coupled with allowing unprivileged overlayfs
mounts in a user ns. Checks that the mounter had access to the lower fs
file were not done before copying data up, and so the file was copied up
temporarily to the id shifted upperdir. Even though it was immediately
removed, other factors made it possible for the user to get the file
contents from the upperdir.

Regardless, I do think you raise a good point. We need to be wary of any
place the kernel could open files through a shifted mount, especially
when the open could be influenced by userspace.

Perhaps kernel file opens through shifted mounts should to be opt-in.
I.e. unless a flag is passed, or a different open interface used, the
open will fail if the dentry being opened is subject to id shifting.
This way any kernel writes which would be subject to id shifting will
only happen through code which as been written to take it into account.

Seth
