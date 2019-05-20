Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5D2398A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbfETOMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:12:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47682 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfETOMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x/3zdEiUKfOzNRlg6soF5SXj7UrfncvAyrrM45rcNmM=; b=eqbVbK5DE7CZgWXx47Ov8hft6
        oLw7eycFzWUQXGZOyIkFVYdevsNNqxlBmaeGaUZdADtRI43laAhwmT5e+bHQRUvZMN2Wqro1o/8Go
        0oHDNFnGwuwbOWQOfXuiNIAYXD0DNi5k/RIBEJ1ikNYKW9w9QwL/rP3rCGSmhbYMZT4C+kv3w8zEH
        5QMzIyjAn9K6G27cDKvqih1Ho5uU4r+avcPe9Akf8W+S8LSYwZTedCaoqJsAcoNdvKoOZG7G3snb2
        T31AlwAzn7yBYmu2isxSi2bCk84VJLQ5vSi6oP19yKAbp+9njFCwchOTIv0cuKso4jCXJFbKLDT7F
        jIYyF2VEg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38200)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hSj1g-00039d-NH; Mon, 20 May 2019 15:12:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hSj1f-0004yv-Tc; Mon, 20 May 2019 15:12:27 +0100
Date:   Mon, 20 May 2019 15:12:27 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] fs/adfs fixes
Message-ID: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro pointed out that adfs's filename truncation was not correct.

This raised a question about whether to keep fs/adfs support in the
kernel or to remove it - and asking in RISC OS forums for feedback
has shown that there is a desire to keep it.  Even though it has a
number of problems identifyable from code reviews, people do not
appear to notice these issues in practice.

This patch series addresses the filename truncation issue by removing
support for that.  Some opportunities for cleanup and fixing an issue
with filename translation which would result in names such as "." and
".." being generated were spotted, and are included in this patch
series.

There are further patches to come.

 fs/adfs/adfs.h      |  14 +-----
 fs/adfs/dir.c       | 137 ++++++++++++++++++++++++++++------------------------
 fs/adfs/dir_f.c     |  43 +++++------------
 fs/adfs/dir_fplus.c |  24 +--------
 4 files changed, 89 insertions(+), 129 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
