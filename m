Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB656C368B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCUQEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCUQEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:04:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C502A151;
        Tue, 21 Mar 2023 09:04:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A62722179;
        Tue, 21 Mar 2023 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679414676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqV68zFEuPEfvE057sQFY+VG01o4U7Wn4v08os2RZjg=;
        b=E/OA2UdMgfl8mYCkExoWWAsmR5K7iAcywCkd0mkc3bM+cC1Zm7jk8SljBNAYSCXKQm0luD
        rP8XBTizJ+Bd3TgkrDMIOL4Zwlh7ojBNLlPVF51RO+i4OmY4bJtNg+2vtTM+LUcDmVWShX
        ZXlulOVUcvXHutCE17HLUBPQPuMGFno=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A3962C141;
        Tue, 21 Mar 2023 16:04:36 +0000 (UTC)
Date:   Tue, 21 Mar 2023 17:04:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL console
 basic infrastructure
Message-ID: <ZBnVkarywpyWlDWW@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2023-03-02 21:02:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current console/printk subsystem is protected by a Big Kernel Lock,
> (aka console_lock) which has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and
> makes forced takeover and output in emergency and panic situations a
> fragile endavour which is based on try and pray.
> 
> The goal of non-BKL consoles is to break out of the console lock jail
> and to provide a new infrastructure that avoids the pitfalls and
> allows console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Per console locking instead of global locking
>   - Per console state which allows to make informed decisions
>   - Stateful handover and takeover
> 
> As a first step state is added to struct console. The per console state
> is an atomic_long_t with a 32bit bit field and on 64bit also a 32bit
> sequence for tracking the last printed ringbuffer sequence number. On
> 32bit the sequence is separate from state for obvious reasons which
> requires handling a few extra race conditions.
>

It is not completely clear that that this struct is stored
as atomic_long_t atomic_state[2] in struct console.

What about adding?

		atomic_long_t atomic;

> +		unsigned long	atom;
> +		struct {
> +#ifdef CONFIG_64BIT
> +			u32	seq;
> +#endif
> +			union {
> +				u32	bits;
> +				struct {
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  /**
> @@ -186,6 +214,8 @@ enum cons_flags {
>   * @dropped:		Number of unreported dropped ringbuffer records
>   * @data:		Driver private data
>   * @node:		hlist node for the console list
> + *
> + * @atomic_state:	State array for NOBKL consoles; real and handover
>   */
>  struct console {
>  	char			name[16];
> @@ -205,6 +235,9 @@ struct console {
>  	unsigned long		dropped;
>  	void			*data;
>  	struct hlist_node	node;
> +
> +	/* NOBKL console specific members */
> +	atomic_long_t		__private atomic_state[2];

and using here

	struct cons_state	__private cons_state[2];

Then we could use cons_state[which].atomic to access it as
the atomic type.

Or was this on purpose? It is true that only the variable
in struct console has to be accessed the atomic way.

Anyway, we should at least add a comment into struct console
about that atomic_state[2] is used to store and access
struct cons_state an atomic way. Also add a compilation
check that the size is the same.

Best Regards,
Petr
