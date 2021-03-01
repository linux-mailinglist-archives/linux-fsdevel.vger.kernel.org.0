Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C38328D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhCATGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 14:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhCATEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:04:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F6C061756;
        Mon,  1 Mar 2021 11:03:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1177725FE; Mon,  1 Mar 2021 14:02:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1177725FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614625379;
        bh=mxaTekYNEqDdiYO9bMH3o6RRL26uXiJHF5SOuD+r1Sc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=fWmjUM4x73v2iYzV6qOdYURZOkzE7G3TZ5AsCJrbp49BX7PtAKjVHoknZLjDHApgr
         lmIGmjISuJGcvyJsNAVtcGj/jwYrriVsJfinvv/u6DFiTgPnhHl2CidBkMx5DGUkxO
         xtbRF3uSxFKFU2yI0EwnZHjydFlEI6gaxHZNK770=
Date:   Mon, 1 Mar 2021 14:02:59 -0500
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210301190259.GC14881@fieldses.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk>
 <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
 <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 02:58:22AM +0000, Al Viro wrote:
> TBH, I don't understand what are you trying to achieve -
> what will that mkdir+open combination buy you, especially
> since that atomicity goes straight out of window if you try
> to use that on e.g. NFS.  How is the userland supposed to make
> use of that thing?

For what it's worth, the RPC that creates a directory can also get a
filehandle of the new directory, so I don't think there's anything in
the NFS protocol that would *prevent* implementing this.  (Whether
that's useful, I don't know.)

--b.
