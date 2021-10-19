Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA7433C15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhJSQ1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhJSQ1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:27:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B95DC61052;
        Tue, 19 Oct 2021 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634660721;
        bh=95zfq3H7AzOVXaStxwjek0lilnUiI4UGTpiGsI5GA68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V81ZepDcu2b0xZatBmX5hpojvnURXk3S52VuM9dZX+hCyIf6oTvg/NKQ2N8K7TsVe
         Blia5F0gDY7c9dwHnwoGCGDCqKKWHu2vW3miaJSRtrq6VW5y/5c6iRQ46rRXCqY+TH
         axCjMSE6G9g9IXCXcrFJPHOX3WSFWsc7pm4maxMQ=
Date:   Tue, 19 Oct 2021 18:25:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW7xbnrqfzifa9OC@kroah.com>
References: <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> So do you want to take the position:
> 
> Hey driver authors: you cannot use any shared lock on module removal and
> on sysfs ops?

Yes, I would not recommend using such a lock at all.  sysfs operations
happen on a per-device basis, so you can lock the device structure.
Module removal happens on a driver basis, and I have no idea what you
want to lock there, but odds are it is NOT shared with your per-device
structures either, right?

If so, then yes, that is a bug, but a very rare one as drivers should do
almost nothing except register/unregister_driver() in their module
init/exit calls.

zram is not a "normal" driver at all here, so fixing this type of
problem up should be done in the zram code, it is not a generic
module/sysfs issue at all.

thanks,

greg k-h
