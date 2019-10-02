Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A100C46DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 07:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfJBFKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 01:10:15 -0400
Received: from mout.web.de ([212.227.15.3]:49933 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfJBFKO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 01:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569992982;
        bh=kEfl/Iv1CCzaybc5hroeM7fCim74t5N0mvhbCmJZhh4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c6Eaq4dGph0GZ/0fGzCqtYvUDgn79Ds29dpAhILOUn4ZpiYVUP7VpS/xhzLvH5tXh
         eaRfSka82OYYoBVX8e697FzZjv5GUCnfpvc38orz44Ahrq9C3eBrlheRVJxD+5mS/T
         KEQSHfGWLpnjLjaKWYGcUcdR7D0vmnhtXLbMWJ6o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.73.205]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtWsu-1i5o7004ii-010xoE; Wed, 02
 Oct 2019 07:09:42 +0200
Subject: Re: [v2] fs: affs: fix a memory leak in affs_remount
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
 <20190930210114.6557-1-navid.emamdoost@gmail.com>
 <44ad775e-3b6f-4cbc-ba6f-455ff7191c58@web.de>
 <CAEkB2ERMqs=xbt4H-1ro0zAQryoQUH=N5iJop-CKbSOo_mTk3w@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8cbd4afc-86ce-4023-febc-e617225d2cbe@web.de>
Date:   Wed, 2 Oct 2019 07:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAEkB2ERMqs=xbt4H-1ro0zAQryoQUH=N5iJop-CKbSOo_mTk3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:SH9bXmHoM2t8W61xxfhNfBxJZf7ZQdex+AyWJe9M05DjfHYbOcq
 oThEi1EVw8FiQysEDDfgKABcSUUPOaRShI3rIxTlTItWseVl8ZLFgBLQE9bA3xoJ9z0D1o3
 rsE/Lbqpl3zOvtYwxfBytk2BekQhJVMlQhhbJJK/UyS9pHDThtQtcabcceiiocDYLqD/DIY
 etFYSCi/ZAwCH9/FJOZ9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LwbZQyr0ln4=:tStxlpIG9X2biGfiBuzMww
 DJrmttCqhnWUeS1lfEtxXRzB4ioe65E+rrzaFv0S3XQLbzmnt17JmGaCjT2fpMZsCEysQGVaz
 jDLNiEM0VehU73H60qSAmhuo7buWznc+nNusoo8Dc6Oc2HpLzMFqiXp6Lcj2Q/yqpeF8eW3rv
 zknMPL3QIA5NoXzhZmVvsM5Dx3I8NjB09tYUJCkvjeO49zdiQLofwM1JlkWPsdOp7xDqBwNJs
 CoqRwZwVHQ0zzu32CA/jgxNhJIjUN6c6rejM46zsnYEA/2d/gJHTemHf56BWjLPU5UOBEIroQ
 gdO8bVJj6aEyXdtLYueMYNg0TDh3D4cXBNJjf4owk2MxPnsWea9cITD0P1/t4i3vZVv4vqIBK
 YTCAC6Q4AT9ipS5HjGsXXPKCrODRYwc6vZAywu8N7eI1GoyqQbEA2Q1F7gJgTC5P38/p106+q
 OijzjNpp157s4RfeBIA+YEmozJecCAL3UxCsdthWyCSPArC5QqycH2RMnR0j9TDuh80uxi2F6
 es6LkqaNB3d+9pm1GgIECNhEC5lJu1ycHLURE3sbmhchA6vFOtclK017u/0TAgelM9jVm78E/
 v/pOTMg+Qdp3h9CObmtRwSzoPkRqgBXSEs9gf8WI0WLpMBXyc6qesYoQxSODf5LA8/qMdfd5a
 rlafovwpCAgv1jjDOnnV8fMbM1gxxcyqD6EuPQhxq8ssSz7+9IoJ6CwY3Bz0KTJSRnn1SSjjf
 +A8XXwfwgFrLE4iLdfaBWljncq6dwCKMQL971WNMyYpmtjeyGzPFH/G9h3W679wq6ZlEVcSRs
 AzIA7fmVYrrpTj1j0wfZ+Ezh73VduzZv7jw58nt5/AmVoExyQeH5m9+0q8wVlL5/2DijEgu7+
 gCiHW0b9slctpuggomYRrcKU3x5ydcJyRqc6jOHZOdOB7bp+n+e3lgwEzlAwV+QTuqtgrgTXe
 uH1cStFNt0h1u8pHlcG0TJZ1Zxujnmu5asN8n4P0UF2grMlHtJA0PcaI+wtgqIrR/gdomG/G8
 fOPqYRFIj+oZbhWPHnDI2P5Y3ed3dO3xlnKjm756jbJCMzCF5z4+kEjdrkHD5wszfr2bqIvTO
 lKVurdXT+77Dp9TgmIWUK87f2C1rqQ4d0PFPlWq7sHRGbUBzqcchqMHt05+HXrMDc8hBX8J1/
 3iPTE/VIof0caSsHFEsK2uwtwi8T+4m6fnzX+uVRnhx+Hmjv3ZZdujwYxzJtyk7IrtAU2y8nW
 OeGJQXm4iWO3s/v3Z5z5Xdh/DFe/ahyqFMDdLjGwBJNb7CYJwLiCR0wPtoxI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Markus, thanks for your suggestions for improving the quality of
> the patch. At the moment I prefer first get a confirmation from
> contributors about the leak and then work on any possible improvements
> for the patch.

Please fix this patch as soon as possible if you care for the correctness
of the provided information.

Regards,
Markus
