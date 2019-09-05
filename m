Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6AAACCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfIEUKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 16:10:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbfIEUKC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:10:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C742300BEAE;
        Thu,  5 Sep 2019 20:10:01 +0000 (UTC)
Received: from ovpn-124-235.rdu2.redhat.com (ovpn-124-235.rdu2.redhat.com [10.10.124.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26E605C1D4;
        Thu,  5 Sep 2019 20:09:59 +0000 (UTC)
Message-ID: <d19e8783e7fe47e51fbc12bf33c95fea16c93070.camel@redhat.com>
Subject: Re: Why add the general notification queue and its sources
From:   David Lehman <dlehman@redhat.com>
To:     Ray Strode <rstrode@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ian Kent <ikent@redhat.com>
Date:   Thu, 05 Sep 2019 16:09:58 -0400
In-Reply-To: <CAKCoTu7ms4ckwDA_-onuJg+famnMzGZE9gGUcqqMz0kCAAECRg@mail.gmail.com>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
         <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
         <17703.1567702907@warthog.procyon.org.uk>
         <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
         <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
         <CAKCoTu7ms4ckwDA_-onuJg+famnMzGZE9gGUcqqMz0kCAAECRg@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 20:10:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-09-05 at 14:51 -0400, Ray Strode wrote:
> Hi,
> 
> On Thu, Sep 5, 2019 at 2:37 PM Steven Whitehouse <swhiteho@redhat.com
> > wrote:
> > The original reason for the mount notification mechanism was so
> > that we
> > are able to provide information to GUIs and similar filesystem and
> > storage management tools, matching the state of the filesystem with
> > the
> > state of the underlying devices. This is part of a larger project
> > entitled "Project Springfield" to try and provide better management
> > tools for storage and filesystems. I've copied David Lehman in,
> > since he
> > can provide a wider view on this topic.
> So one problem that I've heard discussed before is what happens in a
> thinp
> setup when the disk space is overallocated and gets used up. IIRC,
> the
> volumes just sort of eat themselves?
> 
> Getting proper notification of looming catastrophic failure to the
> workstation user
> before it's too late would be useful, indeed.
> 
> I don't know if this new mechanism dhowells has development can help
> with that,

My understanding is that there is already a dm devent that gets sent
when the low water mark is crossed for a thin pool, but there is
nothing in userspace that knows how to effectively get the user's
attention at that time.

> and/or if solving that problem is part of the Project Springfield
> initiative or not. Do you
> know off hand?

We have been looking into building a userspace event notification
service (for storage, initially) to aggregate and add context to low-
level events such as these, providing a single source for all kinds of
storage events with an excellent signal:noise ratio. Thin pool
exhaustion is high on the list of problems we would want to address.


David

