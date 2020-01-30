Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56F14DE3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA3PzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 10:55:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55916 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3PzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:55:22 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixCA3-004pJX-Vl; Thu, 30 Jan 2020 15:55:20 +0000
Date:   Thu, 30 Jan 2020 15:55:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/17] follow_automount() doesn't need the entire
 nameidata
Message-ID: <20200130155519.GC23230@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
 <20200119031738.2681033-4-viro@ZenIV.linux.org.uk>
 <20200130144520.hnf2yk5tjalxfddn@wittgenstein>
 <20200130153825.GA23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130153825.GA23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:38:25PM +0000, Al Viro wrote:
> On Thu, Jan 30, 2020 at 03:45:20PM +0100, Christian Brauner wrote:
> > > -	nd->total_link_count++;
> > > -	if (nd->total_link_count >= 40)
> > > +	if (count && *count++ >= 40)
> > 
> > He, side-effects galore. :)
> > Isn't this incrementing the address but you want to increment the
> > counter?
> > Seems like this should be
> > 
> > if (count && (*count)++ >= 40)
> 
> Nice catch; incidentally, it means that usual testsuites (xfstests,
> LTP) are missing the automount loop detection.  Hmm...

Fix folded and pushed (the series in #next.namei now, on top of
#work.openat2 + #fixes)
