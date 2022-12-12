Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD66497D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 02:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLLB7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 20:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiLLB7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE7B7677
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670810326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g3xEHXieH9G9pXYF7oUeGJEYp7M2m+YZ1AfoAjJ2Mg=;
        b=Ikr+hjENbtjRan+mbMyFbUNgg468epFHBOdPN5iDEteaDuEBT6mcAGQGxdygOTjunCBq7V
        F6Odn5Eb5JDHczrONrZac6H/Nhi20VVZJhnFp6s3fVxvVxHlx8fK4c6O3jirP8xwOCags0
        ZDFy1HdXjSRc4IuWBJBMexoIlJBDbs8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-UDGIeBhYMD6iFVtq_OpypA-1; Sun, 11 Dec 2022 20:58:44 -0500
X-MC-Unique: UDGIeBhYMD6iFVtq_OpypA-1
Received: by mail-pl1-f200.google.com with SMTP id z10-20020a170902ccca00b001898329db72so9309518ple.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 17:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g3xEHXieH9G9pXYF7oUeGJEYp7M2m+YZ1AfoAjJ2Mg=;
        b=x4BV33iNyRwwI2m2BzSiWv99vkUV9IDoO/1P7SK+zfUol6Bi5j0kPmShb/VAT8YR6O
         A0SKLb4ILaExs1ui80OnA9aBNdQ6JkxUQEmjty6cVXG5qGlxCVl8GDhBTfPW/858awwB
         mgYldLyMPWzz6kG8TJALGCcvr+tiLI1ljajXIaAenFj5XMqijEoZLfQHBJctLqKUreez
         sym9D/mDIzUp8QuRje6ujWCIiv5C6nATKX8LF1n3igIsgqNTl3Al73xKLFNvRnNOcm85
         oDI4E/2XREG7qpZdTpqRuBDcXiUvRfvKITerQOs+SyLA8Sl3bnDiizspj5dFQWcvFnYq
         TECw==
X-Gm-Message-State: ANoB5pnSt4lPOWI/IL90U+xHacwAeQzXoE9C17B1C6PFHqqXt71jhFBx
        kKLlp9KHWDoANVyxRIqq5pOeA91znB8105glwZD6NqT8YTxaKT1i7AGin7KnGdOMfG937T0DL/+
        UYvsWbA4z3mI72g1z4OVeMKv0fA==
X-Received: by 2002:aa7:9616:0:b0:573:1d31:2b79 with SMTP id q22-20020aa79616000000b005731d312b79mr14102263pfg.28.1670810322554;
        Sun, 11 Dec 2022 17:58:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5kpqcD/WARrHkSIyJuhGn5/Ao4JFQbn2+IfehjkSLF7UQUmqJdeZNAvwwXgMyNj1fztp1sQg==
X-Received: by 2002:aa7:9616:0:b0:573:1d31:2b79 with SMTP id q22-20020aa79616000000b005731d312b79mr14102248pfg.28.1670810322262;
        Sun, 11 Dec 2022 17:58:42 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b00574de4a2fc7sm4527776pfx.205.2022.12.11.17.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 17:58:41 -0800 (PST)
Message-ID: <4a283c76-9609-7e66-bcf8-61d6ee2e8b06@redhat.com>
Date:   Mon, 12 Dec 2022 09:58:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 5/5] procfs: use efficient tgid pid search on root
 readdir
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onestero@redhat.com, willy@infradead.org, ebiederm@redhat.com
References: <20221202171620.509140-1-bfoster@redhat.com>
 <20221202171620.509140-6-bfoster@redhat.com>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-6-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> find_ge_pid() walks every allocated id and checks every associated
> pid in the namespace for a link to a PIDTYPE_TGID task. If the pid
> namespace contains processes with large numbers of threads, this
> search doesn't scale and can notably increase getdents() syscall
> latency.
>
> For example, on a mostly idle 2.4GHz Intel Xeon running Fedora on
> 5.19.0-rc2, 'strace -T xfs_io -c readdir /proc' shows the following:
>
>    getdents64(... /* 814 entries */, 32768) = 20624 <0.000568>
>
> With the addition of a dummy (i.e. idle) process running that
> creates an additional 100k threads, that latency increases to:
>
>    getdents64(... /* 815 entries */, 32768) = 20656 <0.011315>
>
> While this may not be noticeable to users in one off /proc scans or
> simple usage of ps or top, we have users that report problems caused
> by this latency increase in these sort of scaled environments with
> custom tooling that makes heavier use of task monitoring.
>
> Optimize the tgid task scanning in proc_pid_readdir() by using the
> more efficient find_get_tgid_task() helper. This significantly
> improves readdir() latency when the pid namespace is populated with
> processes with very large thread counts. For example, the above 100k
> idle task test against a patched kernel now results in the
> following:
>
> Idle:
>    getdents64(... /* 861 entries */, 32768) = 21048 <0.000670>
>
> "" + 100k threads:
>    getdents64(... /* 862 entries */, 32768) = 21096 <0.000959>
>
> ... which is a much smaller latency hit after the high thread count
> task is started.


This may not sound like much but in the environment where it

was reported it makes quite a difference.


The thing is that the scenario above sounds totally unreal

but apparently it isn't and even if it was think about

many thread group leaders each with even a moderately large

number of threads and the observed overhead problem becomes

clear.


>
> Signed-off-by: Brian Foster <bfoster@redhat.com>


Reviewed-by: Ian Kent <raven@themaw.net>


Ian

> ---
>   fs/proc/base.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..ac34b6bb7249 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3475,24 +3475,9 @@ struct tgid_iter {
>   };
>   static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter iter)
>   {
> -	struct pid *pid;
> -
>   	if (iter.task)
>   		put_task_struct(iter.task);
> -	rcu_read_lock();
> -retry:
> -	iter.task = NULL;
> -	pid = find_ge_pid(iter.tgid, ns);
> -	if (pid) {
> -		iter.tgid = pid_nr_ns(pid, ns);
> -		iter.task = pid_task(pid, PIDTYPE_TGID);
> -		if (!iter.task) {
> -			iter.tgid += 1;
> -			goto retry;
> -		}
> -		get_task_struct(iter.task);
> -	}
> -	rcu_read_unlock();
> +	iter.task = find_get_tgid_task(&iter.tgid, ns);
>   	return iter;
>   }
>   

