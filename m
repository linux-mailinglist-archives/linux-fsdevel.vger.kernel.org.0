Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B558E71B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 08:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiHJGFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiHJGFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF0D21E1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660111516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBlUQH9ZYI87QjLCL8xa8WoZuHTUiJ4rE7hGqowqg5w=;
        b=XEemTd1dGLlzVpaq9MB4mlRaHJLf4HZRyscpcJNhiDmxudk8evmzZfHg1N5zofRR5M+QS9
        WyKpdqcgtqxLNinT63PSIT09anNwhgRVOXa1oA5GGPIYK8gbN/13LbmBnuRytxarDWFfEu
        zTmAk0qQ7l9uYeh7V6EqXfdhIuH29qY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-63-gqwcXVL1NbO0qiMMLMIuTA-1; Wed, 10 Aug 2022 02:05:15 -0400
X-MC-Unique: gqwcXVL1NbO0qiMMLMIuTA-1
Received: by mail-ed1-f72.google.com with SMTP id j19-20020a05640211d300b0043ddce5c23aso8575337edw.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 23:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sBlUQH9ZYI87QjLCL8xa8WoZuHTUiJ4rE7hGqowqg5w=;
        b=M/+aKjN//ocEukDXiJbrth2yWocNouzqoMz48z48D/J3ZNT6ZDnPH7X5EffDMJ9ilu
         oLLLso75Q+OoAIyxafyBMC9Y0rI16k3XaGTYO9iKIEV+6DN3OFWqDIc+50aWtGDg52bK
         yB4JoQ5eiwJ4vrMnqBd0Ijnsujpo3yi1RTRIUj83V+shTVLc9o8Lz2Sm9LWbHWozccw5
         d0U+BdSSRdmrM8+P1Lt3VJgGtpVgQ77iK1ZzUnljgLd479pl6cQAZsTNm/ivTRG9GcWv
         cL+eMm0Vljlse3VnbzVprTuwI/l5TvFA6Loay+MDB7mKMW0xJJyvNkA5q+al4KJ6dbr4
         Wo1Q==
X-Gm-Message-State: ACgBeo03dM8TJsGhs0llbwRzmBmB6Fe0HjqPmTHVWm0zunJpTrrCyGV4
        27d9BCEOJUn6q0iEb6aNoSbka4CRC+tbtqd55tK71WoQ9Gv7CxXLJWb5tzbEt+N2r1V+U9V6a3Q
        1oCTkhOVDc12Sa1R0JKYrM/PbYw==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr19393957ejb.206.1660111514488;
        Tue, 09 Aug 2022 23:05:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zsECaQisdchCePlp4yUAvq88BKlsK7g/FdrfvnijgIa0+CeZxy11peJJUHhW3QeKUTE6NCQ==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr19393941ejb.206.1660111514262;
        Tue, 09 Aug 2022 23:05:14 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b00732a5b3d09csm1658020ejb.89.2022.08.09.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 23:05:13 -0700 (PDT)
Date:   Wed, 10 Aug 2022 02:05:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
Message-ID: <20220810020330-mutt-send-email-mst@kernel.org>
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809063111-mutt-send-email-mst@kernel.org>
 <d8fd3251-898d-89fe-226e-e166606c6983@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8fd3251-898d-89fe-226e-e166606c6983@virtuozzo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:54:52AM +0300, Alexander Atanasov wrote:
> On 9.08.22 13:32, Michael S. Tsirkin wrote:
> > On Tue, Aug 09, 2022 at 12:49:32PM +0300, Alexander Atanasov wrote:
> > > @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >   		    global_zone_page_state(NR_FREE_CMA_PAGES));
> > >   #endif
> > > +#ifdef CONFIG_MEMORY_BALLOON
> > > +	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
> > > +	if (inflated_kb >= 0)
> > > +		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
> > > +	else
> > > +		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
> > > +#endif
> > > +
> > >   	hugetlb_report_meminfo(m);
> > >   	arch_report_meminfo(m);
> > 
> > 
> > This seems too baroque for my taste.
> > Why not just have two counters for the two pruposes?
> 
> I agree it is not good but it reflects the current situation.
> Dirvers account in only one way - either used or total - which i don't like.
> So to save space and to avoid the possibility that some driver starts to use
> both at the same time. I suggest to be only one value.

I don't see what would be wrong if some driver used both
at some point.

> 
> > And is there any value in having this atomic?
> > We want a consistent value but just READ_ONCE seems sufficient ...
> 
> I do not see this as only a value that is going to be displayed.
> I tried to be defensive here and to avoid premature optimization.
> One possible scenario is OOM killer(using the value) vs balloon deflate on
> oom will need it. But any other user of that value will likely need it
> atomic too. Drivers use spin_locks for calculations they might find a way to
> reduce the spin lock usage and use the atomic.
> While making it a long could only bring bugs without benefits.
> It is not on a fast path too so i prefer to be safe.

Well we do not normally spread atomics around just because we
can, it does not magically make the code safe.
If this needs atomics we need to document why.

> -- 
> Regards,
> Alexander Atanasov

