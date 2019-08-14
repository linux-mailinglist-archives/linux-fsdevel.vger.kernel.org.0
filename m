Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B225A8D5E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfHNO0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:26:14 -0400
Received: from smtp.eckelmann.de ([217.19.183.80]:38778 "EHLO
        EX-SRV2.eckelmann.group" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725800AbfHNO0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:26:13 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 10:26:13 EDT
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e035:172:18:35:5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 14 Aug 2019 16:11:09 +0200
Received: from EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6]) by
 EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6%3]) with mapi id
 15.01.1591.017; Wed, 14 Aug 2019 16:11:09 +0200
From:   "Mainz, Roland" <R.Mainz@eckelmann.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jan Kara <jack@suse.com>,
        "Mainz, Roland" <R.Mainz@eckelmann.de>
Subject: RE: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Thread-Topic: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Thread-Index: AQHVUprJKpCUtlXq4UynIEfGU5LZP6b6rqnA
Date:   Wed, 14 Aug 2019 14:11:08 +0000
Message-ID: <48831093afb8467b90ecf3c96601a2db@eckelmann.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-8-s.hauer@pengutronix.de>
In-Reply-To: <20190814121834.13983-8-s.hauer@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a00:1f08:4007:3c00:dbc:b95a:c2c2:7d02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org




> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of
> Sascha Hauer
> Sent: Wednesday, August 14, 2019 2:19 PM
> To: linux-fsdevel@vger.kernel.org
> Cc: Richard Weinberger <richard@nod.at>; Sascha Hauer
> <s.hauer@pengutronix.de>; linux-mtd@lists.infradead.org;
> kernel@pengutronix.de; Jan Kara <jack@suse.com>
> Subject: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
> 
> The FS_IOC_FS[SG]ETXATTR ioctls are an alternative to FS_IOC_[GS]ETFLAGS
> with additional features. This patch adds support for these ioctls.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/ioctl.c | 89
> +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c index
> b9c4a51bceea..121aa1003e24 100644
> --- a/fs/ubifs/ioctl.c
> +++ b/fs/ubifs/ioctl.c
> @@ -95,9 +95,39 @@ static int ubifs2ioctl(int ubifs_flags)
>  	return ioctl_flags;
>  }
> 
> -static int setflags(struct file *file, int flags)
> +/* Transfer xflags flags to internal */ static inline unsigned long
> +ubifs_xflags_to_iflags(__u32 xflags)
>  {
> -	int oldflags, err, release;
> +	unsigned long iflags = 0;
> +
> +	if (xflags & FS_XFLAG_SYNC)
> +		iflags |= UBIFS_APPEND_FL;

Erm... what does |FS_XFLAG_SYNC| have to do with |*APPEND| ? Is this a typo ?

----

Bye,
Roland
-- 
Roland Mainz, MAA/CAS
Eckelmann AG, Berliner Str. 161, 65205 Wiesbaden
Telefon +49/611/7103-661, Fax +49/611/7103-133
r.mainz@eckelmann.de

Eckelmann Group - Source of inspiration
