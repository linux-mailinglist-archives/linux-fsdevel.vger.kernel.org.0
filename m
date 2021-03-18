Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDF340D55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhCRSlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 14:41:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48022 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhCRSkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:40:46 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMxZb-0007PH-OZ; Thu, 18 Mar 2021 18:40:43 +0000
Date:   Thu, 18 Mar 2021 19:40:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210318184037.k7y3nrk3naktuwvl@wittgenstein>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz>
 <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:07:00PM +0200, Amir Goldstein wrote:
> > > That may change when systemd home dirs feature starts to use idmapped
> > > mounts. Being able to watch the user's entire home directory is a big
> > > win already.
> >
> > Do you mean that home directory would be an extra mount with userns in
> > which the user has CAP_SYS_ADMIN so he'd be able to watch subtrees on that
> > mount?
> >
> 
> That is what I meant.
> My understanding of the systemd-homed use case for idmapped mounts is
> that the user has CAP_SYS_ADMIN is the mapped userns, but I may be wrong.

systemd can simply create a new userns with the uid/gid of the target
user effectively delegating it (That's independent of actually writing a
uid gid mapping for the userns which will be done with privileges.) and
then attach it to that mount for the user.
Mine and Lennart's idea there so far has been that the creation would
likely be done by the user's session at login time

brauner     1346  0.0  0.0  20956  8512 ?        Ss   Mar03   0:03 /lib/systemd/systemd --user

and systemd as root would then take care of writing the mapping to the
userns and then attaching it to the mount. (I'll see Lennart in the next
few days and see what works best and once we're ready start a discussion
somwhere on a public list, I would suggest.)

(If systemd doesn't want a user to be able to monitor a mnt it can
simply create a userns with a different uid/gid but with the relevant
mapping. This was what my earlier point was about "blocking a user from
creating a subtree watch".)

Christian
