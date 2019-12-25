Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F273912A90E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 20:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLYTjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 14:39:01 -0500
Received: from albireo.enyo.de ([37.24.231.21]:43874 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfLYTjB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 14:39:01 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ikCUh-000786-Vl; Wed, 25 Dec 2019 19:38:55 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1ikCTv-0004Mj-Rz; Wed, 25 Dec 2019 20:38:07 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org,
        musl@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [musl] getdents64 lost direntries with SMB/NFS and buffer size < unknown threshold
References: <20191120001522.GA25139@brightrain.aerifal.cx>
        <8736eiqq1f.fsf@mid.deneb.enyo.de>
        <20191120205913.GD16318@brightrain.aerifal.cx>
        <20191121175418.GI4262@mit.edu>
Date:   Wed, 25 Dec 2019 20:38:07 +0100
In-Reply-To: <20191121175418.GI4262@mit.edu> (Theodore Y. Ts'o's message of
        "Thu, 21 Nov 2019 12:54:18 -0500")
Message-ID: <87a77g2o2o.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Theodore Y. Ts'o:

> On Wed, Nov 20, 2019 at 03:59:13PM -0500, Rich Felker wrote:
>> 
>> POSIX only allows both behaviors (showing or not showing) the entry
>> that was deleted. It does not allow deletion of one entry to cause
>> other entries not to be seen.
>
> Agreed, but POSIX requires this of *readdir*.  POSIX says nothing
> about getdents64(2), which is Linux's internal implementation which is
> exposed to a libc.

Sure, but Linux better provides some reasonable foundation for a libc.

I mean, sure, we can read the entire directory into RAM on the first
readdir, and get a fully conforming implementation this way (and as
Rich noted, glibc's 32 KiB buffer tends to approximate that in
practice).  But that doesn't strike me as particularly useful.

The POSIX requirement is really unfortunate because it leads to
incorrect implementations of rm -rf which would on a compliant system
and fail in practice.

> So we would need to see what is exactly going on at the interfaces
> between the VFS and libc, the nfs client code and the VFS, the nfs
> client code and the nfs server, and possibly the behavior of the nfs
> server.
>
> First of all.... you can't reproduce this on anything other than with
> NFS, correct?  That is, does it show up if you are using ext4, xfs,
> btrfs, etc.?

I'm sure it shows up with certain directory contents on any Linux file
system except for those that happen to have a separate B-tree (or
equivalent) for telldir/seekdir support.  And even those will have
broken corner case in case of billions of directory operations.

32 bits are simply not enough storage space for the cookie.  Hashing
just masks the presence of these bugs, but does not eliminate them
completely.
