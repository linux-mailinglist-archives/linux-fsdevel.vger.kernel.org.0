Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95021161D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 23:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgBQWfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 17:35:41 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39500 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgBQWfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:35:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2FCB98EE218;
        Mon, 17 Feb 2020 14:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581978940;
        bh=kGqNQ/LKDec1th/13RGNLf+24LtFPEsPCjEL8hK6Zbs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DXewcExyZkcYnVoT0ZlEZ+F/Xe2t82jrdbs4fH7V3GEeuQOV1b254dwImz26RcCou
         5WvStYzvMmz+awUORnUJS2OWnsVIHfYE1/zoGTe9vafwynWYJwf2PoJJDotjV8qcH5
         lFwR3XUqYBemIvEuorMZ7vXNaW+IAKRvecjFqi6M=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HLoCSdDGbND4; Mon, 17 Feb 2020 14:35:40 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4ED3D8EE0F5;
        Mon, 17 Feb 2020 14:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581978939;
        bh=kGqNQ/LKDec1th/13RGNLf+24LtFPEsPCjEL8hK6Zbs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HSt7T32/extC6bQnxlu4qis+fZzEyxV+jShQLDnasUEpmLEQkKlB7BgJPHhiFnbh/
         LMrE1PBQz0ckwqT10y+tJYFnwWfrGGxiVwLch5l3pfgRAIchM9b6QH08UjxDEi0Qqc
         ygH0zaozLQi1ajwR6Arqx1Kagrp3pIgrfY/ZFFIU=
Message-ID: <1581978938.24289.18.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Date:   Mon, 17 Feb 2020 14:35:38 -0800
In-Reply-To: <20200217212022.2rfex3qsdjyyqrq7@wittgenstein>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
         <1581973568.24289.6.camel@HansenPartnership.com>
         <20200217212022.2rfex3qsdjyyqrq7@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-17 at 22:20 +0100, Christian Brauner wrote:
> On Mon, Feb 17, 2020 at 01:06:08PM -0800, James Bottomley wrote:
> > On Fri, 2020-02-14 at 19:35 +0100, Christian Brauner wrote:
> > [...]
> > > People not as familiar with user namespaces might not be aware
> > > that fsid mappings already exist. Right now, fsid mappings are
> > > always identical to id mappings. Specifically, the kernel will
> > > lookup fsuids in the uid mappings and fsgids in the gid mappings
> > > of the relevant user namespace.
> > 
> > This isn't actually entirely true: today we have the superblock
> > user namespace, which can be used for fsid remapping on filesystems
> > that support it (currently f2fs and fuse).  Since this is a single
> > shift,
> 
> Note that this states "the relevant" user namespace not the caller's
> user namespace. And the point is true even for such filesystems. fuse
> does call make_kuid(fc->user_ns, attr->uid) and hence looks up the
> mapping in the id mappings.. This would be replaced by make_kfsuid().
> 
> > how is it going to play with s_user_ns?  Do you have to understand
> > the superblock mapping to use this shift, or are we simply using
> > this to replace s_user_ns?
> 
> I'm not sure what you mean by understand the superblock mapping. The
> case is not different from the devpts patch in this series.

So since devpts wasn't originally a s_user_ns consumer, I assume you're
thinking that this patch series just replaces the whole of s_user_ns
for fuse and f2fs and we can remove it?

> Fuse needs to be changed to call make_kfsuid() since it is mountable
> inside user namespaces at which point everthing just works.

The fuse case is slightly more complicated because there are sound
reasons to run the daemon in a separate user namespace regardless of
where the end fuse mount is.

James

