Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A96F54B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjECJ2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjECJ2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:28:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1E40FD;
        Wed,  3 May 2023 02:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1466922512;
        Wed,  3 May 2023 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683106118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT8hRoGrD7YYsyuNzU3m9hUOCfJOj+hVhsiy6Y68fVU=;
        b=KNBGK8zjHrHQHnx+S6z2tKwi19OkhXGsbIMMkA+D++2t52hNwFhjKqIhIBhNnmkQzsUP2x
        TcNu1ogjYSws6YOHb9ayFsx7W1J03jaLw3uA7fBr7RoUOrKNoSNmff2i1nnHvz66GeFupz
        htqaQ4deUB8uTiMpypa4CXf/GnuVM8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683106118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT8hRoGrD7YYsyuNzU3m9hUOCfJOj+hVhsiy6Y68fVU=;
        b=8s+fY93F2ait95RVli+zVOCSf/ID1heuYfx1wTPH3IoLdJQZ4NHRYwXnogAW7q/TPa3RDn
        bgAnO1JGVA4jbBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05E311331F;
        Wed,  3 May 2023 09:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lnnVAEUpUmT8FAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 03 May 2023 09:28:37 +0000
Message-ID: <b6857aad-4cfc-4961-df54-6e658fca7f75@suse.cz>
Date:   Wed, 3 May 2023 11:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's
 output
To:     Dave Chinner <david@fromorbit.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?B?Tm9yYWxmIFRyw6/Cv8K9bm5lcw==?= <noralf@tronnes.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan>
 <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan>
 <2f5ebe8a9ce8471906a85ef092c1e50cfd7ddecd.camel@HansenPartnership.com>
 <20230502225016.GJ2155823@dread.disaster.area>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230502225016.GJ2155823@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/23 00:50, Dave Chinner wrote:
> On Tue, May 02, 2023 at 07:42:59AM -0400, James Bottomley wrote:
>> On Mon, 2023-05-01 at 23:17 -0400, Kent Overstreet wrote:
>> > On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:
>> > > It is not used just for debug.  It's used all over the kernel for
>> > > printing out device sizes.  The output mostly goes to the kernel
>> > > print buffer, so it's anyone's guess as to what, if any, tools are
>> > > parsing it, but the concern about breaking log parsers seems to be
>> > > a valid one.
>> > 
>> > Ok, there is sd_print_capacity() - but who in their right mind would
>> > be trying to scrape device sizes, in human readable units,
>> 
>> If you bother to google "kernel log parser", you'll discover it's quite
>> an active area which supports a load of company business models.
> 
> That doesn't mean log messages are unchangable ABI. Indeed, we had
> the whole "printk_index_emit()" addition recently to create
> an external index of printk message formats for such applications to
> use. [*]
> 
>> >  from log messages when it's available in sysfs/procfs (actually, is
>> > it in sysfs? if not, that's an oversight) in more reasonable units?
>> 
>> It's not in sysfs, no.  As aren't a lot of things, which is why log
>> parsing for system monitoring is big business.
> 
> And that big business is why printk_index_emit() exists to allow
> them to easily determine how log messages change format and come and
> go across different kernel versions.
> 
>> > Correct me if I'm wrong, but I've yet to hear about kernel log
>> > messages being consider a stable interface, and this seems a bit out
>> > there.
>> 
>> It might not be listed as stable, but when it's known there's a large
>> ecosystem out there consuming it we shouldn't break it just because you
>> feel like it.
> 
> But we've solved this problem already, yes?
> 
> If the userspace applications are not using the kernel printk format
> index to detect such changes between kernel version, then they
> should be. This makes trivial issues like whether we have a space or
> not between units is completely irrelevant because the entry in the
> printk format index for the log output we emit will match whatever
> is output by the kernel....

If I understand that correctly from the commit changelog, this would have
indeed helped, but if the change was reflected in format string. But with
string_get_size() it's always an %s and the change of the helper's or a
switch to another variant of the helper that would omit the space, wouldn't
be reflected in the format string at all? I guess that would be an argument
for Andy's suggestion for adding a new %pt / %pT which would then be
reflected in the format string. And also more concise to use than using the
helper, fwiw.

> Cheers,
> 
> Dave.
> 
> [*]
> commit 337015573718b161891a3473d25f59273f2e626b
> Author: Chris Down <chris@chrisdown.name>
> Date:   Tue Jun 15 17:52:53 2021 +0100
> 
>     printk: Userspace format indexing support
>     
>     We have a number of systems industry-wide that have a subset of their
>     functionality that works as follows:
>     
>     1. Receive a message from local kmsg, serial console, or netconsole;
>     2. Apply a set of rules to classify the message;
>     3. Do something based on this classification (like scheduling a
>        remediation for the machine), rinse, and repeat.
>     
>     As a couple of examples of places we have this implemented just inside
>     Facebook, although this isn't a Facebook-specific problem, we have this
>     inside our netconsole processing (for alarm classification), and as part
>     of our machine health checking. We use these messages to determine
>     fairly important metrics around production health, and it's important
>     that we get them right.
>     
>     While for some kinds of issues we have counters, tracepoints, or metrics
>     with a stable interface which can reliably indicate the issue, in order
>     to react to production issues quickly we need to work with the interface
>     which most kernel developers naturally use when developing: printk.
>     
>     Most production issues come from unexpected phenomena, and as such
>     usually the code in question doesn't have easily usable tracepoints or
>     other counters available for the specific problem being mitigated. We
>     have a number of lines of monitoring defence against problems in
>     production (host metrics, process metrics, service metrics, etc), and
>     where it's not feasible to reliably monitor at another level, this kind
>     of pragmatic netconsole monitoring is essential.
>     
>     As one would expect, monitoring using printk is rather brittle for a
>     number of reasons -- most notably that the message might disappear
>     entirely in a new version of the kernel, or that the message may change
>     in some way that the regex or other classification methods start to
>     silently fail.
>     
>     One factor that makes this even harder is that, under normal operation,
>     many of these messages are never expected to be hit. For example, there
>     may be a rare hardware bug which one wants to detect if it was to ever
>     happen again, but its recurrence is not likely or anticipated. This
>     precludes using something like checking whether the printk in question
>     was printed somewhere fleetwide recently to determine whether the
>     message in question is still present or not, since we don't anticipate
>     that it should be printed anywhere, but still need to monitor for its
>     future presence in the long-term.
>     
>     This class of issue has happened on a number of occasions, causing
>     unhealthy machines with hardware issues to remain in production for
>     longer than ideal. As a recent example, some monitoring around
>     blk_update_request fell out of date and caused semi-broken machines to
>     remain in production for longer than would be desirable.
>     
>     Searching through the codebase to find the message is also extremely
>     fragile, because many of the messages are further constructed beyond
>     their callsite (eg. btrfs_printk and other module-specific wrappers,
>     each with their own functionality). Even if they aren't, guessing the
>     format and formulation of the underlying message based on the aesthetics
>     of the message emitted is not a recipe for success at scale, and our
>     previous issues with fleetwide machine health checking demonstrate as
>     much.
>     
>     This provides a solution to the issue of silently changed or deleted
>     printks: we record pointers to all printk format strings known at
>     compile time into a new .printk_index section, both in vmlinux and
>     modules. At runtime, this can then be iterated by looking at
>     <debugfs>/printk/index/<module>, which emits the following format, both
>     readable by humans and able to be parsed by machines:
>     
>         $ head -1 vmlinux; shuf -n 5 vmlinux
>         # <level[,flags]> filename:line function "format"
>         <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>         <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>         <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>         <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>         <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
>     
>     This mitigates the majority of cases where we have a highly-specific
>     printk which we want to match on, as we can now enumerate and check
>     whether the format changed or the printk callsite disappeared entirely
>     in userspace. This allows us to catch changes to printks we monitor
>     earlier and decide what to do about it before it becomes problematic.
>     
>     There is no additional runtime cost for printk callers or printk itself,
>     and the assembly generated is exactly the same.
>     
>     Signed-off-by: Chris Down <chris@chrisdown.name>
>     Cc: Petr Mladek <pmladek@suse.com>
>     Cc: Jessica Yu <jeyu@kernel.org>
>     Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>     Cc: John Ogness <john.ogness@linutronix.de>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Cc: Johannes Weiner <hannes@cmpxchg.org>
>     Cc: Kees Cook <keescook@chromium.org>
>     Reviewed-by: Petr Mladek <pmladek@suse.com>
>     Tested-by: Petr Mladek <pmladek@suse.com>
>     Reported-by: kernel test robot <lkp@intel.com>
>     Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>     Acked-by: Jessica Yu <jeyu@kernel.org> # for module.{c,h}
>     Signed-off-by: Petr Mladek <pmladek@suse.com>
>     Link: https://lore.kernel.org/r/e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name
> 

