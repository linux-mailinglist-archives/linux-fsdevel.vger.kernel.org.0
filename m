Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997257EC7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiGWHmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiGWHmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:42:16 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE084E868;
        Sat, 23 Jul 2022 00:42:15 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 89ABC1C6789;
        Sat, 23 Jul 2022 07:42:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 7942120019;
        Sat, 23 Jul 2022 07:42:13 +0000 (UTC)
Message-ID: <0350c21bcfdc896f2b912363f221958d41ebf1e1.camel@perches.com>
Subject: Re: [PATCH 3/4] exfat: Expand exfat_err() and co directly to pr_*()
 macro
From:   Joe Perches <joe@perches.com>
To:     Takashi Iwai <tiwai@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 23 Jul 2022 00:42:12 -0700
In-Reply-To: <20220722142916.29435-4-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de>
         <20220722142916.29435-4-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 3t95ozn3cgqiwgokc1xckwhqba4pqumh
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7942120019
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YD59ycuUpf1eRiadcD8l6BgVFFY4LRTI=
X-HE-Tag: 1658562133-578320
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-07-22 at 16:29 +0200, Takashi Iwai wrote:
> Currently the error and info messages handled by exfat_err() and co
> are tossed to exfat_msg() function that does nothing but passes the
> strings with printk() invocation.  Not only that this is more overhead
> by the indirect calls, but also this makes harder to extend for the
> debug print usage; because of the direct printk() call, you cannot
> make it for dynamic debug or without debug like the standard helpers
> such as pr_debug() or dev_dbg().
> 
> For addressing the problem, this patch replaces exfat_msg() function
> with a macro to expand to pr_*() directly.  This allows us to create
> exfat_debug() macro that is expanded to pr_debug() (which output can
> gracefully suppressed via dyndbg).
[]
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
[]
> @@ -508,14 +508,19 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
>  #define exfat_fs_error_ratelimit(sb, fmt, args...) \
>  		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
>  		fmt, ## args)
> -void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
> -		__printf(3, 4) __cold;
> +
> +/* expand to pr_xxx() with prefix */
> +#define exfat_msg(sb, lv, fmt, ...) \
> +	pr_##lv("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
> +
>  #define exfat_err(sb, fmt, ...)						\
> -	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
> +	exfat_msg(sb, err, fmt, ##__VA_ARGS__)
>  #define exfat_warn(sb, fmt, ...)					\
> -	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	exfat_msg(sb, warn, fmt, ##__VA_ARGS__)
>  #define exfat_info(sb, fmt, ...)					\
> -	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
> +	exfat_msg(sb, info, fmt, ##__VA_ARGS__)
> +#define exfat_debug(sb, fmt, ...)					\
> +	exfat_msg(sb, debug, fmt, ##__VA_ARGS__)

I think this would be clearer using pr_<level> directly instead
of an indirecting macro that uses concatenation of <level> that
obscures the actual use of pr_<level>

Either: (and this first option would be my preference)

#define exfat_err(sb, fmt, ...) \
	pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
#define exfat_warn(sb, fmt, ...) \
	pr_warn("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
etc...

or using an indirecting macro:

#define exfat_printk(pr_level, sb, fmt, ...)	\
	pr_level("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)

#define exfat_err(sb, fmt, ...)
	exfat_printk(pr_err, sb, fmt, ##__VA_ARGS)
#define exfat_warn(sb, fmt, ...)
	exfat_printk(pr_warn, sb, fmt, ##__VA_ARGS)
etc...

and btw, there are multiple uses of exfat_<level> output with a
unnecessary and duplicated '\n' that the macro already adds that
should be removed:

$ git grep -P -n '\bexfat_(err|warn|info).*\\n' fs/exfat/
fs/exfat/fatent.c:334:                  exfat_err(sb, "sbi->clu_srch_ptr is invalid (%u)\n",
fs/exfat/nls.c:674:                     exfat_err(sb, "failed to read sector(0x%llx)\n",
fs/exfat/super.c:467:           exfat_err(sb, "bogus sector size bits : %u\n",
fs/exfat/super.c:476:           exfat_err(sb, "bogus sectors bits per cluster : %u\n",

