Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABB86504C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 22:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiLRVZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 16:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRVZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:25:27 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FD7675;
        Sun, 18 Dec 2022 13:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=u9ME+gslSufltmpu5+rnmYL89CH8VJ/pubMqs7pLZzY=; b=fgc3rAyTaFvonOjoG+WwqUYuoI
        MfX+BYKpljQceMf+4Jb652SuZbT/GI8Lv1pcR9epu7TSDsc/kZimvXRamm1hNbOiqXVbeml5nBxeh
        jZGoPyemsGpdasJHTves0i1exSnV0GP0bTRiTiKT14+kI/tlnoNieeEzchUAnMxlIuOrw7bmAI17B
        +Q04Y+8hKZ65rACFtGjhdGYH9B/exebKUeLVMCTBLRqnLtTu5vUAVoJzghfAD4xCJLaQu7sKX6ecA
        zwzgnIU2TQC4cq3tSS7XLLwIiUWDnLDb7mhSTR/GmbjAhafWSmqZTwQeJrQ6l79PshVx0STBLvSUY
        hame+gTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p719l-00CiFU-0i;
        Sun, 18 Dec 2022 21:25:13 +0000
Date:   Sun, 18 Dec 2022 21:25:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Serge Hallyn <serge@hallyn.com>, Andrey Vagin <avagin@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] nsfs: add compat ioctl handler
Message-ID: <Y5+FOfgNHAnRkE5q@ZenIV>
References: <20221214-nsfs-ioctl-compat-v1-0-b169796000b2@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214-nsfs-ioctl-compat-v1-0-b169796000b2@weissschuh.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 18, 2022 at 09:07:25PM +0000, Thomas Weiﬂschuh wrote:
> As all parameters and return values of the ioctls have the same
> representation on both 32bit and 64bit we can reuse the normal ioctl
> handler for the compat handler.
> 
> All nsfs ioctls return a plain "int" filedescriptor which is a signed
> 4-byte integer type on both 32bit and 64bit.
> The only parameter taken is by NS_GET_OWNER_UID and is a pointer to a
> "uid_t" which is a 4-byte unsigned integer type on both 32bit and 64bit.
> 
> Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
> Reported-By: Karel Zak <kzak@redhat.com>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

NAK.  This is broken on s390; use compat_ptr_ioctl instead.
