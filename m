Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7606A4CE8B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 05:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiCFETe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 23:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiCFETd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 23:19:33 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32CC51E60;
        Sat,  5 Mar 2022 20:18:41 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2264IY0Z012994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Mar 2022 23:18:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2650C15C0038; Sat,  5 Mar 2022 23:18:34 -0500 (EST)
Date:   Sat, 5 Mar 2022 23:18:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Generic per-sb io stats
Message-ID: <YiQ2Gi8umX9LQBWr@mit.edu>
References: <20220305160424.1040102-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305160424.1040102-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 06:04:15PM +0200, Amir Goldstein wrote:
> 
> Dave Chinner asked why the io stats should not be enabled for all
> filesystems.  That change seems too bold for me so instead, I included
> an extra patch to auto-enable per-sb io stats for blockdev filesystems.

Perhaps something to consider is allowing users to be able to enable
or disable I/O stats on per mount basis?

Consider if a potential future user of this feature has servers with
one or two 256-core AMD Epyc chip, and suppose that they have a
several thousand iSCSI mounted file systems containing various
software packages for use by Kubernetes jobs.  (Or even several
thousand mounted overlay file systems.....)

The size of the percpu counter is going to be *big* on a large CPU
count machine, and the iostats structure has 5 of these per-cpu
counters, so if you have one for every single mounted file system,
even if the CPU slowdown isn't significant, the non-swappable kernel
memory overhead might be quite large.

So maybe a VFS-level mount option, say, "iostats" and "noiostats", and
some kind of global option indicating whether the default should be
iostats being enabled or disabled?  Bonus points if iostats can be
enabled or disabled after the initial mount via remount operation.

I could imagine some people only being interested to enable iostats on
certain file systems, or certain classes of block devices --- so they
might want it enabled on some ext4 file systems which are attached to
physical devices, but not on the N thousand iSCSI or nbd mounts that
are also happen to be using ext4.

Cheers,

						- Ted
