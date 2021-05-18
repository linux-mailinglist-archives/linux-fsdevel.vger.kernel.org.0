Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107433875F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbhERKE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347680AbhERKE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:04:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112FC061573;
        Tue, 18 May 2021 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xbxQ7LflgvywD0uq2+jWyofzThk1Q3xiYg3qZ0VHMnQ=; b=Fd/X1Lue1feIdaCIJ/F9pJM4W
        aHDrQfIGkftvyaxgcswhtDvYDJvbovHuksw6PRa4zLWFAwG7RcyU5QgI8v6d05hpDe89xGMB2d4aZ
        IE/Odo6u7q8iUyq6upTArt5DXsrlMjY41xFIOn1zJQy1UucRtYzS51o73HxLkfhEmqJNObj4R/QVL
        lBnbTVBeOXJQl7Q1Zdy+RGn0dJhwrhav1O2Vs5dOW+a67jxUT3sHAFaEeJ/M1EvbVYPi6C4XHTiyB
        qTTrFfHgZWbnvLCvcUeZ8w9Uegkm0zbcMbF6k6mnW+HpLf11Z1lvqoFMjIFdI7v7wU48YkT7m1wwG
        +7waiIxvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44124)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1liwZA-00041w-6W; Tue, 18 May 2021 11:03:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1liwZ8-0007nC-So; Tue, 18 May 2021 11:03:06 +0100
Date:   Tue, 18 May 2021 11:03:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Subject: Re: Fwd: [EXTERNAL] Re: ioctl.c:undefined reference to
 `__get_user_bad'
Message-ID: <20210518100306.GS12395@shell.armlinux.org.uk>
References: <202105110829.MHq04tJz-lkp@intel.com>
 <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
 <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
 <d3e24342-4f30-6a2f-3617-a917539eac94@infradead.org>
 <5b29fe73-7c95-0b9f-3154-c053fa94cb67@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b29fe73-7c95-0b9f-3154-c053fa94cb67@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 02:06:33PM -0700, Randy Dunlap wrote:
> [adding back linux-arm-kernel; what happened to it? ]

Nothing. I'm not interested in trying to do major disgusting
contortions to make get_user() work for 8-byte values. If someone
else wants to put the effort in and come up with an elegant solution
that doesn't add warnings over the rest of the kernel, that's fine.

As far as I remember, everything in __get_user_err() relies on
__gu_val _not_ being 64-bit. If we use the same trick that we do
in __get_user_check():

	__inttype(x) __gu_val = (x);

then if get_user() is called with a 64-bit integer value and a
pointer-to-32-bit location to fetch from, we'd end up passing a
64-bit integer into the __get_user_asm() which could access the
wrong 32-bit half of the value in BE mode. Similar issue with
64-bit vs pointer-to-16-bit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
