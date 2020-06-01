Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330691EA293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFALSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 07:18:36 -0400
Received: from mout.web.de ([212.227.15.3]:43747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFALSg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591010299;
        bh=xt7UBTUtnPCk2kQqG2DBLHWgWmmfl2MNlsqBgwKrxh8=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eTXeSRRqLN+TF9aBzFQPVaQT8hW4jaFoyuy0s1VgM8bch37FK91MKYoAxbkpVKgU5
         eU+HWjY8h87zQvg4GkKTqJ3Lc2X6pUWdLIM6gUYJ5NGZbrTATJ3DB6uFQxQyrXZmlS
         qSVaIbGrpsYC5Yqi1jYnBouZEp4KP2HAGz0iuCK0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4TR-1j6ecc2oqn-00Zc3C; Mon, 01
 Jun 2020 13:18:19 +0200
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH] afs: Fix memory leak in afs_put_sysnames()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d8e5aa79-3f83-a5de-5aa8-7bd4a287646e@web.de>
Date:   Mon, 1 Jun 2020 13:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7UZ2ljg9iRO9n5ouO6yzuqJb+diD4FwJh0QhXsS5Q3MxXnZca2E
 umEqRRNgksEDnzkSgOrvaKbW1+P981gQrdeI1KeF2TnupVAfaOQe0o8sxLNbj23SLMLtFXV
 Vr7zEVLCkrzh0dPb0pSbsgaUX6GBlVC5lE0AZ1C2hWZEZ4WCnQ/a2XGnlyXjicnq46Slva8
 zu8emk0Cr2rVbZfcag4oQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RVoppDxQFcw=:HPz7tNXBPHT+b4PEwZ3E5O
 NsOdDFH06PyRH1gW3FWnUyagMLbZag4K0bi7WZ7Tb2Xw0PyHCui2IH+kiZW3/uDlFfwgZa+Pt
 7gdTDHqM2+LXkSKfF/FG3My4+tbHh+fuwQXHrlYA7JILSUsYDzhQPsCUdw6TDf+O9SguVdHvz
 0LNPcz67vCAByAJy6LARBXyXe8QueheTc7yGyuw1baPG+mWn3z912R4mj0F2lUJTXp1NkC8ep
 yVOkfWWfVUwbIqKaF7GUMWkVua7jb6LdpclFRHR/8ZIjyQFMmcZZAmpM5yVyFCsv2OUFR5K+n
 GJD7xE2mlkrUFbZzmbzr4FXOcmT1oYWmoF0LtdSdXDkq7ltmfieA8T/IOQLaEyIbcQY6u8jDm
 YvD00RlfB5/9XLHSvMequK6EY58l8O2+Yv/Gae0Xor7mJDnS9Cwa8ieb2zPr/0RnziURjFADS
 JiTCn1p6GX06L+2hmM4zTWpgEv+aPseAN6ABvcfGmfauGux7mUFrmy5fcpIkmyQZ6WTlUT2F8
 NYCSDcXmL3Vm0d1pa1HlLil9xLBCrP+ooRB5Zn+SdPAfnnOlThbGsaHKEq/DrbH7STAk2pHHk
 ZUCOIxywIBuNP7r1QAfVjim2gAUpC/XWg7whA9HNeChGJYlGWDdIDUDcMBa+LHDaovUqr5IVL
 TYYZFewRM7hZh/cqR3afwm99q8ki9dUyUACIQIbgUSVwDr21fwsjrtYZ+ZF7VS518QN/LxUrQ
 AJT5zvZtTZHhECoynq7Rp4oCum9LAqW2B6VpmQgYBwygFgqQasys9z1VjesDZeR0kGn4PA3AA
 5Y253R0t2X9ngOC3Z6uff+gCISqq/7RfVdYsNhi4+UusSxIy4YKWLuBMCiTTR98a0t/mdNnYB
 byfayBAewU3L9Yx7ZmrsxobvkYmipTPtokwXHTZ4lYYyMnXOn/acRHSlRaYqxa2Tkfa6cEnc5
 P1YE3FSU/i/q2pEGQJIiOXypQ8Ae81dLkchNY9sxAmk00TuIqdQYcZpwH7C/KlH/BDn53KCtG
 SqWXF/JN9D2D+DipSJANcsbo3RVNUnzQAk7ai4b9J0txpSSIzm3kWFdnAvbEtVhmP7Hjjotxi
 NBwiYJ2QJknxL23/7I8RxFNBXMxjVWtG2DgFUAYKvMSRQ3xWzRRRcH2PpeYeCtjkSSMp1dBPC
 aHpfpT7rxwkZgXUmNaLfVO57Gr13JeUTXTT6MWeQbtmPFuIDmK69foMPY7KqUiX454dVrPnVH
 VPttj0MS9laF0EMfj
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> sysnames should be freed after refcnt being decreased to zero in
> afs_put_sysnames().

* I suggest to use the wording =E2=80=9Creference counter=E2=80=9D.

* Where did you notice a =E2=80=9Cmemory leak=E2=80=9D here?


> Besides, it would be better set net->sysnames
> to 'NULL' after net->sysnames being released if afs_put_sysnames()
> aims on an afs_sysnames object.

* Would you like to consider an adjustment for this information?

* How do you think about to add an imperative wording?

* Will the tag =E2=80=9CFixes=E2=80=9D become relevant for the commit mess=
age?

Regards,
Markus
