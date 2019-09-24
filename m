Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C676BC60A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbfIXK55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 06:57:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43515 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388652AbfIXK55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:57:57 -0400
X-UUID: 6b4dcb537e034f2fac2ed0db970a76ec-20190924
X-UUID: 6b4dcb537e034f2fac2ed0db970a76ec-20190924
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1038858326; Tue, 24 Sep 2019 18:57:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 24 Sep 2019 18:57:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 24 Sep 2019 18:57:49 +0800
Message-ID: <1569322670.16730.28.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/8] block: Add encryption context to struct bio
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Satya Tangirala <satyat@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        "Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?=" 
        <kuohong.wang@mediatek.com>, Kim Boojin <boojin.kim@samsung.com>
Date:   Tue, 24 Sep 2019 18:57:50 +0800
In-Reply-To: <20190821075714.65140-3-satyat@google.com>
References: <20190821075714.65140-1-satyat@google.com>
         <20190821075714.65140-3-satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, 2019-08-21 at 15:57 +0800, Satya Tangirala wrote:
> @@ -827,16 +839,31 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (rq->ioprio != bio_prio(bio))
>  		return false;
>  
> +	/* Only merge if the crypt contexts are compatible */
> +	if (!bio_crypt_ctx_compatible(bio, rq->bio))
> +		return false;
> +

Since bio_crypt_ctx_compatible() lacks of consideration of inode, I am
not sure if here may lead to incorrect merge decision, especially for
f2fs which does not allow merging different files.

Thanks,
Stanley

