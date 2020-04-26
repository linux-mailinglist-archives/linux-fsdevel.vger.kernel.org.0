Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD56E1B9212
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDZR0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgDZR0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:26:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D2C061A0F;
        Sun, 26 Apr 2020 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=WLNcKnNwtQuBxMd6UyKxPPvsQsOYOqq9DmJGUjop6hw=; b=hv2u4SNOCFt7aUxHojfYcroFLU
        YJenQ0tJeM4zjMuh+nUo8WpkbH2dSf7WEGud2mkJfAE1qk5xQ/WNbuEQGp/tAdvs//O0HQQnQF+Hk
        UlIOcCerzutH6TXr6RWpgidecfs4Kz1oasQ78ptcGmIQw5V2yydLSraTMHzs/8vFLGmfSLxoPFU9E
        QUJiNWU+nVCy/q66iiZV/gKCA2k4Zc9b5DVNQearvRQMwD3Sa9D6qEkXxaMOj+g41zvVcdWnIE05z
        FQ7b3rWreod0vMpWRHjWmrpC2JKnOBKbgOgoJ1dMDOKsapKLal04jf3y8+w/5ShG1KaTGIKp4n7hD
        4mi20I8Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSl2Y-0008Sz-Vq; Sun, 26 Apr 2020 17:26:03 +0000
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Minchan Kim <minchan@kernel.org>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
Date:   Sun, 26 Apr 2020 10:26:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

Hi,
I'm seeing lots of build failures in mm/madvise.c.

Is Minchin's patch only partially applied or is it just missing some pieces?

a.  mm/madvise.c needs to #include <linux/uio.h>

b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
has not been updated:

In file included from ../mm/madvise.c:11:0:
../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^
../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
 SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
 ^~~~~~~~~~~~~~~
In file included from ../mm/madvise.c:11:0:
../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
 asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
                 ^~~~~~~~~~~~~~~~~~~

thanks.
-- 
~Randy

