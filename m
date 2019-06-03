Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3135332DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 12:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfFCKdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 06:33:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfFCKdi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:33:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AC133B6A349DDDE4E72;
        Mon,  3 Jun 2019 18:33:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 18:33:31 +0800
Subject: Re: [PATCH v3 1/4] f2fs: Lower threshold for disable_cp_again
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-team@android.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-2-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1246dcc9-800a-ef0e-7cd0-199a0a6d77d4@huawei.com>
Date:   Mon, 3 Jun 2019 18:33:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530004906.261170-2-drosen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/30 8:49, Daniel Rosenberg wrote:
> The existing threshold for allowable holes at checkpoint=disable time is
> too high. The OVP space contains reserved segments, which are always in
> the form of free segments. These must be subtracted from the OVP value.
> 
> The current threshold is meant to be the maximum value of holes of a
> single type we can have and still guarantee that we can fill the disk
> without failing to find space for a block of a given type.
> 
> If the disk is full, ignoring current reserved, which only helps us,
> the amount of unused blocks is equal to the OVP area. Of that, there
> are reserved segments, which must be free segments, and the rest of the
> ovp area, which can come from either free segments or holes. The maximum
> possible amount of holes is OVP-reserved.
> 
> Now, consider the disk when mounting with checkpoint=disable.
> We must be able to fill all available free space with either data or
> node blocks. When we start with checkpoint=disable, holes are locked to
> their current type. Say we have H of one type of hole, and H+X of the
> other. We can fill H of that space with arbitrary typed blocks via SSR.
> For the remaining H+X blocks, we may not have any of a given block type
> left at all. For instance, if we were to fill the disk entirely with
> blocks of the type with fewer holes, the H+X blocks of the opposite type
> would not be used. If H+X > OVP-reserved, there would be more holes than
> could possibly exist, and we would have failed to find a suitable block
> earlier on, leading to a crash in update_sit_entry.
> 
> If H+X <= OVP-reserved, then the holes end up effectively masked by the OVP
> region in this case.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
