Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD92C9289
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 00:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbgK3Xa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 18:30:28 -0500
Received: from sandeen.net ([63.231.237.45]:48778 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388590AbgK3Xa2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:30:28 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 5480911662;
        Mon, 30 Nov 2020 17:29:33 -0600 (CST)
To:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20201125212523.GB14534@magnolia>
 <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
Date:   Mon, 30 Nov 2020 17:29:47 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1942931.1606341048@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25/20 3:50 PM, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
>> mask=1 bit=0: "attribute not set on this file"
>> mask=1 bit=1: "attribute is set on this file"
>> mask=0 bit=0: "attribute doesn't fit into the design of this fs"
> 
> Or is "not supported by the filesystem driver in this kernel version".

For a concrete example, let's talk about the DAX statx attribute.

If the kernel is configured w/o DAX support, should the DAX attr be in the mask?
If the block device has no DAX support, should the DAX attr be in the mask?
If the filesystem is mounted with dax=never, should the DAX attr be in the mask?

About to send a patch for xfs which answers "no" to all of those, but I'm still
not quite sure if that's what's expected.  I'll be sure to cc: dhowells, Ira, and
others who may care...

-Eric

>> mask=0 bit=1: "filesystem is lying snake"
> 
> I like your phrasing :-)
> 
>> It's up to the fs driver and not the vfs to set attributes_mask, and
>> therefore (as I keep pointing out to XiaoLi Feng) xfs_vn_getattr should
>> be setting the mask.
> 
> Agreed.  I think there's some confusion stemming from STATX_ATTR_MOUNT_ROOT -
> but that's supported by the *vfs* not by the filesystem.
> 
> David
> 
