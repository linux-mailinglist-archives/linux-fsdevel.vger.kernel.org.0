Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B73A8FF2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHPJjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 05:39:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35029 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPJjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:39:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so4611586edd.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 02:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHKBBtdm8mYVpe/qaj9ylis+vRE339fn2VRAT7d+440=;
        b=UHV1klUL+34pAj9dvi7P/55EftE/P7lDD3e3w6HWNdiowtSMg1+lN3VgwiYyfS0Xrj
         EARj7jnBre2L+xXC2K5LSgCvsChp4yC/Ptfn5NxTBsHGgVBQfCB2s4l0cjzfoSasMJ9h
         CSg4riXOOcw4watdIqqNeKIzm8k4jv2VlCnPKcLAEZXnAKjwN7CIn7O/lf9FsbTAA6l5
         /uszg3+kMw1ALJ+S/4ItCJAiSAWfs0CE3p8k+Lu8j6h6iis+Ke8JAx3gNKMCXV7y13NL
         RaaLTC74t4Z/o/76LQdXbxIwZ9jc6Eux3yEakvvl5E0Vmdqee9Y0cuseAmZyXXtmDkIo
         h1zg==
X-Gm-Message-State: APjAAAV9pHQ8+6zGpCRoc9zSxnzOf+O32f9n6U1fcHFqWqxk7HOkVJaJ
        xPZJQ6X5hGe5VenFfdCu4rfUQH6tZ7A=
X-Google-Smtp-Source: APXvYqyXPmmAOIPgN7j+x4kC4fO9zrRuuf2mnoEf+p8W3AU3PWW0XGx0sVvzE5tJO0bg5y1sc14ewg==
X-Received: by 2002:a17:906:11da:: with SMTP id o26mr8461644eja.64.1565948373831;
        Fri, 16 Aug 2019 02:39:33 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c14sm1013361edb.5.2019.08.16.02.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:39:33 -0700 (PDT)
Subject: Re: [PATCH v13] fs: Add VirtualBox guest shared folder (vboxsf)
 support
From:   Hans de Goede <hdegoede@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20190815131253.237921-1-hdegoede@redhat.com>
 <20190815131253.237921-2-hdegoede@redhat.com>
 <20190816075654.GA15363@infradead.org>
 <412a10a9-a681-4c7a-9175-e7509b3fea87@redhat.com>
Message-ID: <5ce18de2-b594-c06d-21a0-aa9677dbcc0a@redhat.com>
Date:   Fri, 16 Aug 2019 11:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <412a10a9-a681-4c7a-9175-e7509b3fea87@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

P.S.

On 16-08-19 11:01, Hans de Goede wrote:
> On 16-08-19 09:56, Christoph Hellwig wrote:

<snip>

>>> + * Ideally we would wrap generic_file_read_iter with a function which also
>>> + * does this check, to reduce the chance of us missing writes happening on the
>>> + * host side after open(). But the vboxsf stat call to the host only works on
>>> + * filenames, so that would require caching the filename in our
>>> + * file->private_data and there is no guarantee that filename will still
>>> + * be valid at read_iter time. So this would be in no way bulletproof.
>>
>> Well, you can usually generate a file name from file->f_path.dentry.
>> The only odd case is opened by unliked files.  NFS has a special hack
>> for those called sillyrename (you can grep for that). 
> 
> Right, so since the unlink or a normal rename could happen on the host side
> and there is no notification of that, those will be 2 areas where a stat
> call to verify will fail, which leaves us with 3 options:
> 
> 1) Make stat calls before read() calls, if they fail purge the cache to be safe
> 2) Make stat calls before read(), on failure ignore the stat call
> 3) Treat read() calls like other page-cache reads such as sendfile or mmap
> and only check if the cache is stale at open() time.

I just realized there is a 4th option, which is to make vboxsf read_iter
simply always do:

4) Always evict non dirt pages from page-cache from read_iter, to ensure we
    get the latest version from the host:

So something like this:

	/*
          * Evict non dirt pages from page-cache, so that we reget them from
          * the host in case they have been changed.
          * /
	invalidate_mapping_pages(inode->i_mapping, pos >> PAGE_SHIFT,
				 (pos + len) >> PAGE_SHIFT);
         generic_file_read_iter(...)

This is in essence what the out of tree driver is doing on read(), except
that it does not go through the page-cache at all.

I think this might be the best option, perhaps controlled by a mount
flag ?

Regards,

Hans
