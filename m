Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180DF4C22DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 05:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiBXEFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 23:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiBXEFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:05:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28EC1693BE;
        Wed, 23 Feb 2022 20:04:55 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21O44Yce006899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 23:04:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A71A15C0036; Wed, 23 Feb 2022 23:04:34 -0500 (EST)
Date:   Wed, 23 Feb 2022 23:04:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <YhcD0ugEyDMi4wXO@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <7bd88058-2a9a-92a6-2280-43c805b516c3@nvidia.com>
 <YhbD1T7qhgnz4myM@mit.edu>
 <d75891d6-4c2e-57bc-f840-9d8d5449628a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75891d6-4c2e-57bc-f840-9d8d5449628a@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:44:07PM -0800, John Hubbard wrote:
> 
> Actually...I can confirm that real customers really are doing *exactly* 
> that! Despite the kernel crashes--because the crashes don't always 
> happen unless you have a large (supercomputer-sized) installation. And 
> even then it is not always root-caused properly.

Interesting.  The syzbot reproducer triggers *reliably* on ext4 using
a 2 CPU qemu kernel running on a laptop, and it doesn't require root,
so it's reasonable that Lee is pushing for a fix --- even if for the
Android O or newer, Seccomp can probably prohibit trap
process_vm_writev(2), but it seems unfortunate if say, someone running
a Docker container could take down the entire host OS.

  	 	   	      	       	      - Ted
