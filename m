Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC6463A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 16:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhK3Pfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 10:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhK3Pfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:35:33 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B8C061574;
        Tue, 30 Nov 2021 07:32:12 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E0E70A99; Tue, 30 Nov 2021 10:32:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E0E70A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638286331;
        bh=qqABRgVwut/6j2ygnX0Ggz9doH/B2bLsnWU7YYW1h6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgNLGS5Fw5qXpRl69BjETxRHp8DiPxHcWqns+ob44XNqqwW4g81k+htt++H248xqW
         +SzwLeBOHiiOe3Wgaeop46R2vqGpqjCzkFTh2WuxSMneiLyeWMDWyJzeatyLNI4JhQ
         agQeFcZx2nLyy3RyuKK93s1hupSA46GnlDubtQWs=
Date:   Tue, 30 Nov 2021 10:32:11 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211130153211.GB8837@fieldses.org>
References: <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:13:34PM -0800, dai.ngo@oracle.com wrote:
> Just to be clear, the problem of pynfs with 4.0 is that the server takes
> ~55 secs to expire 1026 4.0 courteous clients, which comes out to ~50ms
> per client. This causes the test to time out in waiting for RPC reply of
> the OPEN that triggers the conflicts.
> 
> I don't know exactly where the time spent in the process of expiring a
> client. But as Bruce mentioned, it could be related to the time to access
> /var/lib/nfs to remove the client's persistent record.

Could you try something like

	strace -r -$(pidof) -oTRACE

and maybe we could take a look at TRACE?  My hope would be that there'd
be a clear set of syscalls whose time, multiplied by 1026, explains most
of that 55 seconds.  Then it might be worth checking whether there are
any easy optimizations possible.

--b.
