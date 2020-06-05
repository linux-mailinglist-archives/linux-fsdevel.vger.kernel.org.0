Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA51EF6B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFELtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:49:10 -0400
Received: from mout.web.de ([212.227.15.14]:55495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgFELtJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591357725;
        bh=YNFT3W4I68wx1XkHhFni77rj2hPxvVddydb8cu7DO9o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=daE+BMqRpFRjN0dgKypNu6WW0o/+81qYrDOX3n3oli3L7Oqi5zs22ex155LBMU20o
         pmh64APWKWN7ky9U2Mr4S2eHkk2Pnvi1NKsT0a9tiMiXK8nZFyoykCcx8axWY5eEy8
         Vd5pvbcJchM1ehh6RLsRvEXmdbH0jPa6/W1XO84A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1jK8jh0Pvg-00PJmf; Fri, 05
 Jun 2020 13:48:45 +0200
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111049.GA19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
Date:   Fri, 5 Jun 2020 13:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605111049.GA19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bZ+hVVmU4XPXH+XKnHAH2xGaJwrtCqJlHTSItq4yaYzqHaMI9g2
 W1CSjONn27C2Tfuhp5V2ume1kaV7tSuI9aM5PBouWO+qmqwP/dWWG4OcBS4+BHi/oT/Ri7E
 YsKT/bskw2flOCodpNSNDWqE4Sd8uWn74cDABHOHbDECvQjyduzVJWULdLFq05c5HQqi8Lt
 e7ptZXECO+UVIWfEFLaMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OrqltsMFwFc=:0j+EbyMb27QL99NCg5MdlA
 0fzja0LrbVnUa8sBjMt2JGY+HIAS8jeT+MJxOqkdHkPAQJKF9MxVBjji9sSH6J0uZX7wJcBVg
 QC0BPrdjiN5x365BXpRk70HRljnh9GeNcotALM9VN1yrehgDhHsMdWaPaK5fU+aBQwEBeh/Rp
 UEuLj4klIXr8j+ozrPORdWR+hegX3Zja0D6lk8vN2C+/zeRWMogoTCrMbu4qV5O3uAD/A57/G
 6BZ3uf/KJZ1Co0KRric0turluyDDC8ZtnYrDlkBuRcFePJqeXRprYQnPZKkr4EV5hUOQJEq2y
 /YgZqmJfFuJyBuLjUx5BtBIwholHVCT8FXhPuUT/oHnImMAjV0ydrF602HzIf2sdCKFKP0uvz
 Ygw5hv+T9zX9Hvu4slX/Ezuk7L/4zjtTPBzHQZfyE8eEGlOYC1h764eV/HzMHfFrYOI4lrlmS
 GFc6Bbu0T0cScXsuOLDeDzwIXxXvW6mpNEULhhu9Bh+s0DfqxYTotvddNV9EUu/HqmyjYP+wE
 NLw3kwhiGMjPb5EUxSfUd9tEmeLsNfQdF0UaDF9KAuk7oxcf89f/bxXiwD84al706sPe+adAr
 WIhH4LdgVM3CXv38IBUatbQUomOe3jF1i+4pVL2bn3ex1JkVCceL+b4qQtqHxGQiLr/zG0j1N
 59vIXLLWv/FTKL/BsD5kn5DNmSOieH034Uxrml3w9s68xZeV1ifm83Ga1NzI6Eo357noqAkxY
 yyOG0hJnemNzyk5voly6/1nP2Kkj/TdFded63GwhTZvWwhGp2vz1AEXcoD/mQtOvxd+laab1q
 mZ6lhKvDgp39Cd/6cJo2avAZA2abvt6n7zTMqwem99Xg7gcZhQH8ERVD7TgaoI3itP2855KW5
 Cn1QoO7oEdcMwVxPq3jmBmWZpu1gBqaE/aJ+t/5MHLxkh2mdz7aFR2RD7dveyMRQN3Tz2zmee
 mYB/Kaw64dOXZMGjysDGL+R48LV9brMCT5deO/3LM9OI4piuJEkD7F5Xgt8FtZdHI1Hj2InT4
 JWXUpq2GBHz5ctg7XEvPL2kV3WZJj9hiMViQefWQ7RGHEPO0yJlAFb2Czvn7iedevGvR4WLSH
 2SZyz4cgb41/rr782zdtYasMC6m2RU94o666HsG0bihE7YFscAbjQvQgIvGkYh8PNhxVv/n24
 BquU5D4MGd29iTk/w4IsZOk0szJYhAuMtzLOPuzgomkjw+2qpmeHxExmIxxoGBIJc8jVRkkme
 twhVHzquFZZtvtqet
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I am trying to contribute a bit of patch review as usual.
>
> Please stop criticising people's commit messages.  Your suggestions
> are usually not improvements.

The details can vary also for my suggestions.
Would you point any more disagreemnents out on concrete items?


> But refcount -> reference count is not particularly interesting.

Can a wording clarification become helpful also for this issue?

Regards,
Markus
