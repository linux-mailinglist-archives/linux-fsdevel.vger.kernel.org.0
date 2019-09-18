Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D4B5FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfIRJHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 05:07:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50426 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfIRJHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:07:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so1644268wmg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6G/whdxwOVG2qxmcsy9XC+pDIIKNhBXnDvwIF4K/VBs=;
        b=kfWr8gWBYBcBGgcxeOud4gsGHHoCDZ+e2gVUoUqlrkYqpWgQKaJ78hHgXC3ilzVr0O
         +8pkEG8kqn4PpvoHDlJhIdgZOtD96xrMJPf5rxoAvthocW4621d3D9Qh5trYnLS5SZ1C
         BN08nY19kls8ugqtZhrEwO8LpHQ8mUyG2tZWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6G/whdxwOVG2qxmcsy9XC+pDIIKNhBXnDvwIF4K/VBs=;
        b=EEUTxcA4UhJA00OuZqyw25dnxySq2E3QTyXE8JG2q02ZLpUmtzRrEfxzXTMPi0dzBW
         rpLmM2D232wxY/aDBgtRCM7bormjpatubxQti1y104MNnzNB0+3FErw9E7ib2hxJT8IT
         2SPlMs/4wiKl7kJU7qZjksKDGtScLZUPQeGoSVovgJ/ubstKJbX17pS4xkUMiNlgpasj
         EwkFLRBB1zKs9UkyYrGrrJfNCKuxbvyQ/VDDQBdZLTDbyeFbuBvJOWTqIUQy0Ur/gS0O
         xEaWpizJvr2BQrEJyzBMr9W5LFXKh3f4aJ6/JWRqs3MZCrqU5m707nHknhUaxuqXJbc+
         dd9A==
X-Gm-Message-State: APjAAAVlvoigH7JadEBxiTPku4SVRD4FVARHOkOajklqw47gejoxToSK
        sCgEwJ+9e+hqxW2LOUNRgfLVcQ==
X-Google-Smtp-Source: APXvYqxcHp0ur5Smn0yHXP17FwVKc+WjZmFyaf7NbEJ/4W74qLgNfNcp6RlqK0gpGfLkmsfzOB/N8g==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr1816647wmj.73.1568797655318;
        Wed, 18 Sep 2019 02:07:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id q124sm2478546wma.5.2019.09.18.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:07:34 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:07:31 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lange <lange@informatik.uni-koeln.de>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190918090731.GB19549@miu.piliscsaba.redhat.com>
References: <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de>
 <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
 <87woj3157p.fsf@notabene.neil.brown.name>
 <20190510200941.GB5349@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510200941.GB5349@fieldses.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 04:09:41PM -0400, J. Bruce Fields wrote:
> On Tue, May 07, 2019 at 10:24:58AM +1000, NeilBrown wrote:
> > Interesting perspective .... though doesn't NFSv4 explicitly allow
> > client-side ACL enforcement in the case of delegations?
> 
> Not really.  What you're probably thinking of is the single ACE that the
> server can return on granting a delegation, that tells the client it can
> skip the ACCESS check for users matching that ACE.  It's unclear how
> useful that is.  It's currently unused by the Linux client and server.
> 
> > Not sure how relevant that is....
> > 
> > It seems to me we have two options:
> >  1/ declare the NFSv4 doesn't work as a lower layer for overlayfs and
> >     recommend people use NFSv3, or
> >  2/ Modify overlayfs to work with NFSv4 by ignoring nfsv4 ACLs either
> >  2a/ always - and ignore all other acls and probably all system. xattrs,
> >  or
> >  2b/ based on a mount option that might be
> >       2bi/ general "noacl" or might be
> >       2bii/ explicit "noxattr=system.nfs4acl"
> >  
> > I think that continuing to discuss the miniature of the options isn't
> > going to help.  No solution is perfect - we just need to clearly
> > document the implications of whatever we come up with.
> > 
> > I lean towards 2a, but I be happy with with any '2' and '1' won't kill
> > me.
> 
> I guess I'd also lean towards 2a.
> 
> I don't think it applies to posix acls, as overlayfs is capable of
> copying those up and evaluating them on its own.

POSIX acls are evaluated and copied up.

I guess same goes for "security.*" attributes, that are evaluated on MAC checks.

I think it would be safe to ignore failure to copy up anything else.  That seems
a bit saner than just blacklisting nfs4_acl...

Something like the following untested patch.

Thanks,
Miklos

---
 fs/overlayfs/copy_up.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -36,6 +36,13 @@ static int ovl_ccup_get(char *buf, const
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
 MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
 
+static bool ovl_must_copy_xattr(const char *name)
+{
+	return !strcmp(name, XATTR_POSIX_ACL_ACCESS) ||
+	       !strcmp(name, XATTR_POSIX_ACL_DEFAULT) ||
+	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
+}
+
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 	ssize_t list_size, size, value_size = 0;
@@ -107,8 +114,13 @@ int ovl_copy_xattr(struct dentry *old, s
 			continue; /* Discard */
 		}
 		error = vfs_setxattr(new, name, value, size, 0);
-		if (error)
-			break;
+		if (error) {
+			if (ovl_must_copy_xattr(name))
+				break;
+
+			/* Ignore failure to copy unknown xattrs */
+			error = 0;
+		}
 	}
 	kfree(value);
 out:
