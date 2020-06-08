Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE661F1BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgFHPHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 11:07:47 -0400
Received: from mout.web.de ([212.227.17.11]:54919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgFHPHq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591628854;
        bh=obCTuHEVCYFUzQwfaEoioBTN6wDVJ+KUzaLa+/2GCrU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=B+YuoA41aqivUHWdJ/5FhUDFEnrrPaTBUqIILNIvrZbEfVBTIAlfKAQVb17qB0eDV
         FrGELY0dmk7/AjlxbDIwF0T7dOV0NImMcDSC8mtVi7uNoFM2b8nmk4lnIk3R/8bwv+
         Prf2zKY3cvpXBJw3dYrYFXMBmJ+10ga7kyd7uS/0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXHXF-1jUEU72rRd-00WGYq; Mon, 08
 Jun 2020 17:07:34 +0200
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>
Subject: Re: [PATCH] exfat: Fix use after free in exfat_load_upcase_table()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
Date:   Mon, 8 Jun 2020 17:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TA9cyiRZuj6etgAQRZklSM6yiWFNFByCc/xUVuQix7aDa+6fNEh
 b8fJ/+mvGMjfPvL9pimuSgoT9hoi03H7Fl/Zauo1HUf4tMWr6cv56eE9o+4culILBUmhpmY
 eeV/JcxCAE2AbhORFgFDgo64K1JUsBL86Xh2p86QsuL1wnkG7LHBBkfcN9XcOUrNQZsfrTF
 HaQsRn82IAtrwUgJxk3Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XRDewrp3/cw=:Vzm02LnTXQDT+kiX4M4bjU
 3uzQdlKG2t4m9QRbK800r8wFmhSh5iv+HtT3kUgBccWDqWH0CaEBQaRdymcgcjw+oSlbfqoG1
 pwa6HvJMtBb/SghKMpBUfzx8FpyYe0K1/DXSLjlYedSqZxfeYRhqWvNPc5WD4VmIfQVkcWTC8
 pofvdQpRUokhYBDtIqxYW3eff+Hr/6B9OdfPVGpmc0iisJnZFNnshBWq4/O+vwGavxWeCtaoi
 B82fZk+v9zz/8aD1EvXR48iWZ4FLu9O23UUR52UzQGGwzveC2Xh7Q6nGY+xGh7XEc5xvedSGT
 9nsLDbYVye6qfPezowU/4w8NmN4Ve7HNw/jsJMC3g6n0xPENutJnqvxNaS7L78pkZnP3Crz0C
 X2wAFK5bMCmqiHB1sjoHKV7Gwa5ZmN8IRMOlH0EYfKHVf6VlWuuLyDPoDWQrVmMnqMfSqW24q
 a0n+EroO+bFU3yZCfu1yBNqW5/B8d1mMWWf9gMrOVs3BNhjcdXeX0OVddXGCRX02muUODmEYr
 nhxKcpTfuuKEN7YsoHtO8Fp467D0cQkXRHahfBgbjWpW04e9BozxK1CDk/C2m2T8T9ATyCFxC
 ARFroIN+7ikcCb572Y+OaTmBpbmtya5qoYvPuCGMDcX8vaWp0vIxkhP6PNkAluL6bQZLflZZs
 giXPIbcsZKKXu/LnZ2f8Cr3LIBwuuDr58pZ6BqKo494VbCdw/KYUnlC6uJ8O2PoAhhB2oOJ1D
 lkxwVT94jD354RKmTluNw0+lpcyXNCSVdmMW9hNiZklSY8uheSgehzc5ePwvPCxIRF6sgD9FC
 9QCQ46a8ALO+JzL1dWTMIMFunYCh/vlQUtLPRrEPY1TDP7e0qTp+WW9pANHtRiJZfMqE3oIWL
 pS0IMzLSGK/ptBcpqUafDsb+msjRtc/zDUgcg5HShNCK/JXBExsI/V5rV2R59D6VLkLR0XMs4
 pql7kNI5pYgpCaSb2tmaeQed0Ui+wajbcpeVv97zhyg+XdXX05g4RASEytkLI3dq60669OLl5
 kDVyJA62tWFeG713E62am/Tdi8SetMZSy8HOWlwymDLPa9/PbskufuHuonVdDw3cCU1YHRgoO
 c61uujXO1d4fm+siEADDcsP3tHviadHQul8CPREC8WkHTumR9GnjY3Oh+Ob4Sm2ccOrncAjJO
 SjaiCMAIUqKRpVl3RGzKN94zPm6gWozj2E9/fJSQJ6S19mWsKV+5OQH8bzZu/0bDbFo0rKoV0
 4akrC+5NRMELUFW7x
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This code calls brelse(bh) and then dereferences "bh" on the next line
> resulting in a possible use after free.

There is an unfortunate function call sequence.


> The brelse() should just be moved down a line.

How do you think about a wording variant like the following?

   Thus move a call of the function =E2=80=9Cbrelse=E2=80=9D one line down=
.


Would you like to omit a word from the patch subject so that
a typo will be avoided there?

Regards,
Markus
