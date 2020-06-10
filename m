Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E331F543D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 14:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFJMIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 08:08:06 -0400
Received: from mout.web.de ([212.227.17.12]:44881 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgFJMIF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591790861;
        bh=Rbfz1tSx1gAVqb9pVfW8xCQg7XrzBdujlG0Xi2jOCPs=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=XT6oiPRXBlPlhxV6U/j4UjIZV9qc7DlH6cXNTeiN3QRh8KSiwRXeZKF5nw/f+3fOI
         Dnt2cs0116Q6RDXGZ2no32kq3GyZgCRCneloMT+BDZEqTIxLJDAXt+wrQC/454TiEd
         HC30pcHQOF5pbrrSNM+W0ujFJkA0eayNRUH1Q1hw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7am-1j6xLu3LlO-00oGBe; Wed, 10
 Jun 2020 14:07:40 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH] exfat: call brelse() on error path
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6939014a-adbf-f970-2541-df16d35de7e5@web.de>
Date:   Wed, 10 Jun 2020 14:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BS/IQ7W2d0RfMg3aks/aA42iFUz+07KoT5lAtzL3qf4Dd6CEyam
 qPskKd5Ql1HYYl+55qLqIPI2Nh7tixb6dxeqgg7dzPlfeyxupx4nQYYpbuJartn8oFesQSu
 kfFDEQhNWn4F748jbc7x+kNSmxBPmgPzTN+6+WkFtfFxed9RBXWXxpDjDi/Z+MJvHciPqVx
 BIyRQgnfTltYbHsCc+25A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3oz132EGEAs=:vnFx1atC4mPv4V71l5BBHs
 fIuZz7PrJK0iosf21wXBs+oYZFeUONlbW2IUa6slZPQ3rjub7V2OnE+D/ningS75Vr0i7nuH7
 9wF4gVty8ymk9LK0Iqk0A/hgtm1ZOCay/hEskAV7sBWJtTx66PxC4UTtd6nMHz4cT8PL7zxHG
 oICzU+4M3D3dsRGEkVV7saqcTaqCoYgd803ECesHyyBh/3JRyqOUdTW9lUYIotRH0rXhYkhSG
 NSYwvCEuOMH/EyagkndX1d/Ocq329Z2NW0MFtPu74EijyzJwGjQkzWT2d7BgMaH/nYVg6cuUX
 UQdXF8972dXsi6V8hUasIrU6htF7mjJJ7XmzmmBEgzL+R/jMvEAOH01ez7pGik7cfA/hHpf9H
 CQHrCq5NXHsihlQdKoAECAVRzM/ppm9SEzLEg2QLshZMA+C1f+H7rBlIchH06c/wLZfBUdtHf
 ZDrO9qxsSEEjJlF+oNM0VcUKcs5VF3FXpiXkm1hYogrnDj7/SV48AcEjBkfT3OPAYYSdAgCzc
 o1I6V5gjOVmV0LlAiutbS9Mo2X8BBlvUhl/tRHQcfRikempbPNg8mfcx3j3w00ksDFRDRvkWX
 /S+VNW7Sp9KRZPq4oCv6zjmdoT3E/HzRhqnqOjNmGKZjxH8lwc9zrtVEYPDyMIsl8oNEua5qY
 QClFpR5pmHIunUOfmLd2f37TJwBxrPpG4Qb/4Wkt62AM9vJrlQiyc/0TcXieTKvSfhXNEDLwV
 zN4EA3iB/QGgH4PWCWz0J9ILoxZRhCyeckC+PVtT7SmSw595e7tYX0Kg0tP0uhtgjG1wOKnpa
 z0XoIjMNf7Z09RBiG62rdPu85AFhcIosJfGyRyYWn1fbtGceaxOZHpLBFyoj6pqMazejf0936
 JFrBlUb6QEwMgfXo+ziaf2R6vnkb1vbmnc8nr70V0Y4IfIVOSgy55zr7/H9o6kfIPa9OCHXPg
 vGeLaG6svbHC8o5XIRuBb/T0LzxPRkhRdsJsnHafLvEtsSOSbjlxUxiGxfxjWRU5MsbUh7D/F
 POfH1017Py+MqkN0hECKbWaJ3KgUQBvtsLELVIgEGLLF8mUjt0Eu9oEHSmJBJXsdlAJZzvid1
 vo1e763RIR+ML/2/Y7rdX/DJ6UQ+j9rzASm+9Y00XPgmMJkRTSUxp9QvqTYeviBOMjgCJB/nR
 FffhVEUQwbxHlzALBuN8RTsy+ajZ5+6fHdPEMwKS9Wwo4IWMvZ311iO+CWVNM5eE9TNu0HHuC
 6Jcfy6Ljw0sqAdYHq
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If the second exfat_get_dentry() call fails then we need to release
> "old_bh" before returning.

Thanks you picked a bit of information up from my source code analysis
for a possible adjustment of the function =E2=80=9Cexfat_rename_file=E2=80=
=9D.

exfat: Improving exception handling in two functions
https://lore.kernel.org/linux-fsdevel/208cba7b-e535-c8e0-5ac7-f15170117a7f=
@web.de/
https://lkml.org/lkml/2020/6/10/272

Would you like to adjust the implementation of the function =E2=80=9Cexfat=
_move_file=E2=80=9D
in a similar way in a subsequent patch variant?

Regards,
Markus
