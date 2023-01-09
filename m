Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CDB662C93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjAIRYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjAIRYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3F41017
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673285024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPrgrbO4EaJMcZw3XP+ZMoUmcH9Y+9fDGPyN/K2Dvmw=;
        b=MPcxSbZ8LNTLMV/n5fdJyTWzokmoslBdO71BQJLOiEEEjYeDzNVnKQXXs0QBFowupwLNq5
        ElxT6c2DTberTzQVSZs/HK0G9sniEanvbbif7xkUPNO+Wf30QgqAEh9iPUpfgdY2FjOvCY
        P+xBF9HSt0K1vRIOfagFuhBVj3jlONY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-TRzZEvLwOKm5D6nm7Mq-Rg-1; Mon, 09 Jan 2023 12:23:42 -0500
X-MC-Unique: TRzZEvLwOKm5D6nm7Mq-Rg-1
Received: by mail-ed1-f72.google.com with SMTP id z20-20020a05640240d400b0047028edd264so5793232edb.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 09:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPrgrbO4EaJMcZw3XP+ZMoUmcH9Y+9fDGPyN/K2Dvmw=;
        b=c9KMOv5YpTW5JZ/amWoGE36ck66h0eWfdy4g/on/mrBFIj71zteg2waednSv8kP3DE
         2UoqS6dhhsy+60t30qce9F71KMNtR5FtvHgk0xjXfsG0TzHsjaRlPj+NgZHiWJqxAnWe
         ONphhAQdWalrdCQOeMjF3YGe4zT4JkEofDEufei6OYEJ72yp1dkwLCyeHsh9xUIF4bLz
         t/m87JFBmYlV3VBxgppoPcqmxKlpewtnNty8t7zuEHZESV30ZIWmShuhtC29HtEUA4La
         WLS2e8of58ViJXzSFG3Y9jpc/wIRaMBaAlvtL+80kT5cMLjKJW8uFQ5BL02ejVHSRkbP
         hf4g==
X-Gm-Message-State: AFqh2krXiE9weXUtknBUavylQpS3lY80+RN97B8/uXWW+KUF1Kkyz/D9
        oBM7DjVKQlqPgImpmKMRk9Q08qqJEgd8kckCrsv0bSTgzjCfsHK2CFS+PytPgKWUapV5EJfWaH4
        00sR7BzSC5kJ3/1X7E6+gOTMN
X-Received: by 2002:a17:906:36c5:b0:829:594c:8ec8 with SMTP id b5-20020a17090636c500b00829594c8ec8mr51388832ejc.29.1673285021070;
        Mon, 09 Jan 2023 09:23:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZ0i9p+8e+EGUjC39Fc3fXEiIKaYn11oX7gxdKN3v2KVBKFky9eSggH3976smcCIqqTw4kJg==
X-Received: by 2002:a17:906:36c5:b0:829:594c:8ec8 with SMTP id b5-20020a17090636c500b00829594c8ec8mr51388825ejc.29.1673285020924;
        Mon, 09 Jan 2023 09:23:40 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090632d700b00837ac146a53sm3965895ejk.23.2023.01.09.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:23:40 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:23:38 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230109172338.5pebvg33fc4xds2f@aalbersh.remote.csb>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-8-aalbersh@redhat.com>
 <Y6XUv68yaKY9vBoO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6XUv68yaKY9vBoO@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:18:07AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 13, 2022 at 06:29:31PM +0100, Andrey Albershteyn wrote:
> > The direct path is not supported on verity files. Attempts to use direct
> > I/O path on such files should fall back to buffered I/O path.
> 
> Just curious: why?  What prevents us from running the hash function
> over the user pages in direct I/O?
> 

hmm, not sure if there are any technical obstacles (probably no),
but as fs-verity subsystem doesn't deal with direct i/o, I went the
same path.

-- 
- Andrey

