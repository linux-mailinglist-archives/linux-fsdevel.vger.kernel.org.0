Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370B6E3540
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 07:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDPFw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:52:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B912D52;
        Sat, 15 Apr 2023 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6cjdWzQYlkKX8MCgRY2YnYvf/2Rcp0ennBO6jbnRXg8=; b=XrwqjHIV7CSsj2VhZZXbl6q1MP
        HIUtD6rBI3uETQ+smSTFaXBHT4jIbR+HHxh+n4ATpeey2y0NjmfNI1D6ibsm4s0H/glybs/u7cAG2
        TV2sqpZK2lt7CV+cya4SjUYJRIatisf7uOigiuuz02Pm7NmMNeiCvpttbDysG3xmQ5CT5/xPqB0pY
        iG29i1JcQiBwmJ8HT7BDIRqOWGhkb2ZZkEw+vATMN3LO6ReVGAd555sgNKgIn76kIC0EvbKGbsWRu
        W9xLzf4INEek5wSf2+6BhFwvwMYgyHfBbL4J6kQ/+leLlfS5WHfq/qYgUsjAFgiYARhXd33j6gGk2
        1BwSNlVw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvJm-00DBqB-0w;
        Sun, 16 Apr 2023 05:52:54 +0000
Message-ID: <0589177d-c1f9-7320-b668-c103e34e8800@infradead.org>
Date:   Sat, 15 Apr 2023 22:52:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] fs/proc: add Kthread flag to /proc/$pid/status
Content-Language: en-US
To:     Chunguang Wu <fullspring2018@gmail.com>, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230416052404.2920-1-fullspring2018@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230416052404.2920-1-fullspring2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 4/15/23 22:24, Chunguang Wu wrote:
> The command `ps -ef ` and `top -c` mark kernel thread by '['
> and ']', but sometimes the result is not correct.
> The task->flags in /proc/$pid/stat is good, but we need remember
> the value of PF_KTHREAD is 0x00200000 and convert dec to hex.
> If we have no binary program and shell script which read
> /proc/$pid/stat, we can know it directly by
> `cat /proc/$pid/status`.
> 
> Signed-off-by: Chunguang Wu <fullspring2018@gmail.com>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/proc.rst | 2 ++
>  fs/proc/array.c                    | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 9d5fd9424e8b..8a563684586c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -179,6 +179,7 @@ read the file /proc/PID/status::
>    Gid:    100     100     100     100
>    FDSize: 256
>    Groups: 100 14 16
> +  Kthread:    0
>    VmPeak:     5004 kB
>    VmSize:     5004 kB
>    VmLck:         0 kB
> @@ -256,6 +257,7 @@ It's slow but very precise.
>   NSpid                       descendant namespace process ID hierarchy
>   NSpgid                      descendant namespace process group ID hierarchy
>   NSsid                       descendant namespace session ID hierarchy
> + Kthread                     kernel thread flag, 1 is yes, 0 is no
>   VmPeak                      peak virtual memory size
>   VmSize                      total program size
>   VmLck                       locked memory size
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 9b0315d34c58..425824ad85e1 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -219,6 +219,8 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
>  		seq_put_decimal_ull(m, "\t", task_session_nr_ns(p, pid->numbers[g].ns));
>  #endif
>  	seq_putc(m, '\n');
> +
> +	seq_printf(m, "Kthread:\t%c\n", p->flags & PF_KTHREAD ? '1' : '0');
>  }
>  
>  void render_sigset_t(struct seq_file *m, const char *header,

-- 
~Randy
