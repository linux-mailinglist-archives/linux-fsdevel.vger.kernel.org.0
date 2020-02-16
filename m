Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292BC160447
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgBPOMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 09:12:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPOMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 09:12:41 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j3Kf0-0000yC-JA; Sun, 16 Feb 2020 14:12:38 +0000
Date:   Sun, 16 Feb 2020 15:12:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 19/28] stat: handle fsid mappings
Message-ID: <20200216141237.nk7yh7hdwpo5nmfx@wittgenstein>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <20200214183554.1133805-20-christian.brauner@ubuntu.com>
 <20200214190314.GD22883@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214190314.GD22883@cisco>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:03:14PM -0700, Tycho Andersen wrote:
> On Fri, Feb 14, 2020 at 07:35:45PM +0100, Christian Brauner wrote:
> > @@ -471,8 +484,13 @@ static long cp_new_stat64(struct kstat *stat, struct stat64 __user *statbuf)
> >  #endif
> >  	tmp.st_mode = stat->mode;
> >  	tmp.st_nlink = stat->nlink;
> > -	tmp.st_uid = from_kuid_munged(current_user_ns(), stat->uid);
> > -	tmp.st_gid = from_kgid_munged(current_user_ns(), stat->gid);
> > +	if (stat->userns_visible) {
> > +		tmp.st_uid, from_kuid_munged(current_user_ns(), stat->uid);
> > +		tmp.st_gid, from_kgid_munged(current_user_ns(), stat->gid);
> > +	} else {
> > +		tmp.st_uid, from_kfsuid_munged(current_user_ns(), stat->uid);
> > +		tmp.st_gid, from_kfsgid_munged(current_user_ns(), stat->gid);
> > +	}
> 
> I suppose this should be = ?

Good catch. I thought I had eliminated all those by doing automated
conversion but apparently not. :)

Christian
