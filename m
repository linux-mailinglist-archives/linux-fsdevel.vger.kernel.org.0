Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606051EB57C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFBFvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 01:51:21 -0400
Received: from mout.web.de ([212.227.15.14]:37157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBFvV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591077063;
        bh=rC+GtSVdZubJNoU6bu4m+AsL5lxmvO33uKhR894JCN4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Og0dgGoDqI2xAHroHGG5ic0Qx2gZJdeqMV/92twHrKa0Rtl82DoHtaF5w8CLakeRK
         FaO8s43EL5C1RWb2X9U/9VIP2PSCCFTTsNn9HB33jIVzBy5sLusjB0ChOWDFhmg6xt
         z3dzVEC16p/vsjq0j1wcEW+q+ymVReko8Av9+uHI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mhljf-1jKDx73ttz-00Mqnc; Tue, 02
 Jun 2020 07:51:03 +0200
Subject: Re: [v2] afs: Fix memory leak in afs_put_sysnames()
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Yi Zhang <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org
References: <a28fd20e-1f9e-d070-4d2e-2bee89f39154@web.de>
 <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de>
 <1346217.1591031323@warthog.procyon.org.uk>
 <1358845.1591037529@warthog.procyon.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b2973430-264a-f9f6-10af-dc8311f8804d@web.de>
Date:   Tue, 2 Jun 2020 07:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1358845.1591037529@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dTgJHGtqzBAk6E9ucnB1lokkvgj4DiRVSt80qr/hx6hzMTipXW
 wZkQReKqbAC74sFyxqSAcsK3e3cT9L5JdFAjnPXxoRxNNm2SshWJrlmZcYMy3th4uM9lb2k
 l2hmKv2mBbQh0Ne0CEZNI/ps0TWcCBm0QPt0WH0Y2lg3nK3JaEXEDnEjYEDZvrYigx1OjFf
 WIXWCPEfQvRWmFtey/hNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFxA4Tl6NnQ=:i9LuWgjDN17ZfT3WeE05e+
 oqXZzAO502FkKZq6+PHmekaOmE1j7aczBxRSB0lrPlRxhC1fy+P/3nA+plB/x3xKMQ18LrljB
 HHyx98scanETG18cKWKhtSU2WrZ3OuhanluHBirRK8ceV0y+bdDllSRFlOhlHqtMKyTxN0WUg
 zrmilTxxUI7JnMt7A1qsTAA2DAHTcmHt1M7fK85Wx+l2EcLddMQWoMQRR0RJTTqwGE8e16SGo
 mAdKTNYcgmDCsd/iX3xc1qYDDl5HWEK+/gJOvvph/s5g/9Y9OgtI20PmdzIoqluxtKxx4WBZA
 Zkoh0oL0vlnLvPyY4y5IpSRc1nG8m1UDlCgBCWUr0hc8sB8ZtR8kyvSbtJJy6SOmpCz2d2rEY
 wXqRx0F6uHnzbq8ftuFF1rmp4c+TAKIqV3u8yPw0ZJc5KPOW6vvex9PyIKP4R5T84Ghggq301
 IplwB6ET+ttBpddb+quwReDEip3gc7XCmss1wfGbFAN3EKpCDXARWdbk70T668n9TCJrPg6Ju
 bJk2oFAM7APLWOaA0mmdMPyzh3e+4R5BnW41mZrnE+T5ddjKkLeFrFoOD5kPRI5jXgw30Tb/R
 dHD2Na0nnZD1WEFhZ978u0R05fe3IqDCVEHx1pl5IqOgKJL94lommtEFEjzXwe6rQOwv1wVpD
 1Gsm3BcN040EuF3M1XIC2Pglv9kmUOL7zy6Bxrc1SHj50JDxVIrDImhN7yTloDjcUiOlubnKE
 wwyh3etctTY5Tnk58yeY/z5mPZckgJdDmeKPXLc/mqKKu0hTb336hhIF2cZRUwgwmINpdUH18
 KvYf+dS7ZhQ3t1HDdxJQcc106oitWPJP9Pw/aRPbn8D6hhBXQa/jlaA6K9h4XJVt9/RhYmPZ0
 ThiueiDTVuT1EvF+uQ3GLQgVqB67Slo4nc113ytbrTxmfSBl+27V9WlWsS1X3v4jn9m6SfBy+
 7Uj08BhBcoaax1z9s01z0czW8H2U1Xr4s2f6CQvC/57mWWU7Yp9r2sifmzan/myLmozo9orHc
 bPSz2FZ29/xFyL9MSLZO9mwsHRw3le12vQBfRf/TrgvU+ryd2tCLUbKOiVcTFE5JZpKQ8dQpm
 G7U6zTKfCC2m5Aq+OkVAoS/HZTL9Jx2kzxC7OuMstDm23ImzQgfQdtV8VUoK+WJ4rwjLGjO7f
 54NLcweKROX+L+pOMJoIdlMD5OyrjvcC+pvd5TX5zIbvaja4ckdsXtWdX4Ur48PG+rUULFLOX
 Aw7yN0D+9Wdq4ZU8B
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> * Is freeing and releasing an item a duplicate operation anyhow?
>
> You're missing the point.  afs_put_sysnames() does release the things th=
e
> object points to (ie. the content),

It is possible to distinguish the release of system resources for further =
items.


> but not the object itself.

How does this view fit to the proposed addition "kfree(sysnames);"?
https://lore.kernel.org/linux-fsdevel/20200602013045.321855-1-chengzhihao1=
@huawei.com/
https://lore.kernel.org/patchwork/patch/1251323/

Regards,
Markus
