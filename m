Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5B30C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEaJzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:55:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SO6RZ2MWMfP966/KS09Kj16aISHfi3y/o8daAQ0/Hv4=; b=GTP6AttidDzMtloNM4u5dMmV7
        MHADEHCym6o6MYH9EHLNZOoLcowWqaAAmQmNozUE/x8fk+boCf4HHz2pJ+ZfNWnpisn5OUz9nn+cq
        HRRDzoUjhrCnriM8TwrwzaV68b/QxuVKP//XiLPqdMmduDFnevOpjbwvr9/FbzmxLxbN90vm9ggA/
        yif13K8VWvZW/NtOoUq3lOfwj8Eo3VMlWy6vloKbHZm7LQV+4eybSIdYSaHBuuzG0L/InyCBD6ipS
        LwYgYV+MzjaxAFoWVX3QIhVRhj2mWafuUxFhnH/IXGCB9Baf4S7MAiGo3tKZ06hZP53ojtPTtBjgQ
        QhwpBvagg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWeGN-0003jR-4E; Fri, 31 May 2019 09:55:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6313201D5AB1; Fri, 31 May 2019 11:55:49 +0200 (CEST)
Date:   Fri, 31 May 2019 11:55:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531095549.GB17637@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516085810.31077-7-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
> +#define atomic_set_unless_zero(ptr, flags)			\
> +({								\
> +	typeof(ptr) _ptr = (ptr);				\
> +	typeof(flags) _flags = (flags);				\
> +	typeof(*_ptr) _old, _val = READ_ONCE(*_ptr);		\
> +								\
> +	for (;;) {						\
> +		if (!_val)					\
> +			break;					\
> +		_old = cmpxchg(_ptr, _val, _flags);		\
> +		if (_old == _val)				\
> +			break;					\
> +		_val = _old;					\
> +	}							\
> +	_val;							\
> +})

> +#define atomic_or_with_mask(ptr, flags, mask)			\
> +({								\
> +	typeof(ptr) _ptr = (ptr);				\
> +	typeof(flags) _flags = (flags);				\
> +	typeof(flags) _mask = (mask);				\
> +	typeof(*_ptr) _old, _new, _val = READ_ONCE(*_ptr);	\
> +								\
> +	for (;;) {						\
> +		_new = (_val & ~_mask) | _flags;		\
> +		_old = cmpxchg(_ptr, _val, _new);		\
> +		if (_old == _val)				\
> +			break;					\
> +		_val = _old;					\
> +	}							\
> +	_val;							\
> +})

Don't call them atomic_*() if they're not part of the atomic_t
interface.

