Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7806034887F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 06:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYFZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCYFZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:25:16 -0400
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D3C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 22:25:15 -0700 (PDT)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:36760 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lPIUU-00020F-2a; Thu, 25 Mar 2021 06:25:06 +0100
X-CTCH-RefID: str=0001.0A782F21.605C1EB2.0066,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=FWiIUfzfzmg/UyJPfZ5eKC2jY996A0w7LSl0n7TyuhI=;
        b=t0Mo6LM+gA02x5GYCB73fbR3J5es6lKfyIiKIUMD5LEMGp5Uh5NDX2IaNdsg53SWku/80LUQOR0JGY81G8iwtD+y9xiHkMogglqmDnPA9Em8dRuTe5WcWdId/sojkGnZ7p8OybJLEDz+XkNIK6FXeGWPrKn804H4WRwMonpXjUo=;
Message-ID: <e95a8960-199b-e114-e5f9-e5879a9466c3@dd-wrt.com>
Date:   Thu, 25 Mar 2021 06:25:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        'Sergey Senozhatsky' <sergey.senozhatsky@gmail.com>,
        'Steve French' <stfrench@microsoft.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com> <20210322064712.GD1667@kadam>
 <009b01d71f71$9224f4e0$b66edea0$@samsung.com> <20210323071945.GJ1667@kadam>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <20210323071945.GJ1667@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f4c:a900:4051:3fe6:eb8a:97]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lPIUT-000IIE-CO; Thu, 25 Mar 2021 06:25:05 +0100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 23.03.2021 um 08:19 schrieb Dan Carpenter:
> On Tue, Mar 23, 2021 at 08:17:47AM +0900, Namjae Jeon wrote:
>>>> +
>>>> +static int
>>>> +compare_oid(unsigned long *oid1, unsigned int oid1len,
>>>> +	    unsigned long *oid2, unsigned int oid2len) {
>>>> +	unsigned int i;
>>>> +
>>>> +	if (oid1len != oid2len)
>>>> +		return 0;
>>>> +
>>>> +	for (i = 0; i < oid1len; i++) {
>>>> +		if (oid1[i] != oid2[i])
>>>> +			return 0;
>>>> +	}
>>>> +	return 1;
>>>> +}
>>> Call this oid_eq()?
>> Why not compare_oid()? This code is come from cifs.
>> I need clear reason to change both cifs/cifsd...
>>
> Boolean functions should tell you what they are testing in the name.
> Without any context you can't know what if (compare_oid(one, two)) {
> means, but if (oid_equal(one, two)) { is readable.
>
> regards,
> dan carpenter
ahm just a pointless comment. but
return !memcmp(oid1,oid2, sizeof(long*)*oid1len);
looks much more efficient than this "for" loop
>
>
>
