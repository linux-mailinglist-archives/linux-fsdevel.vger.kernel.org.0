Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF24E5CEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 02:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbiCXBuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 21:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiCXBuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:50:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8C2B1BF;
        Wed, 23 Mar 2022 18:48:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22O1lwh9019980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 21:47:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 71AB615C0038; Wed, 23 Mar 2022 21:47:58 -0400 (EDT)
Date:   Wed, 23 Mar 2022 21:47:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <YjvNzvdcagflTejJ@mit.edu>
References: <20220317234827.447799-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> 
> The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> but I'd like to hear some comments before doing that.

Adding a hard-coded call to khugepage_enter_file() in ext4 and xfs,
and potentially, each file system, seems kludgy as all heck.  Is there
any reason not to simply call it in the mm code which calls f_op->mmap()?

    	       	  	      	 - Ted
