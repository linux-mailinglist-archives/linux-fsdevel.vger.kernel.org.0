Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6CCA2E61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 06:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfH3EaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 00:30:03 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34419 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfH3EaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:30:03 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 95475360EAD;
        Fri, 30 Aug 2019 14:30:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i3YXu-0003RX-IX; Fri, 30 Aug 2019 14:29:58 +1000
Date:   Fri, 30 Aug 2019 14:29:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Yan <yanaijie@huawei.com>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org
Subject: Re: CONFIG_HARDENED_USERCOPY
Message-ID: <20190830042958.GC7777@dread.disaster.area>
References: <6e02a518-fea9-19fe-dca7-0323a576750d@huawei.com>
 <201908290914.F0F929EA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908290914.F0F929EA@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=hzK9nwXln0vweuEjbcYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:15:36AM -0700, Kees Cook wrote:
> On Thu, Aug 29, 2019 at 08:42:30PM +0800, Jason Yan wrote:
> > We found an issue of kernel bug related to HARDENED_USERCOPY.
> > When copying an IO buffer to userspace, HARDENED_USERCOPY thought it is
> > illegal to copy this buffer. Actually this is because this IO buffer was
> > merged from two bio vectors, and the two bio vectors buffer was allocated
> > with kmalloc() in the filesystem layer.
> 
> Ew. I thought the FS layer was always using page_alloc?

No, they don't. It's perfectly legal to use heap memory for bio
buffers - we've been doing it since, at least, XFS got merged all
those years ago.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
