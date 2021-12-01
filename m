Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2B464F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349821AbhLAOWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbhLAOWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:22:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB6C061574;
        Wed,  1 Dec 2021 06:19:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 302451C81; Wed,  1 Dec 2021 09:19:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 302451C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638368362;
        bh=ef0lWJ1KHbkF8kaGqezNMByFapxUluMxd+gu/NTLFkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdApsnCj4gC8WFADuokQBND2GAH8h0WguW1KF8gQHuckhOwxqG6N9iT6ZG4Py4joE
         Yjemr+RceXTxcX4IrgCuA332Iop2CcenLeinQD1Fk6VH/EVGpSC1rrGTG9B0CvlgO1
         6X5WJ2erKOSDwrx5zM1BnXt7je51PKgWGp9AluC8=
Date:   Wed, 1 Dec 2021 09:19:22 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201141922.GA24991@fieldses.org>
References: <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
 <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
 <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
 <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
 <3302102abac40bfbbd861f6ed942b2536db2e59a.camel@hammerspace.com>
 <9cfd81cc-aee9-bcf3-a4be-bb9a39992ae8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfd81cc-aee9-bcf3-a4be-bb9a39992ae8@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:52:10PM -0800, dai.ngo@oracle.com wrote:
> On 11/30/21 5:37 AM, Trond Myklebust wrote:
> >Then kick off a thread or work item to do that asynchronously in the
> >background, and return NFS4ERR_DELAY to the clients that were trying to
> >grab locks in the meantime.
> 
> Thanks Trond, I think this is a reasonable approach. The behavior would
> be similar to a delegation recall during the OPEN.
> 
> My plan is:
> 
> 1. If the number of conflict clients is less than 100 (some numbers that
> cover realistic usage) then release all their state synchronously in
> the OPEN call, and returns NFS4_OK to the NFS client. Most of conflicts
> should be handled by this case.
> 
> 2. If the number of conflict clients is more than 100 then release the
> state of the 1st 100 clients as in (1) and trigger the laundromat thread
> to release state of the rest of the conflict clients, and return
> NFS4ERR_DELAY to the NFS client. This should be a rare condition.

Honestly, conflict with a courtesy client is itself not going to be that
common, so personally I'd start simple and handle everything with the
asynchronous approach.

--b.
