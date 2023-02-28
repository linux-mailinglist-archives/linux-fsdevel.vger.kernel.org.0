Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C186A5F63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 20:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB1TNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 14:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1TNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:13:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E191D90C;
        Tue, 28 Feb 2023 11:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F139661181;
        Tue, 28 Feb 2023 19:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD2EC433EF;
        Tue, 28 Feb 2023 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677611591;
        bh=NomRgZhAnCadauaNPou4fifv4G+IJxYhxbkOJyVdeaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gC9tn+qCRdX2PPavqpJdx8Gqi2XJrpEt/lxYjeSZMFH1MkwOPTnWeGZSSFyrivHHz
         y+G2Ujnzj5zWphHDQNoj18ubFP9kBGdM1QlEVrI/nK1xvmeQH5ySs/ol0TpkotjjJb
         /sP1lQwiBZp3nUCCxtQ1UZ3IMNi7g58hng+JOqyw=
Date:   Tue, 28 Feb 2023 11:13:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 1/9] mm: Store build id in inode object
Message-Id: <20230228111310.05f339a0a1a00e919859ffad@linux-foundation.org>
In-Reply-To: <20230228093206.821563-2-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
        <20230228093206.821563-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Feb 2023 10:31:58 +0100 Jiri Olsa <jolsa@kernel.org> wrote:

> Storing build id in file's inode object for elf executable with build
> id defined. The build id is stored when file is mmaped.
> 
> This is enabled with new config option CONFIG_INODE_BUILD_ID.
> 
> The build id is valid only when the file with given inode is mmap-ed.
> 
> We store either the build id itself or the error we hit during
> the retrieval.
> 
> ...
>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -699,6 +700,12 @@ struct inode {
>  	struct fsverity_info	*i_verity_info;
>  #endif
>  
> +#ifdef CONFIG_INODE_BUILD_ID
> +	/* Initialized and valid for executable elf files when mmap-ed. */
> +	struct build_id		*i_build_id;
> +	spinlock_t		i_build_id_lock;
> +#endif
> +

Remember we can have squillions of inodes in memory.  So that's one
costly spinlock!

AFAICT this lock could be removed if mmap_region() were to use an
atomic exchange on inode->i_build_id?

If not, can we use an existing lock?  i_lock would be appropriate
(don't forget to update its comment).

Also, the code in mmap_region() runs build_id_free() inside the locked
region, which seems unnecessary.

