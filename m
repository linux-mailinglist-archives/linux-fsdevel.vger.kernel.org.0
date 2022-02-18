Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B44BB1C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 07:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiBRGD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 01:03:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBRGDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:03:53 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B77F15A0B;
        Thu, 17 Feb 2022 22:03:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21I63DM2027234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 01:03:14 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 495C915C34C8; Fri, 18 Feb 2022 01:03:13 -0500 (EST)
Date:   Fri, 18 Feb 2022 01:03:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Yg82oSHmodFHMHHI@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yg8KZvDVFJgTXm4C@mit.edu>
 <Yg8fdCuE6RusrjIh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg8fdCuE6RusrjIh@casper.infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:24:20AM +0000, Matthew Wilcox wrote:
> On Thu, Feb 17, 2022 at 09:54:30PM -0500, Theodore Ts'o wrote:
> > process_vm_writev() uses [un]pin_user_pages_remote() which is the same
> > interface uses for RDMA.  But it's not clear this is ever supposed to
> > work for memory which is mmap'ed region backed by a file.
> > pin_user_pages_remote() appears to assume that it is an anonymous
> > region, since the get_user_pages functions in mm/gup.c don't call
> > read_page() to read data into any pages that might not be mmaped in.
> 
> ... it doesn't end up calling handle_mm_fault() in faultin_page()?

Ah yes, sorry, I missed that.  This is what happens when a syzbot bug
is thrown to a file system developer, who then has to wade theough
mm code for which he is not understand....

	   	    	     	    - Ted
			    
