Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272B7AA31A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfIEM1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 08:27:17 -0400
Received: from aws.guarana.org ([13.237.110.252]:58206 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387820AbfIEM1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:27:16 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 08:27:15 EDT
Received: by aws.guarana.org (Postfix, from userid 1006)
        id DCE0CBBED4; Thu,  5 Sep 2019 12:17:55 +0000 (UTC)
Date:   Thu, 5 Sep 2019 12:17:55 +0000
From:   Kevin Easton <kevin@guarana.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190905121755.GA23258@ip-172-31-14-16>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
 <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org>
 <20190903175610.GM1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903175610.GM1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:56:10PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 08:39:30AM -0700, Christoph Hellwig wrote:
> 
> > > There's much nastier situation than "new upstream kernel released,
> > > need to rebuild" - it's bisect in mainline trying to locate something...
> > 
> > I really don't get the point.  And it's not like we've card about
> > this anywhere else.  And jumping wildly around with the numeric values
> > for constants will lead to bugs like the one you added and fixed again
> > and again.
> 
> The thing is, there are several groups - it's not as if all additions
> were guaranteed to be at the end.  So either we play with renumbering
> again and again, or we are back to the square one...
> 
> Is there any common trick that would allow to verify the lack of duplicates
> at the build time?

What about:

static_assert(
 (LOOKUP_FOLLOW^LOOKUP_DIRECTORY^LOOKUP_AUTOMOUNT^LOOKUP_EMPTY^LOOKUP_DOWN^
  LOOKUP_REVAL^LOOKUP_RCU^
  LOOKUP_OPEN^LOOKUP_CREATE^LOOKUP_EXCL^LOOKUP_RENAME_TARGET^
  LOOKUP_PARENT^LOOKUP_NO_REVAL^LOOKUP_JUMPED^LOOKUP_ROOT^LOOKUP_ROOT_GRABBED)
 ==
 (LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_AUTOMOUNT|LOOKUP_EMPTY|LOOKUP_DOWN|
  LOOKUP_REVAL|LOOKUP_RCU|
  LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL|LOOKUP_RENAME_TARGET|
  LOOKUP_PARENT|LOOKUP_NO_REVAL|LOOKUP_JUMPED|LOOKUP_ROOT|LOOKUP_ROOT_GRABBED)
 , "duplicated LOOKUP_* constant");

?

    - Kevin
