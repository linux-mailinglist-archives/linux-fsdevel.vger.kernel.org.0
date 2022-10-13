Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D285FE5FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJMXve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMXve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:51:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B2133303;
        Thu, 13 Oct 2022 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YCYs7tzRYuLz67p2Ln7qVb0EmBKHWMxYVDKxHFDO8Ao=; b=hijUEPoS1GgvVx8YyL9nx0zVN1
        bkFVy4Fm6MBUJWXZd17HDtn2rU0NEhONJPwlJc2Wjfx22xmjX5I3DELQjGLK8C99sS+nMUxPFihXV
        WKwF2TPT3apBJ9emqhSIOG77Rl/bz0CyrYgWzeCkFl//NT6a92H8RfTmML9AS6BwjpX0ijfSv39JR
        /Ld8EwhfIJQKh3cF4BCJ3dEW//2Lr/sLXyVauLH9PhHjhCf4Fv2K5x63MBJIhhUTvyBOkBKgvRoQA
        7fJ+tVb7uEPH1cRq1mXXSeQ+Y4FWVu1Qa2fUhU9na2TrxdX9oTdAJioQHOvwAf0BKizpGxKV93L5R
        J8Z8uNBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oj7z3-00ACKS-2Z;
        Thu, 13 Oct 2022 23:51:25 +0000
Date:   Fri, 14 Oct 2022 00:51:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
Message-ID: <Y0ikfeqm0ASZTR0g@ZenIV>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:27:19PM -0700, Stephen Brennan wrote:

> So I have two more narrowly scoped strategies to improve the situation. Both are
> included in the hacky, awful patch below.
> 
> First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
> is holding the spinlock for several seconds at a time. We can actually achieve
> this via a cursor, the same way that simple_readdir() is implemented. I think
> this might require moving the declaration of d_alloc_cursor() and maybe
> exporting it. I had to #include fs/internal.h which is not ok.

Er...  Won't that expose every filesystem to having to deal with cursors?
Currently it's entirely up to the filesystem in question and I wouldn't
be a dime on everyone being ready to cope with such surprises...
