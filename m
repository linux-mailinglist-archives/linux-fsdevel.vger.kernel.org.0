Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B5350CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhDAC3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 22:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhDAC3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:29:06 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A213C0613E3;
        Wed, 31 Mar 2021 19:29:06 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRn4p-001XBm-FC; Thu, 01 Apr 2021 02:28:55 +0000
Date:   Thu, 1 Apr 2021 02:28:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Manish Varma <varmam@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Kelly Rossmoyer <krossmo@google.com>
Subject: Re: [PATCH v2] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <YGUv5yIBTFbwuTxB@zeniv-ca.linux.org.uk>
References: <20210401021645.2609047-1-varmam@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021645.2609047-1-varmam@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:16:45PM -0700, Manish Varma wrote:
> timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> it names them after the underlying file descriptor, and since all
> timerfd file descriptors are named "[timerfd]" (which saves memory on
> systems like desktops with potentially many timerfd instances), all
> wakesources created as a result of using the eventpoll-on-timerfd idiom
> are called... "[timerfd]".
> 
> However, it becomes impossible to tell which "[timerfd]" wakesource is
> affliated with which process and hence troubleshooting is difficult.
> 
> This change addresses this problem by changing the way eventpoll
> wakesources are named:
> 
> 1) the top-level per-process eventpoll wakesource is now named "epoll:P"
> (instead of just "eventpoll"), where P, is the PID of the creating
> process.
> 2) individual per-underlying-filedescriptor eventpoll wakesources are
> now named "epollitemN:P.F", where N is a unique ID token and P is PID
> of the creating process and F is the name of the underlying file
> descriptor.
> 
> All together that should be splitted up into a change to eventpoll and
> timerfd (or other file descriptors).

FWIW, it smells like a variant of wakeup_source_register() that would
take printf format + arguments would be a good idea.  I.e. something
like

> +		snprintf(buf, sizeof(buf), "epoll:%d", task_pid);
> +		epi->ep->ws = wakeup_source_register(NULL, buf);

		... = wakeup_source_register(NULL, "epoll:%d", task_pid);

etc.
