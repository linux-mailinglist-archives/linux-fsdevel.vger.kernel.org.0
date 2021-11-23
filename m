Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD1459E85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhKWIuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKWIuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:50:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B0CC061574;
        Tue, 23 Nov 2021 00:46:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x6so76681195edr.5;
        Tue, 23 Nov 2021 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7HA05XhYlCzTp4qvhhSBcSuSKybJ0PulYKdWBwG+DL8=;
        b=eRxUC+sJSCTIGOoVdTOOhCcUZfnZdG7DdFIkTVEmTD9NGwphMQiid3xEfITu5XW/Fm
         OPcyu0o0RT6S6BanewL3NWZY6xVwmP0C439+0yWwFxG7UfkAXRzQPZpRKz3tzk18JnVw
         HtjSX+daGQP8TGpv1J7Hr4rpLkhRhWOvo2U6K+oZWNz38u91Wa2/oojHfKIIW/fP8O/2
         ahzoMGXbn8rp25gMWGp0CrvgXNrpYwO9AUUeMsfLXR/CR8EAjxMYcttXW0FO+AjATfG+
         AGb2k3JRmpq499iNZ+yWcjQK0WwJ6RmYDNO89V0hqqHW4QFAC87ThcSmDD7gnTTsYtlu
         0MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7HA05XhYlCzTp4qvhhSBcSuSKybJ0PulYKdWBwG+DL8=;
        b=CXpaZKQRZ3xOnVgoN+yqI7/g4N0YVnZpKFGGdpXNSWqSRmJb74ATOhZK4e/gphgeZi
         85KKcxOUacY1vkaziEr+jsTuLF1Fiy8fnGW/fdYVbMuugMgXDS2usP2OWqUi8VIciGw2
         N9BsbZSkZTmxfW/ZlYZF/V4JphA8Om72OM/Dh+DmtTvsAk6N8wUGY7Ga7bdTQ2zLYLzZ
         HJHnP/eg81d8J762TS4nJ8kZjeSVlFt/DnPu8m4nzre3VUIdbPHPSto6SqhytNVppcft
         Sc0YyqR3g8pMQlqatzulAzlVUon5mUeYcYswiW4ectcWCntpXIGawNpAlN/BW9/QxwYn
         PPxA==
X-Gm-Message-State: AOAM531Oq+aIkppVYpqO6+t4+QJyibOaDRbaHHFyFNwwt2fClE+Yttnt
        TaT3Lq7kZ9fuixZtpG7BVZY=
X-Google-Smtp-Source: ABdhPJygultcXZ5O6UR+Ra3FMuRkjBlnywYkj/YSuUzgBBN4t/ktdv6OEJaf5N8LyoDiF4gs7MeeKQ==
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr2362914ejy.229.1637657214203;
        Tue, 23 Nov 2021 00:46:54 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id cs12sm5074681ejc.15.2021.11.23.00.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 00:46:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <4041d98a-23df-e9ed-b245-5edd7151fec5@redhat.com>
Date:   Tue, 23 Nov 2021 09:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 09/13] KVM: Introduce kvm_memfd_invalidate_range
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-10-chao.p.peng@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211119134739.20218-10-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 14:47, Chao Peng wrote:
> +
> +	/* Prevent memslot modification */
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	kvm->mn_active_invalidate_count++;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +
> +	ret = __kvm_handle_useraddr_range(kvm, &useraddr_range);
> +
> +	spin_lock(&kvm->mn_invalidate_lock);
> +	kvm->mn_active_invalidate_count--;
> +	spin_unlock(&kvm->mn_invalidate_lock);
> +


You need to follow this with a rcuwait_wake_up as in 
kvm_mmu_notifier_invalidate_range_end.

It's probably best if you move the manipulations of 
mn_active_invalidate_count from kvm_mmu_notifier_invalidate_range_* to 
two separate functions.

Paolo
