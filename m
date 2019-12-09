Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87363116BC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLILHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:07:40 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59946 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OYoP1i4HwovCnE2wnjNJwXLk8c3QpAckSchfXMkR8RI=; b=Px7HvpjJ51Kv98Rstl4/Pc/9Y
        GKIsqcSSXccaH3svTu2I1U1OAyHi212IPQWOGCBzi0CYJbxTXo3wy9uh70cNQiW3Yf9i+yIKSEkAP
        8ZjQuZSxUuUZs85WOuMNg6MXbFkNmYy6zeBqXshwqdWetySzrT++qCEqL308/zNNIIXGr7/1fDl6Y
        stuNWU86oxA3w8RoMzRzsMR8zXoi7VIuF9o23qDpHN9Hx68iFTpJ1gGHVhuYO/TQhGzbklHpkm5Pj
        miSMEBk46ec44Ve5Ycu+Knj7LfFdQES0mymh6Lgw4+Q5rozucjnhJvVkaEbqV0ZRj9/w78X2oiS6F
        2BT7sOj6A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46430)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ieGt4-0002S9-3v; Mon, 09 Dec 2019 11:07:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ieGt1-0003Zc-Kh; Mon, 09 Dec 2019 11:07:31 +0000
Date:   Mon, 9 Dec 2019 11:07:31 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/41] fs/adfs updates for 5.6
Message-ID: <20191209110731.GD25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series updates the fs/adfs code in the kernel (which still
has users!)

- update inode timestamps to centisecond resolution time, as per the
  native format.
- consolidate and clean up map scanning code.
- consolidate and clean up and modernise directory handling code.
- restructure directory handling code to better improve the rudimentary
  write support we have.
- fix inode dropping; otherwise updates are lost on umount.
- add support for E and E+ format image files.

Patches based on v5.4; there have been no changes to fs/adfs during the
merge window.

This is also available from:

   git://git.armlinux.org.uk/~rmk/linux-arm.git adfs

with head SHA1 8901af013ecd.

 Documentation/filesystems/adfs.txt |  24 +++
 fs/adfs/adfs.h                     |  32 ++--
 fs/adfs/dir.c                      | 314 +++++++++++++++++++++++++--------
 fs/adfs/dir_f.c                    | 302 +++++++++-----------------------
 fs/adfs/dir_f.h                    |  52 +++---
 fs/adfs/dir_fplus.c                | 345 +++++++++++++++++++++----------------
 fs/adfs/dir_fplus.h                |   6 +-
 fs/adfs/inode.c                    |  64 +++----
 fs/adfs/map.c                      | 247 +++++++++++++++++++-------
 fs/adfs/super.c                    | 267 ++++++++++------------------
 10 files changed, 913 insertions(+), 740 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
