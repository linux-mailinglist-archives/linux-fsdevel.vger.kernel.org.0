Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F206D796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGSAHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 20:07:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54484 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:07:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoGQQ-0003bD-QA; Fri, 19 Jul 2019 00:07:02 +0000
Date:   Fri, 19 Jul 2019 01:07:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190719000702.GW17978@ZenIV.linux.org.uk>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org>
 <20190718231751.GV17978@ZenIV.linux.org.uk>
 <20190718234352.GN30636@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718234352.GN30636@minitux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 04:43:52PM -0700, Bjorn Andersson wrote:
> On Thu 18 Jul 16:17 PDT 2019, Al Viro wrote:
> 
> > On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> > > Implement a wrapper for aio_read()/write() to allow async IO on files
> > > not implementing the iter version of read/write, such as sysfs. This
> > > mimics how readv/writev uses non-iter ops in do_loop_readv_writev().
> > 
> > IDGI.  How would that IO manage to be async?  And what's the point
> > using aio in such situations in the first place?
> 
> The point is that an application using aio to submit io operations on a
> set of files,

... for no reason whatsoever, I take it?

> can use the same mechanism to read/write files that
> happens to be implemented by driver only implementing read/write (not
> read_iter/write_iter) in the registered file_operations struct, such as
> kernfs.

... except that it still has to support the kernels that don't have
your patch, so the fallback in userland is *not* going away.
