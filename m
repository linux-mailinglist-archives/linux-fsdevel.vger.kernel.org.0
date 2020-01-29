Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A114D2E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2WPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 17:15:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55331 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726222AbgA2WPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:15:46 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00TMFcLC027980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 17:15:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 084F9420324; Wed, 29 Jan 2020 17:15:46 -0500 (EST)
Date:   Wed, 29 Jan 2020 17:15:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH RFC] ext4: skip concurrent inode updates in lazytime
 optimization
Message-ID: <20200129221546.GB303030@mit.edu>
References: <158031264567.6836.126132376018905207.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158031264567.6836.126132376018905207.stgit@buzz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 06:44:05PM +0300, Konstantin Khlebnikov wrote:
> Function ext4_update_other_inodes_time() implements optimization which
> opportunistically updates times for inodes within same inode table block.
> 
> For now	concurrent inode lookup by number does not scale well because
> inode hash table is protected with single spinlock. It could become very
> hot at concurrent writes to fast nvme when inode cache has enough inodes.
> 
> Probably someday inode hash will become searchable under RCU.
> (see linked patchset by David Howells)
> 
> Let's skip concurrent updates instead of wasting cpu time at spinlock.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: https://lore.kernel.org/lkml/155620449631.4720.8762546550728087460.stgit@warthog.procyon.org.uk/

Hmm.... I wonder what Al thinks of adding a varaint of
find_inode_nowait() which uses tries to grab the inode_hash_lock()
using a trylock, and returns ERR_PTR(-EAGAIN) if the attempt to grab
the lock fails.

This might be better since it will prevent other conflicts between
ext4_update_other_inodes_time() and other attempts to lookup inodes
which can't be skipped if things are busy.

      	       	       	  	     - Ted
