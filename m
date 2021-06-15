Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85433A85BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFOP6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOP5A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:57:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3816560FEE;
        Tue, 15 Jun 2021 15:54:55 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:54:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-ID: <20210615115453.63bc3a63@oasis.local.home>
In-Reply-To: <643721.1623754699@warthog.procyon.org.uk>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
        <643721.1623754699@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 11:58:19 +0100
David Howells <dhowells@redhat.com> wrote:

> @@ -649,20 +705,21 @@ TRACE_EVENT(afs_cb_call,
>  
>  	    TP_STRUCT__entry(
>  		    __field(unsigned int,		call		)
> -		    __field(const char *,		name		)
>  		    __field(u32,			op		)
> +		    __field(u16,			service_id	)
>  			     ),
>  
>  	    TP_fast_assign(
>  		    __entry->call	= call->debug_id;
> -		    __entry->name	= call->type->name;
>  		    __entry->op		= call->operation_ID;
> +		    __entry->service_id	= call->service_id;
>  			   ),
>  
> -	    TP_printk("c=%08x %s o=%u",
> +	    TP_printk("c=%08x %s",
>  		      __entry->call,
> -		      __entry->name,
> -		      __entry->op)
> +		      __entry->service_id == 2501 ?
> +		      __print_symbolic(__entry->op, yfs_cm_operations) :
> +		      __print_symbolic(__entry->op, afs_cm_operations))
>  	    );
>  
>  TRACE_EVENT(afs_call,

Looks fine to me, and even saves 4 bytes on 64 bit machines (events are
rounded up to 4 byte increments, so the u16 is no different than a u32
here).

-- Steve
