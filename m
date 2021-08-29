Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37FD3FAE3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhH2TwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhH2TwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:52:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36BC061575;
        Sun, 29 Aug 2021 12:51:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630266690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1e3nSsPm9vFxQ5jfIvm1uHispKQgTIcx2dzb6BILhtM=;
        b=DPvfzjwGONXER0jR9xvjUbua8zjtnfilBJrSOw3hJyC72q0HDjMiEs94sqjPs2Mh/Nk3lt
        DznVBOlT9hejmPxH2DGciXBSVfTnsJR5AgcwhFjepGmRCNNjUJg9ViVoOreRiI4NskCkF2
        AFz1h2fA8xzF70oV+o0oSIGhaRyx7jmM2lH1KzedfL63YxJqcy+ztdzWaTswpMvhGwrSwE
        9VEJ41mievNUgl2ATSDruWvcYyl25fOXDWwwSX3qGKOouB+zNeiDJ3bDrnXMB/5DO7EHWP
        zL+yTNbRQh0uidm3WQO5hz+kptyviqN7X8Rz1sZQl/nQbc9ob9sUw4qGqSyRxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630266690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1e3nSsPm9vFxQ5jfIvm1uHispKQgTIcx2dzb6BILhtM=;
        b=veVifLK6jQGM6KFk3te2gOXCaon93yGE0+oJ1TfamLRvAu4RlVrmGT9c6EaedlKLBxdsak
        qFEYMcWO6kYE29DQ==
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
In-Reply-To: <YSvj/ML2saV3+5Ru@zeniv-ca.linux.org.uk>
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx> <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
 <YSq2WJindB0pJPRb@zeniv-ca.linux.org.uk>
 <YSq93XetyaUuAsY7@zeniv-ca.linux.org.uk> <87k0k4gkgb.ffs@tglx>
 <YSvj/ML2saV3+5Ru@zeniv-ca.linux.org.uk>
Date:   Sun, 29 Aug 2021 21:51:29 +0200
Message-ID: <87h7f8ghby.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29 2021 at 19:46, Al Viro wrote:

> On Sun, Aug 29, 2021 at 08:44:04PM +0200, Thomas Gleixner wrote:
>> On Sat, Aug 28 2021 at 22:51, Al Viro wrote:
>> > @@ -345,7 +346,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
>> >  	 */
>> >  	err = __clear_user(&buf->header, sizeof(buf->header));
>> >  	if (unlikely(err))
>> > -		return -EFAULT;
>> > +		return -X86_TRAP_PF;
>> 
>> This clear_user can be lifted into copy_fpstate_to_sigframe(). Something
>> like the below.
>
> Hmm...  This mixing of -X86_TRAP_... with -E... looks like it's asking for
> trouble in general.  Might be worth making e.g. fpu__restore_sig() (and
> its callers) return bool, seeing that we only check for 0/non-zero in
> there.

Let me fix that.
