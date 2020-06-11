Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9231F6337
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFKICf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:02:35 -0400
Received: from mout.web.de ([212.227.17.11]:47523 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgFKICe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591862464;
        bh=+y1PmpNFdbQw+ppUZ7tcxHX8SdjdXK80MSRo8PVIBgE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kK29WhgFU1xX85Gpc429cWP9XvRaarQ5X3ZTvD9tnokFw0GmqmNRcCAkfjmRM5iEJ
         A/mA17dN5mjZs5fCvO6D35BNeoMCrsGMETOxMGRrqwZIWYtyetbhnK/+cRJ7VctZU7
         HRrpSx3nFLBXrYArS9MlLQhPUOLl4+YOsh/40usE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.66.14]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWAwH-1jP8qP0j7J-00XOTy; Thu, 11
 Jun 2020 10:01:04 +0200
Subject: Re: [PATCH v2] exfat: add missing brelse() calls on error paths
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <20200610172213.GA90634@mwanda>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6e64100a-b623-a4d2-c5d0-cc9235669cdf@web.de>
Date:   Thu, 11 Jun 2020 10:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610172213.GA90634@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Br+WZCnyOu5MQovsERuy+CrDXcu2aPq4x6am0ZY6q1wVxOBphvf
 xvzsJwDf4pBPKrXLUhf7lcZvVm02iiUCIVmkjxGtj2PxxAxqnNoD76jK3O22SE5I/gMevdH
 l9RJ/Cpp7fEmXIIFc2Rzbs2EVc4AVyGiw9m7MYz6oGSmOB8FxW2KaYU241NrkoYpx9LNJdG
 sT4x0Gg6rbCJ6UsdaLx0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sLSyAfGt6VY=:vAC2rbclw+OinxlXAknKiW
 KyXPaJqfvEc87/pHAodb5v+TiAMFJaeHME4ZgNNLrIlWcDbAim/SRFFmGsK7fRUtvyYnkn5Du
 AV2qGQqXwNPcnXr4G5Hxeaa/FHD2e/XHfhx7mbMBUneu4KYtPSwhtBGS+2NnLvOfg4yY00A7h
 HgbfcAT4nbD8rfGnYiNV2WhHgZny/5ebMRhJN85jzGCFPECCfrGNV10lLvmw9a0Zl/EIQtwRu
 VBqzmPZ/WsGMvhPVzzartIaiFwaghovtyGDxMzaXlRn2kRGPFVdlsqngkp2RFueFUeMZIoPuo
 wlfhDBtL18f1JLjkMN7ZJvG/GImLhKnvFrR48d63+VIkhigJZ1TnwznbUn7FtgzW+dcA2EA2E
 66LhadGrJtf6xzsIih4sEvxWbquXqbOq4C5xGKK+N7NRvBXBSqoVkP6FV2vdlCfdsvermWaI8
 7RAQvx6wMxH0L53wUGdbsw3Fb7qZz3uulFrlvLhsdT4p0eIOOwtcFfhcS+gZEtAMgDzAyCSXm
 9ENfyPvjkTcvMpJPR91VpTc48RtxZr3x6DcnUov0I3F8Q9Se4DzICCUOzGDfmkZuF1JzmtKKZ
 Rou3qF7DY42aSb43lttRUy7MWTh0uR7BrAErbvDtIdCPuTneIwUdYU5Ed+wm3rfQybZG48ksm
 2ggOzUXMyL27/G+nFGw/wirTHChe32/mz1XcKGVjPqwr6IM0IPJfGis8dfK4HNRaBeXu4IQX1
 0xd2p163QsoPeaGvAu2Du19hsLBu16ImavNm8IMhHy+B62eW6d8hz3T5xGWgv9Fj61p7SsM8h
 guGX39oSuBg5p1Ik0bZD2A/YIA+sMn2RoCp9Zw2KjiH+0TmOlWdAFw/wnex6+SEMH0ssvrjuX
 q1MbZo1PQt7g17UdDZXdRZ/ACz53t4C7i64ihXT8KRwYyUpD8/+9fDOnsX7aUBpn8dgzYq9KO
 +xhOoJmqE9/jTIQQ1yc3pUPvFbzod5ZxwlxDvWZnuQ0pT0eu3IeKufApCJiZyJt29YRiFQU9D
 LZdtxepHGE9taV0Tdr5520mpFxouTYwrs3y042+znxtlS7zx8vqCzdiPtjMN7SUutITudkmKp
 rRUDKPPj+KCBgb5XCdVEgHya9ry7jdF/E/wcMcuX6kQPnma4J/ekOQBCLffysQLRTYYQMFA65
 ipOcK+nbmxnHSlflFPa+XCST0Ea9ctTiKXm0AKo1Rsn8g/oyDnXgCPenovyjNXu+x4n0jIBjT
 s1Q7ctvYWC7o+FT1d
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/namei.c
> @@ -1077,10 +1077,14 @@ static int exfat_rename_file(struct inode *inode=
, struct exfat_chain *p_dir,
>
>  		epold =3D exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
>  			&sector_old);
> +		if (!epold)
> +			return -EIO;
=E2=80=A6

Can it become helpful to annotate such null pointer checks for branch pred=
iction?
Would you like to indicate a likelihood in any way?

Regards,
Markus
