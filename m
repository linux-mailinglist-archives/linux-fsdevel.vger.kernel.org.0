Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35910160055
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 20:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBOTxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 14:53:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgBOTxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 14:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BpDKtc5YdvqyWLynXykgKLWaF9sL2fROoHx5x/evTK0=; b=Vxhy9E/fi+Z7E4jyxUIC1eZezB
        leCSOEmo0l5bNzoRNmuFF9D08GYbS8pxAS/IyXjE5auf4Sfdslr2Fj8ixSoNCppJADHagxfWwKA46
        v4OorH6lvAWAIVpllsXwrrW5wWnWcg0vmvSifBRw/zVcKqXJyX5fP1yj6BieRX9ye00WLtEq1JTVf
        tdczB9ncC4TDvwDWWI8KCMNAgxHbVzSSczUm/XWMMwj6azNLBGVbmL+f9CxG6EptOVrf8gJTTkg/K
        cHSNS7Q6tfiPz+L627aMphGz5LP6qAaUwk9g7Ko42lxfVSL44JFWOUHltaY9xO0zn1USxQLTdePOY
        1WymFetQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j33Ux-0006H5-8C; Sat, 15 Feb 2020 19:53:07 +0000
Date:   Sat, 15 Feb 2020 11:53:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Atomic Writes
Message-ID: <20200215195307.GI7778@bombadil.infradead.org>
References: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com>
 <20200214044242.GI6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214044242.GI6870@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 08:42:42PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 03:33:08PM -0700, Allison Collins wrote:
> > I also understand there are multiple ways to solve this problem that people
> > may have opinions on.  I've noticed some older patch sets trying to use a
> > flag to control when dirty pages are flushed, though I think our customer
> > would like to see a hardware solution via NVMe devices.  So I would like to
> > see if others have similar interests as well and what their thoughts may be.
> > Thanks everyone!
> 
> Hmmm well there are a number of different ways one could do this--

Interesting.  Your answer implies a question of "How do we expose
a filesystem's ability to do atomic writes to userspace", whereas I
thought Allison's question was "What spec do we write to give to the
NVMe vendors so that filesystems can optimise their atomic writes".

I am very interested in the question of atomic writes, but I don't
know that we're going to have the right people in the room to design
a userspace API.  Maybe this is more of a Plumbers topic?  I think
the two main users of a userspace API would be databases (sqlite,
mysql, postgres, others) and package managers (dpkg, rpm, others?).
Then there would be the miscellaneous users who just want things to work
and don't really care about performance (writing a game's high score file,
updating /etc/sudoers).

That might argue in favour of having two independent APIs, one that's
simple, probably quite slow, but safe, and one that's complex, fast
and safe.  There's also an option for simple, fast and unsafe, but,
y'know, we already have that ...

Your response also implies that atomic writes are only done to a single
file at a time, which isn't true for either databases or for package
managers.  I wonder if the snapshot/reflink paradigm is the right one
for multi-file atomic updates, or if we can use the same underlying
mechanism to implement an API which better fits how userspace actually
wants to do atomic updates.

