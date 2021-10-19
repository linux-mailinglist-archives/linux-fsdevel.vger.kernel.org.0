Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE63B433C2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhJSQcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:32:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E10C06161C;
        Tue, 19 Oct 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3d5VLYLd+DGtK6vi3OXqfvMnVkoUyb51KLWcY/qz7w=; b=F5XwMG9VlrmTBb4f6u7r7z+ZrU
        DHXy8iIRbDw5ZqLG1MJbU30syWtXFssMJ3aEFyEa/u3G0LwTgewzsVFvgvLPCU1cbAPD0WcQckkN6
        o9e6FUXX6Ia67HIQga6ljODAUrYw8aIUTeYBPss1KYXU/X4uLVUyqd6i0VlLZ618/zISot8Vgrya3
        0GUaiL7oPpwV6A2mFOcmKoAVgr2P7oYI9BetvAuxzWWQypQmf3u9wUTW5agLFcjUP0HyRbraG90zG
        btEsDr6kCDVl3nVyA8GH2DmDZ5+1iZNClVN3HLvRzqKzqZjKhYHJDbdzy8Pjv+ClsYWxB/b0Lhm4w
        JuEK85WQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcs05-001vaq-Da; Tue, 19 Oct 2021 16:30:05 +0000
Date:   Tue, 19 Oct 2021 09:30:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YW7yjQVC4NRfrWxD@bombadil.infradead.org>
References: <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
 <YW7xbnrqfzifa9OC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7xbnrqfzifa9OC@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 06:25:18PM +0200, Greg KH wrote:
> On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> > So do you want to take the position:
> > 
> > Hey driver authors: you cannot use any shared lock on module removal and
> > on sysfs ops?
> 
> Yes, I would not recommend using such a lock at all.  sysfs operations
> happen on a per-device basis, so you can lock the device structure.

All devices are going to be removed on module removal and so cannot be locked.

  Luis
