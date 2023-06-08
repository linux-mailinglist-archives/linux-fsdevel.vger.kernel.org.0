Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDF7276A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 07:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjFHF3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFHF3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:29:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B719BB;
        Wed,  7 Jun 2023 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AuoFXc6mC0CchCsTVGZxzFlsH6pVBxlEu3dUOFHvvfQ=; b=Syo8qVTQpUGvrpjzKiLhGW4olW
        sJuNZOHW1JESoIpqG4kgoklwg3rwUAFASf7B6oBHY5dODAeP78HHiYpWmm8fNpb2AylunV5ggx2nN
        bSkP1HbE6kIDxyPuD5LPCsuvGdGbFuRVJWHopON+ddKYPDSuIqlVTWeivflo87mpRvQXouGK0DlzL
        0JIVL5XtASvtBxvljSTzt1cSr2ykwQbgEQ8PcbGpA3OUsb+yQP3VVq65/sDTX85I8iFU+WoAmVGxj
        vJaMn5xsEK/APxX4HcwaqnHAGlXeRB5D8IkNkiTf1onh9i+Z2yWqjW5r6FltWRt6Dgkk7e4MLuJwz
        Bo9HgZpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q78Cm-0089EH-1Y;
        Thu, 08 Jun 2023 05:29:04 +0000
Date:   Wed, 7 Jun 2023 22:29:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZIFnID9ZNpd7zrNa@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525141430.slms7f2xkmesezy5@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> 
> I'd just note that this would need rebasing on top of Luis' patches 1 and
> 2. Also:

I'd not do that for now.  1 needs a lot more work, and 2 seems rather
questionable.

> Now the only remaining issue with the code is that the two different
> holders can be attempting to freeze the filesystem at once and in that case
> one of them has to wait for the other one instead of returning -EBUSY as
> would happen currently. This can happen because we temporarily drop
> s_umount in freeze_super() due to lock ordering issues. I think we could
> do something like:
> 
> 	if (!sb_unfrozen(sb)) {
> 		up_write(&sb->s_umount);
> 		wait_var_event(&sb->s_writers.frozen,
> 			       sb_unfrozen(sb) || sb_frozen(sb));
> 		down_write(&sb->s_umount);
> 		goto retry;
> 	}
> 
> and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> in freeze_super().

Let's do that separately as a follow on..

> 
> BTW, when reading this code, I've spotted attached cleanup opportunity but
> I'll queue that separately so that is JFYI.
> 
> > +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> > +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
> 
> Why not start from 1U << 0? And bonus points for using BIT() macro :).

BIT() is a nasty thing and actually makes code harder to read. And it
doesn't interact very well with the __bitwise annotation that might
actually be useful here.

