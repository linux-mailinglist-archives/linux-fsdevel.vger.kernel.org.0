Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE88C26DCD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgIQNao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 09:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgIQNaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600349389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjkdQTJ/VBG7ZFMg5Nhpzya4K81fiyu8UjZya2led1Q=;
        b=V5lZC3/t/VHSw6TIrIt2X6QD/sgLQyk6RiZ8PC8zlIS9egEgDe4zyS+1EY3fzLGPlx2jZg
        oFd7fQKwgckZA7QxZb4zwOloG1Z0VYKvFoqoPQF+TP1wko7vAVxUFBZ2wI3LP9pBnxGnWn
        SAJIE+khwUpVwTOoa4sQ4S4YJDrOLBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-Q_ysnWYENLK5sfwraF7T4g-1; Thu, 17 Sep 2020 09:27:41 -0400
X-MC-Unique: Q_ysnWYENLK5sfwraF7T4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC33956B35;
        Thu, 17 Sep 2020 13:27:35 +0000 (UTC)
Received: from ovpn-66-148.rdu2.redhat.com (ovpn-66-148.rdu2.redhat.com [10.10.66.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17FB860BEC;
        Thu, 17 Sep 2020 13:27:28 +0000 (UTC)
Message-ID: <5d97da4d86db258fdc9b20be3c12588089e17da2.camel@redhat.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
From:   Qian Cai <cai@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Date:   Thu, 17 Sep 2020 09:27:27 -0400
In-Reply-To: <20200916073539.3552-1-rppt@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-16 at 10:35 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is an implementation of "secret" mappings backed by a file descriptor. 
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.

On powerpc: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config

There is a compiling warning from the today's linux-next:

<stdin>:1532:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]

