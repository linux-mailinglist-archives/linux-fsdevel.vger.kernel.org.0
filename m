Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD0609C5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJXIXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJXIWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:22:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987937F85;
        Mon, 24 Oct 2022 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666599614;
        bh=mRETEBkQgxvlK+wVwijyfvEKXHrp0hCT43YSFto1wVM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Szq5gNq7wFD6eigaToMGB1swCUiRaF9LgF7wlS58ft+Q3sqBjW2HlPLO9p0WtrQ4T
         GXoHmADp9jMRENwMItatwtGAxyMd70AwjWO9TFxHlF3WbvAAo6oTEIsuGhl+loNaNn
         yBkcW9OE47ESGIZeTgkkH5nZNgVDiFV9a8bQSVIQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b2T-1ojs0m3IKL-0081DI; Mon, 24
 Oct 2022 10:20:14 +0200
Message-ID: <de4337f4-3157-c4a3-0ec3-dba845d4f145@gmx.com>
Date:   Mon, 24 Oct 2022 16:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mTkzrOuttAy1jviNO4zU57OeQX2AnMzX8mLjNK2cHF5odq2WYVg
 1FUkeR5oKeyNYCQeytJkxN3MdHk7VQ8NaFWiIZQXaG95Z9kP5ibpkgBSsjN96V473em/fh5
 76REIzFYKgeuyeT7nqOyO1Gd5e3VIyaqjizZTr+NFMKPBS9EmuWo0j6ri0uuM8EGgMJXpM/
 Tc8oWbWpibiKWUGejcw9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9drqmj/oLLI=:Nw34skgsYvifnjaN8ZhjLS
 L/dY2TjcxGbWcqO+HJo4upbLGmpog8MxAsgsWvLyK1mwNq7NjFvSpXLkOps+4JLZcRGFCA/k9
 vWt1/GaR0SQsqpJ/8w/TYJ1/H8KJwh31ZZGt691YBmwKn+Bwqo+r5uVT47RKZxz8xj79D1HgK
 OfLOgq7gF8FQZGmaW+QVkN0pGahSeLJ+zodSU0C5+ZfkbeYjkcqcWV0nuvKoXhXCcXiSQUumU
 tEh/qXjNZMk7LlXgOn8MHBunFS4YRPKfjVV/KG7hasbveUItL/JwXQlyOb5SWKlhfZsRYi8UR
 GY2BoksYs+rMhtrAgsJ+9nQJHcNgWvM1UyAcJ9jPnBJJuniMkg8sfiJp1SJVCLPfNQ589mjxW
 IXZBXwHCcBReD+LNYbS+HuNzxnfpZb1cWK99XGIw5WYyBBYgY9YUpCmnv7r9AJttA9P9XC4Bs
 ab/Wo0hyAS11ecqofoGwYpm+vruH41c1GtCOrxwsRV0ZGuh4LkwF0bTE9sxsrj09EVzxobARm
 BacOKpiTM98/Cc9yIsrzrIcgLVQNygSIC4RZl+5/r8zdQ3MKwinUHuE9orJjAhGCqVfOXM0U7
 Q+jM1XOFbrZGrw4IfiVQYhfStx6PxVTZPC9zpoj2vb5YpWF6745d3St8cBSvfV02GGIHsKLgB
 e89n/Zg2M9/kHF+XmA/udkglMV2WN9pZhQeV5Cq8wfGRadC/+dSXiSxP+y8SLPK8tKwvu7vTY
 wKlKR9Vb6hVTKS1UkSfip2MPtVBuRmz6VMeHSstdfBmkcvq2NKIbpMFxv6QcjjlHYfaUQ7maz
 ymoFV9y2j/6NgkGQs2EE3OiOz2F06XrOMzFRYBuqy0mKQ0axMhCyUG5lgIOGbIwAH/3XlR4Mo
 i1U5fja6in4HA4uqPHcZ6Fj0RY9qOiJN/2hkXivCpx/sO3NfWtue04e+f/79dq5Jl05vhZ3+h
 dZaeiEXXzv2sAXpKxwLUYSekkJ53ju54Bc6sRZqstc7ReJN3nhuFPqgUZUdATVnAaP1M0LdtC
 If6lgI0iPGWRsKcquwWezJqUDUbUgeqT99/agA7HXUHG173WzTa6B9kBNp5F7UPCHTZkkAyoQ
 BSY0/IXt0A1g2qPB/weCt+xPx3yr2JVjhY+TPt7TlBvjQeGVgqVLgQIOHV6gEPw5hJk4AZkQY
 ynx0JGBiaIQfw5Ea9XpwZTaYiFXiluBwqYYzLoC6/+TwzR9JCvZTx7Dshpmplql2S5qAZQQCQ
 vxhvbINsD9nIdmnn4do7MlQ/bZ62DBAlzdj3ebmI//IOK6EJ8W3lqqeSZvPYDa/w1dghYO0iF
 VU9K/PcZ9jyNdkhU4/QoAi54Y8I+LEA6xjOgxywsoLFDSDp4nKFSBE0xWKXSqPg7qkoWIJUTT
 v/JJWGFFIDYuqbR2uNRyEanabFlMMw8fwusRES3Fo+vO9rSgi1gVm3TEx/gDqRG1+qNLB7hub
 GB3TGf2ObKGbXKMj0pFEd0NjVA3Le1lY0zzFq5K9a1xX+V3ss8W4heNSkv2viEURwzWfUbzwR
 CFxBuclmIrJRZONk/ffMH+CfpK/qH0laYPPgqCVoQ17AQ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/10/24 16:12, Johannes Thumshirn wrote:
> David, what's your plan to progress with this series?
>

Initially David wants me to do some fixup in my spare time, but I know
your RST feature is depending on this.

If you're urgent on this series, I guess I can put it with more priority.

Thanks,
Qu
