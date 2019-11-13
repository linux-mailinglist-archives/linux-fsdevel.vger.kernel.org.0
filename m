Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C3FAFA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 12:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKML0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 06:26:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35660 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKML0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:26:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so1942259wrw.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTXRlZhRwusuOSk5qpblMfH+EvvvFoGPrh91430+T2U=;
        b=aGTueDxO+mXVLN37aOrEaaqOt8iqIvL/FDxjzKYcWilMMybJgd+PML9WsuAxHRDi9x
         90gS7o78/Ey7X2dc4jYiw2PyxwMKk4B8mAGvvEAFfcHM+CtkJz/rg+CZ6nStCzlrjJ7U
         AtmQP0tNk39XbfF09tgx51WMv8pYUP2LKS9SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTXRlZhRwusuOSk5qpblMfH+EvvvFoGPrh91430+T2U=;
        b=nb8gjdL0NDlkhJQXVeMRkfq8IKd7sIjN2DdSTTW1mMucnAEO74sRvlc943VmdW9xgi
         dPCdqEeSF1UV4QAOsq9iqAXAhtgEC3poin/B416/vsDKEFqkPnGV6o1p2OPdmzrBTMNI
         mIOGBFjE4ZsHXRPKFAgEXKXxcAw7dQbIb4PIe+vqJbA2gIhID3k9ebDGpv0z/wc3wLgw
         w5QNsD1N89IPItbclF1Tjmt7Nzr1Uc4nlwGHQhoXTihqMkdiGehCNxf1rSdF5CPGWWpD
         AwKqahYsRiFCbspEz+wqSHTW6kgG5/7mxW0HPCHbKDWNq3n8nWkT6oIQYZkGZjg1g8rG
         ei/g==
X-Gm-Message-State: APjAAAUGyEU/Q5L2RS/wkpl566G1e0Rjl9AGdAbSioeLFPpB2ID+Bj6j
        ynJY4U8rHwKNMbyH7HQG0IEL+g==
X-Google-Smtp-Source: APXvYqzUBait63OW0AhXaaPpAWLX1TIz8EDCPO6Z+huQvod4nZOOQ8LdxkIXpDuLyjOP3m45KIvhrg==
X-Received: by 2002:adf:f088:: with SMTP id n8mr2387085wro.115.1573644375190;
        Wed, 13 Nov 2019 03:26:15 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s9sm1884689wmj.22.2019.11.13.03.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 03:26:14 -0800 (PST)
Date:   Wed, 13 Nov 2019 12:26:08 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: fix timestamp limits
Message-ID: <20191113112608.GA5569@miu.piliscsaba.redhat.com>
References: <20191111073000.2957-1-amir73il@gmail.com>
 <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
 <CAJfpeguvm=1Dw7V4XTr4gyo3uK+-EFNYKeDCFvUmuMPJxA=TcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguvm=1Dw7V4XTr4gyo3uK+-EFNYKeDCFvUmuMPJxA=TcA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:26:13AM +0100, Miklos Szeredi wrote:
> On Tue, Nov 12, 2019 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > > filesystem.
> > > >
> > > > The current behavior, when overlayfs is over an underlying filesystem
> > > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > > overflows post 2038 timestamps instead of clamping them.
> > >
> > > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> > >
> >
> > Not sure if it is supposed to be it doesn't.
> > It happens in do_utimes() -> utimes_common()
> 
> Ah.   How about moving the timestamp_truncate() inside notify_change()?

Untested patch below.

BTW overlayfs isn't the only one calling notify_change().  There's knfsd and
ecryptfs, neither of which seems to clamp timestamps according on the underlying
filesystem.

Thanks,
Miklos

diff --git a/fs/attr.c b/fs/attr.c
index df28035aa23e..e8de5e636e66 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -268,8 +268,13 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;
+	else
+		attr->ia_atime = timestamp_truncate(attr->ia_atime, inode);
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
+	else
+		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
+
 	if (ia_valid & ATTR_KILL_PRIV) {
 		error = security_inode_need_killpriv(dentry);
 		if (error < 0)
diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..df483207da4e 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -35,17 +35,13 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 	if (times) {
 		if (times[0].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_ATIME;
-		else if (times[0].tv_nsec != UTIME_NOW) {
-			newattrs.ia_atime = timestamp_truncate(times[0], inode);
+		else if (times[0].tv_nsec != UTIME_NOW)
 			newattrs.ia_valid |= ATTR_ATIME_SET;
-		}
 
 		if (times[1].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_MTIME;
-		else if (times[1].tv_nsec != UTIME_NOW) {
-			newattrs.ia_mtime = timestamp_truncate(times[1], inode);
+		else if (times[1].tv_nsec != UTIME_NOW)
 			newattrs.ia_valid |= ATTR_MTIME_SET;
-		}
 		/*
 		 * Tell setattr_prepare(), that this is an explicit time
 		 * update, even if neither ATTR_ATIME_SET nor ATTR_MTIME_SET
