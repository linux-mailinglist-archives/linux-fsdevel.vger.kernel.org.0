Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD6B1FEE76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgFRJTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 05:19:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgFRJTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:19:06 -0400
Received: from ip-109-41-0-102.web.vodafone.de ([109.41.0.102] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jlqhL-00060Q-8F; Thu, 18 Jun 2020 09:19:04 +0000
Date:   Thu, 18 Jun 2020 11:18:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Serge Hallyn <serge@hallyn.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nsfs: add NS_GET_INIT_PID ioctl
Message-ID: <20200618091857.atycw6ioaiuhddmj@wittgenstein>
References: <20200618084543.326605-1-christian.brauner@ubuntu.com>
 <CAKgNAkjMmLmZPk08tK=mBjTqPF7X771Of79WD-YYXhN9cB2ULw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkjMmLmZPk08tK=mBjTqPF7X771Of79WD-YYXhN9cB2ULw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:03:25AM +0200, Michael Kerrisk (man-pages) wrote:
> On Thu, 18 Jun 2020 at 10:45, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > Add an ioctl() to return the PID of the init process/child reaper of a pid
> > namespace as seen in the caller's pid namespace.
> 
> What are the pros and cons of returning a PID FD instead of a PID?

A pidfd doesn't buy you much here since you can race-free turn the PID
into a pidfd via pidfd_open() right after.
But mostly, I don't want to introduce the pattern of returning pidfds
from all corners of the kernel especially when it's not strictly
required. The central entrypoints should remain clone{3}() and
pidfd_open() for now. I want to remain conservative with this until we
have had more of userspace rely on them for a while and the bugs and
features requests come trickling in. We've seen a good portion of that
but we'll likely see more. If we need to do global changes (e.g. sending
signals outside of your own pid namespace hierarchy or attaching
capabilities to them) we will be in better shape if we don't return them
from everywhere just yet.

Christian
