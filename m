Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3111355C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfLDTCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 14:02:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfLDTCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BQmo+gX5S3W17qKr0RYlhiUhB5LPG6Hzz7ayl1y1PEE=; b=l5/HEX+sVidZ8NTomRmEcS9HZ
        /e1RirGXi9UVXOVn6jWz9mi0GRnu4gEk1tyblJTGRrqjbe/kRIKUyEiDDy+HFbnOxQZvuYqX5vIev
        5gi+sTgCFv+CFgDrCfjC370tyDceKwUQWoRIuU1omw2CwP75YvqsKkGWNR8Il4DPDXKJosuUUYrpP
        oecsdL/cbNmXghC3DMzaAIdIo9NxZhznn3E7G7pgi/K1VBJBeletR99ysNGW7ubqdSZU6oAMcdtrh
        qqEpPGr0m9WG3kA+dxwJhHAHP8g2gNrZ10Y/sFaWraGac0tRjR3XqjCVbAm0NtLGnMR41lC7G1xwE
        CEB5Shzkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icZuY-0005BI-SY; Wed, 04 Dec 2019 19:02:06 +0000
Date:   Wed, 4 Dec 2019 11:02:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20191204190206.GA8331@bombadil.infradead.org>
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz>
 <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 08:37:09PM +0200, Amir Goldstein wrote:
> On Wed, Dec 4, 2019 at 7:34 PM Jan Kara <jack@suse.cz> wrote:
> > The problem is there's no better reliable way. For example even if fanotify
> > event provided a name as in the Amir's commit you reference, this name is
> > not very useful. Because by the time your application gets to processing
> > that fanotify event, the file under that name need not exist anymore, or
> 
> For DELETE event, file is not expected to exist, the filename in event is
> always "reliable" (i.e. this name was unlinked).

Jan already pointed out that events may be reordered.  So a CREATE event
and DELETE event may arrive out of order for the same file.  This will
confuse any agent.

> > there may be a different file under that name already. That is my main
> > objection to providing file names with fanotify events - they are not
> > reliable but they are reliable enough that application developers will use
> > them as a reliable thing which then leads to hard to debug bugs. Also
> > fanotify was never designed to guarantee event ordering so it is impossible
> > to reconstruct exact state of a directory in userspace just by knowing some
> > past directory state and then "replaying" changes as reported by fanotify.
