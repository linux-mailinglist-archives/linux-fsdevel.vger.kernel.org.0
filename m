Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976613BECCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhGGRIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 13:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGGRIt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:08:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A06A61C7F;
        Wed,  7 Jul 2021 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625677569;
        bh=Q3PwKU2MWriiez/7uEGY76FwByXF51elK2MPyqH+BDw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aJxD8e5bZAU/ArkUH8mQlC6pi/cl6Ipfk4qd3l960Fvc9I+ZdcvoFvwuOCeyMZZO5
         0P2YAlLy5+acaD1nXZWuFQpZaBhWkISZq5DILzu3pClnr1OzG78QZxvARoWltS23A6
         PV5m/dgpvj5cndgNGYFPIJVcYgJjuvoKn2zj3m0wtVV+oxkxwCteNRDTOK6KH8GejO
         kgO/OweukSzwSFYYyA6AUrfR6Pub0zht27FcD5NVnxoUkUsXE/OS9zw5ne4eTAZBxm
         P7ZJOa6oz6WJHk4i63O+pM0jeQGz94g9CvbHUFpLqDcTENi6b1B/WnHMLSJ96r3KrV
         FvK5oT8v5eg2g==
Message-ID: <15fbc55a3b983c4962e9ad2d96eeebd77aad3be6.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] fcntl: fix potential deadlocks
From:   Jeff Layton <jlayton@kernel.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 07 Jul 2021 13:06:07 -0400
In-Reply-To: <20210707074401.447952-1-desmondcheongzx@gmail.com>
References: <20210707074401.447952-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 15:43 +0800, Desmond Cheong Zhi Xi wrote:
> Hi,
> 
> Sorry for the delay between v1 and v2, there was an unrelated issue with Syzbot testing.
> 
> Syzbot reports a possible irq lock inversion dependency:
> https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b
> 
> While investigating this error, I discovered that multiple similar lock inversion scenarios can occur. Hence, this series addresses potential deadlocks for two classes of locks, one in each patch:
> 
> 1. Fix potential deadlocks for &fown_struct.lock
> 
> 2. Fix potential deadlock for &fasync_struct.fa_lock
> 
> v2 -> v3:
> - Removed WARN_ON_ONCE, keeping elaboration for why read_lock_irq is safe to use in the commit message. As suggested by Greg KH.
> 
> v1 -> v2:
> - Added WARN_ON_ONCE(irqs_disabled()) before calls to read_lock_irq, and added elaboration in the commit message. As suggested by Jeff Layton.
> 
> Best wishes,
> Desmond
> 
> Desmond Cheong Zhi Xi (2):
>   fcntl: fix potential deadlocks for &fown_struct.lock
>   fcntl: fix potential deadlock for &fasync_struct.fa_lock
> 
>  fs/fcntl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 

Looks like these patches are identical to the v1 set, so I'm just going
to leave those in place since linux-next already has them. Let me know
if I've missed something though.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

