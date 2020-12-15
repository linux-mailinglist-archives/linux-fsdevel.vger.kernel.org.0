Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAFE2DA8AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 08:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLOHk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 02:40:27 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:38274 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgLOHkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:40:17 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 40B239215C4;
        Tue, 15 Dec 2020 07:30:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (100-96-12-130.trex.outbound.svc.cluster.local [100.96.12.130])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BAB93921CEE;
        Tue, 15 Dec 2020 07:30:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Tue, 15 Dec 2020 07:30:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Daffy: 6151692b6aa0cc28_1608017437001_2423627511
X-MC-Loop-Signature: 1608017437001:2334507784
X-MC-Ingress-Time: 1608017437001
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTP id 77E267F506;
        Mon, 14 Dec 2020 23:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=gotplt.org; bh=QCAl8i
        KLJYGU7HD3KJQIDIWx7P4=; b=BwjDSyAZkEHsmfJshfS11chqTjfxY3vlVJcxla
        xnt7HhdVvTsISb3XiqJELflGQBczTS6d2XiZ49SjxalzPYVU9vYhEUn4lGGZ21hw
        QzGWchcvSXVv/bRGPihptHwrHS+vJwh00Bd7bwwtM0qvI1Ud4Kt8DOkTv95a702F
        kUVFM=
Received: from [192.168.1.111] (unknown [1.186.101.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTPSA id D53F57E357;
        Mon, 14 Dec 2020 23:30:32 -0800 (PST)
Subject: Re: [PATCH] proc: Escape more characters in /proc/mounts output
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>
References: <20201215042454.998361-1-siddhesh@gotplt.org>
 <20201215061005.GF3579531@ZenIV.linux.org.uk>
X-DH-BACKEND: pdx1-sub0-mail-a35
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
Message-ID: <85e8114b-31a5-ccd6-f1e4-5b23a67987d6@gotplt.org>
Date:   Tue, 15 Dec 2020 13:00:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201215061005.GF3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 11:40 AM, Al Viro wrote:
> On Tue, Dec 15, 2020 at 09:54:54AM +0530, Siddhesh Poyarekar wrote:
> 
>> +	get_user(byte, (const char __user *)data);
>> +
>> +	return byte ? strndup_user(data, PATH_MAX) : NULL;
>>   }
> 
> No.  Not to mention anything else, you
> 	* fetch the same data twice
> 	* fail to check the get_user() results
> 

Ahh sorry, I could inline the strndup_user call and put an additional 
check for length == 1 to return NULL.  Would that be acceptable?

The other alternative would be to not touch copy_mount_string and 
instead, check after fetching the string and if it is blank, free it and 
set to NULL.  That seems more expensive though.

Siddhesh
