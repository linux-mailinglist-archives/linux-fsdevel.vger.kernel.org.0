Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0520B465014
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbhLAOm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350832AbhLAOkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:40:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19BC061A24;
        Wed,  1 Dec 2021 06:36:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DF7FB6EAA; Wed,  1 Dec 2021 09:36:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DF7FB6EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638369390;
        bh=Mi0YTO7jXgCawJ7A8Jk1KSYKuu3ECxMFpM2C6z6a15A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go7WszeALwRwDlQdqEtszjJFYo/x/+2Qp5ETJRTM46/nVVVSLUxojtjlLLiAcJ7ze
         M3s2doR1u2SPdHAI3kKKQL0tfqLUHGLKvtx70fubqBerWYMi42G15dsynT2RGKZa84
         BKDZibznWoTk/klGK0oxyP+TwYcGzb1dCN/vXP2c=
Date:   Wed, 1 Dec 2021 09:36:30 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201143630.GB24991@fieldses.org>
References: <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:50:13PM -0800, dai.ngo@oracle.com wrote:
> 
> On 11/30/21 7:32 AM, Bruce Fields wrote:
> >On Mon, Nov 29, 2021 at 11:13:34PM -0800, dai.ngo@oracle.com wrote:
> >>Just to be clear, the problem of pynfs with 4.0 is that the server takes
> >>~55 secs to expire 1026 4.0 courteous clients, which comes out to ~50ms
> >>per client. This causes the test to time out in waiting for RPC reply of
> >>the OPEN that triggers the conflicts.
> >>
> >>I don't know exactly where the time spent in the process of expiring a
> >>client. But as Bruce mentioned, it could be related to the time to access
> >>/var/lib/nfs to remove the client's persistent record.
> >Could you try something like
> >
> >	strace -r -$(pidof) -oTRACE

Oops, I mean $(pidof nfsdcld).  But, your system isn't using that:

> 
> Strace does not have any info that shows where the server spent time when
> expiring client state. The client record is removed by nfsd4_umh_cltrack_remove
> doing upcall to user space helper /sbin/nfsdcltrack to do the job.  I used
> the low-tech debug tool, printk, to measure the time spent by
> nfsd4_client_record_remove. Here is a sample of the output, START and END
> are in milliseconds:
> 
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d418] clp[ffff888119206040] client_tracking_ops[ffffffffa04bc2e0]
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d459] clp[ffff888119206040] client_tracking_ops[ffffffffa04bc2e0]
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d461] clp[ffff888119206740] client_tracking_ops[ffffffffa04bc2e0]
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d48e] clp[ffff888119206740] client_tracking_ops[ffffffffa04bc2e0]
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d49c] clp[ffff88811b54e000] client_tracking_ops[ffffffffa04bc2e0]
> Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d4c5] clp[ffff88811b54e000] client_tracking_ops[ffffffffa04bc2e0]
> 
> The average time spent to remove the client record is about ~50ms, matches
> with the time reported by pynfs test. This confirms what Bruce suspected
> earlier.

OK, good to know.  It'd be interesting to dig into where nfsdcltrack is
spending its time, which we could do by replacing it with a wrapper that
runs the real nfsdcltrack under strace.

Though maybe it'd be better to do this on a system using nfsdcld, since
that's what we're transitioning to.

--b.
