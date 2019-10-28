Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7546AE703E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 12:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfJ1LUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 07:20:55 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41610 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbfJ1LUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:20:55 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3ED9B2E14E7;
        Mon, 28 Oct 2019 14:20:52 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id JysqeZpZ3P-Kp9ud7sV;
        Mon, 28 Oct 2019 14:20:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572261652; bh=8XwSiEkPC9qn9resugp5JbDrv4IyCtiDq/CQDPF6oiY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=aOTb4mCQwAKdSGLq1PQZE9I3SRWh+HZt0QF2TTF7e2a6SV9hJ3A7PG89Jvw3hRubY
         R5QiEkOs+cvQ3gUnXVOkPCgOBUEVuXnf6Y5l7B54F+tiZezohUk7rtBug8VpmKj2xU
         oHG4G0QDMPHmsDBnO0SrSQtH+cD382KMs8OyukVo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by myt4-4db2488e778a.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id o1Ru44CYmh-KpVKoKKg;
        Mon, 28 Oct 2019 14:20:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
References: <157225848971.557.16257813537984792761.stgit@buzz>
 <20191028111034.GS2963@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <33978ec2-ac27-1b8b-ba33-3bd2c66aa016@yandex-team.ru>
Date:   Mon, 28 Oct 2019 14:20:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028111034.GS2963@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/10/2019 14.10, Matthew Wilcox wrote:
> On Mon, Oct 28, 2019 at 01:28:09PM +0300, Konstantin Khlebnikov wrote:
>> +	if (dax_mapping(mapping))
>> +		pages = READ_ONCE(mapping->nrexceptional);
>> +	else
>> +		pages = READ_ONCE(mapping->nrpages);
> 
> I'm not sure this is the right calculation for DAX files.  We haven't
> allocated any memory for DAX; we're just accessing storage directly.
> The entries in the page caache are just translation from file offset to
> physical address.
> 

Yep, makes sense. If RSS declared as memory usage then this chunk must do
pages = READ_ONCE(mapping->nrpages) unconditionally and report 0 for DAX.
