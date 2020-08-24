Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81E2509AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHXT7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 15:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHXT7F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9DEDAC12;
        Mon, 24 Aug 2020 19:59:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72209DA730; Mon, 24 Aug 2020 21:57:55 +0200 (CEST)
Date:   Mon, 24 Aug 2020 21:57:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: implement send/receive of compressed extents
 without decompressing
Message-ID: <20200824195754.GQ2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:39:50AM -0700, Omar Sandoval wrote:
> Protocol Updates
> ================
> 
> This series makes some changes to the send stream protocol beyond adding
> the encoded write command/attributes and bumping the version. Namely, v1
> has a 64k limit on the size of a write due to the 16-bit attribute
> length. This is not enough for encoded writes, as compressed extents may
> be up to 128k and cannot be split up. To address this, the
> BTRFS_SEND_A_DATA is treated specially in v2: its length is implicitly
> the remaining length of the command (which has a 32-bit length). This
> was the last bad of the options I considered.
> 
> There are other commands that we've been wanting to add to the protocol:
> fallocate and FS_IOC_SETFLAGS. This series reserves their command and
> attribute numbers but does not implement kernel support for emitting
> them. However, it does implement support in receive for them, so the
> kernel can start emitting those whenever we get around to implementing
> them.

Can you please outline the protocol changes (as a bullet list) and
eventually cross-ref with items
https://btrfs.wiki.kernel.org/index.php/Design_notes_on_Send/Receive#Send_stream_v2_draft

I'd like to know which and why you did not implement. The decision here
is between get v2 out with most desired options and rev v3 later with
the rest, or do v2 as complete as possible.
