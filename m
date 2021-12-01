Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF54654B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhLASHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 13:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhLASHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:07:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FBC061574;
        Wed,  1 Dec 2021 10:03:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9076A25FE; Wed,  1 Dec 2021 13:03:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9076A25FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638381819;
        bh=zER2IUweY2n14zFE8qZhCgF7nM1+aBTmNnBYqO6qWRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcX4eixwfn257cIkGGn4U406GiI4h5R+rG5z045Yh2tYQqXmoyjavZbcdMchVDsCZ
         9gtA0U45rloKKmC1awedS4grpgBombGUHzMpcTkik51yCXzfFIxBHgrBZM7MBtq7ch
         RyBg51rE6bEvOu1De071PySnO6cb6QCQgEo3ERnk=
Date:   Wed, 1 Dec 2021 13:03:39 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201180339.GC26415@fieldses.org>
References: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201174205.GB26415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:42:05PM -0500, Bruce Fields wrote:
> On Wed, Dec 01, 2021 at 09:36:30AM -0500, Bruce Fields wrote:
> > OK, good to know.  It'd be interesting to dig into where nfsdcltrack is
> > spending its time, which we could do by replacing it with a wrapper that
> > runs the real nfsdcltrack under strace.
> > 
> > Though maybe it'd be better to do this on a system using nfsdcld, since
> > that's what we're transitioning to.
> 
> Trying that on a test VM here, I see each upcall doing 3 fdatasyncs() of
> an sqlite-journal file.  On my setup, each of those is taking a few
> milliseconds.  I wonder if it an do better.

If I understand the sqlite documentation correctly, I *think* that if we
use journal_mode WAL with synchronous FULL, we should get the assurances
nfsd needs with one sync per transaction.

--b.
