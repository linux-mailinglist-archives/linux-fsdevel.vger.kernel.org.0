Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8008E6155F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGGPFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 11:05:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39249 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfGGPFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:05:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so12262421edv.6;
        Sun, 07 Jul 2019 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6MLgJUsoAl2NKidgAXjyXQSdQ9DIKaTUuz2m0H5fpTc=;
        b=UF94KMgT2OI+DG6DzuscgNmw8VZQiS9tpSpGSRIYcGhE0j6WWS2sAVLN9ydQ0wEBJ2
         aot/HQMHjyTBqSh+tZ2NQyBDdnanFmhVa3ciHekLQs0BgzKEIr4VlVL/OhBBSNUICWz7
         jtBOfTF6Fyx4QJ8hU+vJzOx4Ng00S9TRVTprOIf0i8bKx2MKl1JaFc9MZ0vZGLsjokqg
         6E30M628GcLb2PX5Ij3GAOW2CUUdJGbR6eOx37gHtAQ684w5i50Mk8Tp7GM+XbNPHKQO
         XgdooaCWgJmO2U+gc52q7D4ITTxQZa6RqhVCr/YiWcaIl7FtDVcu4cjU5uKUPb1Ga8S0
         Vupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MLgJUsoAl2NKidgAXjyXQSdQ9DIKaTUuz2m0H5fpTc=;
        b=FCBsfROo4VINrzFtOgdfyoWSvB3QDxv751N8c5IScZKkSaPY+jLRv4OUCVS0C1Ouqb
         npNpQluejMVi9KAbEaf37TPfwcdpnqJNFtL90G2FAvhv6UgC/tkpaVWwxXP0uDwJtPeS
         fFVfGEeIsyKtgLtHC8Ti5XGbY14vFzOnOLAak0IlAmU+xpXTAk0/S+89F0c6+eldhP0S
         r1o7MSxCeL7XIy2BWiaY38Kq+W5BIfpB8UFZRw9MsT3lFoVoUtC4Q2IkPctcPMNLccLA
         +irWyBU+qzNuydS+A7nLF7+rACKzpuyreTD7ye+HEHfm8f+lPuhHckeAmSash0/R46cU
         519g==
X-Gm-Message-State: APjAAAU79O/ssFeW9pjtwg+C4aTOfzzz4AJV/s2z3UFf/BT6gISBpZ6n
        IDT6E7j6YZz13E3Vdu7cubY=
X-Google-Smtp-Source: APXvYqz5oc0ldMi+NiJhrGcNKhTIkb+I0SjAlmlp1d7jrl3jjLByYJrIDp1O03mFyQKuAavCz2MrPg==
X-Received: by 2002:a50:8be8:: with SMTP id n37mr15301756edn.216.1562511919578;
        Sun, 07 Jul 2019 08:05:19 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id j37sm2497291ede.23.2019.07.07.08.05.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 08:05:18 -0700 (PDT)
Subject: Re: pagecache locking
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
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
References: <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
 <20190705233157.GD7689@dread.disaster.area>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <b43e2707-89ec-3afa-8bca-37747ba6c944@gmail.com>
Date:   Sun, 7 Jul 2019 18:05:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705233157.GD7689@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07/2019 02:31, Dave Chinner wrote:

> 
> As long as the IO ranges to the same file *don't overlap*, it should
> be perfectly safe to take separate range locks (in read or write
> mode) on either side of the mmap_sem as non-overlapping range locks
> can be nested and will not self-deadlock.
> 
> The "recursive lock problem" still arises with DIO and page faults
> inside gup, but it only occurs when the user buffer range overlaps
> the DIO range to the same file. IOWs, the application is trying to
> do something that has an undefined result and is likely to result in
> data corruption. So, in that case I plan to have the gup page faults
> fail and the DIO return -EDEADLOCK to userspace....
> 

This sounds very cool. I now understand. I hope you put all the tools
for this in generic places so it will be easier to salvage.

One thing I will be very curious to see is how you teach lockdep
about the "range locks can be nested" thing. I know its possible,
other places do it, but its something I never understood.

> Cheers,
> Dave.

[ Ha one more question if you have time:

  In one of the mails, and you also mentioned it before, you said about
  the rw_read_lock not being able to scale well on mammoth machines
  over 10ns of cores (maybe you said over 20).
  I wonder why that happens. Is it because of the atomic operations,
  or something in the lock algorithm. In my theoretical understanding,
  as long as there are no write-lock-grabbers, why would the readers
  interfere with each other?
]

Thanks
Boaz
