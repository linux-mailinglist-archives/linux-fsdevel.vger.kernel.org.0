Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8296A250B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHXWQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXWQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:16:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10100C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 15:16:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so5343796pgl.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcuFvZ0Lz8UDFsHCkGBrM5jwXzhDur86Ee/aJP8Lva4=;
        b=cS+B437Ph86aIYmF7XbSd14xQha2uzLvVlcQk3IeammTOY2NfZTkwMv9v9IvAE2+m4
         Ao4ItpoPFsT6ls1uSXt4Iwbl81QWxqdJcrs62vFZgZX6aj1xFkTUOqmP5VgKTpY9myen
         CcaC2vrKTNs0KbIyGiDVhH7YvFqM6ThIq/rIPS7AuI1jnbYJJBU1CmF6lLf4hh7oL9Ge
         tZut4ZSMLHnCRwWFWbBfeH2oc5R0BDQKWPC9hFMMKo8e5kdhOKvTxOTKNVNmVAhhuj8U
         fSJcC5DDsjZQ5RZcLjXubDhRDZhombRCbLGVKZqYXb6ROQCdBz00G4pEbkN0AZqtZlhY
         kF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcuFvZ0Lz8UDFsHCkGBrM5jwXzhDur86Ee/aJP8Lva4=;
        b=EVXkClT6BnJ5iKGEDTtrObLefZzRmouI7o2WfR9npA7zhGYEqZBzwjr9VEGg++iNz2
         4P2YgzMu3rHrOcSzZdBIq7I7Ppwo5jWcJTSSoxul19qeKh0lEBuZm50VH5nkViRgnIAI
         DMLS0A6OAI5cPF/65ws+QS7eQQL8+hRoWZo55yJoqJSjpBLAf662X5TkrrzabSvN4WZj
         JCfggj/1dB347zNYbkp/pv99hrf2QOkjZZCupA47HSk1Cq+IIw8Q6qA91zt9e0EeW3SZ
         cTJIdwNXNF+UAUIDBbEHm4LENd7E3wy5VrKgBf5X07ReCjptSsAjM+yxvLif/1DP3cMF
         XCIw==
X-Gm-Message-State: AOAM531xpxxpeBr1WT6K3k7vbga7LvuQVKLl6dDM63x6ewRaYXdJ3q5f
        2tNMGme2p5LTWQmCUhg/t/VFZuZQDt3hoA==
X-Google-Smtp-Source: ABdhPJx8lyy+LfK/2cr7uek+H12/kTNo1mzKjDV+D8SvUdwnoMs5fkNL5UTr2BwV0eHfXpCJwzNkgw==
X-Received: by 2002:a63:c04c:: with SMTP id z12mr4907014pgi.220.1598307410438;
        Mon, 24 Aug 2020 15:16:50 -0700 (PDT)
Received: from exodia.localdomain ([2601:602:8b80:8e0::c6ee])
        by smtp.gmail.com with ESMTPSA id t10sm965893pfq.52.2020.08.24.15.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:16:48 -0700 (PDT)
Date:   Mon, 24 Aug 2020 15:16:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: implement send/receive of compressed extents
 without decompressing
Message-ID: <20200824221639.GF197795@exodia.localdomain>
References: <cover.1597994106.git.osandov@osandov.com>
 <20200824195754.GQ2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824195754.GQ2026@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:57:55PM +0200, David Sterba wrote:
> On Fri, Aug 21, 2020 at 12:39:50AM -0700, Omar Sandoval wrote:
> > Protocol Updates
> > ================
> > 
> > This series makes some changes to the send stream protocol beyond adding
> > the encoded write command/attributes and bumping the version. Namely, v1
> > has a 64k limit on the size of a write due to the 16-bit attribute
> > length. This is not enough for encoded writes, as compressed extents may
> > be up to 128k and cannot be split up. To address this, the
> > BTRFS_SEND_A_DATA is treated specially in v2: its length is implicitly
> > the remaining length of the command (which has a 32-bit length). This
> > was the last bad of the options I considered.
> > 
> > There are other commands that we've been wanting to add to the protocol:
> > fallocate and FS_IOC_SETFLAGS. This series reserves their command and
> > attribute numbers but does not implement kernel support for emitting
> > them. However, it does implement support in receive for them, so the
> > kernel can start emitting those whenever we get around to implementing
> > them.
> 
> Can you please outline the protocol changes (as a bullet list) and
> eventually cross-ref with items
> https://btrfs.wiki.kernel.org/index.php/Design_notes_on_Send/Receive#Send_stream_v2_draft
> 
> I'd like to know which and why you did not implement. The decision here
> is between get v2 out with most desired options and rev v3 later with
> the rest, or do v2 as complete as possible.

The short version is that I didn't implement the kernel side of any of
those :) the RWF_ENCODED series + this series is already big, and I
didn't want to make it even bigger. I figured updating the
protocol/receive now and doing the kernel side later was a good
compromise (rather than doing a huge code dump or constantly bumping the
protocol version). Is there some reason you don't like this approach?
I'm of course happy to go about this in whatever way you think is best.

Here's a breakdown of the list from the wiki:

* Send extent holes, send preallocated extents: both require fallocate.
  Boris implemented the receive side. I have some old patches
  implementing the send side [1], but they're a largish rework of extent
  tracking in send.
* Extent clones within one file: as far as I can tell, this is already
  possible with v1, it just sends redundant file paths.
* Send otime for inodes: the consensus when I posted patches to enable
  this [2] was that we don't want this after all.
* Send file flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS): again, Boris
  implemented the receive side. I previously took a stab at the send
  side, but it's really annoying because of all of the interactions
  between directory inheritance, writes vs. NOCOW/append-only/immutable,
  etc. It's do-able, it would just take a lot of care.
* Optionally send owner/group as strings: this one I wasn't aware of.
* "block device is not sent over the stream": I don't know what this is
  referring to. It looks like we send block device nodes with mknod.

In my opinion, fallocate support is the most important, SETFLAGS would
be good but is a lot of effort, and the rest are nice-to-have.

Let me know how you'd like me to go about this.

1: https://github.com/osandov/linux/commits/btrfs-send-v2
2: https://lore.kernel.org/linux-btrfs/cover.1550136164.git.osandov@fb.com/
