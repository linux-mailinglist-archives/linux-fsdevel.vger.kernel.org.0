Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFB70C22D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjEVPTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEVPTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 11:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0AF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684768725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtwpGxtG++IildS19TxDJ64n89sIOkk1Zx05HB1YFBA=;
        b=bQ/ziOA/gz1Yb3/irp1ZpeTLwvBHPYWprU5Czlo+KQxxgf7Uk4pnJtJu9UAf+BGz0/t/KK
        a6r9DgBXQ6J8ZTRpxl8HirgRXUF9y3yYSzxjp5Dp6pKAveYmFETrw82UpfiyPfPqpecac4
        VcFO1VlrXNrTRg/11AfF+n8NPgQJ9h0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-jTsudKaSMQKPukvSiDKyfw-1; Mon, 22 May 2023 11:18:42 -0400
X-MC-Unique: jTsudKaSMQKPukvSiDKyfw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4f2f5098bso35363115e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 08:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768721; x=1687360721;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtwpGxtG++IildS19TxDJ64n89sIOkk1Zx05HB1YFBA=;
        b=HHnWXRmkdSErszyz7RtrEaUD24085dNBFCkAmWoYKa0JheacV+psGZasfdL/+/1IXt
         zuhtEhyC2NMelrl+cg4OA0Bs+0z6Pg8yvW8ZCSApd/7lzmvhF/uVr4/BIE1xa/sw35wi
         EruvkbrFrGTEPQ95u8v11o9f3KsYMojV3zasb3bGtCcO2sCwx0yOE+GyahF0lx6YqZh5
         nnsMexIWwl3oCdEMDnswv2+cFDrto0AnfRkD5/5/dvmExn5pv6dN3LAkYqlkBk44/Ejx
         n8D2YwYjSUhxIE0lDJxTsEHY8B3dc0LuXpTBPPdaXIa4XAj2S27IQ5vWwY9CEDJ2ML68
         52lw==
X-Gm-Message-State: AC+VfDzBR7P2EXvYjyT46zicOr6hAtNjeUDfchVgb8xpLnKK9c5TgzuZ
        8ew9yYL9l/XjAdx/jL+1e5ajKBq2o2z8yisNEPgboAeVuxhviAqzDvE3osU6ruKaYypsL9vyvmh
        I4+5L6Cw2gNVukeWxKB3CTPAvMw==
X-Received: by 2002:adf:f3cd:0:b0:307:a4ee:4a25 with SMTP id g13-20020adff3cd000000b00307a4ee4a25mr7567584wrp.28.1684768720936;
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5c5Jh29rHJWdlcSftb4ivtZudFaESkFZGZH5aeQjTlOaWyT+K5kG/FE0wh/FICWlng66JoQQ==
X-Received: by 2002:adf:f3cd:0:b0:307:a4ee:4a25 with SMTP id g13-20020adff3cd000000b00307a4ee4a25mr7567565wrp.28.1684768720646;
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600012c900b003078354f774sm7963718wrx.36.2023.05.22.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v4] fs/buffer.c: update per-CPU bh_lru cache via RCU
In-Reply-To: <ZCXipBvmhAC1+eRi@tpad>
References: <ZCXipBvmhAC1+eRi@tpad>
Date:   Mon, 22 May 2023 16:18:39 +0100
Message-ID: <xhsmha5xwqtrk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/03/23 16:27, Marcelo Tosatti wrote:
> +/*
> + * invalidate_bh_lrus() is called rarely - but not only at unmount.
> + */
>  void invalidate_bh_lrus(void)
>  {
> -	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> +	int cpu, oidx;
> +
> +	mutex_lock(&bh_lru_invalidate_mutex);
> +	cpus_read_lock();
> +	oidx = bh_lru_idx;

> +	bh_lru_idx++;
> +	if (bh_lru_idx >= 2)
> +		bh_lru_idx = 0;
> +

You could make this a bool and flip it:
  bh_lru_idx = !bh_lru_idx

> +	/* Assign the per-CPU bh_lru pointer */
> +	for_each_online_cpu(cpu)
> +		rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +				   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	synchronize_rcu_expedited();
> +
> +	for_each_online_cpu(cpu) {
> +		struct bh_lru *b = per_cpu_ptr(&bh_lrus[oidx], cpu);
> +
> +		bh_lru_lock();
> +		__invalidate_bh_lrus(b);
> +		bh_lru_unlock();

Given the bh_lrup has been updated and we're past the synchronize_rcu(),
what is bh_lru_lock() used for here?

> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&bh_lru_invalidate_mutex);

Re scalability, this is shifting a set of per-CPU-IPI callbacks to a single
CPU, which isn't great. Can we consider doing something like [1], i.e. in
the general case send an IPI to:

  rcu_assign_pointer() + call_rcu(/* invalidation callback */)

and in the case we're NOHZ_FULL and the target CPU is not executing in the
kernel, we do that remotely to reduce interference. We might want to batch
the synchronize_rcu() for the remote invalidates, maybe some abuse of the
API like so?

  bool do_local_invalidate(int cpu, struct cpumask *mask)
  {
          if (cpu_in_kernel(cpu)) {
              __cpumask_clear_cpu(cpu, mask);
              return true;
          }

          return false;
  }

  void invalidate_bh_lrus(void)
  {
          cpumask_var_t cpumask;

          cpus_read_lock();
          cpumask_copy(&cpumask, cpu_online_mask);
          on_each_cpu_cond(do_local_invalidate, invalidate_bh_lru, &cpumask, 1);

          for_each_cpu(cpu, &cpumask)
                  rcu_assign_pointer(per_cpu(bh_lrup, cpu),
                                             per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));

          synchronize_rcu_expedited();

          for_each_cpu(cpu, &cpumask) {
                  // Do remote invalidate here
          }
  }

[1]: https://lore.kernel.org/lkml/20230404134224.137038-4-ypodemsk@redhat.com/

>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>
> @@ -1465,8 +1505,10 @@ void invalidate_bh_lrus_cpu(void)
>       struct bh_lru *b;
>
>       bh_lru_lock();
> -	b = this_cpu_ptr(&bh_lrus);
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
>       __invalidate_bh_lrus(b);
> +	rcu_read_unlock();
>       bh_lru_unlock();
>  }
>
> @@ -2968,15 +3010,25 @@ void free_buffer_head(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(free_buffer_head);
>
> +static int buffer_cpu_online(unsigned int cpu)
> +{
> +	rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +			   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	return 0;
> +}

What serializes this against invalidate_bh_lrus()? Are you relying on this
running under cpus_write_lock()?

