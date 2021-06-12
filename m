Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEB3A4C2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 03:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFLByN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 21:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhFLByN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:54:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B38C061574;
        Fri, 11 Jun 2021 18:52:14 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrsoM-007AAA-Sv; Sat, 12 Jun 2021 01:51:46 +0000
Date:   Sat, 12 Jun 2021 01:51:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
Message-ID: <YMQTMnfmOfdv2DpA@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
 <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
 <2ee74cbed729d66a38a5c7de9c4608d02fb89f26.camel@themaw.net>
 <ab91ce6f0c1b2e9549fc6e966db7514a988d0bf1.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab91ce6f0c1b2e9549fc6e966db7514a988d0bf1.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 12, 2021 at 09:08:05AM +0800, Ian Kent wrote:

> But if I change to take the read lock to ensure there's no operation
> in progress for the revision check I would need the dget_parent(), yes?

WTF for?  ->d_parent can change *ONLY* when ->d_lock is held on all
dentries involved (including old and new parents).

And it very definitely does *not* change for negative dentries.  I mean,
look at the very beginning of __d_move().
