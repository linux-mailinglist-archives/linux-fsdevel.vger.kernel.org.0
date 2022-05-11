Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C7522D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiEKHtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbiEKHtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 03:49:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74013B8C2;
        Wed, 11 May 2022 00:49:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x52so1264162pfu.11;
        Wed, 11 May 2022 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzoa+jq0XpHGYJhcqgikWEC9JzeX9J0ZmovNXZZqPlw=;
        b=pZSkpwiMq4LnqPxtv7NNZnd0sQ+5K2QkvF7M00OPRdBBKZbN6fzMaV6MJ4pqhUWVw3
         qeiB5fkuIePt4fE3hDydIodwOhXdxl0yN1yC4BtaIbYFC+ePtdSDHCS+6VNb0eDtqYuk
         AulJ4HKphYw749hNPshP78whdF192rhBQAtAojzF8WIPZLHLj9KWjxaF+R4EuxjPyf9M
         RJsDZI6Vkw9VbFtfKnTlgLWfxzmwAMj4OmbM3iNnPFvEVQnCQE5AvAj4ZeRjchRJlPuz
         i/nCN41u69MS24J1UGFonJ092NoOkpxszFPNAY4W9uZsAuG1xoZ3tF7XAuaQJHbXsegC
         OVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzoa+jq0XpHGYJhcqgikWEC9JzeX9J0ZmovNXZZqPlw=;
        b=r4b24pAci37AEQA3b8U0NwpbeMeb03a1/1RrRcGl4HKOT9P0uvy4VATxsuz7184S89
         1HuBX0ADYtM5nx3VdWeHQEwv8njW39oNF8XTeXb1FNr8JhWex/O7AlWa2gmsopUoIlSO
         uLjCLOjWYu+9QpAB5R6+49KRYmP4MLgtDd+vrgYqKofzsVb3/hsfKdbkTyk1xdt2SOrM
         Yn3JabPQffNSo7O3r8dYGaOQq91uoLu3Rp9e0ii3Msaap4/9LUD2c5AFY3LLqrXdCxZ0
         F3MlogmGhm3aDqiamzKOnnmU5Hja50oQWqJhni44nrKjAn9/MIac2eLLNPupDt5g6OeV
         IKGQ==
X-Gm-Message-State: AOAM531VrNHD9JxPYHw6jd/gJTma0+siEHicYvmini8YsEmNB8EHlIh7
        XDJma0/nCWj7oBXoR4yIEjU=
X-Google-Smtp-Source: ABdhPJzVIZV8D4vEEibviwMNgTyoQBp4SRevkz7PIHOExgBxObpfveqLm+o4+WoTueHQ5w3vO3B2KQ==
X-Received: by 2002:a63:6381:0:b0:3c6:4449:fc60 with SMTP id x123-20020a636381000000b003c64449fc60mr19232124pgb.457.1652255339674;
        Wed, 11 May 2022 00:48:59 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:2759:da01:e9ea:1584])
        by smtp.gmail.com with ESMTPSA id n19-20020a635913000000b003dafd8f0760sm1036339pgb.28.2022.05.11.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:48:59 -0700 (PDT)
Date:   Wed, 11 May 2022 13:18:53 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix journal_ioprio mount option handling
Message-ID: <20220511074853.4xgdzagwmkp4ejuz@riteshh-domain>
References: <20220418083545.45778-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418083545.45778-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/18 02:05PM, Ojaswin Mujoo wrote:
> In __ext4_super() we always overwrote the user specified journal_ioprio
> value with a default value, expecting  parse_apply_sb_mount_options() to
> later correctly set ctx->journal_ioprio to the user specified value.
> However, if parse_apply_sb_mount_options() returned early because of
> empty sbi->es_s->s_mount_opts, the correct journal_ioprio value was
> never set.

>
> This patch fixes __ext4_super() to only use the default value if the
					^^^ __ext4_fill_super
> user has not specified any value for journal_ioprio.

Also the problem is that ext4_parse_param() is called before
__ext4_fill_super(). Hence when we overwrite ctx->journal_ioprio to default
value in __ext4_fill_super(), that will end up ignoring the user passed
journal_ioprio value via mount opts (which was passed earlier in
ext4_parse_param()).


>
> Similarly, the remount behavior was to either use journal_ioprio
> value specified during initial mount, or use the default value
> irrespective of the journal_ioprio value specified during remount.
> This patch modifies this to first check if a new value for ioprio
> has been passed during remount and apply it. Incase, no new value is
> passed, use the value specified during initial mount.

Yup, here also ext4_parse_param() is called before __ext4_remount().
Hence we should check if the user has passed it's value in mount opts, if not,
only then we should use the task original ioprio.


I tested this patch and with the patch applied, the task ioprio can be correctly
set using "journal_ioprio" mount option.

"Mount test"
=============
qemu-> sudo perf record -e probe:* -aR mount -o journal_ioprio=1 /dev/loop2 /mnt
qemu-> ps -eaf |grep -E "jbd2|loop2"
root        3506       2  0 07:41 ?        00:00:00 [jbd2/loop2-8]
qemu-> sudo perf script
           mount  3504 [000]  2503.106871: probe:ext4_parse_param_L222: (ffffffff8147817f) journal_ioprio=16385 spec=32
           mount  3504 [000]  2503.106908: probe:__ext4_fill_super_L26: (ffffffff8147a650) journal_ioprio=16385 spec=32
qemu-> ionice -p 3506
best-effort: prio 1

"remount test"
=================
qemu-> sudo perf record -e probe:* -aR mount -o remount,journal_ioprio=0 /dev/loop2 /mnt
qemu-> sudo perf script
           mount  3519 [000]  2544.958850: probe:ext4_parse_param_L222: (ffffffff8147817f) journal_ioprio=16384 spec=32
           mount  3519 [000]  2544.958860:    probe:__ext4_remount_L49: (ffffffff81479da2) journal_ioprio=16384 spec=32
qemu-> ionice -p 3506
best-effort: prio 0

"remount with no mount options"
=================================
qemu-> sudo perf record -e probe:* -aR mount -o remount /dev/loop2 /mnt
qemu-> ionice -p 3506
best-effort: prio 0
qemu-> sudo perf script
           mount  3530 [000]  2575.964048:    probe:__ext4_remount_L49: (ffffffff81479da2) journal_ioprio=16384 spec=0


>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

We should add fixes tag too. Can you please confirm if that would be this patch?
"ext4: Completely separate options parsing and sb setup".

With that feel free to add below -

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>


-ritesh

> ---
>  fs/ext4/super.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5a9ffbf7f4f..bfd767c51203 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4427,7 +4427,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	int silent = fc->sb_flags & SB_SILENT;
>
>  	/* Set defaults for the variables that will be set during parsing */
> -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> +		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
>
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
>  	sbi->s_sectors_written_start =
> @@ -6289,7 +6290,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	char *to_free[EXT4_MAXQUOTAS];
>  #endif
>
> -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
>
>  	/* Store the original options */
>  	old_sb_flags = sb->s_flags;
> @@ -6315,9 +6315,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  		} else
>  			old_opts.s_qf_names[i] = NULL;
>  #endif
> -	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> -		ctx->journal_ioprio =
> -			sbi->s_journal->j_task->io_context->ioprio;
> +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)) {
> +		if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> +			ctx->journal_ioprio =
> +				sbi->s_journal->j_task->io_context->ioprio;
> +		else
> +			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +
> +	}
>
>  	ext4_apply_options(fc, sb);
>
> --
> 2.27.0
>
