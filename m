Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5D15099B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBCPQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 10:16:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51309 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBCPQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:16:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so16369726wmi.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 07:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arangodb.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oDRH5we1LRYr69H/g74BFyb9GhUUuAeUSoG8mXyHu3Y=;
        b=fl1ZYh0CUf3sMGtHtJIdJafqlYKLZsSI1uu6QurSiwRuCTiVJqh9V0cgqfAZkuYn2S
         fXV9TTePcAwikD+BC5HR6ZHhzT00wtG+qlrpBQ2Wdn5vUqVy6Bx+g7R5fa+HziqZ6Odm
         llpf1Jt1DT8yD9+pX8BwrZtNhPoh7hpgfOtBrMgiKpA8nf5H9XBIXmfw1qg0KprYgfSw
         IBVnql47upOCp2D8yO/F4lG3svM0wg5RwmuIrl8ppeivODqmrlpuUvzvK5KqqjYbd3kW
         26nq1Ky+W7oW6Mw2INas3fWVOddwxEeg3PyU7BuMHtzNm7TMmEejgAjkYnbaKw7H/oFC
         q8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oDRH5we1LRYr69H/g74BFyb9GhUUuAeUSoG8mXyHu3Y=;
        b=T8OPXme3M4xanxxiNlkQ0NlViilKBWhqONphqY7PPULiBe0SbAFiKVxu2YdPiBIDgQ
         lkXCyLBOinRCHKIrlH7ETRJ5821cZGzPrDU4kXeaQJ4k7YlbM9zU1Cad/alm8P6/xHcN
         EuZ13fco3v0HICrgqODa7x2gimpHe3jGVA8x6hepb9LTe0SF84hb+HVePEfeizLD2BRn
         F6pJx7CRnaXXcQgPePQDOFY6zIN+CMD7HlbY2zZY2JHLKFiYNly1t+PAYfpHARb6Q8j6
         aOE06Yh7MJ+wz5TyfVxfaKRZiYUJwEqYjq7YlTMXa8KgaPWkMT37TPnnhmck35JXsjF9
         8BHA==
X-Gm-Message-State: APjAAAWfkeF8SePSRllrhrGI8bc9rFM2eWQsrdnyNZP6QFwqS8CqdZGq
        4uZWWOztGxh7OQsXCTflp+SH
X-Google-Smtp-Source: APXvYqy9zJqEX1AE9F9FSyxmUYx5bGNX2475G5HyDwL44k6DUQVwT9KWcQDJJvYA7H0B4qM5xdkivw==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr31280131wmk.5.1580743013835;
        Mon, 03 Feb 2020 07:16:53 -0800 (PST)
Received: from localhost (static-85-197-33-87.netcologne.de. [85.197.33.87])
        by smtp.gmail.com with ESMTPSA id z19sm22877844wmi.43.2020.02.03.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:16:53 -0800 (PST)
Date:   Mon, 3 Feb 2020 16:15:36 +0100
From:   Max Neunhoeffer <max@arangodb.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
Subject: Re: epoll_wait misses edge-triggered eventfd events: bug in Linux
 5.3 and 5.4
Message-ID: <20200203151536.caf6n4b2ymvtssmh@tux>
References: <20200131135730.ezwtgxddjpuczpwy@tux>
 <20200201121647.62914697@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201121647.62914697@cakuba.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Jakub and all,

I have done a git bisect and found that this commit introduced the epoll
bug:

https://github.com/torvalds/linux/commit/a218cc4914209ac14476cb32769b31a556355b22

I Cc the author of the commit.

This makes sense, since the commit introduces a new rwlock to reduce
contention in ep_poll_callback. I do not fully understand the details
but this sounds all very close to this bug.

I have also verified that the bug is still present in the latest master
branch in Linus' repository.

Furthermore, Chris Kohlhoff has provided yet another reproducing program
which is no longer using edge-triggered but standard level-triggered
events and epoll_wait. This makes the bug all the more urgent, since
potentially more programs could run into this problem and could end up
with sleeping barbers.

I have added all the details to the bugzilla bugreport:

  https://bugzilla.kernel.org/show_bug.cgi?id=205933

Hopefully, we can resolve this now equipped with this amount of information.

Best regards,
  Max.

On 20/02/01 12:16, Jakub Kicinski wrote:
> On Fri, 31 Jan 2020 14:57:30 +0100, Max Neunhoeffer wrote:
> > Dear All,
> > 
> > I believe I have found a bug in Linux 5.3 and 5.4 in epoll_wait/epoll_ctl
> > when an eventfd together with edge-triggered or the EPOLLONESHOT policy
> > is used. If an epoll_ctl call to rearm the eventfd happens approximately
> > at the same time as the epoll_wait goes to sleep, the event can be lost, 
> > even though proper protection through a mutex is employed.
> > 
> > The details together with two programs showing the problem can be found
> > here:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=205933
> > 
> > Older kernels seem not to have this problem, although I did not test all
> > versions. I know that 4.15 and 5.0 do not show the problem.
> > 
> > Note that this method of using epoll_wait/eventfd is used by
> > boost::asio to wake up event loops in case a new completion handler
> > is posted to an io_service, so this is probably relevant for many
> > applications.
> > 
> > Any help with this would be appreciated.
> 
> Could be networking related but let's CC FS folks just in case.
> 
> Would you be able to perform bisection to narrow down the search 
> for a buggy change?
