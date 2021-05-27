Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9823938B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhE0Wcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 18:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233203AbhE0Wca (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 18:32:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84445613BF;
        Thu, 27 May 2021 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622154655;
        bh=WJmieutuwb6wkOGdzy8Hj2ZjOYjV2ibJ9Y9kPqy6aw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tVGGg5rxq0/R2ltpNyFklO7UPieKW96IS8mI2FQx8Gx2qy0lRrWpGIOE6DQRfZrcW
         Hi7LdCSO+n8i4Qc9c5HcqQXsprAuabloQ0N7uVsqO/kJcQv99d3S2r/c3CyqXNSwmg
         fwUvxE8zqXG+/anrty4+uT9S+kfuilI+ybP9Nkro=
Date:   Thu, 27 May 2021 15:30:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhoufeng <zhoufeng.zf@bytedance.com>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [External] Re: [PATCH] fs/proc/kcore.c: add mmap interface
Message-Id: <20210527153055.aefeee8d8385da8152bdbacc@linux-foundation.org>
In-Reply-To: <d71a4ffa-f21e-62f5-7fa6-83ca14b3f05b@bytedance.com>
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
        <20210526173953.49fb3dc48c0f2a8b3c31fe2b@linux-foundation.org>
        <d71a4ffa-f21e-62f5-7fa6-83ca14b3f05b@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 May 2021 14:13:09 +0800 zhoufeng <zhoufeng.zf@bytedance.com> wrote:

> > I'm surprised that it makes this much difference.  Has DRGN been fully
> > optimised to minimise the amount of pread()ing which it does?  Why does
> > it do so much reading?
> DRGN is a tool similar to Crash, but much lighter. It allows users to 
> obtain kernel data structures from Python scripts. Based on this, we 
> intend to use DRGN for kernel monitoring. So we used some pressure test 
> scripts to test the loss of monitoring.
> Monitoring is all about getting current real-time data, so every time 
> DRGN tries to get kernel data, it needs to read /proc/kcore. In my 
> script, I tried to loop 1000 times to obtain the information of all the 
> processes in the machine, in order to construct a scene where kernel 
> data is frequently read. So, the frequency in the default version of 
> kcore, pread is very high. In view of this situation, our optimization 
> idea is to reduce the number of context switches as much as possible 
> under the scenario of frequent kernel data acquisition, to reduce the 
> performance loss to a minimum, and then move the monitoring system to 
> the production environment.

Why would a pread() cause a context switch?

> After running for a long time in a 
> production environment, the number of kernel data reads was added as 
> time went on, and the pread number also increased. If users use mmap, 
> it's once for all.
