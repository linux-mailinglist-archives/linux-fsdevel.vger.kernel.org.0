Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE843DEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfFMPpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbfFMJno (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4F32C04AC69;
        Thu, 13 Jun 2019 09:43:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B8F35F9B0;
        Thu, 13 Jun 2019 09:43:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 13 Jun 2019 11:43:36 +0200 (CEST)
Date:   Thu, 13 Jun 2019 11:43:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Deepa Dinamani' <deepa.kernel@gmail.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'arnd@arndb.de'" <arnd@arndb.de>,
        "'dbueso@suse.de'" <dbueso@suse.de>,
        "'axboe@kernel.dk'" <axboe@kernel.dk>,
        "'dave@stgolabs.net'" <dave@stgolabs.net>,
        "'e@80x24.org'" <e@80x24.org>,
        "'jbaron@akamai.com'" <jbaron@akamai.com>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-aio@kvack.org'" <linux-aio@kvack.org>,
        "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        'Al Viro' <viro@ZenIV.linux.org.uk>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190613094324.GA12506@redhat.com>
References: <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
 <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
 <6e9b964b08d84c99980b1707e5fe3d1d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9b964b08d84c99980b1707e5fe3d1d@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 09:43:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/13, David Laight wrote:
>
> I tested NetBSD last night.
> pselect() always calls the signal handlers even when an fd is ready.
> I'm beginning to suspect that this is the 'standards conforming' behaviour.

May be. May be not. I have no idea.

> > The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/9699919799/functions/pselect.html
> > says:
> >     "If sigmask is not a null pointer, then the pselect() function shall replace
> >     the signal mask of the caller by the set of signals pointed to by sigmask
> >     before examining the descriptors, and shall restore the signal mask of the
> >     calling thread before returning."

> > Note that it says 'before examining the descriptors' not 'before blocking'.

And you interpret this as if a pending signal should be delivered in any case,
even if pselect succeeds. Again, perhaps you are right, but to me this is simply
undocumented.

However, linux never did this. Until the commit 854a6ed56839 ("signal: Add
restore_user_sigmask()"). This commit caused regression. We had to revert it.

> > If nothing else the man pages need a note about the standards and portability.

Agreed.

Oleg.

