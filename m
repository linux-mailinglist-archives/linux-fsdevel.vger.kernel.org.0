Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17A53B77E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 20:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhF2Sf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhF2Sf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:35:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA1EC061760;
        Tue, 29 Jun 2021 11:32:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0034C478E; Tue, 29 Jun 2021 14:32:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0034C478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624991578;
        bh=oYKACCqdjAYqAB4CvyR4NHowPlIjpAPhb05W7zkPQug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx4efYnBjk2atut7H+lbKtg4hH+Qmk+jB7SYAjNOy3ENbLvUehisuzG/87ajsGwHi
         Ueozy011i1LJVVIp49hA8gQ8roLXhw1tOZ/z6vSPIBC4I6IQxtNf482E4TFsKl6qU1
         KiTuiYhOdllcH8xQifbH34upUgFyX8GnOJqZquy0=
Date:   Tue, 29 Jun 2021 14:32:57 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: automatic freeing of space on ENOSPC
Message-ID: <20210629183257.GA1926@fieldses.org>
References: <20210628194908.GB6776@fieldses.org>
 <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>
 <20210629011200.GA14733@fieldses.org>
 <162493102550.7211.15170485925982544813@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162493102550.7211.15170485925982544813@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:43:45AM +1000, NeilBrown wrote:
> I wonder how important this is.  If an NFS client unlinks a file that it
> has open, it will be silly_renamed, and if the client then goes silent,
> it might never be removed.  So we already theoretically have a
> possibilty of ENOSPC due to silent clients.  Have we heard of this
> becoming a problem?

Oh, that's a good point.  I've seen complaints about sillyrename files,
but I can't recall ever seen a single complaint about their causing
ENOSPC.

> Is there reason to think that the Courteous server changes will make
> this problem more likely? 

So I guess the only new cases the courteous server will introduce are
even less likely (probably just the case where a file is unlinked by a
client other than the one that has it open).

So I think doing nothing for now is an acceptable alternative....

--b.
