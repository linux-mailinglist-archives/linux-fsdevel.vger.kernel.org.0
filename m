Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997E6F374D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKGSeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 13:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKGSeX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:34:23 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0669214D8;
        Thu,  7 Nov 2019 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573151663;
        bh=bW1G6M0gI9u4OvtON+m4YYs0ZAALaGyOmm0QrPeUqCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CvuLizYXED57Fp/0P/Gn69Zf2894InNPu3/ZwyGP1ca8IBH4hHpDUofrSocIsEssD
         bWu7hYEe0Krmsdz+X4Y82H2BDSfCfabx0lES4Wy7WUrbAtqtTK+/yHV3W6eeRj1M9u
         Uqbzr1RviqX+4Zzvv9Ku9IcG1EhOS3s+ka8Pd11Y=
Message-ID: <e9c46777ec0aaca768681eb144823f19185d9fa0.camel@kernel.org>
Subject: Re: Deprecated mandatory file locking
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:34:21 -0500
In-Reply-To: <20191107161514.GA21965@quack2.suse.cz>
References: <20190814173345.GB10843@quack2.suse.cz>
         <20190814174604.GC10843@quack2.suse.cz>
         <01b6620186a18b167ca1bab1fadb2dbaffdd8379.camel@kernel.org>
         <20190816153149.GD3041@quack2.suse.cz>
         <20191107161514.GA21965@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-11-07 at 17:15 +0100, Jan Kara wrote:
> Hi Jeff,
> 
> On Fri 16-08-19 17:31:49, Jan Kara wrote:
> > On Thu 15-08-19 15:18:45, Jeff Layton wrote:
> > > On Wed, 2019-08-14 at 19:46 +0200, Jan Kara wrote:
> > > > Resending to proper Jeff's address...
> > > > 
> > > > On Wed 14-08-19 19:33:45, Jan Kara wrote:
> > > > > Hello Jeff,
> > > > > 
> > > > > we've got a report from user
> > > > > (https://bugzilla.suse.com/show_bug.cgi?id=1145007) wondering why his fstab
> > > > > entry (for root filesystem!) using 'mand' mount option stopped working.
> > > > > Now I understand your rationale in 9e8925b67a "locks: Allow disabling
> > > > > mandatory locking at compile time" but I guess there's some work to do wrt
> > > > > documentation. At least mount(8) manpage could mention that mandatory
> > > > > locking is broken and may be disabled referencing the rationale in fcntl
> > > > > manpage? Or the kernel could mention something in the log about failing
> > > > > mount because of 'mand' mount option?  What do you think? Because it took
> > > > > me some code searching to understand why the mount is actually failing
> > > > > which we can hardly expect from a normal sysadmin...
> > > > > 
> > > > > 								Honza
> > > 
> > > Wow, I think this is the first actual user fallout we've ever had from
> > > that change! Why was he setting that option? Does he actually use
> > > mandatory locking?
> > 
> > Yeah, reportedly they had an application that required mandatory locking.
> > But they don't use it anymore so they just removed the mount option.
> > 
> > > I think a pr_notice() or pr_warn() at mount time when someone tries to
> > > use it sounds like a very reasonable thing to do. Perhaps we can just
> > > stick one in may_mandlock()?
> > 
> > Yeah, sounds reasonable to me.
> > 
> > > I'll draft up a patch, and also update
> > > Documentation/filesystems/mandatory-locking.txt with the current
> > > situation.
> > 
> > Thanks!
> 
> Did you ever get to this?
> 
> 								Honza

Yes. It went into v5.4-rc1. You even reviewed it! ;)

See:

commit df2474a22c42ce419b67067c52d71da06c385501
Author: Jeff Layton <jlayton@kernel.org>
Date:   Thu Aug 15 15:21:17 2019 -0400

    locks: print a warning when mount fails due to lack of "mand" support

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

