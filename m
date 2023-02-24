Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3A6A144B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 01:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBXA0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 19:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBXA0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:26:35 -0500
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 16:26:34 PST
Received: from out-16.mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378934DE13
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 16:26:33 -0800 (PST)
Date:   Thu, 23 Feb 2023 19:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677197964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6REC/wJsss8hwTL6+ixMar8Dv+b0M+/eEfw/IWUo6k=;
        b=HNvF/2YjjAWo0fM5BqS/BWjFxXkAl+R6eV6A9jkUYn8LxSIDofHrXEnYSu/jeDBYmPgCOe
        3wdPRZ8vNS2APcKr9uzFVPElFdoWT/3zFmD7meNSdptsRxAkmG6bvXLRzEzkDH9EC9fF9E
        bffJUyAfQced76+6RObAM96G/V+7bR0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <Y/gCiDAGTUFw+u5q@moria.home.lan>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117214457.GG360264@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:44:57AM +1100, Dave Chinner wrote:
> XFS just has a function that allows for an arbitrary number of
> inodes to be locked in the given order: xfs_lock_inodes(). For
> rename, the lock order is determined by xfs_sort_for_rename().

bcachefs does the same thing - we just sort and dedup the inodes being
locked, lock order is always pointer ordering.

Is there some reason we couldn't do the same for inode locks? Then
pointer order would be the only lock ordering, no child/descendent
stuff.

On a related note, I also just sent Peter Zijlstra a lockdep patch so
that we can define an ordering within a class - soon we'll be able to
have lockdep check that we're taking locks in pointer order, or whatever
ordering we decide.
