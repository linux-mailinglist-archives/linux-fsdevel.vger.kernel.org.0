Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE06D10DEC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK3TDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:03:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53969 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbfK3TDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:03:05 -0500
Received: from callcc.thunk.org (ip-64-134-102-67.public.wayport.net [64.134.102.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAUJ2tch026831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Nov 2019 14:02:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 07A86421A48; Sat, 30 Nov 2019 12:50:47 -0500 (EST)
Date:   Sat, 30 Nov 2019 12:50:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daniel Phillips <daniel@phunq.net>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <20191130175046.GA6655@mit.edu>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 08:27:59PM -0800, Daniel Phillips wrote:
> You are right that Shardmap also must update the shard fifo tail block,
> however there is only one index shard up to 64K entries, so all the new
> index entries go into the same tail block(s).

So how big is an index shard?  If it is 64k entries, and each entry is
16 bytes (8 bytes hash, 8 bytes block number), then a shard is a
megabyte, right?  Are entries in an index shard stored in sorted or
unsorted manner?  If they are stored in an unsorted manner, then when
trying to do a lookup, you need to search all of the index shard ---
which means for a directory that is being frequently accessed, the
entire index shard has to be kept in memory, no?  (Or paged in as
necessary, if you are using mmap in userspace).

> Important example: how is atomic directory commit going to work for
> Ext4?

The same way all metadata updates work in ext4.  Which is to say, you
need to declare the maximum number of 4k metadata blocks that an
operation might need to change when calling ext4_journal_start() to
create a handle; and before modifying a 4k block, you need to call
ext4_journal_get_write_access(), passing in the handle and the block's
buffer_head.  After modifying the block, you must call
ext4_handle_dirty_metadata() on the buffer_head.  And when you are
doing with the changes in an atomic metadata operation, you call
ext4_journal_stop() on the handle.

This hasn't changed since the days of ext3 and htree.

     	    	    	      	      	   - Ted
