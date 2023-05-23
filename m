Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4854070DF74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjEWOiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEWOiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:38:04 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B7E0;
        Tue, 23 May 2023 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lVxc8nMPNGIm5J+njIEIPXXeD353Vh5ymn5V4/A0dvg=; b=mzQt2SkOgl1mdg+WuY9fkhOPAh
        mIWKLljybsKGp2mvuu/30+CBsasAfF9CXUnTTqc//ujHs2ytgT/oipLbS834fclgBUA5UIqLd9FRu
        GrKfkM6y9ooDGoZWMs/hupyL3NL2EfbEBtCMXHWTxM9hpFTX3m48zTWydMtOMxsiR9WjgY12lPqaa
        rXYIjhKq+zriDr2lNGMaSakwWuYOuiR/RbqyRTtsOI8ftthlAAkJt6hmFq3BgY+h5LGMiPUb9TFsl
        oi9TpHBDrrDw110TF/lOeRJYoxLSgMiYpdP3rGlwgv07fxxxHrp+3bIjBc9FP8ln56CPvyW0zyubi
        ff7FC8tA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1q1T9F-000Iy2-BU; Tue, 23 May 2023 16:38:01 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1q1T9E-000C87-Qg; Tue, 23 May 2023 16:38:00 +0200
Subject: Re: [PATCH v3 bpf-next 3/4] libbpf: add opts-based bpf_obj_pin() API
 and add support for path_fd
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org
Cc:     cyphar@cyphar.com, brauner@kernel.org, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
References: <20230522232917.2454595-1-andrii@kernel.org>
 <20230522232917.2454595-4-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <383289fa-1036-b569-1ebf-5da8ba41c58d@iogearbox.net>
Date:   Tue, 23 May 2023 16:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230522232917.2454595-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26916/Tue May 23 09:22:39 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/23 1:29 AM, Andrii Nakryiko wrote:
[...]
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a5aa3a383d69..7a4fe80da360 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -389,5 +389,6 @@ LIBBPF_1.2.0 {
>   		bpf_link__update_map;
>   		bpf_link_get_info_by_fd;
>   		bpf_map_get_info_by_fd;
> +		bpf_obj_pin_opts;

Given 1.2.0 went out [0], shouldn't this go into a new LIBBPF_1.3.0 section?

>   		bpf_prog_get_info_by_fd;
>   } LIBBPF_1.1.0;

Thanks,
Daniel

   [0] https://lore.kernel.org/bpf/CAEf4BzYJhzEDHarRGvidhPd-DRtu4VXxnQ=HhOG-LZjkbK-MwQ@mail.gmail.com/
