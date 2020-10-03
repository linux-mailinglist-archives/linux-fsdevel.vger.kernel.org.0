Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A2282153
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 06:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJCEtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 00:49:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50776 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCEtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 00:49:18 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934n6HF010588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:49:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D29E842003C; Sat,  3 Oct 2020 00:49:05 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:49:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, dan.j.williams@intel.com,
        anju@linux.vnet.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/1] ext4: Optimize file overwrites
Message-ID: <20201003044905.GF23474@mit.edu>
References: <cover.1600401668.git.riteshh@linux.ibm.com>
 <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e795d8a4d5cd22165c7ebe857ba91d68d8813e.1600401668.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:36:35AM +0530, Ritesh Harjani wrote:
> In case if the file already has underlying blocks/extents allocated
> then we don't need to start a journal txn and can directly return
> the underlying mapping. Currently ext4_iomap_begin() is used by
> both DAX & DIO path. We can check if the write request is an
> overwrite & then directly return the mapping information.
> 
> This could give a significant perf boost for multi-threaded writes
> specially random overwrites.
> On PPC64 VM with simulated pmem(DAX) device, ~10x perf improvement
> could be seen in random writes (overwrite). Also bcoz this optimizes
> away the spinlock contention during jbd2 slab cache allocation
> (jbd2_journal_handle). On x86 VM, ~2x perf improvement was observed.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks, applied.

					- Ted
