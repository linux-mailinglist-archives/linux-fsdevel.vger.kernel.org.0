Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBBD3A0EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 10:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhFIITA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 04:19:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhFIIS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:18:59 -0400
Received: from [192.168.1.155] ([77.9.120.3]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md6AP-1lIexq0haV-00aHkm; Wed, 09 Jun 2021 10:16:29 +0200
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
To:     Chris Down <chris@chrisdown.name>, legion@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <YLi+JoBwfLtqVGiP@chrisdown.name>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net>
Date:   Wed, 9 Jun 2021 10:16:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLi+JoBwfLtqVGiP@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7koxO5BYDpAqMJLkjAi8sQ3UCPPXcTQYX99ymXS5Xqgz0nlGGuK
 Hxb+ndUGgPuVDZUuZ5nTXtCvHrxWi4iW5JK0j7U974MtjWtMY2aS0VLI/KED+rz6ayZZcA4
 Xx0b/USmKF42nW+OADIYE9NI4u/lRQ5grSAxY4BuHtuBMJUcJGwP8P+bG/xzNZubYSDqN5Y
 CvXBoBECUCVPaja1xu0uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wo5zd+VdzY0=:WzJo4B1hGsN1c/G3OJ0Xqi
 6bpG3QrMz5EWv5/XdALXVYgynfY8jHF6cxC7hhR2eU2/KHVsemxVCEraCnDbGV53VFq6EnrN8
 YQpMSx+JVivz86PrADc2V+zC0jT06VAeYEOSKmg8swZ56AkcZDAzVS79YbmHeRB1IJeWW0RXf
 BjRzusAphKr5cqYTAuAFaasm9whF+e8iwijwWttQ92Illd9ID6Y4aessHWfAiYZyECH1RpWrQ
 lyV7Mvu7T0dIuaG4IQKEcRtk0BDd8BI9r90T8R+4kvYa4ZzpV/psMBg9f6+ebwZ+kOdSBHTQR
 hhxk7Qabba6bWe8261ONlT8xDldTIAIMqE5UpWg1nwK4xhZqAoKW477qAeeKDNjDzTw1OXn3r
 vuTDCU5CfxyHcXDFDDPDmBk9tPOe6a8eGXLo5Ei98A+HVdcPrMacgSPaJdcavMwBWqkK/0dOi
 q4XlbR4XfeoLD+0Nv0/QdoQgyq5YpSVeCAdJaI0oPxn+HTLmFszQMLleS73jOaVzWhxpPNWlp
 zWWEXt3f11Y7HY4FlDEUm0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.06.21 13:33, Chris Down wrote:

Hi folks,


> Putting stuff in /proc to get around the problem of "some other metric I 
> need might not be exported to a container" is not a very compelling 
> argument. If they want it, then export it to the container...
> 
> Ultimately, if they're going to have to add support for a new 
> /proc/self/meminfo file anyway, these use cases should just do it 
> properly through the already supported APIs.

It's even a bit more complex ...

/proc/meminfo always tells what the *machine* has available, not what a
process can eat up. That has been this way even long before cgroups.
(eg. ulimits).

Even if you want a container look more like a VM - /proc/meminfo showing
what the container (instead of the machine) has available - just looking
at the calling task's cgroup is also wrong. Because there're cgroups
outside containers (that really shouldn't be affected) and there're even
other cgroups inside the container (that further restrict below the
container's limits).

BTW: applications trying to autotune themselves by looking at
/proc/meminfo are broken-by-design anyways. This never has been a valid
metric on how much memory invididual processes can or should eat.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
