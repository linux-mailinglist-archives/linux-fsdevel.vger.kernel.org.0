Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DD73B94F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391173AbfFJQXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 12:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389293AbfFJQXK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C117C31628ED;
        Mon, 10 Jun 2019 16:22:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 34B64600C7;
        Mon, 10 Jun 2019 16:22:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Jun 2019 18:22:52 +0200 (CEST)
Date:   Mon, 10 Jun 2019 18:22:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190610162244.GB8127@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Jun 2019 16:23:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07, Eric W. Biederman wrote:
>
> +static int set_sigmask(sigset_t *kmask)
> +{
> +	set_restore_sigmask();
> +	current->saved_sigmask = current->blocked;
> +	set_current_blocked(kmask);
> +
> +	return 0;
> +}

I was going to do the same change except my version returns void ;)

So ACK.


As for 2-5, sorry I can't read them today, will do tomorrow.

But at first glance... yes, we can remove TIF_RESTORE_SIGMASK.

As for "remove saved_sigmask" I have some concerns... At least this
means a user-visible change iiuc. Say, pselect unblocks a fatal signal.
Say, SIGINT without a handler. Suppose SIGINT comes after set_sigmask().

Before this change the process will be killed.

After this change it will be killed or not. It won't be killed if
do_select() finds an already ready fd without blocking, or it finds a
ready fd right after SIGINT interrupts poll_schedule_timeout().

And _to me_ the new behaviour makes more sense. But when it comes to
user-visible changes you can never know if it breaks something or not.

Oleg.

