Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982F73102DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 03:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBEChk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 21:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhBEChi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:37:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD33C0613D6;
        Thu,  4 Feb 2021 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ciHjs+jRrxK7UOBz+1nbSJbYdNtvt9f7zqlIzJkiFvs=; b=hnpcq40Tto7xSO201H6yoUJZQW
        7+k0d0rFKmVmR4ELTYvU2IVB/Jo/q0YQ81rwoDxA31OcpKEMQq4r3XNUjDJ8NkiFsecwwmLbqLB2S
        nNUjI2aLKw1aYyjpkFt5uLbCZ26ynXK0n17tqcq5T0DEvT859URB4Tgp5f63PBdQhyEqINdMxjVqi
        gjtzh660wsK2aprk5pKQ8XPMRwuhnNGxlivsyXAJfdlY9yxLNaEwJMic8bpcq5K6K+KlTGH+l8ChV
        vZ1+x0mMOmMRGJ+mbOTVFIFT8jm7O3SR4Z3h651a4pLq+EoO1+xjgakzxTOBul4M79Ii9m0H+30n2
        G89HxS0A==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7qzN-0008VE-Go; Fri, 05 Feb 2021 02:36:53 +0000
Subject: Re: [PATCH v3 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Anand K Mistry <amistry@google.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20210205022328.481524-1-kaleshsingh@google.com>
 <20210205022328.481524-2-kaleshsingh@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b2d08c27-ae9b-16ed-3500-a4a724d563ef@infradead.org>
Date:   Thu, 4 Feb 2021 18:36:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205022328.481524-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 6:23 PM, Kalesh Singh wrote:
> If a FD refers to a DMA buffer add the DMA buffer inode number to
> /proc/<pid>/fdinfo/<FD> and /proc/<pid>/task/<tid>/fdindo/<FD>.
> 
> The dmabuf inode number allows userspace to uniquely identify the buffer
> and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
> DMA buffer sizes.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v3:
>   - Add documentation in proc.rst

Hi,
Thanks for the doc update.

> Changes in v2:
>   - Update patch description
> 
>  Documentation/filesystems/proc.rst | 17 +++++++++++++++++
>  drivers/dma-buf/dma-buf.c          |  1 +
>  2 files changed, 18 insertions(+)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # for Documentation/filesystems/proc.rst


-- 
~Randy

