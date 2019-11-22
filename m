Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE5106A1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 11:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKVKbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 05:31:51 -0500
Received: from mout.web.de ([212.227.15.3]:37665 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfKVKbv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574418620;
        bh=O2UnRxlxavQ5jorOhKL9yhuALJHowD/hkaHhoUSfn98=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lrz9yymJw9DpZHSlUVqEgCODeziDha6ztDmG9/RjxKgMcndA6u4a3fO4ZY9M5ZUcA
         xETQnuAfE9/dvoMYdwh46Bq8Y/Lgb7V4CrJqclSfggr/hRfET3Jkl+8PeEDAIpBJrO
         0jE95efbesVhyqLYQMtC/505MUdFXO7kLJmCXtHo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzKJV-1hlJ7q3qsb-014Vq0; Fri, 22
 Nov 2019 11:30:20 +0100
Subject: Re: [v4 04/13] exfat: add directory operations
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
 <20191121052618.31117-5-namjae.jeon@samsung.com>
 <498a958f-9066-09c6-7240-114234965c1a@web.de>
 <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
 <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de> <20191122085242.GA19926@lst.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d8db04fd-6e6e-7912-6725-10a1840bc5a7@web.de>
Date:   Fri, 22 Nov 2019 11:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122085242.GA19926@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:UyQojwwGufTGcLRdg5g9YTHTR83YlNmDROOWK71bSlCvfv+pM3B
 xLKrSLvAS8m+w1fXejKHhNk8TOjq9JzFLsKFnZDYgOSffcL61y/T4cUIIQZQgvB1MJvDIcR
 aC6SnfMuKRl0MxaSbHw8wLKX778OIXv6znSmDHTDOWmsJd5lV2AjSFetL7fxU5Xr++60eax
 m2N/Nv4em+TGuTWIFws0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yMv+jCSneRQ=:B5u5vVeJvDsWk/GDVpjDTA
 QCZZ9fGcH7PirFJg/5xfbbPNZKEBrkSVHYbM7Gp4FY5ToKnHpOVZuBwJFCnRfTtxyhILHLDys
 5BdDYCWzi/sN7ld4iwAFfpij8SF8jt3zL+noP38whP+p9mW08dlVlSPcm5NK5nGF8wamH5VyJ
 fBHAT5tmn3U9cw871xHN/HI5LTioOrBugpUx7Lp258YlPudMRFijKe317WS+lUxHTuAvV+csd
 hMB1Uvp6j+7w8eh4CmnQ8GfHhzdWh/2oJRmaa2XxzF/ZhzXKrMdiQmWP5amAe545xINX6kWDu
 cZsqE+AkJXHqmOyMPuaFjs0rYXBzYY3bFzqeqw4Fbywl7OnkV2EBmLFYkaxWnciB8PTq2apMQ
 Jjh/mJc0oYyVStm2Vwer21NokYay8lx+HfNyrnhrODsAUW28kpD3s0ygHtaSXyh90J6Qi2IjN
 91MhWc9+AdFNbVUh1z+OLEgQDZGs7QRtXusb2gG6RPy4Hc55uiF158FYeko6qc6uIVHYl6Wwk
 6SLJKYKMIxzFsZUIfgM+d1cbBghjuZiAuGD5JOv/fjDpC2a7ijaoI/pGOn566HIdwVDaNiIMI
 kk0HhCXCYsJyczlWYq/dT7pYrwY8F3swrHv2e9Amu8+qBoE00WdNlchCXC5lLjQCGQG48O47e
 818FEn/ASPxxUmp27hSaEDPBDhSMyFHYUz2N0Np6ubqzrEDwfqUWKthx8TjVWsaj3O2VvY5xH
 R+/veeiLuu3TYqeOEXXO93oOMHkX8zxJlU3qtS28xBdg3qsrKXMRwNT8PusyTH/PlWVJaolu1
 lXgdW7JAnmttxdQJKNs0JDbgJPJkmiC81KyHZBrxi5j4q+UOoTvmEgTGvTfWv4rWTq8D7SYB2
 tqekEF7eBaSRjOORcnQ7sUHYo0qre3M77vE26IxwG00RGZW1y+/F5XBSxxyVGAFGCkp+TriyG
 SiVr7McQ/LpM22wonnLzzGbEOS+51qGNysgkgujJW0giucPAACIC7zEqrEOp+24hjJsSD1u0V
 qnnZ36+A/6f86taol8X54Vfnewe4cNDffoLcyt/Doi4vswEXlM/s0ASNfG07SxV/bFA7IwF17
 hmWJPeGeEQTWnRkN05dcb2BN0ycqCm2uXLK7I7JLdc+jpIqmlpxz890+/YNimLX357HWQ5Jcj
 AyVD9+2b4jgnuMYm/oqQfv8hJgbRUMV7S4rDnqdfCO5m57BAgsoYMWoQDoA2v3WtTdUQ6W9An
 OfyrzpU2+E7ZpSLbtdwW1alRTeKUzED2mA+VrHGTi/BOQgliJ+6c7Tq+OHHs=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> please leave people alone with your opinions.

I propose to reconsider this suggestion.


> They actually do create value

This is generally usual.


> and don't need your personal opinion on coding style trolling.

I got the impression that some of my views fit also to the usage
of the Linux coding style often enough.

The clarification of different opinions will hopefully trigger
further useful software improvements.

Regards,
Markus
