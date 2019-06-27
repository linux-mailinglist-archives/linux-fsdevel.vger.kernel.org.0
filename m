Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE73578C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 02:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF0A4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 20:56:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfF0A4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:56:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgIiC-0002Xh-Fu; Thu, 27 Jun 2019 00:56:28 +0000
Date:   Thu, 27 Jun 2019 01:56:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org
Subject: Re: misuse of fget_raw() in perf_event_get()
Message-ID: <20190627005628.GP17978@ZenIV.linux.org.uk>
References: <20190413210242.GP2217@ZenIV.linux.org.uk>
 <20190415044158.5goa2je57j63kwaz@ast-mbp.dhcp.thefacebook.com>
 <20190415090406.GJ2490@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415090406.GJ2490@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:04:06AM +0200, Peter Zijlstra wrote:
> On Sun, Apr 14, 2019 at 09:42:00PM -0700, Alexei Starovoitov wrote:
> > On Sat, Apr 13, 2019 at 10:02:42PM +0100, Al Viro wrote:
> > > 	What's the point of using fget_raw(), if you do
> > > _not_ accept O_PATH descriptors?  That should be fget()...
> > 
> > I think you're talking about commit e03e7ee34fdd ("perf/bpf: Convert perf_event_array to use struct file")
> > I don't really remember why we went with this instead of fget().
> > There was a bunch of back and forth back then with Peter.
> 
> That was mostly on what refcount to use, you wanted to use the event
> refcount, and I suggested using the file refcount.
> 
> If you look at:
> 
>   lkml.kernel.org/r/20160126161637.GF6357@twins.programming.kicks-ass.net
> 
> I too wondered about the fget_raw() at the time, whatever Al wants
> though, I never quite remember how that file stuff works :/

Anyway, fget() it becomes...
