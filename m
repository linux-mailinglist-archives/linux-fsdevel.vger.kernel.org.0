Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB334950
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfFDNru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:47:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40186 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TOwZdwxBqBfDN/lQ43D0mDUETM7uWGVdcKmFf0HPVA4=; b=kWjk/FVBhJNS6nGcSZlyP/MJ9
        bAyPveGcWVn7uKLzn6KXAM/dKgFPM5RPgoQK9lzLxCAMaDdWeI7q0pkhg6C3ar2FdJmU4SthBmDGW
        iRGi38nFUoBD3F6C8LWv2xG7WWsLgPX++jyrLfZRA9KIDuenXHe/yHwTezVdWA11vPa8DmJJ+PCvp
        1NAiB21CzC9YC/Gr7Fod603xTVUrmOERIP1Q3jZxxiqTNjMu+lP1ADO5TXBFxNEZx3PMaFpzf+AD0
        k2Txwo/MjzJNI2EF7BHy9tCyIBbX5BcXwK0mozHlnZe2aE+L2W6TicDX7vrQuo/5pVqG5O4Szt3rN
        qnipLj1Aw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56182)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hY9n1-0001aH-3q; Tue, 04 Jun 2019 14:47:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hY9n0-0001YE-Bj; Tue, 04 Jun 2019 14:47:46 +0100
Date:   Tue, 4 Jun 2019 14:47:46 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] fs/adfs: miscellaneous updates
Message-ID: <20190604134746.m7dzefl77ftn4ap2@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

The following patch series brings some updates to ADFS:

- Ensure that there is no padding in the on-disc record structure and
  pack it to ensure correct layout.
- Add helper to retrieve the disc record structure from the first sector
  of the disc map.
- Add helper to get the filesystem size.
- Directly use format_version from the disc record structure rather than
  storing it in our superblock structure.
- Clean up kernel message printing, use %pV to avoid temporary buffers,
  printing fragment ids with six hex digits.
- Ensure superblock flags are always set correctly, even on remounts,
  specifically the noatime and read-only flags.
- Only update superblock flags on remount if we are returning success.
- Fix a potential use-after-free bug while parsing the filesystem
  block size.
- Limit idlen (length of a fragment identifier in the map) according to
  the directory type - only big directories support idlen > 16.
- Add and use some helpers to deal with time stamps and file types.

 fs/adfs/adfs.h               |  70 ++++++++++++++++---------
 fs/adfs/dir.c                |  25 ++++-----
 fs/adfs/dir_f.c              |  38 ++++++--------
 fs/adfs/dir_fplus.c          |  21 ++++----
 fs/adfs/inode.c              |  12 ++---
 fs/adfs/map.c                |  15 ++----
 fs/adfs/super.c              | 121 +++++++++++++++++++++++++------------------
 include/uapi/linux/adfs_fs.h |   6 +--
 8 files changed, 164 insertions(+), 144 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
