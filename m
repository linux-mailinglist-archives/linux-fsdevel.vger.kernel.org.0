Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865292616CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIHRTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgIHRTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:19:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FDC061573;
        Tue,  8 Sep 2020 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9uZRgbe3Vq6CrxDMqukXR6cWakSDCk1Eri1y4t7+iO0=; b=ppTDKN5CEfSyw823xZjmFI5UQX
        nWXWzwpGCDWl3B/cfD++bEP3jz1dG1nLramw5tLcjCQU7sIMtkeZbxZsKt4bJLbmR/Bn1qNVtlgNj
        rmHH6pwtx5WZZGeHtO3V/jQb50SYxi7sLmsHCt8IjNs8I+cDVwIhu8mFtLIG3tVZ11V36IonUCzRr
        6Ils39+kFrlA7otfC8Vo10jvlh6GBsSSyQx9c2WVvk3LTBXE9eW7ONYoE4HK5m7yXuEaeXNse1vqN
        XQWE/vzKSjDCWOKn2/v4c4yz71InEnFQx3lhRXp3c+Z3Edd/c22MYsIPwtT9jmLVlhNp/kN9jpgcr
        9STHyhGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFhGl-0003jr-Kn; Tue, 08 Sep 2020 17:18:59 +0000
Date:   Tue, 8 Sep 2020 18:18:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
Message-ID: <20200908171859.GA29953@casper.infradead.org>
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
 <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com>
 <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:18:29PM +0300, Amir Goldstein wrote:
> On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > For example, in fs/coredump.c, do_coredump() calls filp_open() to
> > generate core files.
> > In this scenario, the fsnotify_open() notification is missing.
> 
> I am not convinced that we should generate an event.
> You will have to explain in what is the real world use case that requires this
> event to be generated.

Take the typical usage for fsnotify of a graphical file manager.
It would be nice if the file manager showed a corefile as soon as it
appeared in a directory rather than waiting until some other operation
in that directory caused those directory contents to be refreshed.
