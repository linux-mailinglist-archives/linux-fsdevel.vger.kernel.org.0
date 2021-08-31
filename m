Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB663FCAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 17:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhHaPeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 11:34:23 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33112 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhHaPeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:34:22 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL5h3-0000RV-T4; Tue, 31 Aug 2021 15:28:58 +0000
Date:   Tue, 31 Aug 2021 15:28:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
Message-ID: <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS40qqmXL7CMFLGq@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 02:54:50PM +0100, Catalin Marinas wrote:

> An arm64-specific workaround would be for pagefault_disable() to disable
> tag checking. It's a pretty big hammer, weakening the out of bounds
> access detection of MTE. My preference would be a fix in the btrfs code.
> 
> A btrfs option would be for copy_to_sk() to return an indication of
> where the fault occurred and get fault_in_pages_writeable() to check
> that location, even if the copying would restart from an earlier offset
> (this requires open-coding copy_to_user_nofault()). An attempt below,
> untested and does not cover read_extent_buffer_to_user_nofault():

Umm...  There's another copy_to_user_nofault() call in the same function
(same story, AFAICS).

Can't say I'm fond of their ABI, but then I guess it could've been worse -
iterating over btree, running a user-supplied chunk of INTERCAL over it,
with all details of internal representation cast in stone by that exposure...
