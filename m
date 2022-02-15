Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF284B5EC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiBOAF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 19:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBOAF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:05:27 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89DBC7923F;
        Mon, 14 Feb 2022 16:05:18 -0800 (PST)
Received: from dread.disaster.area (pa49-186-85-251.pa.vic.optusnet.com.au [49.186.85.251])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F253610C757A;
        Tue, 15 Feb 2022 11:05:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nJlLH-00C6nT-Ni; Tue, 15 Feb 2022 11:05:15 +1100
Date:   Tue, 15 Feb 2022 11:05:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Message-ID: <20220215000515.GC2872883@dread.disaster.area>
References: <cover.1644469146.git.naohiro.aota@wdc.com>
 <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
 <20220214213531.GA2872883@dread.disaster.area>
 <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=620aee3d
        a=2CV4XU02g+4RbH+qqUnf+g==:117 a=2CV4XU02g+4RbH+qqUnf+g==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=JF9118EUAAAA:8 a=7-415B0cAAAA:8
        a=pDkgLxu4piZ9osPqlWgA:9 a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:49:27AM +0900, Damien Le Moal wrote:
> On 2/15/22 06:35, Dave Chinner wrote:
> > On Thu, Feb 10, 2022 at 02:59:04PM +0900, Naohiro Aota wrote:
> >> Add an assert function sb_assert_write_started() to check if
> >> sb_start_write() is properly called. It is used in the next commit.
> >>
> >> Also, add the assert functions for sb_start_pagefault() and
> >> sb_start_intwrite().
> >>
> >> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >> ---
> >>  include/linux/fs.h | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index bbf812ce89a8..5d5dc9a276d9 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
> >>  #define __sb_writers_release(sb, lev)	\
> >>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> >>  
> >> +static inline void __sb_assert_write_started(struct super_block *sb, int level)
> >> +{
> >> +	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
> >> +}
> >> +
> > 
> > So this isn't an assert, it's a WARN_ON(). Asserts stop execution
> > (i.e. kill the task) rather than just issue a warning, so let's not
> > name a function that issues a warning "assert"...
> > 
> > Hence I'd much rather see this implemented as:
> > 
> > static inline bool __sb_write_held(struct super_block *sb, int level)
> > {
> > 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> > }
> 
> Since this would be true when called in between __sb_start_write() and
> __sb_end_write(), what about calling it __sb_write_started() ? That
> disconnects from the fact that the implementation uses a sem.

Makes no difference to me; I initially was going to suggest
*_inprogress() but that seemed a bit verbose. We don't need to
bikeshed this to death - all I want is it to be a check that can be
used for generic purposes rather than being an explicit assert.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
