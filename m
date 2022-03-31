Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100E4EE213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiCaTsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiCaTr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:47:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441F63526;
        Thu, 31 Mar 2022 12:46:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na0jt-001HLx-Ti; Thu, 31 Mar 2022 19:45:50 +0000
Date:   Thu, 31 Mar 2022 19:45:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Colin Walters <walters@verbum.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fs/dcache: Add negative-dentry-ratio config
Message-ID: <YkYE7RXgP8hL9aLd@zeniv-ca.linux.org.uk>
References: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
 <20220331190827.48241-3-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331190827.48241-3-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:08:27PM -0700, Stephen Brennan wrote:
> Negative dentry bloat is a well-known problem. For systems without
> memory pressure, some workloads (like repeated stat calls) can create an
> unbounded amount of negative dentries quite quickly. In the best case,
> these dentries could speed up a subsequent name lookup, but in the worst
> case, they are never used and their memory never freed.
> 
> While systems without memory pressure may not need that memory for other
> purposes, negative dentry bloat can have other side-effects, such as
> soft lockups when traversing the d_subdirs list or general slowness with
> managing them. It is a good idea to have some sort of mechanism for
> controlling negative dentries, even outside memory pressure.
> 
> This patch attempts to do so in a fair way. Workloads which create many
> negative dentries must create many dentries, or convert dentries from
> positive to negative. Thus, negative dentry management is best done
> during these same operations, as it will amortize its cost, and
> distribute the cost to the perpetrators of the dentry bloat. We
> introduce a sysctl "negative-dentry-ratio" which sets a maximum number
> of negative dentries per positive dentry, N:1. When a dentry is created
> or unlinked, the next N+1 dentries of the parent are scanned. If no
> positive dentries are found, then a candidate negative dentry is killed.

Er...  So what's to stop d_move() from leaving you with your cursor
pointer poiting into the list of children of another parent?

What's more, your dentry_unlist() logics will be defeated by that -
if victim used to have a different parent, got moved, then evicted,
it looks like you could end up with old parent cursor pointing
to the victim and left unmodified by dentry_unlist() (since it looks
only at the current parent's cursor).  Wait for it to be freed and
voila - access to old parent's cursor will do unpleasant things.

What am I missing here?
