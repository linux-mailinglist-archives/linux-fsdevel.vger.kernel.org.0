Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69C4C1FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 00:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiBWXjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244970AbiBWXjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:39:15 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A85B3E1;
        Wed, 23 Feb 2022 15:38:13 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21NNZsRH024029
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 18:35:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0E27A15C0036; Wed, 23 Feb 2022 18:35:54 -0500 (EST)
Date:   Wed, 23 Feb 2022 18:35:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <YhbE2nocBMtLc27C@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <Yg9QGm2Rygrv+lMj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg9QGm2Rygrv+lMj@kroah.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:51:54AM +0100, Greg Kroah-Hartman wrote:
> > The challenge is that fixing this "the right away" is probably not
> > something we can backport into an LTS kernel, whether it's 5.15 or
> > 5.10... or 4.19.
> 
> Don't worry about stable backports to start with.  Do it the "right way"
> first and then we can consider if it needs to be backported or not.

Fair enough; on the other hand, we could also view this as making ext4
more robust against buggy code in other subsystems, and while other
file systems may be losing user data if they are actually trying to do
remote memory access to file-backed memory, apparently other file
systems aren't noticing and so they're not crashing.  Issuing a
warning and then not crashing is arguably a better way for ext4 to
react, especially if there are other parts of the kernel that are
randomly calling set_page_dirty() on file-backed memory without
properly first informing the file system in a context where it can
block and potentially do I/O to do things like allocate blocks.

      	  	      	     	      	 - Ted
