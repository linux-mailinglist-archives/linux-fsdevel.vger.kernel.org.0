Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7438C8A2B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHLPxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 11:53:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37342 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLPxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:53:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so3072630wrt.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 08:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4DKVopx7Nt9Ima+DLY8Fb9/9+/EpjgOuRGGadWubLw0=;
        b=JsxJqYkWfwsUqfhDF0bwICvAl0WHLOTALidWOqOfFlJs7GVGsC+5rqyUUhxmW7vmqT
         UpUQfQGSLoIIBOKrqeDIU+2ztYJ4YRZ1fg7zKbLXq6ruGPpLE/FEPYPu76pNxPH12W5I
         JYkElmHvzZ2VnZYbfq+Juil31GFAnVAne6Ug8GMgR/BimTOycPIXXFXIOpsGbhZHMlLe
         py/A8YG6z/PC7Ke01wMwtKWs/UR2uziv2CmbllrQcH9XmXZn1IX2vd4JlBG1unfsoZfy
         4xS9Oo2LUbKWEtF9gX+Xr73Jj/lA9vy6i9rZvS5I8y2jcMgFDdpFSPFhp/FJgd8VIYtU
         ZCeA==
X-Gm-Message-State: APjAAAXXGYEMHrcGiS3QI0ScfJAueC4TMT60KLv02kO6KITRO/xvCzbU
        P6N/MXplJhcktWJ4cfcwshX/ChY5Qt0=
X-Google-Smtp-Source: APXvYqxX2wnjKllKQSi7tYQkhwitZBogn5QqAx+i9na2e6GRIBB1rylleDpjnJfq47trC92ow3lR6Q==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr40785618wru.246.1565625227583;
        Mon, 12 Aug 2019 08:53:47 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b3sm4409605wrv.43.2019.08.12.08.53.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:53:46 -0700 (PDT)
Subject: Re: [PATCH v12 resend] fs: Add VirtualBox guest shared folder
 (vboxsf) support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20190811163134.12708-1-hdegoede@redhat.com>
 <20190811163134.12708-2-hdegoede@redhat.com>
 <20190812114926.GB21901@infradead.org>
 <b95eaa46-098d-0954-34b4-a96c7ed7ffa2@redhat.com>
 <20190812141701.GA31267@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1e9b72d8-c69e-03a9-8a38-bf2ea78d77e9@redhat.com>
Date:   Mon, 12 Aug 2019 17:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812141701.GA31267@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12-08-19 16:17, Christoph Hellwig wrote:

<snip>

>> The problem is that the IPC to the host which we build upon only offers
>> regular read / write calls. So the most consistent (also cache coherent)
>> mapping which we can offer is to directly mapping read -> read and
>> wrtie->write without the pagecache. Ideally we would be able to just
>> say sorry cannot do mmap, but too much apps rely on mmap and the
>> out of tree driver has this mmap "emulation" which means not offering
>> it in the mainline version would be a serious regression.
>>
>> In essence this is the same situation as a bunch of network filesystems
>> are in and I've looked at several for inspiration. Looking again at
>> e.g. v9fs_file_write_iter it does similar regular read -> read mapping
>> with invalidation of the page-cache for mmap users.
> 
> v9 is probably not a good idea to copy in general.  While not the best
> idea to copy directly either I'd rather look at nfs - that is another
> protocol without a real distributed lock manager, but at least the
> NFS close to open semantics are reasonably well defined and allow using
> the pagecache.

Ok, I've been taking a quick peek at always using the page-cache for
writes, like NFS is doing.

One scenario here which I still have questions about is normal write
syscalls on a file opened in append mode. Currently I'm relying on
passing through the append flag to the host while opening the file.

This is fine for address_space_operations.write_end which AFAICT will be used
in case of implementing the write_iter callback through generic_perform_write,
this is fine for write_end since in write_end I have access to file->private_data
and thus to the IPC handle representing the open call with the append flag set,
so I do not need to worry about the host having changed the file underneath
us, since the host will make sure the write gets appended itself.

But what about address_space_operations.writepage? I guess this will never
get called as the result of a write call on a file with the append flag set,
right ?  So I should have at least one handle around in the list of open
handles for the inode, which does not have the append flag set, so which I
can safely use to writeback dirty pages coming in through writepage(), right ?

Hmm, looking at my current vboxsf writepage code I see that I already only allow
using handles which were opened without the append flag, so I'm pretty sure
that I got this right, still if you can confirm that I've got this right,
that would be great.

And mmap of a file with the append flag set is not supported, so we should
be good there.

Regards,

Hans
