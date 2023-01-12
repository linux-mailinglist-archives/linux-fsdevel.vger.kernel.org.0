Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE426686FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjALWbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjALWbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:31:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA0282;
        Thu, 12 Jan 2023 14:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F123AB8202B;
        Thu, 12 Jan 2023 22:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E1C433EF;
        Thu, 12 Jan 2023 22:30:39 +0000 (UTC)
Date:   Thu, 12 Jan 2023 17:30:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Brian Norris <briannorris@chromium.org>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] tracing mapped pages for quicker boot
 performance
Message-ID: <20230112173036.01677fa7@gandalf.local.home>
In-Reply-To: <Y8CItRIuL3KUqUlk@casper.infradead.org>
References: <20230112132153.38d52708@gandalf.local.home>
        <Y8BvKZFI9RIoS4C/@casper.infradead.org>
        <20230112171759.70132384@gandalf.local.home>
        <Y8CItRIuL3KUqUlk@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Jan 2023 22:24:53 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> > Great! How do I translate this to files? Do I just do a full scan on the
> > entire device to find which file maps to an inode? And I'm guessing that
> > the ofs is the offset into the file?  
> 
> 'ofs' is, yes.  That should have been called 'pos'.
> 
> And as you know, inodes can have multiple names in the filesystem.
> I imagine you'd want to trace open() to see which names are being
> opened; you can fstat the fd to build the ino->name lookup.

I'm not sure which file that points to the inode matters. I'm guessing that
if I have two files that are hard-linked together, and I run the readahead()
system call on one of them, it will speed up a read of the other one. Or am
I mistaken?

If I'm not mistaken, then just finding any file that is mapped to the inode
is sufficient.

The purpose of this is to speed up boot by having portions of the files
being read already in the page cache when they are needed.

-- Steve
