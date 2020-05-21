Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622FB1DD5EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgEUS06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 14:26:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45649 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728240AbgEUS06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 14:26:58 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04LIQocA007023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 14:26:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2CF13420304; Thu, 21 May 2020 14:26:50 -0400 (EDT)
Date:   Thu, 21 May 2020 14:26:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC 16/16] ext4: Add process name and pid in ext4_msg()
Message-ID: <20200521182650.GC2946569@mit.edu>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
 <3d99e1291b3bc8f2a78467d11b1a7a31393180fc.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d99e1291b3bc8f2a78467d11b1a7a31393180fc.1589086800.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 11:54:56AM +0530, Ritesh Harjani wrote:
> This adds process name and pid for ext4_msg().
> I found this to be useful. For e.g. below print gives more
> info about process name and pid.
> 
> [ 7671.131912]  [mount/12543] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr

I'm not entirely sure about adding the command/pid at the beginning of
the message.  The way we do this in ext4_warning and ext4_err is to
print that information like this:

		printk(KERN_CRIT
		       "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
		       sb->s_id, function, line, current->comm, &vaf);

... and I wonder if it would make more sense to add something like to
ext4_msg(), just out of consistency's sake.  Which of the debugging
messages were you finding this to be most helpful?

	      	  	       	     - Ted
