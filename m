Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C283A5D8F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGCAbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 20:31:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42523 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGCAbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:31:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so290971edq.9;
        Tue, 02 Jul 2019 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXcSaivLBse0FFf2ctO/vkXxTGh9DxaocpQVfdLoLhY=;
        b=RUqiuvk5AXV5I5ft6eTyLmR+50TxxAHEbh5RUXy9WxrZUs+fYtaZ+E6l8tcroswlKp
         +BYxwkQTCxhVX2mBpTDi/tnQ6N6iXOk4VJdgCMLecTRQjj0PNLhvRZSFy5qTxAjrUoZr
         Or2MpOdjjsoTr7SphxentppPilrsV779srsW4zxu72YOawstxJKLcA++bumylNQKRYpD
         SlnH/WQROmdN3sBj1QjyXZiEYWyZHxaEcITpC6AuLUdC0rJfrKYqisQ5PEpZPUcWBhjI
         Nuu6ZEqLepGpx0nCV0FrHUrVYirL71OGyt0HeO2g1BDeyGsRkJyh0OJSrFYdm6sWSB/4
         HlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXcSaivLBse0FFf2ctO/vkXxTGh9DxaocpQVfdLoLhY=;
        b=lcrjBSCe1DsNNTDNzDx1KaNY+bc9X5rxvmS6PZjcMosr4RyiodxUTMenAEUNu1cDCI
         zGGL9C5Xs+sn2X5B2yk+9enX/A3hckdGxuOCEN5pYFESwgVznsyD3OfUVV4zdQyHrEBC
         ZvDU9v494IVN0DYeXs7z7+cSTU59Prsdsqf8z+EZpxUQDijolTXHknGyilVQc0pdUEFw
         CYVnz5ex/Mw5hm1QouhZTKl1iAEymoizxTdfyMmDU+WAmWQR9ehdS811cszmwHXH7uR6
         wwIghSDAc4OhDfLmnN7DpFDKJcNSwHuzuW71Ik+tLKahnfZxqQOZUEfjJ7t7ISpgjuLA
         QKmg==
X-Gm-Message-State: APjAAAW9qiQRn83FjfyzeQY2BoaNb14yN7UNNyCBwO5p3PmNer5crxHz
        6yiE77sBhTtBIbWXFCGbSe0=
X-Google-Smtp-Source: APXvYqyhSetE6h0usazNMfHOe7nFs1mK2xvZFfe4TNf39deATvRUohuXWV9wNHAOZ9jhCerU1FXCcg==
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr31237606ejw.306.1562112290271;
        Tue, 02 Jul 2019 17:04:50 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id k11sm159289edq.54.2019.07.02.17.04.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 17:04:49 -0700 (PDT)
Subject: Re: pagecache locking
To:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
Date:   Wed, 3 Jul 2019 03:04:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619223756.GC26375@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/06/2019 01:37, Dave Chinner wrote:
<>
> 
> I'd prefer it doesn't get lifted to the VFS because I'm planning on
> getting rid of it in XFS with range locks. i.e. the XFS_MMAPLOCK is
> likely to go away in the near term because a range lock can be
> taken on either side of the mmap_sem in the page fault path.
> 
<>
Sir Dave

Sorry if this was answered before. I am please very curious. In the zufs
project I have an equivalent rw_MMAPLOCK that I _read_lock on page_faults.
(Read & writes all take read-locks ...)
The only reason I have it is because of lockdep actually.

Specifically for those xfstests that mmap a buffer then direct_IO in/out
of that buffer from/to another file in the same FS or the same file.
(For lockdep its the same case).
I would be perfectly happy to recursively _read_lock both from the top
of the page_fault at the DIO path, and under in the page_fault. I'm
_read_locking after all. But lockdep is hard to convince. So I stole the
xfs idea of having an rw_MMAPLOCK. And grab yet another _write_lock at
truncate/punch/clone time when all mapping traversal needs to stop for
the destructive change to take place. (Allocations are done another way
and are race safe with traversal)

How do you intend to address this problem with range-locks? ie recursively
taking the same "lock"? because if not for the recursive-ity and lockdep I would
not need the extra lock-object per inode.

Thanks
Boaz
