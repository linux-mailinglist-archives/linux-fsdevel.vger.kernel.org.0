Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0632438AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMKg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 06:36:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726249AbgHMKg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597315015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHTuFVTalfQfPA2SgrXd36xvN0GI3IA7pVeXYZFZfuE=;
        b=YjVN439ywW+xeseIOdy7uo7XDhoznvbxmO6YF9QAe+czVHGS2K/iMP7E0lb8uOqGyRFDiE
        589VYv5VonE03yhr2yPN2syUbqGzAPoqu8G3kxlutbzQqs+AOdH/4TfiGuBBYK4+56DiuA
        1t+zWLZH/pvPSaOBM5zi2MR29w0he3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-BabCGu27OAmcOQkv6mZDEg-1; Thu, 13 Aug 2020 06:36:52 -0400
X-MC-Unique: BabCGu27OAmcOQkv6mZDEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E848BF8A4;
        Thu, 13 Aug 2020 10:36:41 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4CF6760B;
        Thu, 13 Aug 2020 10:36:37 +0000 (UTC)
Date:   Thu, 13 Aug 2020 12:36:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API
Message-ID: <20200813103634.ey2xxwgbn3e4lhdr@ws.net.home>
References: <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
 <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:50:28PM -0700, Linus Torvalds wrote:
> Convince me otherwise. AGAIN. This is the exact same issue I had with
> the notification queues that I really wanted actual use-cases for, and
> feedback from actual outside users.

I thought (in last 10 years) we all agree that /proc/self/mountinfo is
the expensive, ineffective and fragile way how to deliver information to
userspace.

We have systems with thousands of mountpoints and compose mountinfo in
kernel and again parse it in userspace takes time and it's strange if
you need info about just one mountpoint. 

Unfortunately, the same systems modify the huge mount table extremely
often, because it starts/stops large number of containers and every 
container means a mount operation(s).

In this crazy environment, we have userspace tools like systemd or udisk 
which react to VFS changes and there is no elegant way how to get
details about a modified mount node from kernel.

And of course we already have negative feedback from users who
maintain large systems -- mountinfo returns inconsistent data if you
read it by more read() calls (hopefully fixed by recent Miklos'
mountinfo cursors); system is pretty busy to compose+parse mountinfo,
etc.

> I really think this is engineering for its own sake, rather than
> responding to actual user concerns.

We're too old and too lazy for "engineering for its own sake" :-)
there is pressure from users ...

Maybe David's fsinfo() sucks, but it does not mean that
/proc/self/mountinfo is something cool. Right?

We have to dig deep grave for /proc/self/mountinfo ...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

