Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0C1FDA84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 02:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFRAnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 20:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFRAnv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:43:51 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B88521556;
        Thu, 18 Jun 2020 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592441031;
        bh=z8URL52jsUeVV4acHgb8mhAwfXotlh0gswF4QwIowhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lFr7x6WrpgmRN4lzyjuvDZG/zGaopYG62aB1wPAszZtJjQPV9FdWelscdkKZ1qRgQ
         AvtBQETgA+y3uFWv09ZMZ8o39Xuvl5i+wHRZRgNpcmzkR8W9OqNit+yo8ORkU4fGBb
         M3YbM5M6BVVRc9kul9eNloay4TPH74oCLloXGYj4=
Date:   Wed, 17 Jun 2020 17:43:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com, slyfox@gentoo.org,
        ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org,
        ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kmod/umh: a few fixes
Message-Id: <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> fixes, and one patch which modified kmod to return 254 when a module
> was not found. This opened up pandora's box about why that was being
> used for and low and behold its because when UMH_WAIT_PROC is used
> we call a kernel_wait4() call but have never unwrapped the error code.
> The commit log for that fix details the rationale for the approach
> taken. I'd appreciate some review on that, in particular nfs folks
> as it seems a case was never really hit before.
> 
> This goes boot tested, selftested with kmod, and 0-day gives its
> build blessings.

Any thoughts on which kernel version(s) need some/all of these fixes?

>  drivers/block/drbd/drbd_nl.c         | 20 +++++------
>  fs/nfsd/nfs4recover.c                |  2 +-
>  include/linux/sched/task.h           | 13 ++++++++
>  kernel/kmod.c                        |  5 ++-
>  kernel/umh.c                         |  4 +--
>  lib/test_kmod.c                      |  2 +-
>  net/bridge/br_stp_if.c               | 10 ++----
>  security/keys/request_key.c          |  2 +-
>  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----

I'm not really sure who takes kmod changes - I'll grab these unless
someone shouts at me.

