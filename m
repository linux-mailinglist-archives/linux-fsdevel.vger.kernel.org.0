Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDB194063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCZNvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 09:51:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38106 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZNvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:51:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHSsv-003Jcf-BF; Thu, 26 Mar 2020 13:49:25 +0000
Date:   Thu, 26 Mar 2020 13:49:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [powerpc] Intermittent crashes ( link_path_walk) with linux-next
Message-ID: <20200326134925.GP23230@ZenIV.linux.org.uk>
References: <1CB4E533-FD97-4C39-87ED-4857F3AB9097@linux.vnet.ibm.com>
 <87h7ybwdih.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7ybwdih.fsf@mpe.ellerman.id.au>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:40:06PM +1100, Michael Ellerman wrote:

> > The code in question (link_path_walk() in fs/namei.c ) was recently changed by
> > following commit:
> >
> > commit 881386f7e46a: 
> >   link_path_walk(): sample parent's i_uid and i_mode for the last component
> 
> That and about 10 other commits.
> 
> Unless Al can give us a clue we'll need to bisect.

	Already fixed yesterday.  It's not link_path_walk(), it's handle_dots()
ignoring an error returned by step_into().

commit 5e3c3570ec97 is the broken one; commit 20971012f63e is its variant with the
fix folded in.  So next-20200325 has the bug and next-20200326 should have it
fixed.  Could you check the current -next and see if you still observe that crap?
