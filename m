Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B864740F9F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhIQOL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 10:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhIQOLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631887802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY+5cjjtOXLMGk6Ah71l6SEWU61dMBIeT5xM8p+8KR0=;
        b=N3kOAVN2zt/mQZnPr+fDemKaQpzn5baos6RCdxryrPmeg+M3tUAzch7oIpJeaxYamEsEPN
        OENF8ALxGWzwE6odwVPUaVWjvsCpnpF+qBY1lwRA1SG/0fAENVy2GPT2JujoDXNWBgbv1G
        /YKTTVv88Py4H4KQlrlwvZn4JCoZeNQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-gXDZftFlO9W-WB_hJzwlvw-1; Fri, 17 Sep 2021 10:10:01 -0400
X-MC-Unique: gXDZftFlO9W-WB_hJzwlvw-1
Received: by mail-io1-f71.google.com with SMTP id p71-20020a6b8d4a000000b005d323186f7cso11788654iod.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 07:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TY+5cjjtOXLMGk6Ah71l6SEWU61dMBIeT5xM8p+8KR0=;
        b=tO3up7ScMKDbS/I7KfqrTqKgTMXnJQmPOvmoxzgjK3pA9YuNaGTz8/6LzxRhefFCAq
         b3dGmcB1AH6zRm6X+jaskQOC9ZOQNj5gfN30sXyRe7Vr5HORTcjVsmEycQxQiPFPhXV1
         uPK1bWpRX8uPkzFr5MUNU89NfGs5k44QJIuN32CklKX/ZMs0DIDKaOTHBb1ehmeFnzci
         SDzcEYVdetUFvXx4yrgq1DwzxOtheLIrhB4Q4Q6aiz6u4kvqsRPU47qwQESkyzEH+Kzd
         vibOicevn08joki8S7zpTBxIKX6s8uzYqv1ifLiLbSrIwX8OuXE41TGAJcBBRfkop9D4
         ImxA==
X-Gm-Message-State: AOAM533dAFTOJmrXIIVjVdwytoRIQlfsxVXJs+Q/YNE/iOCxAW0oeMmH
        SNouqvzLeNdCDAS7Z2SKLrWFdfKz3WL1hBaqzRwB/VzsO2+hien8+91b+b7aokVHTurLsCchVvA
        TepFjLvlTeHQK+FcRi6C91Ua5ug==
X-Received: by 2002:a05:6638:2104:: with SMTP id n4mr8923962jaj.111.1631887800023;
        Fri, 17 Sep 2021 07:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm9IC36vEywfx+sz4ATVHgsWJakFIiFwIeDkiTlzPLoL0Wy3A7Ida5gfJjDR8YXmMbBcgHFg==
X-Received: by 2002:a05:6638:2104:: with SMTP id n4mr8923909jaj.111.1631887799266;
        Fri, 17 Sep 2021 07:09:59 -0700 (PDT)
Received: from liberator.local (h114.53.19.98.static.ip.windstream.net. [98.19.53.114])
        by smtp.gmail.com with ESMTPSA id c13sm3459309iod.25.2021.09.17.07.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 07:09:58 -0700 (PDT)
From:   Eric Sandeen <esandeen@redhat.com>
X-Google-Original-From: Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 3/3] ext2: remove dax EXPERIMENTAL warning
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <1631726561-16358-4-git-send-email-sandeen@redhat.com>
 <20210917094707.GD6547@quack2.suse.cz> <YUSRHjynaozAuO+P@infradead.org>
Message-ID: <88613c7a-5619-c038-16ac-f6383ad7943f@redhat.com>
Date:   Fri, 17 Sep 2021 09:09:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUSRHjynaozAuO+P@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 7:59 AM, Christoph Hellwig wrote:
> On Fri, Sep 17, 2021 at 11:47:07AM +0200, Jan Kara wrote:
>> On Wed 15-09-21 12:22:41, Eric Sandeen wrote:
>>> As there seems to be no significant outstanding concern about
>>> dax on ext2 at this point, remove the scary EXPERIMENTAL
>>> warning when in use.
>>>
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>
>> Agreed. Do you want my ack or should I just merge this patch?
> 
> Please do not merge it.  The whole DAX path is still a mess and should
> not be elevated to non-EXPERMINTAL state in this form.

Hi Christoph, "a mess" is tough to work with. What work remains before
we can lift the warning?

-Eric

