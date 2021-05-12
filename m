Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE837BDC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhELNNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhELNNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620825151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkUtsmXhTln8ZuCPuyfmYtBmjG5e9wQzlcCwa1mE9Fg=;
        b=bqQgNci4uIOS4q9+76mmY3G7831tfrZS3Y5Rhb/I3tVJ+o5Z+xHQ8FM4pxkyrBi5A6xwCR
        +sWcMidRpzqqK0C9v77BcubXSQL8PH8EwpoA47Kq8tFKTAw8+gMgq7DduqbdZ4Q3eCmSa2
        gDqwYVto89rcH3CiJO9czBcrSZboVR0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-JQL6FgEENR6Nusc8kDaIrw-1; Wed, 12 May 2021 09:12:29 -0400
X-MC-Unique: JQL6FgEENR6Nusc8kDaIrw-1
Received: by mail-wm1-f71.google.com with SMTP id a19-20020a1c98130000b029016acd801495so808203wme.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xkUtsmXhTln8ZuCPuyfmYtBmjG5e9wQzlcCwa1mE9Fg=;
        b=MQLHhj0VTP4CqDT9Jwu2Q0WGueXwkv3ZKH8g7aNtoWKxA4e0P3DiBVmi1DNK9ph3M1
         Cm91+dGpwcFGwPdGNLxUjkgW4asNNH/W5PXdOTGp5OVRr1zyDc65fpqNjuq3HKz1n22G
         rKxZADZzO+7yh8mHfj+mGHCMSbFUTxtsJWVYf18GX/FIggoBLb3oekvmHF3JpLt3iLdf
         d026PvJozRnwYsygAQZJ0MFkmVLE/hlWwoTSUN5KNvRwDCigtuXchkjUa/DCAnAPomy0
         zxfOjpwIk0UjuyW6xvAtNdY5yo8mlIkMGezK+ugP6m7e7dPXcDOzDG3bCsaq9pHUeMgJ
         NOnw==
X-Gm-Message-State: AOAM532twomktEKRlGWTjoeIopH5QCUAVMggjYB9d1k53P64Ho5lH+as
        saPafITxn8Wyd+mk1PFL0qnI5qw+yzCM1rDWKiwRpzU16gKnwlOPogmBXTfs9SU81QvvM6FhSb6
        TONIL4+qxulEUxTz691pd3Wk9ZA==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr44985764wrj.75.1620825148634;
        Wed, 12 May 2021 06:12:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/bKM7tb3kGzV/c5fUH9I6/yF7gfmWH2UTCxgDB167HFBRdbQPq3VIR//MAPGfKngYzQmzw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr44985731wrj.75.1620825148402;
        Wed, 12 May 2021 06:12:28 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65ab.dip0.t-ipconnect.de. [91.12.101.171])
        by smtp.gmail.com with ESMTPSA id z5sm1439367wrn.69.2021.05.12.06.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:12:27 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] binfmt: remove in-tree usage of MAP_EXECUTABLE
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210421093453.6904-1-david@redhat.com>
 <20210421093453.6904-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <49a8cb62-e26d-a351-937e-6fb62a6f4a2e@redhat.com>
Date:   Wed, 12 May 2021 15:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421093453.6904-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.04.21 11:34, David Hildenbrand wrote:
> Ever since commit e9714acf8c43 ("mm: kill vma flag VM_EXECUTABLE and
> mm->num_exe_file_vmas"), VM_EXECUTABLE is gone and MAP_EXECUTABLE is
> essentially completely ignored. Let's remove all usage of
> MAP_EXECUTABLE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

> +++ b/fs/binfmt_aout.c
> @@ -222,7 +222,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   
>   		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
>   			PROT_READ | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
> +			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;

As reported by kernel test robot, this line should end with a ","

>   			fd_offset);
>   
>   		if (error != N_TXTADDR(ex))
> @@ -230,7 +230,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   
>   		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
>   				PROT_READ | PROT_WRITE | PROT_EXEC,
> -				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
> +				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
>   				fd_offset + ex.a_text);

dito


@Andrew, I think this resides your tree. Can you fix that up or shall I 
resend the series, or only this individual patch?

-- 
Thanks,

David / dhildenb

