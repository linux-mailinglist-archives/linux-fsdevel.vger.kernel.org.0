Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B1B1047
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgDTPfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgDTPfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:35:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE5C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 08:35:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so18212wmg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=+K+qKu708z2zVtKaY1gkYCyIah49wYPOwR1gFNLf0bo=;
        b=qpAdI8vvJOtyeSlXBkFHfH4B5C8yKPj5rBiaxCTZBc7Iuk412crGYb7cJJV8hqda+8
         1w6hDI4DcEJ8KH5sPSlr1UnRM9CJUJN3BuyAignz7OGxJIKhwX21bE2zT495CCm6OtTr
         O4SqYJ/coKIi17kgGJV1eVN0Lt544tq7RAxYpcs1RpXlaYIuIQj01cyDXgPSnUw9Geec
         zw+jm4KgINP2OxNKFO9u5QUv6pOizP0KWZ31nVt+wUWiJwt8FZUrb0/9UasNNpCgmLOS
         Yy/zwJFUULhR3SSeOnkdPt3pQz9OHfQPzmUkG95sYyx1rCpHKhjhFAisgSH+VC128VkM
         qaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+K+qKu708z2zVtKaY1gkYCyIah49wYPOwR1gFNLf0bo=;
        b=nRHXy+eOc/FB9XzbexjQQfoqo8h2+2o8+nfcP+wJdD3ihledMzId2N4VYBTS6PZGTw
         xfrVnX7k0rzHgKaE/VTGT+LhsBCW44qlB3jnWpvDeN6d55J8jgEIOzon3Zn8h2aWGuzK
         +4urgpkSjQoXnjs3G9GxwWfa4wAAi57IN79oofq/Y26Llnz2Yz6FloSG6w5hMqUnjkXO
         5PIUOz1+7VcUQGpbPW7mJzlqMyyoDgpEWS6k+Pt6rGF6rifQuxLvEV3atXxirTlVHmr6
         jFu2woeo/zk/ye/PEwMU3TQiqtjFtmeqzRtHQw25tdjFvHMr13skozHkIA5/paC4AFzW
         4hkg==
X-Gm-Message-State: AGi0PuZnRdqCVLVd9PajJjfPWO65+BVGnyaL+potIxW+pZyrHAjNotUO
        66RPt8BY6cRLsLeCg65EQQb/2A==
X-Google-Smtp-Source: APiQypICr1nADV0G13PJbrR/ddpdcRZMBwBzTFr+0IZALFBviYlLaDljuZMViX5a/fg0cB6qqO0qhg==
X-Received: by 2002:a1c:5446:: with SMTP id p6mr18188522wmi.172.1587396922664;
        Mon, 20 Apr 2020 08:35:22 -0700 (PDT)
Received: from linux-2.fritz.box (p200300D997064100F4D27C63BD39C692.dip0.t-ipconnect.de. [2003:d9:9706:4100:f4d2:7c63:bd39:c692])
        by smtp.googlemail.com with ESMTPSA id v131sm1878061wmb.19.2020.04.20.08.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 08:35:21 -0700 (PDT)
Subject: Re: [PATCH] ipc: Convert ipcs_idr to XArray
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200326151418.27545-1-willy@infradead.org>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <80ab3182-5a17-7434-9007-33eb1da46d85@colorfullife.com>
Date:   Mon, 20 Apr 2020 17:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326151418.27545-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 3/26/20 4:14 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> The XArray has better loops than the IDR has, removing the need to
> open-code them.  We also don't need to call idr_destroy() any more.
> Allocating the ID is a little tricky due to needing to get 'seq'
> correct.  Open-code a variant of __xa_alloc() which lets us set the
> ID and the seq before depositing the pointer in the array.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---

> -		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
> -		max_idx = min(max_idx, ipc_mni);
> -
> -		/* allocate the idx, with a NULL struct kern_ipc_perm */
> -		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
> -					GFP_NOWAIT);
> -
> -		if (idx >= 0) {
> -			/*
> -			 * idx got allocated successfully.
> -			 * Now calculate the sequence number and set the
> -			 * pointer for real.
> -			 */
> -			if (idx <= ids->last_idx) {
> +		min_idx = ids->next_idx;
> +		new->seq = ids->seq;
> +
> +		/* Modified version of __xa_alloc */
> +		do {
> +			xas.xa_index = min_idx;
> +			xas_find_marked(&xas, max_idx, XA_FREE_MARK);
> +			if (xas.xa_node == XAS_RESTART && min_idx > 0) {
>   				ids->seq++;
>   				if (ids->seq >= ipcid_seq_max())
>   					ids->seq = 0;
> +				new->seq = ids->seq;
> +				xas.xa_index = 0;
> +				min_idx = 0;
> +				xas_find_marked(&xas, max_idx, XA_FREE_MARK);
>   			}

Is is nessary to have that many details of xarray in ipc/util?

This function is not performance critical.

The core requirement is that ipc_obtain_object_check() must scale.

Would it be possible to use something like

     xa_alloc(,entry=NULL,)

     new->seq = ...

     xa_store(,entry=new,);

> -			ids->last_idx = idx;
> -
> -			new->seq = ids->seq;
> -			/* no need for smp_wmb(), this is done
> -			 * inside idr_replace, as part of
> -			 * rcu_assign_pointer
> -			 */

Could you leave the memory barrier comments in the code?

The rcu_assign_pointer() is the first hands-off from semget() or msgget().

Before the rcu_assign_pointer, e.g. semop() calls would return -EINVAL;

After the rcu_assign_pointer, semwhatever() must work - and e.g. the 
permission checks are lockless.

> -			idr_replace(&ids->ipcs_idr, new, idx);
> -		}
> +			if (xas.xa_node == XAS_RESTART)
> +				xas_set_err(&xas, -ENOSPC);
> +			else
> +				new->id = (new->seq << ipcmni_seq_shift()) +
> +					xas.xa_index;

Setting new->id should remain at the end, outside any locking:

The variable has no special protection, access is only allowed after 
proper locking, thus no need to have the initialization in the middle.

What is crucial is that the final value of new->seq is visible to all 
cpus before a storing the pointer.
> +			xas_store(&xas, new);
> +			xas_clear_mark(&xas, XA_FREE_MARK);
> +		} while (__xas_nomem(&xas, GFP_KERNEL));
> +

Just for my curiosity:

If the xas is in an invalid state, then xas_store() will not store anything.
Thus the loop will not store "new" multiple times, it will be stored 
only once.

@@ -472,7 +487,7 @@ void ipc_rmid(struct ipc_ids *ids, struct 
kern_ipc_perm *ipcp)
>   			idx--;
>   			if (idx == -1)
>   				break;
> -		} while (!idr_find(&ids->ipcs_idr, idx));
> +		} while (!xa_load(&ids->ipcs, idx));
>   		ids->max_idx = idx;
>   	}
>   }

Is there an xa_find_last() function?

It is outside of any hot path, I have a patch that does a binary search 
with idr_get_next().

If there is no xa_find_last(), then I would rebase that patch.


--

     Manfred

