Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32010E272
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfLAQAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 11:00:08 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42932 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfLAQAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:00:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F32588EE133;
        Sun,  1 Dec 2019 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575216008;
        bh=SQMci2TwWaXQ6p1PA/tS0pw7vJqCK2dZbQoETPjE9Js=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uCu+VK7PwnTWwPvM+rXEFTjntuhj0goD/E3OQm4CTdvZghG7BEJ8+naiqhDUJprfW
         6giA+retO8LwUazxLYObHJhAx+AQWhl0TZ8Gk/L5jCtpzlG85T8Js3pQKt75vy6E2m
         abdJcQjwDotgi/bLeR23YtKdiBjZYbNK9gWZy70o=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DKuA77goXulG; Sun,  1 Dec 2019 08:00:07 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EA1058EE0DA;
        Sun,  1 Dec 2019 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575216007;
        bh=SQMci2TwWaXQ6p1PA/tS0pw7vJqCK2dZbQoETPjE9Js=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=chI4XJFpuaOc/zpI5mPXgD1LKltJiwU6iIG13z3HCBgG1eJMw4NBZwQz8OSbjjkw4
         GDB9HK7huOz02xKg19S72SEYGOMT5vW4MsFTCBJxWKMCqDUVfOHX2BTXTC+0DeQ5ZK
         kt4WMAE4kv5k8xakQ/M7kU/OyZEc9alk4dSHUXGo=
Message-ID: <1575216006.4080.3.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] fs: rethread notify_change to take a path instead
 of a dentry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Date:   Sun, 01 Dec 2019 08:00:06 -0800
In-Reply-To: <CAOQ4uxggMt77HHD4GOk4Rth8KAVz17f5CcZdgAfiMpTuQLz3PA@mail.gmail.com>
References: <1575148763.5563.28.camel@HansenPartnership.com>
         <1575148868.5563.30.camel@HansenPartnership.com>
         <CAOQ4uxggMt77HHD4GOk4Rth8KAVz17f5CcZdgAfiMpTuQLz3PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2019-12-01 at 09:04 +0200, Amir Goldstein wrote:
> Hi James!
> 
> On Sat, Nov 30, 2019 at 11:21 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > In order to prepare for implementing shiftfs as a property changing
> > bind mount, the path (which contains the vfsmount) must be threaded
> > through everywhere we are going to do either a permission check or
> > an
> 
> I am curious how bind/shift mount is expected to handle
> inode_permission().

I should be posting the initial patch soon, so you can see.  However
the principle is pretty simple: at the top of the API you have to
install a fsuid/fsgid shifted override credential if the vfsmount is
marked for shifting.  To make that determination you need the path at
all those points, hence this patch.  However, anywhere in the stack
after this, you can make the determination either by the vfsmount flag
or by recognizing the shifted credential.  The latter is how I do this
in inode_permission

> Otherwise, I am fine with the change, short of some style comments
> below...

OK, will fix for v2.

James

