Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02029433F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhJSTlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhJSTlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:41:07 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980F3C06161C;
        Tue, 19 Oct 2021 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zY/TOEsZiQ3A5NcBB8ThTVV+O2F16AgeBhmjTIEWu7w=; b=ZStJ/DXqq1wAvyAXrcCXgyZYTL
        AbzgYczpU5nQMNid+f6J4ibhGfIyJqjlykgL/v5dQDL+HLL2ZsC8YzEuzI0LfocO782ZVzleec++r
        nemnPop2nMpQedimhX/v2i4cCuXgnPpeK6heH5Ap9yMKk4nh3OaeiJGvI3eUU4XHcMl0vjslhWOe5
        P9NcT7KFmWZwL11f5OGcZoJ2cX/dR6taK+9lafK+TBHdeohoKfUbhikMaztwxtLSQuiYMrZo2FQTt
        plVx+iPPZEbaRCRqP6vOSOGjS8ns1X3V2Eebf/S6yYCzwJrYDx99KaEN9zNPeJnEs5Db9Uct4ni5B
        qMqkvecA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcuwc-002XBh-TJ; Tue, 19 Oct 2021 19:38:43 +0000
Date:   Tue, 19 Oct 2021 12:38:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW8ewvAac/T2vxz2@bombadil.infradead.org>
References: <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
 <YW70uklcBWrmJIn8@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW70uklcBWrmJIn8@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:39:22AM +0800, Ming Lei wrote:
> On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> > So do you want to take the position:
> > 
> > Hey driver authors: you cannot use any shared lock on module removal and
> > on sysfs ops?
> 
> IMO, yes, in your patch of 'zram: fix crashes with cpu hotplug multistate',
> when you added mutex_lock(zram_index_mutex) to disksize_store() and
> other attribute show() or store() method. You have added new deadlock
> between hot_remove_store() and disksize_store() & others, which can't be
> addressed by your approach of holding module refcnt.
> 
> So far not see ltp tests covers hot add/remove interface yet.

Care to show what commands to use to cause this deadlock with my patches?

  Luis
