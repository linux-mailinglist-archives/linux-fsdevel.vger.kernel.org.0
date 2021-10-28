Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635443E619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJ1Qbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 12:31:37 -0400
Received: from sandeen.net ([63.231.237.45]:35518 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhJ1Qbg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:31:36 -0400
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 02EA078D2;
        Thu, 28 Oct 2021 11:27:41 -0500 (CDT)
Message-ID: <ef95af19-4b0a-61e8-5dfa-3e223118da8e@sandeen.net>
Date:   Thu, 28 Oct 2021 11:29:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia> <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026223317.GB5111@dread.disaster.area> <YXlQyMfXDQnO/5E3@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
In-Reply-To: <YXlQyMfXDQnO/5E3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/27/21 8:14 AM, Vivek Goyal wrote:
> On Wed, Oct 27, 2021 at 09:33:17AM +1100, Dave Chinner wrote:

...

> Hi Dave,
> 
> Thanks for all the explanaiton and background. It helps me a lot in
> wrapping my head around the rationale for current design.
> 
>> It's perfectly reasonable. If the hardware doesn't support DAX, then
>> we just always behave as if dax=never is set.
> 
> I tried mounting non-DAX block device with dax=always and it failed
> saying DAX can't be used with reflink.
> 
> [  100.371978] XFS (vdb): DAX unsupported by block device. Turning off DAX.
> [  100.374185] XFS (vdb): DAX and reflink cannot be used together!
> 
> So looks like first check tried to fallback to dax=never as device does
> not support DAX. But later reflink check thought dax is enabled and
> did not fallback to dax=never.

We need to think hard about this stuff and audit it to be sure.

But, I think that reflink check should probably just be removed, now that
DAX files and reflinked files can co-exist on a filesystem - it's just
that they can't both be active on the /same file/.

I think that even "dax=always" is still just "advisory" - it means,
try to enable dax on every file. It may still fail in the same ways as
dax=inode (default) + flag set may fail.

But ... we should go through the whole mount option / feature set /
device capability logic to be sure this is all consistent. Thanks for
pointing it out!

-Eric

>> IO
