Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27667470CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 22:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbhLJVnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 16:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbhLJVnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:43:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A9C061746;
        Fri, 10 Dec 2021 13:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IImUyHw0fYTRLw6PD6GbmYZPbFq6ycRb3COIrcJBmNM=; b=cshpw5exgnpCxe3IJDUVDMQl4O
        TuzN7v7xORQE5wFkhFbzXOc5tUECKd6uR8Mn/vONWx1Y/FhS+H8vjQD7tf8YeE67qc6WcuanrEVnt
        c+TcEHZiawu/bbhJ3LWJvDvNEGm3bt9Xg2q/kwmrBhNCQH/R9+ksN4Du0EoOXBMOjFMszV4LviCJz
        6G2zk0XM7xNkiV96DADT5SPlOvTBUWmdc3u4MEAfUw5/Q7Tc5TAC+z1b4788628eLv0hyJUzMzL7j
        Lg/7VjzZz4chhCBybmdCL4lTLJuDyrPU6uV0CV1OaoKNy+/RhR+fgs/GBiIhRckkVBtBLxqZhB2rO
        QcepcvtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvnc3-003tf7-KO; Fri, 10 Dec 2021 21:39:31 +0000
Date:   Fri, 10 Dec 2021 13:39:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     tj@kernel.org, akpm@linux-foundation.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
Message-ID: <YbPJEznncIVSKQvH@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com>
 <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:48:25PM -0800, Luis Chamberlain wrote:
> On Fri, Dec 03, 2021 at 04:29:02PM +0100, Greg KH wrote:
> > On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:
> > > This adds a new selftest module which can be used to test sysfs, which
> > > would otherwise require using an existing driver. This lets us muck
> > > with a template driver to test breaking things without affecting
> > > system behaviour or requiring the dependencies of a real device
> > > driver.
> > 
> > Test sysfs "how"?  What exactly are you wanting to test?
> 
> You can look at the 32 tests added after all patches applied.
> 
> > I see lots of things in this code as examples of how to NOT use sysfs,
> > so are you testing my review cycles?  :)
> 
> You are exagerating, there are 32 tests there and only 2 tests deal
> with a deadlock which we are not yet sure how widespread it could be.

Also very important is how one test uses failure injection support to proove
how getting the kernfs active reference suffices to avoid crashes with
module removal and uses of sysfs ops in a driver, something which *you*
did not believe to be true but the code speaks for itself. This is also
why uses of try_module_get() is *safe* if used on sysfs ops.

  Luis
