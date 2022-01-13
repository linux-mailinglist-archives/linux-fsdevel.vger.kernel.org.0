Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8448D27E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 07:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiAMGzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 01:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiAMGzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:55:17 -0500
X-Greylist: delayed 1439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 22:55:16 PST
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9BC06173F;
        Wed, 12 Jan 2022 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=nj5k3mlsUDDGuLxVB3qEkpQFS6rGFoeOraW+MaiB/Xo=; b=gBSu931hJouc0xwpLTHSdQgfFc
        2Uf3gAhZOCeTpcRU4tAg5rAp1APUp8FiLsMFus94HYwJG14n3Jh151WGaKmJ3P+cshZ4k3GZQBCRK
        hFmcTI4qMRoeUrdlGtPeF2U0DqRW/g0aPINmwSlHPbhXhneo6rfntXcGU313ITFsWDW2hRZ083c5R
        MqL4joDYnmkh8Teg4NSCmhd9Cvp+PDXVLm89lh7zrg0G7fLSjUWSW6hVw5uohPUAFfrDsKMUbd+CQ
        5q0mRSHmZsTp2bV8+UzXAUS8NRBaxIagoDhZ50huS8sxoR7uhVPqQczFZafIGZHFgrJAlVVQeg0Ae
        Rt/uXjyXj65Mv7ZpZNGccO8PkIUi5vY/tJVOpe7hLd99EneFehypO/FSXWI+h6ivwWo2IlQZHVvEK
        ERGc9exCYndN0oauBfMpUmBfE2gS4H3F5mH9qB3hibrLV2PJzD/yhF9wtu8mO1Nt1Unbo88zSW3ay
        BdUwcybj4QhvblLGZOwWxFap;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1n7tda-0073Lw-Ji; Thu, 13 Jan 2022 06:31:07 +0000
Date:   Wed, 12 Jan 2022 22:30:57 -0800
From:   Jeremy Allison <jra@samba.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        lance.shelton@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ntfs3@lists.linux.dev,
        Steve French <sfrench@samba.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Ralph Boehme <slow@samba.org>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <Yd/HIYsCBPH5jPmS@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20220111074309.GA12918@kili>
 <Yd1ETmx/HCigOrzl@infradead.org>
 <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
 <20220112174301.GB19154@magnolia>
 <CAOQ4uxh7wpxx2H6Vpm26OdigXbWCCLO1xbFapupvLCn8xOiL=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh7wpxx2H6Vpm26OdigXbWCCLO1xbFapupvLCn8xOiL=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:52:40AM +0200, Amir Goldstein wrote:
>
>To add one more terminology to the mix - when Samba needed to cope
>with these two terminologies they came up with itime for "instantiation time"
>(one may also consider it "immutable time").

No, that's not what itime is. It's used as the basis
for the fileid return as MacOSX clients insist on no-reuse
of inode numbers when a file is deleted then re-created,
and ext4 will re-use the same inode.

Samba uses btime for "birth time", and will use statx
to get it from the filesystem but then store it in
the dos.attribute EA so it can be modified if the
client sets it.
