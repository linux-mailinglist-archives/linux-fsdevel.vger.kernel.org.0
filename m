Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26445A35A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiH0HiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiH0HiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB866BE4F9;
        Sat, 27 Aug 2022 00:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919FE6124B;
        Sat, 27 Aug 2022 07:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3BFC433D6;
        Sat, 27 Aug 2022 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661585885;
        bh=GrLWDELw8iNQBvqWXRuHF3mbjI0n7VONQg20yLpPTJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8Y9W1IeIRXUWuiRhDe4zsq0+Lx90n+UBgJaf5l/k6EqIHLSaHo3X5w33v8O50NKQ
         uGYClNDLZB3iFyzjkcmSIYsULUIcmUqlkUYqGMn7g3nia+uPEmABSzOXSkrcx7NlA4
         5EEbKGiH+z9twqLKry4/Z8ds3s0wlNs+/oEw1AHc=
Date:   Sat, 27 Aug 2022 09:38:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Colin Walters <walters@verbum.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
Message-ID: <YwnJ6nieMHHFHqZg@kroah.com>
References: <20220819115641.14744-1-jlayton@kernel.org>
 <20220823215333.GC3144495@dread.disaster.area>
 <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:48:02PM -0400, Colin Walters wrote:
> 
> 
> On Tue, Aug 23, 2022, at 5:53 PM, Dave Chinner wrote:
> > 
> > THere's no definition of what consitutes an "inode change" and this
> > exposes internal filesystem implementation details (i.e. on disk
> > format behaviour) directly to userspace. That means when the
> > internal filesystem behaviour changes, userspace applications will
> > see changes in stat->ino_version changes and potentially break them.
> 
> As a userspace developer (ostree, etc. who is definitely interested in this functionality) I do agree with this concern; but a random drive by comment: would it be helpful to expose iversion (or other bits like this from the vfs) via e.g. debugfs to start?  I think that'd unblock writing fstests in the short term right?
> 
> 

This would not work at all for "virtual" filesystems like debugfs and
sysfs which only create the data when the file is read, and there's no
way to know if the data is going to be different than the last time it
was read, sorry.

greg k-h
