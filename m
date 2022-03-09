Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3B4D31C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiCIPbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCIPbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7AC910662F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 07:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646839841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EsyJDNMaW7aLzLkycFQGvPjjJ3FlfDqU3pzS9T1Q8I=;
        b=N+gY2C4FWhyo1L05/xf6vKSLuQkAulCUSmVu0XiV7Z6gzHPMLM21dUwrLo/xUWbfXyrR+0
        ISvIu+9QslLVYxu7SDnq52ImpumYVzFO0Jr76RZUpUrH1ruRZApYAn/00s60WNmKAPA2li
        eyTXRJGZ+umn/9PCyd7qN5D5lZfFB3w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-dVn1vJQzNqqdvA7nbX9z0Q-1; Wed, 09 Mar 2022 10:30:38 -0500
X-MC-Unique: dVn1vJQzNqqdvA7nbX9z0Q-1
Received: by mail-qk1-f199.google.com with SMTP id q24-20020a05620a0c9800b0060d5d0b7a90so1774421qki.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 07:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6EsyJDNMaW7aLzLkycFQGvPjjJ3FlfDqU3pzS9T1Q8I=;
        b=68A8l2VzHIPMi5cr7TEfw17BQGShN1YP1V2yeVO76nGQt9P00Y0HiuEAgrKatTqmQy
         JhC9YbXRKG0YGBfoqKqOUcvoD9SOQUqdLfC0U4AwsMORWjsDUiNqwfweYXCA8SLLiTXd
         JWPwmm6whCyatXNMKB0YBCYF6V/7SKHznEYkwscFlg7xWlUMcZLXJ/+/hWFLt9RpwBm3
         EizXOEQF8X5AxB08abIGWAe5aQUqabOpbAnsLD3ejyAbZkzn/dxaoWAGd3vLm72zfprf
         n6slqD8O8zGxkXGuIoNuhh+536fdML7xIYuW0qJdK6v3Cw4/VFSzqM0HVp3+42M4FOP6
         xPKg==
X-Gm-Message-State: AOAM531Aqa3OleQxyGycUtoh1gMgZabjYLLbpYCZOBspran0kTpQTCc5
        ikrERneTOxTbB47TGw2tCPNYBKvrLEI5XMMssbEnhCjuA1peCjWcgeLkI5AaXn0psSzuu2g0Hr4
        rBFbGX5g6qeRMeYGeokWbnn8ViA==
X-Received: by 2002:a05:622a:102:b0:2de:6596:73ff with SMTP id u2-20020a05622a010200b002de659673ffmr166631qtw.75.1646839838466;
        Wed, 09 Mar 2022 07:30:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFSSJDdxTCAvhdcrcS/qlT4SNihglL15R3cIkJvlDoonZ+iPAI4r0UaiLtAuAoNBZeA0b9IA==
X-Received: by 2002:a05:622a:102:b0:2de:6596:73ff with SMTP id u2-20020a05622a010200b002de659673ffmr166596qtw.75.1646839838220;
        Wed, 09 Mar 2022 07:30:38 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b0060deaee7a21sm1055813qkj.51.2022.03.09.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:30:37 -0800 (PST)
Message-ID: <c2f4b3dc107b106e04c48f54945a12715cccfdf3.camel@redhat.com>
Subject: Re: [PATCH v2 02/19] netfs: Generate enums from trace symbol
 mapping lists
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:30:36 -0500
In-Reply-To: <164678192454.1200972.4428834328108580460.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678192454.1200972.4428834328108580460.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:25 +0000, David Howells wrote:
> netfs has a number of lists of symbols for use in tracing, listed in an
> enum and then listed again in a symbol->string mapping for use with
> __print_symbolic().  This is, however, redundant.
> 
> Instead, use the symbol->string mapping list to also generate the enum
> where the enum is in the same file.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/164622980839.3564931.5673300162465266909.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  include/trace/events/netfs.h |   57 ++++++++++--------------------------------
>  1 file changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index e6f4ebbb4c69..88d9a74dd346 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -15,49 +15,6 @@
>  /*
>   * Define enums for tracing information.
>   */
> -#ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
> -#define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
> -
> -enum netfs_read_trace {
> -	netfs_read_trace_expanded,
> -	netfs_read_trace_readahead,
> -	netfs_read_trace_readpage,
> -	netfs_read_trace_write_begin,
> -};
> -
> -enum netfs_rreq_trace {
> -	netfs_rreq_trace_assess,
> -	netfs_rreq_trace_done,
> -	netfs_rreq_trace_free,
> -	netfs_rreq_trace_resubmit,
> -	netfs_rreq_trace_unlock,
> -	netfs_rreq_trace_unmark,
> -	netfs_rreq_trace_write,
> -};
> -
> -enum netfs_sreq_trace {
> -	netfs_sreq_trace_download_instead,
> -	netfs_sreq_trace_free,
> -	netfs_sreq_trace_prepare,
> -	netfs_sreq_trace_resubmit_short,
> -	netfs_sreq_trace_submit,
> -	netfs_sreq_trace_terminated,
> -	netfs_sreq_trace_write,
> -	netfs_sreq_trace_write_skip,
> -	netfs_sreq_trace_write_term,
> -};
> -
> -enum netfs_failure {
> -	netfs_fail_check_write_begin,
> -	netfs_fail_copy_to_cache,
> -	netfs_fail_read,
> -	netfs_fail_short_readpage,
> -	netfs_fail_short_write_begin,
> -	netfs_fail_prepare_write,
> -};
> -
> -#endif
> -
>  #define netfs_read_traces					\
>  	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
>  	EM(netfs_read_trace_readahead,		"READAHEAD")	\
> @@ -98,6 +55,20 @@ enum netfs_failure {
>  	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
>  	E_(netfs_fail_prepare_write,		"prep-write")
>  
> +#ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
> +#define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
> +
> +#undef EM
> +#undef E_
> +#define EM(a, b) a,
> +#define E_(a, b) a
> +
> +enum netfs_read_trace { netfs_read_traces } __mode(byte);
> +enum netfs_rreq_trace { netfs_rreq_traces } __mode(byte);
> +enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
> +enum netfs_failure { netfs_failures } __mode(byte);
> +

Should you undef EM and E_ here after creating these?

> +#endif
>  
>  /*
>   * Export enum symbols via userspace.
> 
> 

Looks fine otherwise:

Acked-by: Jeff Layton <jlayton@redhat.com>

