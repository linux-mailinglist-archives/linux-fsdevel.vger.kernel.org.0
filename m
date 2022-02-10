Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF34B17E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 23:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbiBJWEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 17:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbiBJWEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:04:23 -0500
X-Greylist: delayed 7746 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 14:04:20 PST
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBCFC5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 14:04:20 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id BB2399BBC4; Thu, 10 Feb 2022 22:04:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644530658;
        bh=X5iH7SAXsVOy69HNGO0jcR/yN9f9rLAWo9cX5938tXM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=UoHE+3tEXYC0q3Yfgtq/ZNYj/Httzq7oDqaXjDAVGtHzOVAmOw2Qf5aGW0K8fOPcn
         zwYlET5skR2KfPdKTv968VVeoF02k7OdyoVe5kizW+wWi5ArxyH/GYkwYOqECN3jM+
         xs+KXTwhcxLBp6zjt69GHVQV0WLNz+wQbtADGR1JD72CeeLozrezPpLPXYQTZD1g7N
         uRBoD13YouhSsIViQXsmIIW+vpjiagLSnnR+besagmtzLfsI+h8bmdARXT/4QoJR0E
         +7FmIdDLgQoracy1ieQHja0ODm38QJmaA9Th4a6TrzFVDDNF9KMZNQgnaGArO/BxFF
         8nVW/nf61TKKQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 04A019B7DE;
        Thu, 10 Feb 2022 22:03:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644530607;
        bh=X5iH7SAXsVOy69HNGO0jcR/yN9f9rLAWo9cX5938tXM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=XLeibTCJn6Ss/QhGIhl8IqJM4uypd/5sSZLqzKuF3wzX51R7WO2GFZgPma37YqUOA
         9Db9NR3JvdVFZAnGmIDG8VY8r+RrvdPZe93F6ha3cWtPUfZOuYHDy/OkQseOshuJhC
         F5S5IyaNlxd9fFLMRT6EcqccOTKC9JV6VMMEcZLPXRqvm3k5tE7KFgkNqQjEqsYnnN
         9TZkf6jjNMJdfg1bb3ltqe587FjFQD0i3Le9120YNCUmhyf6FsPy4Y97d7jn2SSpQI
         Ah2ACk64AU5pdBCGqeoaISVzkmaIud70hOVzHpyvDVz4nSUo6q+KgL6ilKhi9nDZ8f
         5JYI/+/UlklRg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5BF2911EFD7;
        Thu, 10 Feb 2022 22:03:26 +0000 (GMT)
Message-ID: <938de929-d63f-2f04-ec0a-9005ba013a2f@cobb.uk.net>
Date:   Thu, 10 Feb 2022 22:03:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
 <20220210213058.m7kukfryrk4cgsye@fiona>
In-Reply-To: <20220210213058.m7kukfryrk4cgsye@fiona>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/02/2022 21:30, Goldwyn Rodrigues wrote:
> On 19:54 10/02, Graham Cobb wrote:
>> On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
>>> If a read-write root mount is remounted as read-only, the subvolume
>>> is also set to read-only.
>>
>> Errrr... Isn't that exactly what I want?
>>
>> If I have a btrfs filesystem with hundreds of subvols, some of which may
>> be mounted into various places in my filesystem, I would expect that if
>> I remount the main mountpoint as RO, that all the subvols become RO as
>> well. I actually don't mind if the behaviour went further and remounting
>> ANY of the mount points as RO would make them all RO.
>>
>> My mental model is that mounting a subvol somewhere is rather like a
>> bind mount. And a bind mount goes RO if the underlying fs goes RO -
>> doesn't it?
>>
> 
> If we want bind mount, we would use bind mount. subvolume mounts and bind
> mounts are different and should be treated as different features.

Yes that's a good point. However, I am still not convinced that this is
a change in behaviour that is obvious enough to justify the risk of
disruption to existing systems, admin scripts or system managers.

> 
>> Or am I just confused about what this patch is discussing?
> 
> Root can also be considered as a unique subvolume with a unique
> subvolume id and a unique name=/

But with an important special property that is different from all other
subvolumes: all other subvolumes are reachable from it.

