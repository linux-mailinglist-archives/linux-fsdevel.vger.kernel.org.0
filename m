Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C88152D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHEJQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 05:16:28 -0400
Received: from mout.web.de ([212.227.17.12]:59477 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfHEJQ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564996551;
        bh=Lava83WeBTNK8y0fCWBr4gFIIH1fgDIi4D+2PbA2nU0=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=pzQW1nJ2QLBQ3ybzRgwjeBtTCCovoDBhTcB2Vc7qxtPQlG8qnQaZilNFrj+HOfJI+
         JLseAA5wtz6yePbs59dweQGAPleoE4Nbd5dwd/phz6qCAslHR65F/DRpGOKqlWHPwT
         pi8MeYk4JiXLM4m35cC11Sp02a9v0cdL5qObIfoM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.163.134]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGign-1i7R8o0rDt-00Dbph; Mon, 05
 Aug 2019 11:15:51 +0200
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Turchanov <turchanov@farpost.com>
References: <87mugojl0f.fsf@notabene.neil.brown.name>
Subject: Re: seq_file: fix problem when seeking mid-record.
To:     Neil Brown <neilb@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4862a29d-7e4f-5bc5-dcde-ec9ebafa1ff2@web.de>
Date:   Mon, 5 Aug 2019 11:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87mugojl0f.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:9ylnVCQNAG5orZXuJ9ZxrYVpvRCVqK+52CmbzkWsf41XCQb7cKP
 QXs4cHylFMRhnTWhpP+p6+rrmNo++pltAmn1RQqHz4YwiZTeskYcbcx0UWKGL/LCmn3dca+
 47QKsvnKtT4qgS6fw/FMFrC680G6SQR/ZI6U3Hx+bjqniQOv76bNE5uU32PHFHni1O1wFIh
 5+adhy9Ni29P7B8ipIpJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dl/XEqIFSTg=:06YvczyAcvsDyMgOMlM5Dh
 uUrRGo8oAe7E7tY6+WrNrN6Mwms2dYrkAFggMV5D1SWsM0Pq+Okgq2JksnPTaEwVzcT0rQ2om
 dEh1jsCLUStnBlatv3ZAPbO7KKFU4Yiw7l/q2WC9cZv4dRvVTMjWVxig1LTn1MHBN8lSU9rnT
 Ic5jPKmO/LT7P6O0D9BPlm+eAUjuRiaO5il5RklngYzet+xBk50V3lHdetdU9KF5jsnFyR3Ct
 KVLnKXrw4flgqb5zYtS22/2dUQPqq+TSLU1Zk9U5fMkG+SLQBJsVehKE6q1GaPFS7KEaRl/qL
 UvbW1SZ2Nz9x49U7/31M954a4yeSzat/iRwv+PnEvrr5UjBT3bKZ0cHwOThgZd/mQpfxs2QVA
 p6dTBWdGvZItIIMp+njse99ClHQhprG71TRAoYTPRnZ0KiwYV+miOn/GiWI7M3GgvwiVjikPc
 22nCRvzlc8wyIRqhScoqQaZxqV9aG0Ab1oDFmX7Spd04VEzkqFPUPXXuZ71CKFhIjD703phnR
 V+oDhJ6N1XZkKCz4udlIbO+GCm3T+G6aQ1r5S6xfdkHo+3o3IsnM64YhN97Ah7NvhFuODSSTL
 ihTOKF9feTN+tZasphLTTf7S8mEInBinC/tX7ILJZFUIcWFa8PmDf5VDK2nWtjPlYbpJ2uceZ
 31q3zBmC4DdW8udyTMs15tuGOVIRCltnVssJZiovoyKpWNXqATe347G+cJUlqCeg/+pAi7ndY
 bFZ+TJOWvn+E7Xt1t0aKXxsWzfOcaJw3TZKHY/QGaWabTArZIM3qfoTc9i9uzHO8nk5VQK2YP
 ymrARk9eTqkPxP4FM6RrB4OdxG8ffbL8LKy+bjNBGsiNnHb/FJHTTsMq9FkWJYv1oVj4cpXT7
 Vagkq72UBR+iK6vsFMEe0W28gga4aprQdl/GhpXjlABpioH88vMuVd6EbN3iF2FPCgAhDzGlU
 H3eJwPLWZ57F77PNnFbqq4AhAoY57uUzAkTHVEWXTnS3+VuahdC2q8D3xu163ngfq0gNvOuC3
 egt1wKrRSskr/+7WrwYRx/9rusrIEwQMSEotsm5mTPXN+Whx/88c5I3niKWGPMbe9xfvM2RpN
 J+6QvR1RBDoOcvJWN0XXzD0Yg84JO+dL9soidkO77IDsTZre9Tnvdh8vHbB2XkPuO4i7klbxu
 BKps4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> 	and interface")

Please do not split this tag across multiple lines in the final commit description.

Regards,
Markus
