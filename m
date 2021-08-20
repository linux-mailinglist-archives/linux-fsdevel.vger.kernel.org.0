Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB63F28A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhHTIrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231757AbhHTIr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629449210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HhD3HCRTFvEVqk5yap83SXC5Y82U0v5dcvw39zc4Z4=;
        b=YLxiu0lCFQYyMP91p9KefzStodfvkg5GDrKgEpQMfpjqVf982M+l6Y7dVmmHQ3PfKe0vrU
        hcYdpLr1tP3YKcelZZi/w4wizftrP3KiK8LRCCJhCY0jUgacFrqJIPChccDGGaPRWXmcJX
        cRTtoocizyOEvC9lg8+JH8EdbD0IqjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-gy70d_RaOJKOo1QYttwOSA-1; Fri, 20 Aug 2021 04:46:49 -0400
X-MC-Unique: gy70d_RaOJKOo1QYttwOSA-1
Received: by mail-wm1-f71.google.com with SMTP id 201-20020a1c01d2000000b002e72ba822dcso202935wmb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 01:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2HhD3HCRTFvEVqk5yap83SXC5Y82U0v5dcvw39zc4Z4=;
        b=ZGlGd9C9WphDYz58ZnvtctZDq5FbnGQePfu84vgoCm9Hl11GReNDG5Y3fmnqW39XM6
         4D7ea/e68BOhnREaRpMjvzRDsyy+6TXoS8Rx8xtyADs9CK1LJkkT74cXc2huXZb8d+Ki
         N+4rHukwzIdCLcSYKL8uH8U+g3b2fvd9u5f+O7GfwhGciSMqw9DdgmieuPx/3LTgcfz5
         o5i2VSPbjUFc/yLR9dZO25VVnQR2JNf2ZihS0QgVYKF14RTxsLk7QMgaf+Ko0+CEnE5u
         6yIr+ep1+lKpxgQjsrNGIQ78xZ1Mtk4GRcaypE2egMuhaBIX30TLDAH06NV0RQymD8ub
         qvJw==
X-Gm-Message-State: AOAM5322U5oRtNIzMVrCoJFqtGELlRXAKfTcSAdNbxi871XIVv0VEDsC
        AeQ0CFjdqXINXFzV53w/fVvdW+XiUFsUYBVAWuCQj484HKFHmW4xMKvbzx4VcCZykQho1PIpqbr
        etns72HagO4K6ip+bir3U5ShF6Q==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr2685747wma.62.1629449208325;
        Fri, 20 Aug 2021 01:46:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytHgubr94As8EiptaA6/T3rm3zShRCHuT1SQpKBWMx/QJTseDVs/BhmrdZPds05dmrZoxc2A==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr2685692wma.62.1629449208132;
        Fri, 20 Aug 2021 01:46:48 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id l9sm5187699wrt.95.2021.08.20.01.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 01:46:47 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210816194840.42769-1-david@redhat.com>
 <20210816194840.42769-3-david@redhat.com>
 <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/7] kernel/fork: factor out replacing the current MM
 exe_file
Message-ID: <d90a7dfd-11c8-c4e1-1c59-91aad5a7f08e@redhat.com>
Date:   Fri, 20 Aug 2021 10:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.08.21 22:51, Linus Torvalds wrote:
> So I like this series.
> 
> However, logically, I think this part in replace_mm_exe_file() no
> longer makes sense:
> 
> On Mon, Aug 16, 2021 at 12:50 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> +       /* Forbid mm->exe_file change if old file still mapped. */
>> +       old_exe_file = get_mm_exe_file(mm);
>> +       if (old_exe_file) {
>> +               mmap_read_lock(mm);
>> +               for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
>> +                       if (!vma->vm_file)
>> +                               continue;
>> +                       if (path_equal(&vma->vm_file->f_path,
>> +                                      &old_exe_file->f_path))
>> +                               ret = -EBUSY;
>> +               }
>> +               mmap_read_unlock(mm);
>> +               fput(old_exe_file);
>> +               if (ret)
>> +                       return ret;
>> +       }
> 
> and should just be removed.
> 
> NOTE! I think it makes sense within the context of this patch (where
> you just move code around), but that it should then be removed in the
> next patch that does that "always deny write access to current MM
> exe_file" thing.
> 
> I just quoted it in the context of this patch, since the next patch
> doesn't actually show this code any more.
> 
> In the *old* model - where the ETXTBUSY was about the mmap() of the
> file - the above tests make sense.
> 
> But in the new model, walking the mappings just doesn't seem to be a
> sensible operation any more. The mappings simply aren't what ETXTBUSY
> is about in the new world order, and so doing that mapping walk seems
> nonsensical.
> 
> Hmm?

I think this is somewhat another kind of "stop user space trying
to do stupid things" thingy, not necessarily glued to ETXTBUSY:
don't allow replacing exe_file if that very file is still mapped
and consequently eventually still in use by the application.

I don't think it necessarily has many things to do with ETXTBUSY:
we only check if there is a VMA mapping that file, not that it's
a VM_DENYWRITE mapping.

That code originates from

commit 4229fb1dc6843c49a14bb098719f8a696cdc44f8
Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date:   Wed Jul 11 14:02:11 2012 -0700

     c/r: prctl: less paranoid prctl_set_mm_exe_file()

     "no other files mapped" requirement from my previous patch (c/r: prctl:
     update prctl_set_mm_exe_file() after mm->num_exe_file_vmas removal) is too
     paranoid, it forbids operation even if there mapped one shared-anon vma.
     
     Let's check that current mm->exe_file already unmapped, in this case
     exe_file symlink already outdated and its changing is reasonable.


The statement "exe_file symlink already outdated and its
changing is reasonable" somewhat makes sense.


Long story short, I think this check somehow makes a bit of sense, but
we wouldn't lose too much if we drop it -- just another sanity check.

Your call :)

-- 
Thanks,

David / dhildenb

