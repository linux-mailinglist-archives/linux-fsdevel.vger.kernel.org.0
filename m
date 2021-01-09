Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193492EFCE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 02:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAIBuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 20:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbhAIBuu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:50:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 282C52399C;
        Sat,  9 Jan 2021 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610157009;
        bh=z7UqMVFYSJxdzVLfXg8lbRyvre2vUdZj4dWLmneULJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwP6pSnTvoUY/yBfJMkk4z9bp7cALDgm/YU+jIg/Eon/3Xka/h3LqLuWTZxiODkDo
         MFnFkoFBKFNtrr+0i3ng7g6gtVRfTrbDniojusqOiVAUSuoY/+5WVlIgzh7nwy3l8Q
         UwWQEjXrEJW2LEXeUD1nYsUEmDolAmkofFE6WDZ0=
Date:   Fri, 8 Jan 2021 17:50:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz, wangle6@huawei.com
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-Id: <20210108175008.da3c60a6e402f5f1ddab2a65@linux-foundation.org>
In-Reply-To: <20210108201025.GA17019@dhcp22.suse.cz>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
        <20210108092145.GX13207@dhcp22.suse.cz>
        <829bbba0-d3bb-a114-af81-df7390082958@huawei.com>
        <20210108114718.GA13207@dhcp22.suse.cz>
        <202101081152.0CB22390@keescook>
        <20210108201025.GA17019@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 8 Jan 2021 21:10:25 +0100 Michal Hocko <mhocko@suse.com> wrote:

> > > Why would that matter? A missing value is clearly a error path and it
> > > should be reported.
> > 
> > This test is in the correct place. I think it's just a question of the
> > return values.
> 
> I was probably not clear. The test for val is at the right place. I
> would just expect -EINVAL and have the generic code to report.

It does seem a bit screwy that process_sysctl_arg() returns zero in all
situations (parse_args() is set up to handle an error return from it). 
But this patch is consistent with all the other error handling in
process_sysctl_arg().
