Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074CF1EF883
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFENCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:02:17 -0400
Received: from mout.web.de ([212.227.15.3]:50583 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgFENCO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591362105;
        bh=O+67Zqc7BNPiu0Riju17L/rB8Wen0+rCWIN/C3IARsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dZrynhEH/Nx8o5dHlZU66Fg33ZPH4WJPbG3SxalHBlbIZM6ivHis49E1N5x/2dS8g
         JKyQOPzzIbYihRtMBc/cclsJOQTMxP3/nxk+8KGbBYJNTZqZbnHMLTSeRFwZ2j481M
         84Oo1la85K/2q9s+Vu5Kku+W7Maypf6IDKJeSUlo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvFp-1jfHEW2cQr-002Xm8; Fri, 05
 Jun 2020 15:01:45 +0200
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
 <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
 <20200605115158.GD19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <453060f2-80af-86a4-7e33-78d4cc87503f@web.de>
Date:   Fri, 5 Jun 2020 15:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605115158.GD19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKXlcLZKgmIulc8SYpt1u3oN8t78sRzUmxkIXEg6d2D2vNd+W0N
 0b9nLwnyqZuUp5eqjiJJvj8MuIE5SdZjuDQcG3DIB9cZBqQGXvqIW+dHIWry3R68CklJ78E
 sokHRR4KkSba98h78cnA+/FT3kdEkjWNrad15TbU6XXXUCSyyiYtXT+c40sAAAzR4Lmx6tG
 aqPmnLG+tHmHGUN1wKQhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wxN1oTDv5mw=:BTcJBkwLg9kmS63/COWQcV
 YUiqjujxYt+urC1wylQFbiOD7byvROkQSh8PAlMdzfc8iByBJ91E2cQ9NWCndkMtjlqJc2hcn
 7W4knYbq4LBvD88CgNeELY9o3ViM/QFZw2nh/R05ik8G5j+ommZiuw+CM/sHO9GG02oxWixcj
 zQlLiveauyqbRtjvZ9VtKgddWbuLh7hxvO4ds4gQleo7CTZOgFqdgmLnwxHkQzASjUYdnr9FP
 StgRsvxVNDRWo1bKhRwGqzBPlCJAapPsK0XwKs1QCeDsAY0UzVos8+JrNW3iVEEZO41brnWWV
 UjBBB4406xIyo6ME4Gczd3rVP4cv2hsYnzxRwGIfJjkZDKjJ5HZRntdabIPpx/s6iqr0Fx15c
 c5m3NUjEZF7ZnCAP1f0pWiXqGT/WowQVVJXDInUA6bCqj3pCucgyKvBKKYJNJ1UyzzmdFUCTG
 qFXathf9WSZKedx1V3klT1bRgTBsARIj94WsBPSJSDXilhL7RuP54ns3MiIPb0m+Jux353TaE
 2PveNrZe7Xh51Dp5D/dCNu/6OT/AcR5GT1W4PCA/3wppSR1BJxmdTPql+hTsgAnJisiVx7fQH
 2TFeupyUyGMJ+GJrrdQV2J358AfkRtshh2RoFAysMyQhivXkqsRjklKX+pVRhtbSjeQ4O/Ewd
 3l8SLRnPB1kGFIR6M9mNAJSgCQwGIFPDbCz2iskTVhNzNr43deU8orJFvT4bwXuX+FnEC06cX
 IDlYdLSpEL2+ytgshcKh7RQS9/QBoJ93SZVewpGkWkmrYbV5oSdkRr7EXpYyqEt7pfr4JuYe5
 M6cmrrjmjKarITwhKbbyUveAuF7AyLM6j9qLwOyfXtCLKMcMfhR+Ana/JfeAa5wmDrZfhEZem
 RXEtoRPcA4HDbCDLCukjQB0lb58hvB3Wd/bPwn0gF/aB8Cxx4c3xSMi1ZudSTN0e2xKv7PFFS
 lYlJwsUDulJdzydK84bobLvGsWvLJijAr7bbErJcDqts4oL7mPmvBVb4RAJkQtXQtX45zUjsv
 2J3SBKQlewi0YV3FQp9w+TyvnELmdinZJle+HPNSzEAD/hLzfCUWFbP/62mw9f5VPK4FBg0l6
 y6nSBt3FYGzo3n9JVsfTZu1upfil8iOsAfkkRlFRtDEvg/MLTl8k0skTz7iYhtenBdwQBHNRa
 GqFvic70rD7XDgJcAgxrwwOHqVHgg53btm3CXTKa/rC/BWUvdpx4ZM/Eile+cdITWa7436WkI
 ikWQ7efkfIYC7OOz8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> The details can vary also for my suggestions.
>> Would you point any more disagreements out on concrete items?
>
> That's exactly the problem with many of your comments.
> They're vague to the point of unintelligibility.

Was is so vague about possibilities which I point out for patch reviews
(for example)?
* Spelling corrections
* Additional wording alternatives


>>> But refcount -> reference count is not particularly interesting.
>>
>> Can a wording clarification become helpful also for this issue?
>
> This is a great example.  I have no idea what this sentence means.

Some developers usually prefer to use abbreviations at specific places
while I dare to propose the usage of another well-known term
for commit messages.

Regards,
Markus
