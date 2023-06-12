Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD172B863
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjFLG7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFLG7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB25173E
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686552489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR6k3vMJTPH3xKL4v/z/wsx8OedHdvcs9Mf/qAS1BEg=;
        b=e6jbz8fgUV35YuHZcFIdZLRLyKzrDj8U2pe8S22fhozw3+jfOS4DDYbM2RzOSGZZIgQkmk
        ymPlBaMuq0/NXHnIrIfwuZF+S+g5nfzUrR9QA2PAzYDUq3ie0M5QGcaNWyIXH+9tRCAThU
        G9eQeoFl3IHj8ghtDlDOhujsh9ZHKhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-lVuKkMMeM7WAz-4E8dTDpQ-1; Mon, 12 Jun 2023 02:19:06 -0400
X-MC-Unique: lVuKkMMeM7WAz-4E8dTDpQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fbb0ac191so387961f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 23:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686550745; x=1689142745;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR6k3vMJTPH3xKL4v/z/wsx8OedHdvcs9Mf/qAS1BEg=;
        b=Acbp4j1DUvlQSyYzzrYewW/J299FjQkVkgZthBegx6flDbEpfveAcFrlMj80AXxVob
         +oinYK9xZrcy92k0XV2cRpIDev1cDLbFdEsNnHxXtQxJgjwWHUyXxSgdW6VYu43K4U/J
         R9BCWXxBpMprqDXON4dTSt+HnjcchHgazdLDPYARfMRxCJ4tHZ+KXf0+I3C54s9Tp/Ca
         ak/8ivl5zQcCJHv0HgCp3PsP52tmt0y1Lph5pIP1V+0LtqSCjLmVp6uCF4HzQdfeEhqf
         /O6Sat5TuDpz2oqS+1J5pJ3NbCwJBLU715q/FN+SeH+QsqZsXOCPLPqox+LdNcb455vr
         wrjQ==
X-Gm-Message-State: AC+VfDzHmzvARjcOWbSOIpq8tLjD3QH6DcIN16fPiht7e4zjpy/M6B00
        1Cf5UxOXSYc+C90lhIk9WAsR4EVgQGB8y6TTALfNPuxfKBnUJa4f/xhgFVxZyTWmG5qQKmCEsgB
        AvWsWClK1rylUYxtjfGcCM1Ij3A==
X-Received: by 2002:adf:e252:0:b0:30c:2b30:ec82 with SMTP id bl18-20020adfe252000000b0030c2b30ec82mr4158703wrb.18.1686550745452;
        Sun, 11 Jun 2023 23:19:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aYWnu9qdVctep8Bbpospy3q7fEGmG/5MsIKhesIiZ7Y+14Yic8NJNBcLrDmAeKAb7BOv68w==
X-Received: by 2002:adf:e252:0:b0:30c:2b30:ec82 with SMTP id bl18-20020adfe252000000b0030c2b30ec82mr4158669wrb.18.1686550745031;
        Sun, 11 Jun 2023 23:19:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d6dc8000000b0030aec5e020fsm11324649wrz.86.2023.06.11.23.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 23:19:04 -0700 (PDT)
Message-ID: <63868def-9a92-3b0f-4369-160a18b447ee@redhat.com>
Date:   Mon, 12 Jun 2023 08:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [axboe-block:for-6.5/block] [block] 1ccf164ec8:
 WARNING:at_mm/gup.c:#try_get_folio
To:     kernel test robot <oliver.sang@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
References: <202306120931.a9606b88-oliver.sang@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202306120931.a9606b88-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.06.23 03:54, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/gup.c:#try_get_folio" on:
> 
> commit: 1ccf164ec866cb8575ab9b2e219fca875089c60e ("block: Use iov_iter_extract_pages() and page pinning in direct-io.c")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-6.5/block
> 
> [test failed on linux-next/master 53ab6975c12d1ad86c599a8927e8c698b144d669]
> 
> in testcase: xfstests
> version: xfstests-x86_64-06c027a-1_20230529
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: udf
> 	test: generic-group-45
> 
> 
> 
> compiler: gcc-12
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@intel.com
> 
> 
> [  121.986791][ T2220] ------------[ cut here ]------------
> [ 121.992093][ T2220] WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio (mm/gup.c:76 (discriminator 1))

I assume we have a refcount underflow (but could be an overflow?). Maybe 
we used unpin_user_page() on a page not pinned via pin_user_pages() ?

-- 
Cheers,

David / dhildenb

