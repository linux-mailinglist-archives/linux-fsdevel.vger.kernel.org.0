Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525557ECAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiGWIQs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGWIQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:16:46 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA471186E3;
        Sat, 23 Jul 2022 01:16:45 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 9F0FF120EDF;
        Sat, 23 Jul 2022 08:16:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 8B1EA1A;
        Sat, 23 Jul 2022 08:16:43 +0000 (UTC)
Message-ID: <23290590dcf9f97187f59d655ce817a8aa658833.camel@perches.com>
Subject: Re: [PATCH 3/4] exfat: Expand exfat_err() and co directly to pr_*()
 macro
From:   Joe Perches <joe@perches.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 23 Jul 2022 01:16:42 -0700
In-Reply-To: <87edyc2r2e.wl-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de>
         <20220722142916.29435-4-tiwai@suse.de>
         <0350c21bcfdc896f2b912363f221958d41ebf1e1.camel@perches.com>
         <87edyc2r2e.wl-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: tdn6xufrza8anjua993f5owtjeb7ex3a
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8B1EA1A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/oHwr3Rx2pLfHMEwKBkij8cn0YKk0+wyU=
X-HE-Tag: 1658564203-726879
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-07-23 at 10:04 +0200, Takashi Iwai wrote:
> On Sat, 23 Jul 2022 09:42:12 +0200, Joe Perches wrote:
> > On Fri, 2022-07-22 at 16:29 +0200, Takashi Iwai wrote:
> > > Currently the error and info messages handled by exfat_err() and co
> > > are tossed to exfat_msg() function that does nothing but passes the
> > > strings with printk() invocation.  Not only that this is more overhead
> > > by the indirect calls, but also this makes harder to extend for the
> > > debug print usage; because of the direct printk() call, you cannot
> > > make it for dynamic debug or without debug like the standard helpers
> > > such as pr_debug() or dev_dbg().
> > > 
> > > For addressing the problem, this patch replaces exfat_msg() function
> > > with a macro to expand to pr_*() directly.  This allows us to create
> > > exfat_debug() macro that is expanded to pr_debug() (which output can
> > > gracefully suppressed via dyndbg).
> > []
> > > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> > []
> > > @@ -508,14 +508,19 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
> > >  #define exfat_fs_error_ratelimit(sb, fmt, args...) \
> > >  		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
> > >  		fmt, ## args)
> > > -void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
> > > -		__printf(3, 4) __cold;
> > > +
> > > +/* expand to pr_xxx() with prefix */
> > > +#define exfat_msg(sb, lv, fmt, ...) \
> > > +	pr_##lv("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
> > > +
> > >  #define exfat_err(sb, fmt, ...)						\
> > > -	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
> > > +	exfat_msg(sb, err, fmt, ##__VA_ARGS__)
> > >  #define exfat_warn(sb, fmt, ...)					\
> > > -	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
> > > +	exfat_msg(sb, warn, fmt, ##__VA_ARGS__)
> > >  #define exfat_info(sb, fmt, ...)					\
> > > -	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
> > > +	exfat_msg(sb, info, fmt, ##__VA_ARGS__)
> > > +#define exfat_debug(sb, fmt, ...)					\
> > > +	exfat_msg(sb, debug, fmt, ##__VA_ARGS__)
> > 
> > I think this would be clearer using pr_<level> directly instead
> > of an indirecting macro that uses concatenation of <level> that
> > obscures the actual use of pr_<level>
> > 
> > Either: (and this first option would be my preference)
> > 
> > #define exfat_err(sb, fmt, ...) \
> > 	pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
> > #define exfat_warn(sb, fmt, ...) \
> > 	pr_warn("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
> > etc...
> 
> IMO, it's a matter of taste, and I don't mind either way.
> Just let me know.
> 
> > or using an indirecting macro:
> > 
> > #define exfat_printk(pr_level, sb, fmt, ...)	\
> > 	pr_level("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
> 
> Is pr_level() defined anywhere...?

no

$ git grep -w pr_level
$ 

