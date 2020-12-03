Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C432CDCDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgLCR4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 12:56:32 -0500
Received: from sandeen.net ([63.231.237.45]:44968 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLCR4c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:56:32 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 306A17906;
        Thu,  3 Dec 2020 11:55:32 -0600 (CST)
To:     Christoph Hellwig <hch@lst.de>, ira.weiny@intel.com
Cc:     fstests@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <20201202214145.1563433-1-ira.weiny@intel.com>
 <20201203081556.GA15306@lst.de>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] common/rc: Fix _check_s_dax()
Message-ID: <b757842d-b020-49c9-498c-df5de89f10af@sandeen.net>
Date:   Thu, 3 Dec 2020 11:55:50 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203081556.GA15306@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/3/20 2:15 AM, Christoph Hellwig wrote:
> On Wed, Dec 02, 2020 at 01:41:45PM -0800, ira.weiny@intel.com wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> There is a conflict with the user visible statx bits 'mount root' and
>> 'dax'.  The kernel is changing the dax bit to correct this conflict.[1]
>>
>> Adjust _check_s_dax() to use the new bit.  Because DAX tests do not run
>> on root mounts, STATX_ATTR_MOUNT_ROOT should always be 0, therefore we
>> can allow either bit to indicate DAX and cover any kernel which may be
>> running.
>>
>> [1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/
>>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>
>> I went ahead and used Christoph's suggestion regarding using both bits.
> 
> That wasn't my suggestion.  I think we should always error out when
> the bit value shared with STATX_ATTR_MOUNT_ROOT is seen.  Because that
> means the kernel is not using or fixed ABI we agreed to use going
> forward.

*nod* and my suggestion was to explicitly test for the old/wrong value and
offer the test-runner a hint about why it may have been set (missing the
fix commit), but we should still ultimately fail the test when it is seen.

-Eric
