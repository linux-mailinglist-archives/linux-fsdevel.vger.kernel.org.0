Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C5E1BCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbfJWNJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 09:09:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43625 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbfJWNJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:09:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id q24so9722750edr.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NinmgajUCfhO7+tZ41dBDs+Wf/QWxDVGKSCH9dLTzRQ=;
        b=Ue6vcAWXJumSy35CyULE52NwN/O5lBkjnv9W+NBFTDwFNKyvVEU8n3GtW0A6Ip5xMM
         jYmD3UgNWmMoM/ChyG9SxPC0xzUCQv6UAixpeQlQQ2C3zJ59PtOIwjk0ObIiKceehjFZ
         7nyLriOsglh0IubE9caMlAhyGbJwrXIG9V0phNMTWk10nfiM274GVzS8FLdwugR8M8k8
         P1Xo6dRBAs+FK8SYRwmsL6zEFZfJH/RkmxttRQvnzuRKKaDHtjgYfnBWBesfjGf4LIRf
         AzPBR2eR/JBYl9QxjzDlx/EUBfEfjgMcI5SBMS5WscFAhrN+0sft4P4GrzYn5jDd2HQZ
         TFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NinmgajUCfhO7+tZ41dBDs+Wf/QWxDVGKSCH9dLTzRQ=;
        b=nIPEtjTIAWi5Jf/JLok7Xhptqvg+Ce8N0wuiydpgLRbCXZz2k1FARjCJhK8jA4Zh5g
         IBvl1w7CyiCC5Q1Pa9GvBBfce0sPLALymrSrs0z0JR6N+FO3CJEcy9OpN/8705shJxp6
         scouiJ1NODlFLDyrZI7MxdTryoZ8eWh7/juScb1jmz+OBDn7kzuYSO8zOA0j6P/g34Cj
         63OJECbgON29Aq8Hpmrw1Sj4kq8Na3Aeckn/USs+ISuIrKB5yqeltycAe2Lk2nR9mXEP
         kg54Z4ERBY1aXPusv7F8jZpmDNY2/1asNWpah1YU6LDP4X/uiqhHRpRXu9HRzbhTWMzU
         fU+Q==
X-Gm-Message-State: APjAAAXrTAzR5+QgDj5dDIcfFnWiewphOgyHUiZyHBYfA9QzEYsNb/xn
        aLiNfqrfB6vucseLFdP9S4Sr4IfGpok=
X-Google-Smtp-Source: APXvYqyRh5PulbU0JdPquFxyjvevhPD2754GjlUlLCqslOvV0Q+oG+GG6pV2FwjfcFMZbk+F1TJ4mg==
X-Received: by 2002:a17:906:7212:: with SMTP id m18mr32604441ejk.88.1571836193408;
        Wed, 23 Oct 2019 06:09:53 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o26sm115518edt.55.2019.10.23.06.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:09:52 -0700 (PDT)
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
From:   Boaz Harrosh <boaz@plexistor.com>
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
Message-ID: <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
Date:   Wed, 23 Oct 2019 16:09:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/2019 14:21, Boaz Harrosh wrote:
> On 20/10/2019 18:59, ira.weiny@intel.com wrote:
<>
>> At LSF/MM we discussed the difficulties of switching the mode of a file with
>> active mappings / page cache. Rather than solve those races the decision was to
>> just limit mode flips to 0-length files.
>>
> 
> What I understand above is that only "writers" before writing any bytes may
> turn the flag on, which then persists. But as a very long time user of DAX, usually
> it is the writers that are least interesting. With lots of DAX technologies and
> emulations the write is slower and needs slow "flushing".
> 
> The more interesting and performance gains comes from DAX READs actually.
> specially cross the VM guest. (IE. All VMs share host memory or pmem)
> 
> This fixture as I understand it, that I need to know before I write if I will
> want DAX or not and then the write is DAX as well as reads after that, looks
> not very interesting for me as a user.
> 
> Just my $0.17
> Boaz
> 

I want to say one more thing about this patchset please. I was sleeping on it
and I think it is completely wrong approach with a completely wrong API.

The DAX or not DAX is a matter of transport. and is nothing to do with data
content and persistency. It's like connecting a disk behind, say, a scsi bus and then
take the same DB and putting it behind a multy-path or an NFS server. It is always
the same data.
(Same mistake we did with ndctl which is cry for generations)

For me the DAX or NO-DAX is an application thing and not a data thing.

The right API is perhaps an open O_FLAG where if you are not the first opener
the open returns EBUSY and then the app can decide if to open without the
flag or complain and fail. (Or apply open locks)

If you are a second opener when the file is already opened O_DAX you are
silently running DAX. If you are 2nd open(O_DAX) when already oppened
O_DAX then off course you succeed.
(Also the directory inheritance thing is all mute too)

Please explain the use case behind your model?

Thanks
Boaz
