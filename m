Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B444C1B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfI3GD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 02:03:57 -0400
Received: from mout.web.de ([212.227.17.11]:46801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfI3GD5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569823383;
        bh=HGG0I96NkETQYQwgStUjCsGhYSZLyQy3fD3AGR7Me50=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=E/FDxgKHjd5LVpckg52gwMrScZmaD0CMN3jvojBijVsWdyk+K5W9f4us4bE62b2Sk
         IThJoblQ+dnHKpPB7jwV0i4ZeDwcHl4BYuXbcSnkaLFOrZTSnqnt/ySTkJmcuD/OuK
         sg1rfDs9nKZwCgxpkbWLnKGqx9QQC7O3ysvrr29I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.97.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWsC-1i75Wt0B2y-010urk; Mon, 30
 Sep 2019 08:03:03 +0200
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190930032200.30474-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] fs: affs: fix a memory leak in affs_remount
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
Date:   Mon, 30 Sep 2019 08:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930032200.30474-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4UBRBpT6eO7hvyCvrgBdFi65xYTnuce0lYLy1JDMNcGQqrVF0C
 ZVzeTHs7ODMHhMLoN8wkHR7kZSmlV44aL9/B5TdIW0YZ9yvWgaD4SNPOBFjNGa/FokI3faK
 CTaHd8qsMUl2aDmQ3l0xVRK8BKiVraVUrtU+H5mrJOHzohrrCHj47R63y3ZVOpQ/RBde3zY
 PgN2wD+W7TMZ2ScqzDs6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xdPGvWMEzLw=:DOsFF20mdzcuGlAduEu7Pi
 Fc3pBlr8H90fS45fNcVJsZYEHRp1+toc+fIgWHrgtrcdz12cMmH2LZjw8+Dl650oN1JLWh42q
 IJNUtkLOuyfOR5HvjViyiZrz9CWqbQLEKsQ0EWLS9Fsra2q1hlj9VX0feiNvs+mj3bC2QPs6w
 Lmxfn8GtH2ievPOP94/CUK8SW5HxpfT2HeKbvKwyiga15WiSjn4vIG4HdebeRhRjC7eFheKHd
 GhK8pfQMdGDVBLgs4aWib6TnNxD5GSG0PxYErd6YBOXzybZswzILKGpYqTYvpr+pMNX7b2QCk
 fkKzPIrFdXTn94r4NlipxdlCTeVXacqZcPUN1ebqAqcMo8Hj/fMQQod+IhO1lX/haEw6rR60u
 Qtnp5TCjITpnuNxL+aUYIEuAlwlRltxSd0+Nh4zIikr6DPfpj+Q5+9Mium2ItW+p7riIY2o8Y
 kuSExYsUy/bSQGMHlgVZ9cjDbquGYh4pZjYicEotsfUOWHan4Q4HiKAjRDHV0L+atXvprkCpk
 pLMd40y3dlGrZkxlJZxsuqM3kmvoKG93pNHJGmIF5pRrPabCsHvNjQNaUNaI3CQyt09DZGDaF
 K7ECsvPcqeJCAtWReIJls7oS+Dk/r+wFIm8sd3XmOyUeIuVciyB5gfyjIHSCoZnkhjsNiWQeA
 0M/Z9cSFMK8396Fz4qqqpSHP3eqdk/zZsfsUZHkMYlxLYgzpEFNmfzmFF/4+sMWPzD2Qthecd
 iQfTDZIbWMZb02k6IF8PEucC+vVObxw4LML2jxAR5cwTfxoZo/N+n3X/LgytA6HTz4mF9N+m7
 LD2DdoqkZn8YK4tpa60e1oGtfYDoZ0sTqKE9Kk7QVyfxDX3FaqhOU1mpyCTy0ocBrSBMN2nHC
 ze6Ul+OuERMmuszjeML8Dsj81Zfg1Njo5pDZWBum8V8DjFCau2pifUlk9S87jTlQXF08l58XC
 S4TrrgE0DmjRAyMEpCrEOGBieD4JQCxPAuIek9z0uZPdop1Wcbm2Z5zBbHnjvJVn/VTWGEEKd
 keUzwc2X1YuvOvhaswnZgrqUKhcpot0+H0cKVzOnqNlwAVzTdWoj3Yvn/Sjp3CRfL9FE1L41L
 egwqDOrfov98Teu3iPIsfTY9Q89VphjQML6DgS6AQsTsvbhWS5Jltuv4GWvgTaGGTWeC9DyHu
 mTZGkQdW/jM7LR5LZn9o1jA8wb0VU41eN+Q29I7jfDgzJihhemBgQn5TaNifbjOKPoIJTZkUI
 OCcU4PMgU7IxjS6xqNsP3weNwOFJ5IRtK2wtb11awONOiXX9kEyZmpPd/QfQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Please avoid typos in the commit message.

* I would prefer an other wording for the change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D97f9a3c4eee55b0178b518ae=
7114a6a53372913d#n151


> But this is not actually used later!

Can this information trigger the deletion of questionable source code
instead of adding a missing function call =E2=80=9Ckfree(new_opts)=E2=80=
=9D?


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
