Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C931EE7228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJ1MzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:55:25 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:44650 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728269AbfJ1MzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:55:25 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 71BB12E09CF;
        Mon, 28 Oct 2019 15:55:21 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6aykFKr5ke-tJBSrcoG;
        Mon, 28 Oct 2019 15:55:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572267321; bh=8ZYFRTzWqu504O6KQ7FUcpox3cZWhyoBz5ojDPWSmYE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=vBo73IPUe3lrjMad2DFnaYStzbQtHX6+YDN8Zspbs17A3PUhAE2CpNckQRNrj+NQH
         Fc/ykjTuHoaEP25SzA0GilwBqxkYuDk/Vog1pEEZ+1V9GKWmEN/wj1TMj63mquBT+n
         9bq3FElt7uiVv3dj0zaldvpCQ2e4tNqLPw32lFcQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id HgRUn4uEtY-tJWiB8BI;
        Mon, 28 Oct 2019 15:55:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
References: <157225848971.557.16257813537984792761.stgit@buzz>
 <87k18p6qjk.fsf@mid.deneb.enyo.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d7e76bee-80c3-d787-b854-91e631ab29cd@yandex-team.ru>
Date:   Mon, 28 Oct 2019 15:55:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87k18p6qjk.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/10/2019 14.46, Florian Weimer wrote:
> * Konstantin Khlebnikov:
> 
>> This implements fcntl() for getting amount of resident memory in cache.
>> Kernel already maintains counter for each inode, this patch just exposes
>> it into userspace. Returned size is in kilobytes like values in procfs.
> 
> I think this needs a 32-bit compat implementation which clamps the
> returned value to INT_MAX.
> 

32-bit machine couldn't hold more than 2TB cache in one file.
Even radix tree wouldn't fit into low memory area.
