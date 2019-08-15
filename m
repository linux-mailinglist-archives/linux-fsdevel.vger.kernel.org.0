Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD38F44F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfHOTSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731622AbfHOTSs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:18:48 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467920656;
        Thu, 15 Aug 2019 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565896727;
        bh=xb3DyN7+JjEreEpTFI2Ds9GHRndFIqFAERtGNbOWS7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IwBwr4X7s6UUHdEn1pqVL9Ih31e97AG9B5E6L1EEtU+w1kICT77efALfAX80qMHgv
         uV84QgbrpemnviUcI1i3vtF3aZ+rWXMmAQBUvcy/zGRntno9fSGO8sWI6zilPB2+VQ
         huE5hvP3Z7Qp9yTnewO3qIk0mHQsIXfTwPL5FwwY=
Message-ID: <01b6620186a18b167ca1bab1fadb2dbaffdd8379.camel@kernel.org>
Subject: Re: Deprecated mandatory file locking
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:18:45 -0400
In-Reply-To: <20190814174604.GC10843@quack2.suse.cz>
References: <20190814173345.GB10843@quack2.suse.cz>
         <20190814174604.GC10843@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-08-14 at 19:46 +0200, Jan Kara wrote:
> Resending to proper Jeff's address...
> 
> On Wed 14-08-19 19:33:45, Jan Kara wrote:
> > Hello Jeff,
> > 
> > we've got a report from user
> > (https://bugzilla.suse.com/show_bug.cgi?id=1145007) wondering why his fstab
> > entry (for root filesystem!) using 'mand' mount option stopped working.
> > Now I understand your rationale in 9e8925b67a "locks: Allow disabling
> > mandatory locking at compile time" but I guess there's some work to do wrt
> > documentation. At least mount(8) manpage could mention that mandatory
> > locking is broken and may be disabled referencing the rationale in fcntl
> > manpage? Or the kernel could mention something in the log about failing
> > mount because of 'mand' mount option?  What do you think? Because it took
> > me some code searching to understand why the mount is actually failing
> > which we can hardly expect from a normal sysadmin...
> > 
> > 								Honza

Wow, I think this is the first actual user fallout we've ever had from
that change! Why was he setting that option? Does he actually use
mandatory locking?

I think a pr_notice() or pr_warn() at mount time when someone tries to
use it sounds like a very reasonable thing to do. Perhaps we can just
stick one in may_mandlock()?

I'll draft up a patch, and also update
Documentation/filesystems/mandatory-locking.txt with the current
situation.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

